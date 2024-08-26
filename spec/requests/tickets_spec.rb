require "rails_helper"

RSpec.describe "Tickets", type: :request do
  describe "POST /tickets" do
    context "success" do
      it "returns success" do
        post api_v1_tickets_path, params: { title: 'xpto', user_id: 12345, tags: ['tag one', 'tag two'] }
        expect(response).to have_http_status(201)
        res = JSON.parse(response.body).with_indifferent_access
        expect(res.keys).to include("id", "title", "user_id", "tags")
      end

      context "when sending an empty list of tags" do
        it "returns success" do
          post api_v1_tickets_path, params: { title: 'xpto', user_id: 12345, tags: [] }
          expect(response).to have_http_status(201)
        end
      end
    end

    context "with error" do
      it "renders the messages" do
        post api_v1_tickets_path, params: { }
        res = JSON.parse(response.body).with_indifferent_access
        expect(res).to have_key(:errors)
        expect(res[:errors]).to include("Title must be filled")
      end

      it "renders http status code as 422" do
        post api_v1_tickets_path, params: { }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      context "when sending more than 5 tags" do
        it "returns error message" do
          post api_v1_tickets_path, params: { title: 'xpto', user_id: 12345, tags: ['1', '2', '3', '4', '5', '6'] }
          expect(response).to have_http_status(:unprocessable_entity)
          res = JSON.parse(response.body).with_indifferent_access
          expect(res).to have_key(:errors)
          expect(res[:errors]).to include(" Max of five tags exceeded")
        end
      end
    end
  end
end
