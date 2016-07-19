class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
    :trackable, :omniauthable

  has_many :logs, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: Follow.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Follow.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates_presence_of :email, if: :email_required?
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  validates_format_of :email, with: Devise.email_regexp, allow_blank: true,
    if: :email_changed?
  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of :password, within: Devise.password_length,
    allow_blank: true

  mount_uploader :image, ImageUploader

  scope :not_admin, ->{where is_admin: false}

  %w(facebook twitter).each do |provider|
    define_method provider do |provider|
      identities.find_by provider: provider
    end

    define_method "#{provider}_client" do |provider|
      binding.eval("@#{provider}_client ||= #{provider.capitalize}.client(access_token: #{provider}.accesstoken)")
    end
  end

  include PublicActivity::Model
  tracked

  def password_required?
    return false if email.blank?
    !persisted? || !password.nil? || !password_cofirmation.nil?
  end

  def email_required?
    true
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def words_in_month
    Result.word_in_month self.id
  end

  def following? other_user
    following.include? other_user
  end

  def lesson_in_month
    Lesson.in_month(self.id).size
  end

  def category_in_month
    Lesson.in_month(self.id).distinct.count :category_id
  end

  private
  def destroy_user_activities
    PublicActivity::Activity.user(self).each do |activity|
      activity.destroy!
    end
  end
end
