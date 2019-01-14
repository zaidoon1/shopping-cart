Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :products, only: %i[index show], param: :product_id do
        collection { get 'in_stock' }
      end
      resources :carts, only: [:show], param: :cart_id
      resources :carts, only: [:create] do
        collection { post 'checkout' }
        resources :cart_items, only: %i[create update destroy],
                               param: :product_id
      end
      root to: 'products#index'
    end
  end
  match '*path' => 'errors#render_not_found', via: :all
end
