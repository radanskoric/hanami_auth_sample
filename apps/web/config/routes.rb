# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

root to: "home#index"

resource :session, only: %i[new create destroy]

resources :users, only: %i[new create]
