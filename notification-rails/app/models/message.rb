class Message < ApplicationRecord
  after_create_commit :notify
  private
  def notify
    Notification.create(event: "✉️ #{self.body}")
  end
end
