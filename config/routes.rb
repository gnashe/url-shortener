Rails.application.routes.draw do
  root "short_urls#home"
  get "/short/:short_url", to: "short_urls#shortened"
  get "/all",                  to: "short_urls#show_all"
  get "/:short_url",           to: "short_urls#redirect"
end
