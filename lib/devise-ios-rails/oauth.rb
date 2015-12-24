module DeviseIosRails
  module OAuth
    def self.included receiver
      receiver.extend ClassMethods
      receiver.validates_with OauthTokenValidator, unless: 'provider.blank?'
      receiver.validates :uid, uniqueness: { scope: :provider },
                               allow_nil: true, allow_blank: true
    end

    def email_required?
      super && password_required?
    end

    def password_required?
      super && provider.blank?
    end

    module ClassMethods
      def from_oauth attributes
        where(attributes.slice(:uid, :provider)).first_or_create do |user|
          user.email       = attributes[:email]
          user.first_name  = attributes[:first_name]   # assuming the user model has a name
      		user.last_name   = attributes[:last_name]
      		user.avatar      = attributes[:avatar] # assuming the user model has an image
          user.gender      = attributes[:gender]
          user.birthday    = attributes[:birthday]
          user.country     = attributes[:country]
          user.state       = attributes[:state]
          user.city        = attributes[:city]
          user.oauth_email = attributes[:email]
          user.provider    = attributes[:provider]
          user.uid         = attributes[:uid]
          user.oauth_token = attributes[:oauth_token]
        end
      end
    end
  end
end
