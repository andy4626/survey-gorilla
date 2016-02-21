get '/surveys/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  if logged_in?
    if @survey.user_answers.any?{|user_answer| user_answer.user_id == current_user.id}
      erb :'/taken-already'
    else
      @questions = @survey.questions
      erb :'surveys/show'
    end
  else
    erb :'/taken-already'
  end
end

get '/surveys/:survey_id/tokens' do
  @survey = Survey.find(params[:survey_id])
  # token.generate_key
  @tokens = @survey.tokens
  if @survey.user.id == current_user.id
    erb :token_list
  else
    redirect "/users/#{@token.survey.user_id}"
  end
end

post '/surveys/:survey_id/tokens' do
  survey = Survey.find(params[:survey_id])
  if logged_in? && survey.user_id == current_user.id
    token = Token.create(survey_id: survey.id)
    @tokens = survey.tokens
    erb :token_list
  end
    redirect "/users/#{survey.user_id}"
end

get '/surveys/:survey_id/:key' do
  @url = params[:key]
  token = Token.find_by(url: @url, survey_id: params[:survey_id])
  if token
    token.destroy
    redirect "/surveys/#{token.survey_id}"
  else
    erb :"/taken-already"
  end
end


get '/surveys/:survey_id/results' do
  @survey = Survey.find(params[:survey_id])
  if logged_in? && current_user.id == @survey.user.id
    # UserAnswer.where(answer_id.question.id.survey.id == @survey.id)
    erb :'surveys/results'
  else
    redirect "/surveys/#{@survey.id}"
  end
end

post '/surveys/:survey_id' do
  params[:input].each_value do |answer|
    UserAnswer.create(user_id: current_user.id, answer_id: answer)
  end
  redirect "/"
end

