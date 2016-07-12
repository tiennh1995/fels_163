PublicActivity::Activity.class_eval do
  scope :all_activity, -> (user_id){where "owner_id IN (SELECT followed_id FROM follows
    WHERE follower_id = #{user_id}) OR owner_id = #{user_id} AND owner_type = 'User'"}
  scope :user, -> user_id do
    where(owner_id: user_id, owner_type: Settings.activity.user)
  end
end
