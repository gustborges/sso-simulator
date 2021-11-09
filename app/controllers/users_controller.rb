class UsersController < ApplicationController
  def send_request
    @user = User.find_by_email(params[:email])
    payload = {
      name: @user.name,
      email: @user.email,
      iat: Time.now.to_i
    }
    hmac_secret = '74vpdZOJvKKq8AptwX_7t3fwNjn7hhOJoLw7liubWJzZtYMVthDXRzmvQl15ANEY'
    token = JWT.encode payload, hmac_secret, 'HS256'
    res = HTTParty.post('http://yieldhub.elearningaccelerator.com/auth/jwt',
                        body: {
                          jwt: token,
                          return_to: 'https://yieldhub.elearningaccelerator.com/paths/1'
                        },
                        headers: {
                          'typ': 'JWT',
                          'alg': 'HS256'
                        })
    redirect_to res.parsed_response['url']
  end
end
