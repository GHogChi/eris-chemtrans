# smiles_to_iupacPrefix.rb

class ParsedSmiles

  attr_reader :parent_chain_len, :is_branched

  def initialize smiles
    @parent_chain_len = 0
    smiles.each_char { |c| 
      @parent_chain_len += 1 if c == 'C'
      @is_branched = true if c == '('    
    }
  end

end

class SmilesToIupacTranslator
    
  ALKANE_SUFFIX = "ane"
  ALKYL_SUFFIC = "yl"
  REGULAR_DIGIT_MORPHEMES = ["","un","do","tri","tetr","pent","hex","hept","oct","non"]
    
  def translate smiles
    iupac = []
    if multiSmiles = Array.try_convert(smiles)
      iupac = multiSmiles.collect {|oneSmiles| translateSingle oneSmiles}
    elsif singleSmiles = String.try_convert(smiles)
      iupac =  translateSingle singleSmiles 
    end
    iupac
  end

  def translateSingle smiles
    parsed = ParsedSmiles.new smiles
    iupacBody = translateParentChain parsed.parent_chain_len
    if parsed.is_branched
      iupacBody = "2-methyl-" + iupacBody
    else
    end
    if iupacBody == nil
      iupacBody = "error!"
    end
      #todo convert to a single regexp if possible
    iupac = iupacBody + ALKANE_SUFFIX
    iupac = iupac.gsub(/a[ia]/,"a")
    iupac = iupac.gsub(/oi/,"o")
    iupac.gsub(/ii/,"i")
  end

  def translateParentChain length
      parentChainName = buildIrregularBody length
      if parentChainName == nil 
	parentChainName = buildRegularBody length
      end
      parentChainName
  end

# terms are based on http://www.chem.qmul.ac.uk/iupac/misc/numb.html
  def buildRegularBody carbonCount
    onesValue = carbonCount % 10
    onesTerm = ["","hen","do","tri","tetra","penta","hexa","hepta","octa","nona"][onesValue]
    tensValue = (carbonCount / 10) % 10
    tensTerm = ["","deca","icosa","triaconta","tetraconta","pentaconta","hexaconta","heptaconta","octaconta","nonaconta"][tensValue]
    hundredsValue = (carbonCount /100) % 10
    hundredsTerm = ["","hect","dicta","tricta","tetracta","pentacta","hexacta","heptacta","octacta","nonacta"][hundredsValue]
    thousandsValue = (carbonCount /1000) % 10
    thousandsTerm = ["","kili","dili","trili","tetrali","pentali","hexali","heptali","octali","nonali"][thousandsValue]
    iupac = onesTerm + tensTerm + hundredsTerm + thousandsTerm
    iupac = iupac.gsub(/nh/,"nih")
    iupac.gsub(/th/,"tah")
  end

  def buildIrregularBody carbonCount
    iupacBody = case carbonCount
	when  1
	   "meth"
	when  2
	   "eth"
	when  3
	   "prop"
	when  4
	   "but"
	when  11
	   "undec"
        when 111
	   "undecahect"
    end
  end
end
