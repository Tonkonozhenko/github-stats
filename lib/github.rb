class Github
  CONFIG_ATTRIBUTES = [:oauth_token]

  class Config
    attr_accessor *CONFIG_ATTRIBUTES
  end

  delegate *CONFIG_ATTRIBUTES, to: :@config

  def initialize
    @config = Config.new
    yield(@config)
  end
end