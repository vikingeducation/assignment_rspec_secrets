# Given an array of sorted positive integers and a target sum, find if
# there exists in the given array a contiguous sub-array whose sum
# equals the target sum.
#
# For example, let's say the given array is [2, 4, 7, 8].
# A target of 6 would return TRUE, as 2 + 4 = 6.
# A target sum of 5 would return FALSE.
# A target of 9 would return FALSE because 2 and 7 are not contiguous.
# A target sum of 19 or a target sum of 7 would both return TRUE.

def sub_arr_sum_eq?( target, arr )
  arr = arr.select{ |el| el <= target }

  arr.each_with_index do |el, i|
    sum = 0
    ((i+1).. (arr.length - 1)).each do |index|
      return true if arr[index] == target

      sum += arr[index]

      return true if sum == target
    end
  end

  false
end

# find sum going to r, then l, then check inclusion in those and og arr

def find_sub_arr_sum( target, arr )
  return true if arr.sum == target
  return arr.sum if arr.length <= 1

  sum = find_sub_arr( target, arr[0 .. (arr.length/2 +1)] ) + find_sub_arr( target, arr[(arr.length/2 +1) .. -1] )

  true if sum == target

  false
end

# FOR O(n) ==> keep a continuous moving window, add and subtract values.
