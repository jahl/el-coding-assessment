module JtiTokenizable
  extend ActiveSupport::Concern

  included do
    private

    def set_jti
      self.jti = SecureRandom.uuid
    end
  end
end