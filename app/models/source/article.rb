class Source::Article
  attr_reader :source

  def initialize(source)
    @source = source
  end

  def to_h
    {
      article_url: source.article_url,
      title: source.title,
      body: source.summary.presence || source.body
    }
  end
end
