module ChemTransTestUtil

  def makeUnbranched carbonCount
    c = ""
    1.upto(carbonCount) {c << "C"}
    c
  end

  def smilize smiles #convert an array of integers to an array of SMILES unbranched H-suppressed alkanes
      smiles.collect {|carbonCount| makeUnbranched carbonCount}
  end

end

