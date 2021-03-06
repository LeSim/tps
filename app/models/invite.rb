# == Schema Information
#
# Table name: invites
#
#  id           :integer          not null, primary key
#  email        :string
#  email_sender :string
#  message      :text
#  created_at   :datetime
#  updated_at   :datetime
#  dossier_id   :integer
#  user_id      :integer
#
class Invite < ApplicationRecord
  include EmailSanitizableConcern

  belongs_to :dossier, optional: false
  belongs_to :user, optional: true

  before_validation -> { sanitize_email(:email) }

  after_create_commit :send_notification

  validates :email, presence: true
  validates :email, uniqueness: { scope: :dossier_id }

  validates :email, format: { with: Devise.email_regexp, message: "n'est pas valide" }, allow_nil: true

  # #1619 When an administrateur deletes a `Procedure`, its `hidden_at` field, and
  # the `hidden_at` field of its `Dossier`s, get set, effectively removing the Procedure
  # and Dossier from their respective `default_scope`s.
  # Therefore, we also remove `Invite`s for such effectively deleted `Dossier`s
  # from their default scope.
  scope :kept, -> { joins(:dossier).merge(Dossier.kept) }

  default_scope { kept }

  def send_notification
    if self.user.present?
      InviteMailer.invite_user(self).deliver_later
    else
      InviteMailer.invite_guest(self).deliver_later
    end
  end
end
