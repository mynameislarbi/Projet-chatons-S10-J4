class UserMailer < ApplicationMailer
    default from: 'catshop@yopmail.com'
    def user
        mail(to: 'catshop@yopmail.com' , subject: 'sujet de test')
    end
end
