Rails.application.routes.draw do
  resources :short_urls

  root "short_urls#home"
  get "/:short_path",           to: "short_urls#redirect"
end
