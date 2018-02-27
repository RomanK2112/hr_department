class PostMailer < ApplicationMailer
  def send_posts(recipients, post, group_name)
    @post = post
    emails = recipients.collect(&:email).join(',')
    mail to: emails, subject: "Posts from group: #{group_name}"
  end
end
