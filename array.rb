sequence_sum(arr, amount)
  return true if arr[0] == amount
  #iterate over array with two pointers
  arr[0..-2].each do |i|
    tally = 0
    arr[1..-1].each do |j|
      if arr[i] + arr[j] + tally == amount
        retrun true
      elsif arr[i] + arr[j] + tally > amount
        break
      else
        tally = arr[i] + arr[j] + tally
    end
  end
  false
end

sequence_sum([2,4,7,8], 15)
