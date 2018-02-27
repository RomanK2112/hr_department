module PostsHelper
  def shorter_post (long_post)
    long_post.truncate(512, seperator: ' ')
  end
end
