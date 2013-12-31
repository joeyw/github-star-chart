class StarChartsController < ApplicationController
  def index
    target = 'joeyw'
    @users = [GitHubUser.fetch(target)]
    @users.concat Octokit.following(target).map { |u| GitHubUser.fetch(u.login) }
    @starred = StarCharter.combine_starred(*@users)
    @shared_starred = @starred.select { |starred|
      @starred[starred][:stargazers].include?(target) &&
        @starred[starred][:stargazers].length > 1
    }.sort

  end
end
