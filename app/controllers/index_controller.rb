class IndexController < ApplicationController
  def index
    @categories = Category.all
  end
end
