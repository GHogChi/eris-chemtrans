# smiles_to_iupacPrefix.rb


class SmilesToIupacTranslator
    
  ALKANE_SUFFIX = "ne"
  IUPAC_SEPARATOR = "a"
  REGULAR_DIGIT_MORPHEMES = ["","un","do","tri","tetr","pent","hex","hept","oct","non"]
    

  def countCarbons smiles
    len = 0
    smiles.each_char {|c| len += 1 if c == 'C'}
    len
  end   

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
    carbonCount = countCarbons smiles
    iupacBody = buildIrregularBody carbonCount
    if iupacBody == nil 
      iupacBody = buildRegularBody carbonCount
    end
    if iupacBody == nil
      iupacBody = "error!"
    end
      #todo convert to a single regexp if possible
    iupac = iupacBody + IUPAC_SEPARATOR + ALKANE_SUFFIX
    iupac = iupac.gsub(/a[ia]/,"a")
    iupac = iupac.gsub(/oi/,"o")
    iupac.gsub(/ii/,"i")
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
#puts "NTT: " + carbonCount.to_s + "TV: " + tensValue.to_s  + " TM: " + tensTerm
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
