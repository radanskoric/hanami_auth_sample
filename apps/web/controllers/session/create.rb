module Web::Controllers::Session
  # The session creation, i.e the log in action.
  class Create
    include Web::Action

    def call(params)
      params.env["warden"].authenticate!(:password)
      redirect_to routes.root_path
    end
  end
end
