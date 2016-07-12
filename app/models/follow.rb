class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  after_create :create_following_activity
  after_destroy :create_unfollow_activity

  private
  def create_following_activity
    followed.create_activity key: "follow", owner: follower
  end

  def create_unfollow_activity
    followed.create_activity key: "unfollow", owner: follower
  end
end
