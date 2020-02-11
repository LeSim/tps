require 'spec_helper'

describe Champs::CheckboxChamp do
  let(:types_de_champ) do
    [
      create(:type_de_champ_header_section),
      create(:type_de_champ_civilite),
      create(:type_de_champ_text),
      create(:type_de_champ_header_section),
      create(:type_de_champ_email)
    ]
  end

  let(:procedure) { create(:procedure, types_de_champ: types_de_champ) }
  let(:dossier) { create(:dossier, procedure: procedure) }

  describe '#section_index' do
    let(:first_header)  { dossier.champs[0] }
    let(:second_header) { dossier.champs[3] }

    it 'returns the index of the section (starting from 1)' do
      expect(first_header.section_index).to eq 1
      expect(second_header.section_index).to eq 2
    end
  end
end
