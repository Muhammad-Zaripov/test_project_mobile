enum DetailResult {
  deleted,
  updated;

  bool get isDeleted => this == .deleted;
  bool get isUpdated => this == .updated;
}
