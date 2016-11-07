module PostsHelper
  def post_body_with_links(post)
    sanitize post.body.gsub(/\#(\w+)/) { |match|
      link_to match, hashtag_path(match[1..-1])
    }
  end

  TIME_FORMAT = "%a, %b %-d, %Y, %l:%S %p".freeze
  TIME_SWITCH = 2.hours.freeze

  def post_time_tag(post)
    time = post.created_at
    now = Time.zone.now

    link = if now.ago(TIME_SWITCH) < time
      "Posted " + link_to(distance_of_time_in_words(time, now) + " ago", post)
    else
      "Posted on " + link_to(time.strftime(TIME_FORMAT), post)
    end

    time_tag time, link.html_safe
  end
end
