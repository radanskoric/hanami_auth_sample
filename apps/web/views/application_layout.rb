module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def user_name
        @scope.local(:params).env["warden"].user&.name
      end
    end
  end
end
