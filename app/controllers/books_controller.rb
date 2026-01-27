class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [ :edit, :update, :destroy ]

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = Current.user

    if @book.save
      redirect_to book_path(@book), notice: "Book was successfully created."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end

  private

  def ensure_correct_user
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user == Current.user
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
