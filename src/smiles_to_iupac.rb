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

  def buildRegularBody numberToTranslate
    onesValue = numberToTranslate % 10
    onesMorpheme = ["","hen","do","tri","tetra","penta","hexa","hepta","octa","nona"][onesValue]
    tensValue = (numberToTranslate / 10) % 10
    tensMorpheme = ["","dec","icos","triacont","tetracont","pentacont","hexacont","heptacont","octacont","nonacont"][tensValue]
    hundredsValue = (numberToTranslate /100) % 10
    hundredsMorpheme = ["","hect","?200?","?300?","?400?","?500?","?600?","?700?","?80?","?900?"][hundredsValue]
#puts "NTT: " + numberToTranslate.to_s + "TV: " + tensValue.to_s  + " TM: " + tensMorpheme
    iupac = onesMorpheme + tensMorpheme + hundredsMorpheme
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
