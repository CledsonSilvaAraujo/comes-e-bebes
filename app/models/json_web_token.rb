class JsonWebToken
	Secret = "shdjklfhiuwehfmn"
	def self.encode(payload)
		JWT.encode(payload, Secret) #string aleatoria de criptografia
	end
	def self.decode(token)
		begin
			JWT.decode(token, Secret)
		rescue => exception
			return nil
		end
		
	end
end