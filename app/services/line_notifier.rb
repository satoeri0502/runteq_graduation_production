# app/services/line_notifier.rb
require 'net/http'
require 'uri'
require 'json'

class LineNotifier
  API_ENDPOINT = 'https://api.line.me/v2/bot/message/push'

  def self.send_message(to:, message:)
    token = Rails.application.credentials.dig(:line, :channel_token)
    Rails.logger.debug "LINE TOKEN: #{Rails.application.credentials.dig(:line, :channel_token)}"
    raise "LINEアクセストークンが設定されていません" unless token.present?

    uri = URI.parse(API_ENDPOINT)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{token}"
    }

    body = {
      to: to,
      messages: [
        {
          type: 'text',
          text: message
        }
      ]
    }

    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = body.to_json

    response = http.request(request)

    unless response.is_a?(Net::HTTPSuccess)
      Rails.logger.error("LINE通知エラー: #{response.body}")
    end

    response
  end
end
