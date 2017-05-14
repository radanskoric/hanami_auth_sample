module Web::Views::Users
  # User register page.
  class New
    include Web::View

    def form
      form_for :user, routes.users_path do
        div class: "input" do
          errors_for(:name, self)
          label :name
          text_field :name
        end

        div class: "input" do
          errors_for(:email, self)
          label :email
          email_field :email
        end

        div class: "input" do
          errors_for(:password, self)
          label :password
          password_field :password
        end

        submit "Register"
      end
    end

    private

    def errors_for(attribute, context)
      return if params.valid?

      errors = params.errors.dig(:user, attribute)
      return if errors.nil? || errors.empty?

      context.div class: "errors" do
        ul do
          errors.each do |error|
            li "#{attribute.capitalize} #{error}"
          end
        end
      end
    end
  end
end
