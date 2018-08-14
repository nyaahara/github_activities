require 'github_activities'
require 'octokit'

module GithubActivities
  class CommentAndReaction
    def get(options)
      Octokit.configure do |c|
        c.login = options[:login_user]
        c.password = options[:password]
      end

      name = options[:name]
      repository = options[:repository]
      pages = options[:pages]

      puts name
      puts repository
      puts pages

      result = []
      client = Octokit::Client.new
      (1..pages).each do |index|
        client.pulls(repository, state: :all, page: index).map(&:number).each do |number|
          client.issue_reactions(repository, number, :accept => 'application/vnd.github.squirrel-girl-preview').
            select {|reaction| reaction.user.login == name}.
            each {|reaction|
              result << OpenStruct.new(user_id: name, number: number, content: reaction.content, created_at: reaction.created_at)
            }
          client.pull_comments(repository, number).
            select {|comment| comment.user.login == name}.
            each {|comment|
              result << OpenStruct.new(user_id: name, number: number, content: comment.body, created_at: comment.created_at)
            }
          client.issue_comments(repository, number).
            select {|comment| comment.user.login == name}.
            each {|comment|
              result << OpenStruct.new(user_id: name, number: number, content: comment.body, created_at: comment.created_at)
            }
        end
      end

      puts '----------'
      puts '----------'
      puts '----------'

      result.sort_by(&:created_at).each do |reaction|
        p reaction
      end

      nil
    end
  end
end