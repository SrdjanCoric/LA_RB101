def joinor(array, sign = ',', word = 'or')
  string = ''
  if array.size == 2
    string << array.shift.to_s + ' ' + word << ' ' + array.shift.to_s
  elsif array.size == 1
    string << array.last.to_s
  else
    loop do
      break  if array.size == 1
        string << (array.shift.to_s + sign + ' ')
    end
  string << word + ' ' + array.last.to_s
  end
end

p joinor([1, 2, 3], sign = ',', word = 'or')
p joinor([1, 2, 3, 4, 5, 6], sign = ',', word = 'or')
p joinor([1, 2], sign = ',', word = 'or')
p joinor([1], sign = ',', word = 'or')