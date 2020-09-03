num toNumber(String source) {
  var numbers = source.split(',');
  source = '';
  for (String i in numbers) {
    source += i;
  }
  return num.parse(source);
}