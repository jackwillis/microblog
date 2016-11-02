module PostsHelper
  def post_body_with_links(post)
    sanitize post.body.gsub(/\#(\w+)/) { |match|
      link_to match, hashtag_path(match[1..-1])
    }
  end
end
