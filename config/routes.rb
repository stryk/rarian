Rarian::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  resource :searches do
    post :index
  end

  resources :companies do
    collection {
      post :import
      post :search
    }
    member {
      put :follow
      put :unfollow
    }
    resources :blips
    resources :target_prices
    resources :catalysts
    resources :comments
    resources :competitors do
      resources :votes do
        collection {
          put :up
          put :down
        }
      end
    end
    resources :risks do
      resources :votes do
        collection {
          put :up
          put :down
        }
      end
    end

    resources :pitches do
      resources :votes do
        collection {
          put :up
          put :down
        }
      end
      resources :comments

    end

    resources :questions do
      resources :votes do
        collection {
          put :up
          put :down
        }
      end
      resources :answers
      resources :comments
    end

    resources :answers do
      resources :votes do
        collection {
          put :up
          put :down
        }
      end
      resources :comments
    end

    resources :blips do
      resources :votes do
        collection {
          put :up
          put :down
        }
      end

      resources :comments
    end

  end


  #devise_scope :users do
  #  get "users/sign_up", :to => "users1/registrations#new"
  #end

  devise_for :users, :controllers => {:registrations => "users/registrations", :sessions => "users/sessions"}

  resources :users do
    collection {
      get :setting
      get :credits
      get :blips
      get :buypitch
      get :sellpitch
      get :question
      get :answer
      get :comment
      post :imageuploader


    }

    member {

      put :follow
      put :unfollow

    }
  end

  resources :home  do
    collection {
      get :landing
      get :blips
      get :sellpitch
      get :buypitch
    }
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#landing'



  put '/' => 'companies#index'




  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
