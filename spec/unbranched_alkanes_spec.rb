# unbranched_alkanes_spec.rb
require_relative '../src/smiles_to_iupac.rb'

describe SmilesToIupacTranslator do
  it "translates H-suppressed methane representation from SMILES to IUPAC" do
    translator = SmilesToIupacTranslator.new
    iupac = translator.translate makeUnbranched 1
    iupac.should eq "methane"
  end
  it "translates H-suppressed ethane representation from SMILES to IUPAC" do
    translator = SmilesToIupacTranslator.new
    iupac = translator.translate makeUnbranched 2
    iupac.should eq "ethane"
  end
  it "translates H-suppressed nonane representation from SMILES to IUPAC" do
    translator = SmilesToIupacTranslator.new
    iupac = translator.translate makeUnbranched 9
    iupac.should eq "nonane"
  end
  it "translates H-suppressed decane representation from SMILES to IUPAC" do
    translator = SmilesToIupacTranslator.new
    iupac = translator.translate makeUnbranched 10
    iupac.should eq "decane"
  end
  it "translates H-suppressed nonadecane representation from SMILES to IUPAC" do
    translator = SmilesToIupacTranslator.new
    iupac = translator.translate makeUnbranched 19
    iupac.should eq "nonadecane"
  end
  def makeUnbranched carbonCount
    c = ""
    1.upto(carbonCount) {c << "C"}
    c
  end

end
