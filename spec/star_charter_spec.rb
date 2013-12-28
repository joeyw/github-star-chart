require 'helper'

describe ".combine_starred" do
  context "with two users with overlapping starred repos" do
    it "combines users starred repositories" do
      pengwynn = {
        login: 'pengwynn',
        starred: [
          {full_name: 'octokit/octokit.rb'},
          {full_name: 'heroku/hk'}
        ]
      }
      joeyw = {
        login: 'joeyw',
        starred: [
          {full_name: 'octokit/octokit.rb'},
          {full_name: 'jp9000/obs'}
        ]
      }
      expected_result = {
        'heroku/hk' => { stargazers: ['pengwynn'] },
        'jp9000/obs' => { stargazers: ['joeyw'] },
        'octokit/octokit.rb' => { stargazers: ['pengwynn', 'joeyw'] }
      }.sort
      result = StarCharter.combine_starred(pengwynn, joeyw)

      expect(result.sort).to eq(expected_result)
    end
  end
end

