module SecretMacros

  def update_secret(secret, new_param)
    put :update,  :id => secret.id,
                  :secret => attributes_for(:secret, new_param)
  end

end