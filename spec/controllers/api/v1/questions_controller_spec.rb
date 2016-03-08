require 'rails_helper'
require 'json'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  describe "Fetching a list of questions" do
    render_views

    context "with valid api key" do
      it "includes the question's title" do
        user = User.create(first_name: "John", last_name: "Smith",
                           email: "test@test.ca", password: "password")
        question = Question.create(title: "Awesome Question", body: "Hello World!")
        get :index, api_key: user.api_key, format: :json
        expect(response.body).to match(/#{question.title}/i)
      end

      it "includes the question's body" do
        user = User.create(first_name: "John", last_name: "Smith",
                           email: "test@test.ca", password: "password")
        question = Question.create(title: "Awesome Question", body: "Hello World!")
        get :index, api_key: user.api_key, format: :json
        parsed_json = JSON.parse(response.body)
        puts ">>>>>>>>>>"
        puts parsed_json
        puts ">>>>>>>>>>"
        expect(parsed_json["questions"][0]["body"]).to eq(question.body)
      end

    end

    context "with invalid api key" do
      it "returns a 401 HTTP response code" do
        get :index, format: :json
        expect(response.code).to eq("401")
      end
    end

  end
end
