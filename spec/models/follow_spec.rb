require 'rails_helper'

describe User, '#follow' do
  it 'follows users' do
    foo, bar, baz = create_list(:user, 3)

    foo.follow(bar)

    expect(foo.follows?(bar))
    expect(!foo.follows?(baz))
    expect(!bar.follows?(foo))
    expect(bar.leads?(foo))

    expect(foo.following).to eq([bar])

    foo.follow(baz)
    foo.reload

    expect(foo.following).to eq([bar, baz])

    baz.follow(bar)

    expect(bar.followers).to eq([foo, baz])
  end
end

describe User, '#unfollow' do
  it 'unfollows users' do
    foo, bar = create_list(:user, 2)

    foo.follow(bar)

    expect(foo.follows?(bar))

    foo.unfollow(bar)
    
    expect(!foo.follows?(bar))
  end
end

describe User, '#followers_count, #following_count' do
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