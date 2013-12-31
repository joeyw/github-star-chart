class StarChartsController < ApplicationController
  def index 
    target = 'joeyw'
    users = GitHubUser.fetch_user_and_followingers(target)
    @starred = StarCharter.combine_starred(*users)
    @shared_starred = StarCharter.shared_starred(target, *users).sort
    @top_starred_languages = GitHubUser.top_starred_languages(target)
    @very_descript_variable_name = GitHubUser.magic(target)
  end
end
