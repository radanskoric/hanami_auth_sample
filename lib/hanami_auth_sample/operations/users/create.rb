require "bcrypt"

module Operations
  module Users
    # An operation for creating a new user
    class Create
      def initialize(repository: UserRepository.new)
        @repository = repository
      end

      def call(params)
        if params[:password]
          params = params.merge(encrypted_password: encrypt(params[:password]))
          params.delete(:password)
        end

        @repository.create(params)
      end

      private

      def encrypt(password)
        BCrypt::Password.create(password, cost: 12)
      end
    end
  end
end
