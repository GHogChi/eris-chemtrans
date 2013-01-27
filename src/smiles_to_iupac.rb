# smiles_to_iupacPrefix.rb


class SmilesToIupacTranslator
    
  ALKANE_SUFFIX = "ane"
    
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
    when carbonCount == 9
      iupacPrefix = "non"
    when carbonCount == 10
      iupacPrefix = "dec"
    when carbonCount == 19
      iupacPrefix = "nonadec"
    end
    iupac = iupacPrefix + ALKANE_SUFFIX
  end

  def countCarbons smiles
    smiles.length
  end   

end
