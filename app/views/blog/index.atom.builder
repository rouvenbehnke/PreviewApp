atom_feed(language: 'en-US') do |feed|
  feed.title @obj.headline
  feed.updated @posts.first.published_at

  @posts.each do |post|
    feed.entry(post, url: cms_url(post)) do |entry|
      entry.title post.headline
      entry.content truncate(strip_tags(cms_tag(:div, post, :main_content)), length: 150), type: 'text'

      # the strftime is needed to work with Google Reader.
      entry.updated post.published_at.strftime('%Y-%m-%dT%H:%M:%SZ')

      entry.author do |author|
        author.name post.author_name
      end
    end
  end
end
