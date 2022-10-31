module Api
  module V1
    class BooksController < ApplicationController
      include ActionController::HttpAuthentication::Token

      MAX_PAGINATION_LIMIT = 100

      before_action :set_book, only: [:update, :destroy]
      before_action :authenticate_user, only: [:create, :destroy]

      def index
        @books = Book.limit(limit).offset(params[:offset])
    
        render json: BooksRepresenter.new(@books).as_json
      end
    
      def create
        @author = Author.create!(author_params)
        @book = Book.new(book_params.merge(author_id: @author.id))
    
        if @book.save
          render json: BookRepresenter.new(@book).as_json, status: :created
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end
    
      def destroy
        @book.destroy
      end
    
      private

      def authenticate_user
        begin
          # _ : nghia la ko quan tam 
          token, _options = token_and_options(request)
          user_id = AuthenticationTokenService.decode(token)
          User.find(user_id)
        rescue ActiveRecord::RecordNotFound
          render status: :unauthorized
        end
      end

      def limit
        [
          # Nếu có params[:limit] thì sử dụng giá trị đó, nếu ko thì là MAX_PAGINATION_LIMIT
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
          MAX_PAGINATION_LIMIT
        ].min
      end

      def set_book
        @book = Book.find(params[:id])
      end

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end
    
      def book_params
        params.require(:book).permit(:title)
      end
    end    
  end
end