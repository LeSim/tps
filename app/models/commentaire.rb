class Commentaire < ActiveRecord::Base
  belongs_to :dossier
  belongs_to :champ

  belongs_to :piece_justificative

  after_save :notify_gestionnaires
  after_save :notify_user_with_mail

  def header
    "#{email}, " + I18n.l(created_at.localtime, format: '%d %b %Y %H:%M')
  end

  private

  def notify_gestionnaires
    if email == dossier.user.email || dossier.invites_user.pluck(:email).to_a.include?(email)
      NotificationService.new('commentaire', self.dossier.id).notify
    end
  end

  def notify_user_with_mail
    NotificationMailer.new_answer(dossier).deliver_now! unless (current_user.try(:email) == dossier.user.email || email == 'contact@tps.apientreprise.fr')
  end
end
