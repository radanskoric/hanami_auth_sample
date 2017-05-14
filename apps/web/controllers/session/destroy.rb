module Web::Controllers::Session
  # The log out action.
  class Destroy
    include Web::Action

    def call(params)
      params.env["warden"].logout
      redirect_to routes.root_path
    end
  end
end
