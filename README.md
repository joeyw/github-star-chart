# github-star-chart

Welcome to the birth of an idea.

If you are not reading this from an old version then you are witnessing the
inception of a small project. Said project has two meta goals. The first meta
goal being to make something (hopefully interesting) using Octokit.rb. The
second meta goal is for the project to be open source and live on GitHub from
inception, which is already started since this repository was created from the
GitHub website.

Enough nonsense, what is this? Right now the idea floating in my head is to
take the list of people you are following on GitHub, get their list of starred
repositories, do some magic and present it nicely in such a way that
repositories starred by multiple users are grouped. Down the road that output
may be sortable by languages and/or other sorty things. That is pretty much the
basic concept at this point, as I work towards it I'm sure more things will
come to mind. Thoughts? Open an issue.

# Notes

This app is single user focused at this early stage. You will need a personal
GitHub API token for Octokit if you run into rate limit issues. It can be set
by exporting `OCTOKIT_ACCESS_TOKEN`. See [Creating an access token][token]

[token]: https://help.github.com/articles/creating-an-access-token-for-command-line-use

The secret token for the rails app can be set by exporting
`GITHUB_STAR_CHART_SECRET_KEY_BASE`. You can use `rake secret` to
generate a secure secret key.
