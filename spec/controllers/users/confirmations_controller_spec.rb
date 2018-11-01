require 'spec_helper'

describe Users::Confirmations, type: :controller do
  let(:loged_in_with_france_connect) { User.loged_in_with_france_connects.fetch(:particulier) }
  let(:user) { create(:user, loged_in_with_france_connect: loged_in_with_france_connect) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe '#show' do
    it 'signs in the user after confirming its token' do
      # TODO
    end


    it 'redirects the user to its home page' do
      # TODO
    end

    context 'when the user attempted to start a demarche before' do
      before { session["user_return_to"] = '?procedure_id=0' }

      it 'redirects the user to the demarche' do
        # TODO
      end
    end

    context 'when the auto-sign-in delay has expired' do
      it 'redirects the user to the sign-in path' do
        # TODO
      end
    end
  end
end
