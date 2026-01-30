class BooksController < ApplicationController
  before_action :require_login
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = @book.user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      flash.now[:alert] = "There was an error creating the book."
      render :index
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      flash.now[:alert] = "There was an error updating the book."
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def ensure_correct_user
    redirect_to books_path unless @book.user == current_user
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
