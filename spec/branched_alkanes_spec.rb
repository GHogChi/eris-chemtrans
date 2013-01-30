#branched_alkanes_spec.rb

require_relative '../src/smiles_to_iupac.rb'
require 'chem_trans_test_util.rb'
include ChemTransTestUtil

describe "branched alkanes" do

  before :all do
    @translator = SmilesToIupacTranslator.new
  end


  it "translates a simple branched alkane" do
    smiles = "C(C)C"
    iupac = @translator.translate smiles
    iupac.should eq "2-methyl-ethane"
  end

end

