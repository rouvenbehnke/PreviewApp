class Blog < Page
  # Defines a reference to a blog associated with this page.
  def blog
    self
  end

  def latest_posts(count, page = 0)
    BlogPost.all
      .and(:_path, :starts_with, path + '/')
      .offset(page * count)
      .batch_size(count)
      .order(:published_at)
      .reverse_order
      .take(count)
  end
end
