module Web::Controllers::Users
  # The page for new users to register.
  class Create
    include Web::Action

    def initialize(operation: Operations::Users::Create.new)
      @operation = operation
    end

    params do
      required(:user).schema do
        required(:name).filled(:str?)
        required(:email) { filled? & str? & format?(/\A[^@\s]+@[^@\s]+\z/) }
        required(:password) { filled? & str? & size?(6..64) }
      end
    end

    def call(params)
      if params.valid?
        user = @operation.call(params[:user])
        params.env["warden"].set_user(user)
        redirect_to routes.root_path
      else
        self.status = 422
      end
    end
  end
end
