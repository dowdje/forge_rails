class WelcomeController < ActionController::Base

  def index
    if params['code']
      session[:auth_code] = params['code']
    end
  end
  # {"access_token"=>"84AHoqLqZpEoRDSgIs15ypezXzmp", "refresh_token"=>"Rke4mOyTOn3ZLLroV1EtTLTJA88F2W2NsdlsxwfGMw", "token_type"=>"Bearer", "expires_in"=>86399}
  
  def access
    
    @result = HTTParty.post('https://developer.api.autodesk.com/authentication/v1/gettoken', 
    :body => { :client_id => 'XRj2rYsTCJOcbtRaW87AOY8GBjoyLGvS', 
               :client_secret => 'Jc599ef6bef864b4', 
               :grant_type => 'authorization_code', 
               :code => session[:auth_code], 
               :redirect_uri => 'http://localhost:3000'
             },
    :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' } )
    session[:access_token] = @result["access_token"]
  end

  def hubs

    @result = HTTParty.get('https://developer.api.autodesk.com/project/v1/hubs',
      :headers => {'Authorization' => 'Bearer ' + session[:access_token]})
  end

  

  def auth
    # @result = HTTParty.post('https://developer.api.autodesk.com/authentication/v1/authenticate',
    #   :body => {:client_id => '11S6ResStiu0nWeVHRCf5RIJ5DIVnA9K',
    #             :client_secret => 'X2co5opbKfCSQff6',
    #             :grant_type => 'client_credentials',
    #             :scope => 'data:read data:write bucket:create bucket:read account:read user-profile:read'},
    #   :headers => {'Content-Type' => 'application/x-www-form-urlencoded'})

    # session[:token] = @result['access_token']

    #  @bucket = HTTParty.post('https://developer.api.autodesk.com/oss/v2/buckets',
    #   :headers => {'Authorization'=> 'Bearer ' + session[:token],
    #                'Content-Type'=> 'application/json'},
    #   :body => {'bucketKey' => 'mybucket1',
    #             'policyKey' => 'transient'}.to_json)

    #  @bucket = HTTParty.get('https://developer.api.autodesk.com/oss/v2/buckets/mybucket1/details',
    #             :headers => {'Authorization'=> 'Bearer ' + session[:token]})
    #  byebug
  end

end