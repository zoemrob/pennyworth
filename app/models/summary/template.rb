class Summary::Template
  attr_reader :sources

  def initialize
    @sources = Source.today
  end

  def build
    mapped = @sources.map do |source|
      source.body = source.body.split('\n').map(&:strip).reject(&:empty?).join(' ')
      source
    end

    ApplicationController.render 'templates/news_prompt', locals: { data: mapped.to_json }, layout: false
  end
end
