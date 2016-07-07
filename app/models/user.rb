class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
    :trackable, :omniauthable

  has_many :logs
  has_many :identities
  has_many :activities, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: Follow.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Follow.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  scope :not_admin, ->{where is_admin: false}

  %w(facebook twitter).each do |provider|
    define_method provider do |provider|
      identities.find_by provider: provider
    end

    define_method "#{provider}_client" do |provider|
      binding.eval("@#{provider}_client ||= #{provider.capitalize}.client(access_token: #{provider}.accesstoken)")
    end
  end
end
