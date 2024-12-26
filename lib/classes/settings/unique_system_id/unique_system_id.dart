class UniqueSystemId {
  static String _uniqueSystemId = "Unknown";

  static get getUniqueSystemIdCommand => "/gen $_uniqueSystemId";

  static get getUniqueSystemId => _uniqueSystemId;

  static get isUniqueSystemIdValid => getUniqueSystemIdCommand != "Unknown";

  static void init(String id) {
    _uniqueSystemId = id;
  }
}
