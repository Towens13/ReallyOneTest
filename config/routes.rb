ReallyOneTest::Application.routes.draw do
  devise_for :users
  get 'home' , to: 'application#home'

end
