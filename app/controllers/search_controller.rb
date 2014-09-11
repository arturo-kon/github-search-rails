class SearchController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]
  def index
    @repos = []
    @page_numbers = []
    params[:filter] = nil if params[:commit] == 'Reset'
    if params[:filter] && params[:filter][:search]
      client = Octokit::Client.new(:access_token => current_user.token)
      page = params[:page].present? ? params[:page].to_i : 1
      opts = {
        :per_page => params[:filter][:per_page],
        :sort => params[:filter][:sort].downcase,
        :order => params[:filter][:sort_order].downcase,
        :page => page
      }
      search = params[:filter][:language] ? params[:filter][:search] + '+language:' + params[:filter][:language] : params[:filter][:search]
      result = client.search_repositories(search, opts)
      @count = result.total_count
      if @count > params[:filter][:per_page].to_i
        @total_pages = (result.total_count.to_f / params[:filter][:per_page].to_i).ceil
        @current_page = page
        @page_numbers = [@current_page]
        2.times do
          @page_numbers.unshift((@page_numbers.first - 1)) if @page_numbers.first > 1
          @page_numbers << (@page_numbers.last + 1) if @page_numbers.last < @total_pages
        end
      end
      @repos = result.items
    end
  end

  def home
    if current_user
      redirect_to action: 'index'
    end
  end
end
