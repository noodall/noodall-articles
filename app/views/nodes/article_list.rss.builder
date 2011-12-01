xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title(@node.title)
    xml.description(@node.description)
    xml.link(node_url(@node))
    xml.language('en-gb')
      for article in articles_rss_feed(@node)
        xml.item do
          xml.title(article.title)
          xml.category(article.category_list) unless article.categories.blank?
          xml.description(article.description)
          xml.pubDate(article.published_at.rfc822)
          xml.link(node_url(article))
          xml.guid(node_url(article))
        end
      end
  end
end
