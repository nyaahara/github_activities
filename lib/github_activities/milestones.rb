require 'github_activities'
require 'octokit'
require 'csv'

module GithubActivities
  class Milestones
    def get(options)
      Octokit.configure do |c|
        c.login = options[:login_user]
        c.password = options[:password]
      end

      repository = options[:repository]
      milestone = options[:milestone]
      client = Octokit::Client.new
      list_issues = client.list_issues(repository, state: :all, milestone: milestone, accept: 'application/vnd.github.symmetra-preview+json')
      CSV.open("#{milestone}.csv", 'w') do |csv|
        csv << ["スプリントRv前確認", "Author", "案件概要", "プルリクエスト（修正コード）", "確認担当", "リリース判定", "備考", '確認方法', 'リリースノート', '目的', 'テストケース' "issue内容"]
        list_issues.each do |issue|
          /### The person in charge\n\*?(?<person_in_charge>.*).*### How to test to sprint review\n\*?(?<test_procedure>.*).*### Release note\n(?<release_note>.*).*### Purpose\n(?<purpose>.*).*### Testcases\n(?<test_cases>.*)$/m =~ issue.body
          csv << ['', issue.user.login, issue.title, issue.html_url, person_in_charge&.strip, '', '', test_procedure, release_note, purpose, testcases, issue.body]
        end
      end
    end
  end
end