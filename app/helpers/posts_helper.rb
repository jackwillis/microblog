module PostsHelper
  def post_body_with_links(post)
    sanitize(with_hashtag_links(with_username_links(post.body)))
  end

  private

    def with_hashtag_links(s)
      s.gsub(/\#(\w+)/) { |match| link_to match, hashtag_path(match[1..-1]) }
    end

    def with_username_links(s)
      s.gsub(/\@(\w+)/) { |match| link_to match, user_path(match[1..-1]) }
    end

  public

  def post_time_tag(post)
    time = post.created_at
    now = Time.zone.now

    link = if now.ago(2.hours) < time
      "Posted " + link_to(distance_of_time_in_words(time, now) + " ago", post)
    else
      "Posted on " + link_to(time.strftime("%a, %b %-d, %Y, %l:%S %p"), post)
    end

    time_tag time, link.html_safe, title: time.rfc2822
  end
end
