require 'rails_helper'

RSpec.describe 'Books API', type: :request do
  let!(:user) { FactoryBot.create(:user, username: 'TuChan', password: '123456') }
  let(:first_author) { FactoryBot.create(:author, first_name: 'Nguyen', last_name: 'A', age: 20) }
  let(:second_author) { FactoryBot.create(:author, first_name: 'Nguyen', last_name: 'B', age: 20) }

  describe 'GET /books' do
    before do
      FactoryBot.create(:book, title: 'title 1', author: first_author)
      FactoryBot.create(:book, title: 'title 2', author: second_author)
    end

    it 'returns all books' do
      get '/api/v1/books'
      
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to eq(
        [
          {
            "id" => 1,
            "title" => "title 1",
            "author_name" => "Nguyen A",
            "author_age" => 20
          },
          {
            "id" => 2,
            "title" => "title 2",
            "author_name" => "Nguyen B",
            "author_age" => 20
          }
        ]
      )
    end

    it 'returns a subset of books based on limit' do
      get '/api/v1/books?limit=1'
      
      expect(response).to have_http_status(:success)
      expect(Author.count).to eq(2)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            "id" => 1,
            "title" => "title 1",
            "author_name" => "Nguyen A",
            "author_age" => 20
          }
        ]
      )
    end

    it 'returns a subset of books based on limit and offset' do
      get '/api/v1/books?limit=1&offset=1'

      expect(response).to have_http_status(:success)
      expect(Author.count).to eq(2)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            "id" => 2,
            "title" => "title 2",
            "author_name" => "Nguyen B",
            "author_age" => 20
          }
        ]
      )
    end
  end

  describe 'POST /books' do
    it 'create a new book' do
      expect {
        post '/api/v1/books', params: {
          book: {title: 'title 3'},
          author: {first_name: 'Nguyen', last_name: 'C', age: 20}
        }, headers: { "Authorization" => "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.DiPWrOKsx3sPeVClrm_j07XNdSYHgBa3Qctosdxax3w" }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
      expect(response_body).to eq(
        {
          "id" => 1,
          "title" => "title 3",
          "author_name" => "Nguyen C",
          "author_age" => 20
        }
      )
    end
  end
  
  describe 'DELETE /books/:id' do
    let!(:book) { FactoryBot.create(:book, title: 'title 1', author: first_author) }

    it 'deletes a book' do
      expect {
        delete "/api/v1/books/#{book.id}", headers: { "Authorization" => "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.DiPWrOKsx3sPeVClrm_j07XNdSYHgBa3Qctosdxax3w" }
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end