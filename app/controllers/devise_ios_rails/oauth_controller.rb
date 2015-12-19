module DeviseIosRails
  class OauthController < DeviseController
    skip_before_action :verify_authenticity_token

    respond_to :json

    def all
      respond_with resource_class.from_oauth(resource_params)
    end

    alias_method :facebook, :all
    alias_method :google,   :all

    private

    def resource_params
      params.require(resource_name).permit(:email, :first_name, :last_name, :avatar, :gender, :birthday, :country, :state, :city, :provider, :uid, :oauth_token)
    end
  end
end
