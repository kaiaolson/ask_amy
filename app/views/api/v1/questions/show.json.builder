json.array! @questions do |question|
  json.id    question.id
  json.title question.title.capitalize
  json.url   question_url(question)
  json.answers question.answers do |answer|
    json.id answer.id
    json.body   answer.body
  end
  json.tags question.tags do |tag|
    json.id tag.id
    json.name tag.name
  end
end
