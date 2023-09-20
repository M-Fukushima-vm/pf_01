# 外部api HackMD_APIへのアクセス
# =>https://hackmd.io/@hackmd-api/developer-portal/https%3A%2F%2Fhackmd.io%2F%40hackmd-api%2Fapi-authorization?utm_source=tutorial&utm_medium=book-section
module Api::Hackmd::Request
	extend self

	def get_user_notes_list(token)
		connection(token).get('notes', { readPermission: 'guest'})
	end

	def get_user_notes(token, id)
		uri = URI.parse("notes/#{id}")
		connection(token).get(uri, { readPermission: 'guest'})
	end

	private

	def connection(token)
    connection ||= Faraday.new(url: 'https://api.hackmd.io/v1') do |conn|
      conn.request :url_encoded
			# Bearerトークンをヘッダーに追加 => https://lostisland.github.io/faraday/#/middleware/included/authentication
			conn.request :authorization, 'Bearer', token
      conn.response :json, content_type: /\bjson$/
      conn.adapter Faraday.default_adapter
    end
  end

end