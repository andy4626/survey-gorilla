get '/users/:user_id' do
  @user = User.find(params[:user_id])
  erb :'users/show'
end
