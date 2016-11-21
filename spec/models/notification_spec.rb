require 'rails_helper'

RSpec.describe Notification, type: :model do
  it "is created after foo likes bar's post'" do
    foo, bar = create_list(:user, 2)
    post = create(:post, user: foo)

    bar.like(post)

    expect(Notification.count).to eq(1)

    pl = PostLike.first
    nx = Notification.first

    expect(nx.subject).to eq(pl)
    expect(nx.user).to eq(foo)
  end

  it "is not created after foo likes foo's own post" do
    foo = create(:user)
    post = create(:post, user: foo)

    foo.like(post)

    expect(Notification.count).to eq(0)
  end

  it "is created after foo follows bar" do
    foo, bar = create_list(:user, 2)
    
    foo.follow(bar)

    expect(Notification.count).to eq(1)

    fx = Follow.first
    nx = Notification.first

    expect(nx.subject).to eq(fx)
    expect(nx.user).to eq(bar)
  end

  it "is created after foo mentions bar" do
    foo, bar = create_list(:user, 2)
    post = create(:post, user: foo, body: "I love to mention @#{bar.username}.")

    expect(Notification.count).to eq(1)

    um = UsernameMention.first
    nx = Notification.first

    expect(nx.subject).to eq(um)
    expect(nx.user).to eq(bar)
  end
end
