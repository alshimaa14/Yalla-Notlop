class Message < ApplicationRecord
  after_create do |message| 
    @notify = Notification.create(event: "#{message.body}", user_id: "#{message.msgid}")
  end

  # after_create_commit { notify }
  # private

  # def notify
  #   Notification.create(event: "New Notification", user_id: message.id)
  # end
end
