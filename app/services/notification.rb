class Notification
  def initialize object
    @object = object
    @users = User.not_admin
  end

  def notify_new_category
    @users.each do |user|
      @object.activities.create key: "new_category", owner: user
    end
  end

  def notify_delete_category
    @users.each do |user|
      @object.activities.create owner: user, key: "destroy_category"
    end
end
