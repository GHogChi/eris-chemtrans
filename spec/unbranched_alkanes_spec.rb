# unbranched_alkanes_spec.rb
require_relative '../src/smiles_to_iupac.rb'

describe SmilesToIupacTranslator do
  it "translates H-suppressed methane representation from SMILES to IUPAC" do
    translator = SmilesToIupacTranslator.new
    iupac = translator.translate "C"
    iupac.should eq "methane"
  end
  it "translates H-suppressed ethane representation from SMILES to IUPAC" do
    translator = SmilesToIupacTranslator.new
    iupac = translator.translate "CC"
    iupac.should eq "ethane"
  end
  it "translates H-suppressed nonane representation from SMILES to IUPAC" do
    translator = SmilesToIupacTranslator.new
    iupac = translator.translate "CCCCCCCCC"
    iupac.should eq "nonane"
  end
  it "translates H-suppressed decane representation from SMILES to IUPAC" do
    translator = SmilesToIupacTranslator.new
    iupac = translator.translate "CCCCCCCCCC"
    iupac.should eq "decane"
  end
  it "translates H-suppressed nonadecane representation from SMILES to IUPAC" do
    translator = SmilesToIupacTranslator.new
    iupac = translator.translate "CCCCCCCCCCCCCCCCCCC"
    iupac.should eq "nonadecane"
  end
end
