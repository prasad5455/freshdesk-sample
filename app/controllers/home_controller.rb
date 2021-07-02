class HomeController < ApplicationController
  def index
    flash[:error] = flash[:success] = ''
    if request.post?
      begin
        json_payload = { status: params[:status].to_i,
                         priority: params[:priority].to_i,
                         description: params[:description],
                         subject: params[:subject],
                         cc_emails: params[:cc_email].split(','),
                         email: params[:email] }.to_json

        freshdesk_api_url = "https://#{params[:freshdesk_domain]}.freshdesk.com/api/v2/tickets"

        site = RestClient::Resource.new(freshdesk_api_url, params[:api_key], 'X')
        response = site.post(json_payload, content_type: 'application/json')
        puts "response_code: #{response.code} \n Location Header:" \
             "#{response.headers[:location]}\n response_body: #{response.body}"
        flash[:success] = 'API Success: Your request is successful.'
      rescue StandardError => e
        flash[:error] = 'API Error: Your request is not successful.'
        puts e.message
      end
    end
  end
end
