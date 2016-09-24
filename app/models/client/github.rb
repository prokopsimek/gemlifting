class Client::Github

  def get_repo_info_hash(gh_uri)
    client = Octokit::Client.new(access_token: ENV['GITHUB_API_TOKEN'])

    repo_user_and_name = get_gh_repo_string(gh_uri)

    client.repo repo_user_and_name
  end

  private

  def get_gh_repo_string(gh_uri)
    # regex tester: https://regex101.com/r/pT7kE6/4
    regex = /(?<=github\.com\/)(?!repos)(.*?)\/(.*?)(?=\/|$)|(?<=github\.com\/repos\/)(.*?)\/(.*?)(?=\/|$)/

    gh_uri.match(regex).to_s
  end

end
