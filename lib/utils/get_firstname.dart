String getFirstName(String fullName) {
  if (fullName.trim().isEmpty) return '';
  return fullName.trim().split(' ').first;
}
