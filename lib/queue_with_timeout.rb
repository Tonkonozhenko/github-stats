class QueueWithTimeout
  attr_reader :queue

  def initialize(array = 0)
    @mutex = Mutex.new
    @queue = ThreadSafe::Array.new(array)
    @received = ConditionVariable.new
  end

  def size
    @queue.size
  end

  def <<(x)
    @mutex.synchronize do
      @queue << x
      @received.signal
    end
  end

  alias :push :<<

  def pop(non_block = false)
    pop_with_timeout(non_block ? 0 : nil)
  end

  # timeout in seconds
  def pop_with_timeout(timeout = nil)
    @mutex.synchronize do
      if @queue.empty?
        @received.wait(@mutex, timeout) if timeout != 0
        #if we're still empty after the timeout, raise exception
        return nil if @queue.empty?
      end
      @queue.shift
    end
  end
end