class PagesController < ApplicationController
  layout 'pagessmall'
  def index
    render :layout => 'pages'
  end
end