class BooksController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    def index
        @books = Book.all
    end
    def new
        @book = Book.new
      end
    
    def create
        book = Book.new(book_params)
        book.user_id = current_user.id
        if book.save
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
    end
        def show
            @book = Book.find(params[:id])
            @comments = @book.comments
            @comment = Comment.new
          end
        
          def edit
            @book = Book.find(params[:id])
          end
        
          def update
            book = Book.find(params[:id])
            if book.update(book_params)
              redirect_to :action => "show", :id => book.id
            else
              redirect_to :action => "new"
            end
          end
        
          def destroy
            book = Book.find(params[:id])
            book.destroy
            redirect_to action: :index
          end
      end
    
      private
      def book_params
        params.require(:book).permit(:title, :author, :about, :image)
      end 
