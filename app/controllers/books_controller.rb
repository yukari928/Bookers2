class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @users = User.all
    if @book.save
      redirect_to books_path(@book.id)
    else
      @books = Book.all
      render :index
    end

  end

  def index
    @users = User.all
    @books = Book.page(params[:page])
    @book = Book.new
    @books = Book.all
  end

  def show
    @users = User.all
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @books = Book.all
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

end
