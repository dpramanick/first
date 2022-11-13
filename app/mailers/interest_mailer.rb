class InterestMailer < ApplicationMailer
  def notify
    @seller = params[:seller_id]
    @seller_email = User.find_by(id: params[:seller_id]).email 
    @current_user = params[:current_user]
        
  mail(
      from: 'instrumentmarket.com<donotreply@instrumentmarket.com>',
      to: @seller_email,
      subject: "Someone wants to buy your Product"
    )
  end
end
