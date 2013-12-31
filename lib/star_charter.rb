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

    def shared_starred(target, *users)
      starred = combine_starred(*users)
      starred.select { |repo|
        starred[repo][:stargazers].include?(target) &&
        starred[repo][:stargazers].length > 1
      }
    end
  end
end

