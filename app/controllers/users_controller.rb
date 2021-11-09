class UsersController < ApplicationController
  def send_request
    @user = User.find_by_email(params[:email])
    payload = {
      name: @user.name,
      email: @user.email,
      iat: Time.now.to_i,
      workspace_id: 1671
    }
    puts payload
    hmac_secret = 'lxWAdQbKlc7O5C6zygGHuzukfhnx2_opEd8AktWn1QzZEE7-WS6vBA2gpzAUHxY1'
    token = JWT.encode payload, hmac_secret, 'HS256'
    puts token
    res = HTTParty.post('http://yieldhub.marbleteams.com/auth/jwt',
                        body: {
                          jwt: token
                          # return_to: 'https://www.google.com/'
                        },
                        headers: {
                          'typ': 'JWT',
                          'alg': 'HS256',
                          'Authorization': 'Bearer lxWAdQbKlc7O5C6zygGHuzukfhnx2_opEd8AktWn1QzZEE7-WS6vBA2gpzAUHxY1',
                        })
    puts res
  end
end
