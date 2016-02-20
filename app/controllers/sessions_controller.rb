get '/login' do
  erb :'/sessions/login'
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = user.errors.full_messages
    @errors << 'Wrong username or password'
    erb :'sessions/login'
  end
end

post '/signup' do
  new_user = User.new(params[:user])
  if new_user.save
    session[:user_id] = new_user.id
    redirect '/'
  else
    @errors = new_user.errors.full_messages
  end
end

get '/signup' do
  erb :'sessions/signup'
end

get '/logout' do
  session.clear
  redirect '/'
end

