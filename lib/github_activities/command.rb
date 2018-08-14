require 'github_activities'
require 'thor'
require 'github_activities/comment_and_reaction'

module GithubActivities
  class Command < Thor
    option :login_user, aliases: ['l', 'u'], required: true
    option :password, aliases: 'p', required: true
    option :repository, aliases: 'r', required: true
    option :name, aliases: 'n', required: true
    option :pages, type: :numeric, default: 1
    desc '', '特定リポジトリ、対象ユーザーのコメントとリアクションを返します'
    def get
      hello = GithubActivities::CommentAndReaction.new
      hello.get(options)
    end
  end
end