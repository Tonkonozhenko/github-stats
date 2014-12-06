# Require
require_relative 'setup'

Worker.new(RepoJob.initialize(GITHUB)).work(CONFIG[:threads_count])