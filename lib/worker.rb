class Worker
  attr_accessor :queue,:job_class

  def initialize(job_class)
    self.job_class = job_class
    self.queue = job_class.queue
  end

  def work(thread_count = 1)
    executor = java.util.concurrent.Executors::newFixedThreadPool(thread_count)
    while next_url = queue.pop_with_timeout(job_class::TIMEOUT)
      executor.submit(job_class.new(next_url))
      break if executor.is_shutdown
    end
    executor.shutdown
  end
end