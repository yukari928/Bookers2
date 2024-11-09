class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @book = Book.new(title: "Default Title", body: "Default Body")
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @users = User.all
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
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
    @books = Book.new
    @book = Book.find(params[:id])
    @users = User.all
    @book_comment = BookComment.new
    @other_user = User.find_by(id: 2)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
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

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end


end
