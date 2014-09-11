class SearchController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]
  def index
    @repos = []
    @page_numbers = []
    params[:filter] = nil if params[:commit] == 'Reset'
    filter = params[:filter]
    if filter && filter[:search]
      client = Octokit::Client.new(:access_token => current_user.token)
      page = params[:page].present? ? params[:page].to_i : 1
      opts = {
        :per_page => filter[:per_page],
        :sort => filter[:sort].downcase,
        :order => filter[:sort_order].downcase,
        :page => page
      }
      search = (filter[:language] && !filter[:language].empty?) ? filter[:search] + '+language:' + filter[:language] : filter[:search]
      result = client.search_repositories(search, opts)
      @count = @total_count = result.total_count

      # This is a limit on github api https://developer.github.com/v3/search/#about-the-search-api
      @count = 1000 if @count > 1000
      if @count > filter[:per_page].to_i
        @total_pages = (@count.to_f / filter[:per_page].to_i).ceil
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
