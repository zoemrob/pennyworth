module ApplicationHelper
  def header_links
    [
      link_to('Signup', root_path),
      link_to('Archive', news_index_path),
      link_to('About', '')
    ]
  end

  def btn_cartoon(opts)
    btn(opts.merge(class: opts.fetch(:class, '') + ' ' + btn_cartoon_parent_styles)) do
      content_tag(:span, class: btn_cartoon_offset_styles_1) { '' } +
      content_tag(:span, class: btn_cartoon_offset_styles_2) { yield }
    end
  end

  def btn_simple(opts)
    btn(opts.merge(class: opts.fetch(:class, '') + ' ' + btn_simple_styles)) { yield }
  end

  def btn(opts)
    content_tag(:button, merge_button_options(opts)) { yield }
  end

  def merge_button_options(opts)
    { type: 'button' }.merge(opts)
  end

  def btn_simple_styles
    'inline-block rounded border border-indigo-600 px-12 py-3 text-sm font-medium text-indigo-600 hover:bg-indigo-600 hover:text-white focus:outline-none focus:ring active:bg-indigo-500'
  end

  def btn_cartoon_parent_styles
    'group relative inline-block focus:outline-none focus:ring'
  end

  def btn_cartoon_offset_styles_1
    brand_blue + ' absolute inset-0 translate-x-1.5 translate-y-1.5 transition-transform group-hover:translate-x-0 group-hover:translate-y-0'
  end

  def btn_cartoon_offset_styles_2
    'relative inline-block border-2 border-current px-8 py-3 text-sm font-bold uppercase tracking-widest text-black group-active:text-opacity-75'
  end

  def brand_blue = 'bg-cyan-500'
end
