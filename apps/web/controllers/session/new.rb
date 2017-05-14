module Web::Controllers::Session
  # The log in page.
  class New
    include Web::Action
    expose :failure_message

    def initialize(login_failed_with: nil)
      @failed_login_attempt = !login_failed_with.nil?
      @failure_message = login_failed_with
    end

    def call(_params)
      self.status = 403 if @failed_login_attempt
    end
  end
end
