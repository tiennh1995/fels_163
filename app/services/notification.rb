class Notification
  def initialize object
    @object = object
    @users = User.not_admin
  end

  def notify_new_category
    @users.each do |user|
      user.activities.create action_id: @object.id, activity_type: :new_category
    end
  end
end
