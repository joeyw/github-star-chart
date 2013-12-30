class GitHubUser

  # Fetch a user and their starred repositories
  #
  # @param user [String] GitHub username.
  # @return [Hash] User and their starred repositories.
  def fetch(user)
    user_hash = octokit.user(user).to_hash
    user_hash[:starred] = octokit.starred(user)
    user_hash
  end

  private

  def octokit
    @octokit ||= Octokit::Client.new :auto_paginate => true
  end

end
