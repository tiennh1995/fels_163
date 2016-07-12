class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  class << self
    def find_for_oauth auth
      identity = find_or_create_by uid: auth.uid, provider: auth.provider
      identity.update_attributes accesstoken: auth.credentials.token,
        refresh_token: auth.credentials.refresh_token, email: auth.info.email,
        name: auth.info.name, image: auth.info.image
      identity
    end
  end
end
