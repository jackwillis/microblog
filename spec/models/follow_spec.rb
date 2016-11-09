require 'rails_helper'

describe User do
  it 'follows users' do
    foo, bar, baz = create_list(:user, 3)

    foo.follow(bar)

    expect(foo.following).to include(bar)
    expect(foo.following).to_not include(baz)
    expect(bar.following).to_not include(foo)
    expect(bar.followers).to include(foo)
  end

  it 'unfollows users' do
    foo, bar = create_list(:user, 2)

    foo.follow(bar)

    expect(foo.following).to include(bar)

    foo.unfollow(bar)
    
    expect(foo.following).to_not include(bar)
  end

  it 'tracks follower counts' do
    foo, bar, baz = create_list(:user, 3)

    foo.follow(bar)
    foo.follow(baz)
    baz.follow(bar)

    expect(foo.following_count).to eq(2)
    expect(bar.followers_count).to eq(2)

    foo.unfollow(bar)
    bar.reload

    expect(bar.followers_count).to eq(1)
  end
end