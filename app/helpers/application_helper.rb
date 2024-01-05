module ApplicationHelper
  def header_links
    [
      link_to('Signup', root_path),
      link_to('Archive', news_index_path),
      link_to('About', '')
    ]
  end
end
