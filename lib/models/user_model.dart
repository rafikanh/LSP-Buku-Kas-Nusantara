class User {
  int? _id;
  late String uname, pass, nm, create, update;

  User(
      {required this.uname,
      required this.pass,
      required this.nm,
      required this.create,
      required this.update});

  User.fromMap(dynamic objek) {
    _id = objek['id'];
    uname = objek['username'];
    pass = objek['password'];
    nm = objek['name'];
    create = objek['created_at'];
    update = objek['updated_at'];
  }

  int? get id => _id;
  String get username => uname;
  String get password => pass;
  String get name => nm;
  String get createdAt => create;
  String get updatedAt => update;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = uname;
    map['password'] = pass;
    map['name'] = nm;
    map['created_at'] = create;
    map['updated_at'] = update;
    return map;
  }
}
