require_relative 'job'

class RepoJob < Job
  mattr_accessor :github

  def self.initialize(github)
    self.queue = QueueWithTimeout.new(['https://api.github.com/repositories'])
    self.github = github
    self
  end

  def initialize(url)
    @url = url
  end

  def call
    puts "GET: #{@url}"
    response = RestClient.get(@url, { 'Authorization' => "token #{github.oauth_token}" })
    queue.push response.headers[:link].split(/[<>]/)[1]

    # TODO doing hard work
  end
end