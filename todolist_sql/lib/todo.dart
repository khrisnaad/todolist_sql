class Todo{
  int? id;
  String nama;
  String deskripsi;
  bool done;

  Todo(this.nama, this.deskripsi, {this.done = false, this.id});

  static List<Todo> dummyData = [
    Todo("Latihan coding", "Belajar coding"),
    Todo("Makan malam", "Makan malam bersama dosen", done: true),
    Todo("Bernyanyi", "Bernyanyi"),
  ];

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id' : id,
      'nama' : nama,
      'deskripsi' : deskripsi,
      'done' : done,
    };
  }

  factory Todo.fromMap(Map<String, dynamic>map){
    return Todo(
      id : map ['id'],
      map['nama'] as String,
      map['deskripsi'] as String,
      done : map['done'] == 0 ? false : true
    );
  }
}