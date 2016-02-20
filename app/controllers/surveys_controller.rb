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
   @questions = @survey.questions
   erb :'surveys/show'
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
  @survey = Survey.find(params[:survey_id])
  if logged_in?
    if @survey.user_answers.any?{|user_answer| user_answer.user_id == current_user.id}
      erb :'/taken-already'
    else
      params[:input].each_value do |answer|
        UserAnswer.create(user_id: current_user.id, answer_id: answer)
      end
      redirect "/"
    end
  else
    @errors = ["You need to login to take this survey."]
    erb :'sessions/login'
  end
end

