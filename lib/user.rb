

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji
  
  def initialize(real_name:, status_text: nil , status_emoji: nil, slack_id:, name:)
    super(slack_id: slack_id, name: name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end
  
  # def details
  # end
  
  def self.list
    response = self.get("https://slack.com/api/users.list", ENV["SLACK_TOKEN"])

    members = response["members"].map do |member|
      self.new(slack_id: member["id"],  name: member["name"], real_name: member["real_name"] )
    end
    return members
  end
end