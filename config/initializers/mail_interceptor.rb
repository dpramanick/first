
#options = { forward_emails_to: 'intercepted_emails@domain.com',
 #           deliver_emails_to: ["@wheel.com"] }

#unless (Rails.env.test? || Rails.env.production?)
 #ActionMailer::Base.register_interceptor(interceptor)
#end