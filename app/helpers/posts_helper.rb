module PostsHelper
  def post_body_with_links(post)
    sanitize post.body.gsub(/\#(\w+)/) { |match|
      link_to match, hashtag_path(match[1..-1])
    }
  end

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
