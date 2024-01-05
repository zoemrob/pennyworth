class Source::Template
  attr_reader :source, :body, :model

  def initialize(source, model)
    @model = model
    @source = source
  end

  def build
    source.clean_body
    @body = ApplicationController.render "templates/source_prompt_#{friendly_model_name}", locals: { text: source.body }, layout: false
    self
  end

  def friendly_model_name = model.gsub('.', '_')
end
