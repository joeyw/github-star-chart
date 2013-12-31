class GitHubUser

  # Fetch a user and their starred repositories
  #
  # @param login [String] GitHub username.
  # @return [Hash] User and their starred repositories.
  def self.fetch(login)
    user = Rails.cache.fetch(login) do
      user_hash = octokit.user(login).to_hash
      user_hash[:starred] = octokit.starred(login)
      user_hash.to_json
    end
    JSON.parse(user, :symbolize_names => true)
  end

  private

  def octokit
    @octokit ||= Octokit::Client.new :auto_paginate => true
  end

end
