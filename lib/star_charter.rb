require 'octokit'

class StarCharter
  class << self

    # Combine the starred repositories of a set of users into a hash
    # with the repositories name as the key for the repository and an
    # array of users starring it.
    #
    # @param users [Hash] One or more GitHub users and their starred
    # repositories to combine together.
    # @return [Hash] Repositories with a list of their stargazers.
    def combine_starred(*users)
      result = {}
      users.each do |user|
        user[:starred].each do |repo|
          key = repo[:full_name]
          result[key] = { stargazers: [] } if result[key].nil?
          result[key][:stargazers].push user[:login]
        end
      end
      result
    end

    # Fetch a user and their starred repositories
    #
    # @param user [String] GitHub username.
    # @return [Hash] User and their starred repositories.
    def fetch_user(user)
      user_hash = octokit.user(user).to_hash
      user_hash[:starred] = octokit.starred(user)
      user_hash
    end

    private

    def octokit
      @octokit ||= Octokit::Client.new :auto_paginate => true
    end
  end
end

