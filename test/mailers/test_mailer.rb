class TestMailer < ActionMailer::Base
  def hello
    mail(
      :subject => 'Hello from Postmark',
      :to  => 'cdwhight@gmail.com',
      :from => 'welcome@templatejobs.co.uk',
      :html_body => '<strong>Hello</strong> dear Postmark user.',
      :track_opens => 'true')
  end
end
