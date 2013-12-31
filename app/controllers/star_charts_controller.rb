class StarChartsController < ApplicationController
  def index
    @users = [
      GitHubUser.fetch('pengwynn'),
      GitHubUser.fetch('joeyw')
    ]
    @starred = StarCharter.combine_starred(*@users)
    @combined = @starred.select { |starred| 
      @starred[starred][:stargazers].length > 1
    }

  end
end
