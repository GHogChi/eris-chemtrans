# unbranched_alkanes_spec.rb
require_relative '../src/smiles_to_iupac.rb'
require 'chem_trans_test_util.rb'
include ChemTransTestUtil

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

    it "translates undecane correctly" do
      smiles = smilize [11,111]
      iupac = @translator.translate smiles
      iupac.should eq ["undecane","undecahectane"]
    end

  end

  describe "regular names" do

    it "translates H-suppressed nonane representation from SMILES to IUPAC" do
      iupac = @translator.translate makeUnbranched 9
      iupac.should eq "nonane"
    end

    it "translates numbers in the eighties - potentially problematic because octa starts with a vowel" do
      smiles = smilize [81,82,83,84]
      iupac = @translator.translate smiles
      iupac.should eq ["henoctacontane","dooctacontane","trioctacontane","tetraoctacontane"]
    end
    
    it "translates multiples of 10 correctly" do
      smiles = smilize 1.upto(9).collect {|n| n * 10}
      iupac = @translator.translate smiles
      iupac.should eq ["decane","icosane","triacontane","tetracontane","pentacontane",\
      		"hexacontane","heptacontane","octacontane","nonacontane"]
    end

    it "translates 1-10 carbons correctly" do
      smiles = smilize 1.upto(10)
      iupac = @translator.translate smiles
      iupac.should eq ["methane","ethane","propane","butane","pentane","hexane","heptane","octane","nonane","decane"]
    end

    it "translates 11-20 carbons correctly" do
      smiles = smilize 11.upto(20)
      iupac = @translator.translate smiles
      iupac.should eq ["undecane","dodecane","tridecane","tetradecane","pentadecane","hexadecane","heptadecane","octadecane","nonadecane","icosane"]
    end

#NOTE: every IUPAC name above 30 is fully regular so an exhaustive test should not be necessary
    it "translates 21-30 carbons correctly" do
      smiles = smilize 21.upto(30)
      iupac = @translator.translate smiles
      iupac.should eq ["henicosane","docosane","tricosane","tetracosane","pentacosane","hexacosane","heptacosane","octacosane","nonacosane","triacontane"]
    end

    it "translates 100-900 by 100s correctly" do
      smiles = smilize 1.upto(9).collect {|n| n * 100}
      iupac = @translator.translate smiles
      iupac.should eq ["hectane","dictane","trictane","tetractane","pentactane","hexactane","heptactane","octactane","nonactane"]
    end

    it "translates 1000-9000 by 1000s correctly" do
      smiles = smilize 1.upto(9).collect {|n| n * 1000}
      iupac = @translator.translate smiles
      iupac.should eq ["kiliane","diliane","triliane","tetraliane","pentaliane","hexaliane","heptaliane","octaliane","nonaliane"]
    end

    it "translates 101-104,199 carbons correctly" do
      smiles = smilize [100,101,102,103,104,199]
      iupac = @translator.translate smiles
      iupac.should eq ["hectane","henihectane","dohectane","trihectane","tetrahectane","nonanonacontahectane"]
    end

    it "translates some big ones" do
      smiles = smilize [1234,5678,9999,8765,4321]
      iupac = @translator.translate smiles
      iupac.should eq ["tetratriacontadictakiliane","octaheptacontahexactapentaliane","nonanonacontanonactanonaliane","pentahexacontaheptactaoctaliane","henicosatrictatetraliane"]
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

end

