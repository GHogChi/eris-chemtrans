# unbranched_alkanes_spec.rb
require_relative '../src/smiles_to_iupac.rb'

describe SmilesToIupacTranslator do

  before :all do # translator is stateless
    @translator = SmilesToIupacTranslator.new
  end

  describe "irregular names" do
    
    it "translates the first four SMILES to the  corresponding irregular IUPAC names" do
      smiles = smilize [1,2,3,4]
      iupac = @translator.translate smiles
      iupac.should eq ["methane","ethane","propane","butane"]
    end

  end

  describe "regular names" do

    it "translates H-suppressed nonane representation from SMILES to IUPAC" do
      iupac = @translator.translate makeUnbranched 9
      iupac.should eq "nonane"
    end

    it "translates H-suppressed decane representation from SMILES to IUPAC" do
      iupac = @translator.translate makeUnbranched 10
      iupac.should eq "decane"
    end

    it "translates H-suppressed nonadecane representation from SMILES to IUPAC" do
      iupac = @translator.translate makeUnbranched 19
      iupac.should eq "nonadecane"
    end

    it "translates multiple SMILES names to IUPAC" do
      smiles = Array.new(2)
      smiles[0] = makeUnbranched 1
      smiles[1] = makeUnbranched 2
      iupac = @translator.translate smiles
      puts iupac.inspect
      iupac[0].should eq "methane"
      iupac[1].should eq "ethane"
    end

  end  

  describe "unsupported stuff" do

    describe "ignored text" do

      it "ignores every char except C" do # Assume valid SMILES
        iupac = @translator.translate "2837HOiquwyecC"
	iupac.should eq "methane"
      end
    end

  end

  def makeUnbranched carbonCount
    c = ""
    1.upto(carbonCount) {c << "C"}
    c
  end

  def smilize smiles #convert an array of integers to an array of SMILES unbranched H-suppressed alkanes
    smiles.collect {|carbonCount| makeUnbranched carbonCount}
  end

end
