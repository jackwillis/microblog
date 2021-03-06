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

    link = if now.ago(1.day + 6.hours) < time
      link_to(distance_of_time_in_words(time, now) + " ago", post)
    else
      "on " + link_to(time.strftime("%a, %b %-d, %l:%S %p"), post)
    end

    time_tag time.in_time_zone, link.html_safe, title: time.in_time_zone.rfc2822
  end

  def like_button(post)
    return "\u2764" unless user_signed_in?
    
    if current_user.likes?(post)
      button_to "( \u2764 )", unlike_post_path(post), method: :delete, class: "like_button liked"
    else
      button_to "\u2764", like_post_path(post), class: "like_button unliked"
    end
  end
end
