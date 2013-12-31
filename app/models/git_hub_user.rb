class GitHubUser
  class << self

    # Fetch a user and their starred repositories
    #
    # @param login [String] GitHub username.
    # @return [Hash] User and their starred repositories.
    def fetch(login)
      user = Rails.cache.fetch(login) do
        user_hash = octokit.user(login).to_hash
        user_hash[:starred] = octokit.starred(login)
        user_hash.to_json
      end
      JSON.parse(user, :symbolize_names => true)
    end

    def fetch_followingers(login)
      octokit.following login
    end

    def fetch_user_and_followingers(login)
      [fetch(login)].concat fetch_followingers(login).
        map { |u| fetch(u.login) }
    end

    def top_starred_languages(login)
      user = fetch(login)
      user[:starred].group_by { |repo| repo[:language] }.
        map { |lang| { (lang[0] || 'Undefined') => lang[1].length } }.
        sort_by { |lang| lang[lang.keys.first] }.
        reverse[0..2].
        collect { |lang| lang.keys.first }
    end

    private

    def octokit
      Octokit::Client.new :auto_paginate => true
    end

  end
end
