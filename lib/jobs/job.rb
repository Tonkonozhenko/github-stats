class Job
  include java.util.concurrent.Callable

  TIMEOUT = 10

  mattr_accessor :queue
end