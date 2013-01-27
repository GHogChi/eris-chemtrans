# smiles_to_iupacPrefix.rb


class SmilesToIupacTranslator
    
  ALKANE_SUFFIX = "ne"
  IUPAC_SEPARATOR = "a"
    
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
    iupacPrefix = ""
    carbonCount = countCarbons smiles
    case
    when carbonCount == 1
      iupacPrefix = "meth"
    when carbonCount == 2
      iupacPrefix = "eth"
    when carbonCount == 3
      iupacPrefix = "prop"
    when carbonCount == 4
      iupacPrefix = "but"
    when carbonCount == 9
      iupacPrefix = "non"
    when carbonCount == 10
      iupacPrefix = "dec"
    when carbonCount == 19
      iupacPrefix = "nonadec"
    end
    iupac = iupacPrefix + IUPAC_SEPARATOR + ALKANE_SUFFIX
  end

  def countCarbons smiles
    len = 0
    smiles.each_char {|c| len += 1 if c == 'C'}
    len
  end   

end
