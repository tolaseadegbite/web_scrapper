Rails.application.routes.draw do
  resources :products do
    match '/scrape', to: 'products#scrape', via: :post, on: :collection
  end
  
  root "products#index"
end
