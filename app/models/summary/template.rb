class Summary::Template
  attr_reader :sources

  def initialize
    @sources = Source.today
  end

  def build
    practice = @sources.second
    practice.body.split('\n').map(&:strip).reject(&:empty?)
  end
end
