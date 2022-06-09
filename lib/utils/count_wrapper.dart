String countWrapper({required int count, required List variants}) {
  var endNum = count % 10;
  if (endNum == 0 ||
      (endNum >= 5 && endNum <= 9) ||
      (count >= 11 && count <= 15)) {
    return variants[0];
  } else if (endNum == 1) {
    return variants[1];
  } else {
    return variants[2];
  }
}
