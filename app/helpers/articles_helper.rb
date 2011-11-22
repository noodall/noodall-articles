require 'noodall/articles/custom_link_renderer'

module ArticlesHelper
  def paginated_articles(pagination_options = {}, &block)
    options = { :per_page => 10, :page => params[:page] }

    # Add search filters
    options.merge!(build_query_from_params)

    if params[:year]
      if params[:month]
        time = Time.zone.local(params[:year].to_i, params[:month].to_i, 1)
        options[:published_at] = { :$gt => time.beginning_of_month, :$lt => time.end_of_month }
      else
        time = Time.zone.local(params[:year].to_i, 1, 1)
        options[:published_at] = { :$gt => time.beginning_of_year, :$lt => time.end_of_year }
      end
    end
    articles = @node.articles.paginate(options)

    # Set default will_paginate options
    paginated_section_options = {
      :renderer => Noodall::Articles::CustomLinkRenderer,
      :next_label => "Next",
      :previous_label => "Previous",
      :first_label => "First",
      :last_label => "Last"
    }

    # Override any options passed in
    paginated_section_options.merge!(pagination_options)
    paginated_section(articles, paginated_section_options) { yield(articles) }.html_safe unless articles.empty?
  end

  def articles_rss_feed(node)
    node.articles.all(build_query_from_params)
  end

  def articles_rss_feed_link(text, options = {})
    querystring = build_querystring
    querystring[:format] = :rss
    link_to text, node_path(@node.list, querystring), options
  end

  def related_articles
    nodes = @node.siblings.published.order('published_date DESC').where(:tags => /(#{@node.tags.join('|')})/i).limit(3)

    return if nodes.empty?

    content_tag('h3', 'Related Articles', :class => "sup-title") + content_tag('ul', :id => 'related-articles') do
      nodes.collect do |node|
        content_tag('li', link_to((node.title).html_safe, node_path(node))+content_tag('time', l(node.published_at, :format => :short)))
      end.join.html_safe
    end
  end

  def link_for_filter_text(text, node, current_filter)
    querystring = build_querystring(current_filter)
    link_to(text, node_path(node.list, querystring))
  end

  protected

  def build_query_from_params
    query = {}
    query[:categories] = params[:category] if valid_filter?(params[:category])
    query
  end

  def build_querystring(current_filter = {})
    querystring = {
      category: params[:category],
    }
    querystring.merge!(current_filter)
  end

  def valid_filter?(filter)
    !filter.blank? && filter != "All"
  end
end
