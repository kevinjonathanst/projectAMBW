class StokBarang {
  final String namabarang;
  final String kategori;
  final String jumlah;


  StokBarang({required this.namabarang, required this.kategori, required this.jumlah});

  Map<String, dynamic> toJson(){
    return {
      'namabarang': namabarang,
      'kategori': kategori,
      'jumlah': jumlah
    };
  }

  factory StokBarang.fromJson(Map<String, dynamic> json){
    return StokBarang(
      namabarang: json['namabarang'],
      kategori: json['kategori'],
      jumlah: json['jumlah']
    );
  }
}

class History {
  final String nama;
  final String kategori;
  final String jumlah;
  final String User;

  History({required this.nama, required this.kategori, required this.jumlah, required this.User});

  Map<String, dynamic> toJson(){
    return {
      'nama': nama,
      'kategori': kategori,
      'jumlah': jumlah,
      'User': User
    };
  }

  factory History.fromJson(Map<String, dynamic> json){
    return History(
      nama: json['nama'],
      kategori: json['kategori'],
      jumlah: json['jumlah'],
      User: json['User']
    );
  }
}