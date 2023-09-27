class CashFlow {
  int? _id;
  late int idUser, jml;
  late String tipe, tgl, ket, dibuat, diperbaharui;

  CashFlow(
      {required this.idUser,
      required this.tipe,
      required this.tgl,
      required this.jml,
      required this.ket,
      required this.dibuat,
      required this.diperbaharui});

  CashFlow.fromMap(dynamic objek) {
    _id = objek['id'];
    idUser = objek['id_user'];
    tipe = objek['type'];
    tgl = objek['date'];
    jml = objek['total'];
    ket = objek['description'];
    dibuat = objek['created_at'];
    diperbaharui = objek['updated_at'];
  }

  int? get id => _id;
  int get id_user => idUser;
  String get type => tipe;
  String get date => tgl;
  int get total => jml;
  String get description => ket;
  String get createdAt => dibuat;
  String get updatedAt => diperbaharui;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['id_user'] = idUser;
    map['type'] = tipe;
    map['date'] = tgl;
    map['total'] = jml;
    map['description'] = ket;
    map['created_at'] = dibuat;
    map['updated_at'] = diperbaharui;
    return map;
  }
}
