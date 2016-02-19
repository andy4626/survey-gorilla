get '/survey/new' do
  erb :survey_new
end

post '/survey' do
  @survey = Survey.new(name: params[:survey_name])
  if @survey.save
    redirect "/survey/#{@survey.id}/question/new"
  else
    @errors=["You need to put in a survey name"]
    # erb :'error partial'
  end
end

get '/survey/:survey_id/question/new' do
  @survey = Survey.find(params[:survey_id])
  erb :question_new
end


post '/survey/:survey_id/question' do
  @survey= Survey.find(params[:survey_id])
  @question = Question.new(content: params[:question], survey_id: @survey.id)
  if @question.save
    redirect "/survey/#{@survey.id}/question/#{@question.id}/answer/new"
  else
    @errors=["You need to put in a question"]
    # erb :'error partial'
  end
end


get '/survey/:survey_id/question/:question_id/answer/new' do
  @survey = Survey.find(params[:survey_id])
  @question = Question.find(params[:question_id])
  erb :answer_new
end

post '/survey/:survey_id/question/:question_id/answer' do
  @survey = Survey.find(params[:survey_id])
  @answer = Answer.new(content: params[:answer], question_id: params[:question_id])
  if @answer.save
    redirect "/survey/#{@survey.id}/question/new"
  end
end
