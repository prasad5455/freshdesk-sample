require 'rubygems'
require 'rest_client'
require 'json'

class FreshDesk
  def self.create_new_ticket(freshdesk_domain, api_key, email, status, priority, description, subject, cc_email = [])
    json_payload = { status: status,
                     priority: priority,
                     description: description,
                     subject: subject,
                     cc_emails: cc_email,
                     email: email }.to_json
    freshdesk_api_path = 'api/v2/tickets'

    freshdesk_api_url = "https://#{freshdesk_domain}.freshdesk.com/#{freshdesk_api_path}"

    site = RestClient::Resource.new(freshdesk_api_url, api_key, 'X')
    response = site.post(json_payload, content_type: 'application/json')
    puts "response_code: #{response.code} \n Location Header: #{response.headers[:location]}\n response_body: #{response.body}"
  rescue RestClient::Exception => e
    puts 'API Error: Your request is not successful.'
    puts "X-Request-Id : #{e.response.headers[:x_request_id]}"
    puts "Response Code: #{e.response.code} Response Body: #{e.response.body} "
  end
end