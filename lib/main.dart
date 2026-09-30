import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manajemen Data Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DaftarMahasiswaPage(),
    );
  }
}

class Mahasiswa {
  const Mahasiswa({
    required this.nim,
    required this.nama,
    required this.programStudi,
    required this.kelas,
  });

  final String nim;
  final String nama;
  final String programStudi;
  final String kelas;
}

class DaftarMahasiswaPage extends StatefulWidget {
  const DaftarMahasiswaPage({super.key});

  @override
  State<DaftarMahasiswaPage> createState() => _DaftarMahasiswaPageState();
}

class _DaftarMahasiswaPageState extends State<DaftarMahasiswaPage> {
  final TextEditingController _cariController = TextEditingController();
  final List<Mahasiswa> _mahasiswa = [
    const Mahasiswa(
      nim: '231001',
      nama: 'Andi Saputra',
      programStudi: 'Informatika',
      kelas: 'TI-3A',
    ),
    const Mahasiswa(
      nim: '231002',
      nama: 'Budi Santoso',
      programStudi: 'Informatika',
      kelas: 'TI-3A',
    ),
    const Mahasiswa(
      nim: '231003',
      nama: 'Citra Lestari',
      programStudi: 'Sistem Informasi',
      kelas: 'SI-3B',
    ),
    const Mahasiswa(
      nim: '231004',
      nama: 'Deni Kurniawan',
      programStudi: 'Teknik Komputer',
      kelas: 'TK-3A',
    ),
    const Mahasiswa(
      nim: '231005',
      nama: 'Eka Wulandari',
      programStudi: 'Informatika',
      kelas: 'TI-3B',
    ),
  ];

  String _kataKunci = '';
  String _filterProgramStudi = 'Semua';

  List<_MahasiswaItem> get _hasilPencarian {
    final kataKunci = _kataKunci.toLowerCase();

    return _mahasiswa.asMap().entries.where((entry) {
      final mahasiswa = entry.value;
      final sesuaiPencarian = mahasiswa.nama.toLowerCase().contains(kataKunci) ||
          mahasiswa.nim.toLowerCase().contains(kataKunci);
      final sesuaiFilter = _filterProgramStudi == 'Semua' ||
          mahasiswa.programStudi == _filterProgramStudi;

      return sesuaiPencarian && sesuaiFilter;
    }).map((entry) {
      return _MahasiswaItem(indeks: entry.key, mahasiswa: entry.value);
    }).toList();
  }

  @override
  void dispose() {
    _cariController.dispose();
    super.dispose();
  }

  Future<void> _tambahMahasiswa() async {
    final mahasiswaBaru = await Navigator.push<Mahasiswa>(
      context,
      MaterialPageRoute(builder: (context) => const FormMahasiswaPage()),
    );

    if (mahasiswaBaru == null || !mounted) {
      return;
    }

    setState(() {
      _mahasiswa.add(mahasiswaBaru);
    });
  }

  Future<void> _bukaDetail(_MahasiswaItem item) async {
    final hasil = await Navigator.push<DetailMahasiswaResult>(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMahasiswaPage(
          mahasiswa: item.mahasiswa,
          indeks: item.indeks,
        ),
      ),
    );

    if (hasil == null || !mounted) {
      return;
    }

    setState(() {
      if (hasil.dihapus) {
        _mahasiswa.removeAt(hasil.indeks);
      } else if (hasil.mahasiswa != null) {
        _mahasiswa[hasil.indeks] = hasil.mahasiswa!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasilPencarian = _hasilPencarian;

    return Scaffold(
      appBar: AppBar(title: const Text('Data Mahasiswa')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahMahasiswa,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total Mahasiswa: ${_mahasiswa.length}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('cariMahasiswa'),
              controller: _cariController,
              onChanged: (nilai) {
                setState(() {
                  _kataKunci = nilai;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Cari nama atau NIM',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _filterProgramStudi,
              decoration: const InputDecoration(
                labelText: 'Filter Program Studi',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Semua', child: Text('Semua')),
                DropdownMenuItem(
                  value: 'Informatika',
                  child: Text('Informatika'),
                ),
                DropdownMenuItem(
                  value: 'Sistem Informasi',
                  child: Text('Sistem Informasi'),
                ),
                DropdownMenuItem(
                  value: 'Teknik Komputer',
                  child: Text('Teknik Komputer'),
                ),
              ],
              onChanged: (nilai) {
                if (nilai == null) {
                  return;
                }

                setState(() {
                  _filterProgramStudi = nilai;
                });
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _buildIsiDaftar(hasilPencarian),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIsiDaftar(List<_MahasiswaItem> hasilPencarian) {
    if (_mahasiswa.isEmpty) {
      return const Center(child: Text('Belum ada data mahasiswa'));
    }

    if (hasilPencarian.isEmpty) {
      return const Center(child: Text('Data mahasiswa tidak ditemukan'));
    }

    return ListView.builder(
      itemCount: hasilPencarian.length,
      itemBuilder: (context, index) {
        final item = hasilPencarian[index];
        final mahasiswa = item.mahasiswa;

        return Card(
          child: ListTile(
            onTap: () => _bukaDetail(item),
            title: Text(mahasiswa.nama),
            subtitle: Text(
              'NIM: ${mahasiswa.nim}\n'
              '${mahasiswa.programStudi} • ${mahasiswa.kelas}',
            ),
            isThreeLine: true,
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}

class _MahasiswaItem {
  const _MahasiswaItem({required this.indeks, required this.mahasiswa});

  final int indeks;
  final Mahasiswa mahasiswa;
}

class FormMahasiswaPage extends StatefulWidget {
  const FormMahasiswaPage({super.key, this.mahasiswa});

  final Mahasiswa? mahasiswa;

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nimController;
  late final TextEditingController _namaController;
  late final TextEditingController _programStudiController;
  late final TextEditingController _kelasController;

  bool get _modeEdit => widget.mahasiswa != null;

  @override
  void initState() {
    super.initState();
    final mahasiswa = widget.mahasiswa;
    _nimController = TextEditingController(text: mahasiswa?.nim ?? '');
    _namaController = TextEditingController(text: mahasiswa?.nama ?? '');
    _programStudiController =
        TextEditingController(text: mahasiswa?.programStudi ?? '');
    _kelasController = TextEditingController(text: mahasiswa?.kelas ?? '');
  }

  @override
  void dispose() {
    _nimController.dispose();
    _namaController.dispose();
    _programStudiController.dispose();
    _kelasController.dispose();
    super.dispose();
  }

  String? _validasiWajib(String? nilai, String namaField) {
    if (nilai == null || nilai.trim().isEmpty) {
      return '$namaField wajib diisi';
    }
    return null;
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final mahasiswa = Mahasiswa(
      nim: _nimController.text.trim(),
      nama: _namaController.text.trim(),
      programStudi: _programStudiController.text.trim(),
      kelas: _kelasController.text.trim(),
    );
    Navigator.pop(context, mahasiswa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_modeEdit ? 'Edit Mahasiswa' : 'Tambah Mahasiswa'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nimController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'NIM',
                    border: OutlineInputBorder(),
                  ),
                  validator: (nilai) => _validasiWajib(nilai, 'NIM'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                  validator: (nilai) => _validasiWajib(nilai, 'Nama'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _programStudiController,
                  decoration: const InputDecoration(
                    labelText: 'Program Studi',
                    border: OutlineInputBorder(),
                  ),
                  validator: (nilai) =>
                      _validasiWajib(nilai, 'Program Studi'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _kelasController,
                  decoration: const InputDecoration(
                    labelText: 'Kelas',
                    border: OutlineInputBorder(),
                  ),
                  validator: (nilai) => _validasiWajib(nilai, 'Kelas'),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _simpan,
                    child: Text(_modeEdit ? 'Simpan Perubahan' : 'Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailMahasiswaPage extends StatefulWidget {
  const DetailMahasiswaPage({
    super.key,
    required this.mahasiswa,
    required this.indeks,
  });

  final Mahasiswa mahasiswa;
  final int indeks;

  @override
  State<DetailMahasiswaPage> createState() => _DetailMahasiswaPageState();
}

class _DetailMahasiswaPageState extends State<DetailMahasiswaPage> {
  late Mahasiswa _mahasiswa;

  @override
  void initState() {
    super.initState();
    _mahasiswa = widget.mahasiswa;
  }

  Future<void> _editMahasiswa() async {
    final mahasiswaDiubah = await Navigator.push<Mahasiswa>(
      context,
      MaterialPageRoute(
        builder: (context) => FormMahasiswaPage(mahasiswa: _mahasiswa),
      ),
    );

    if (mahasiswaDiubah == null || !mounted) {
      return;
    }

    setState(() {
      _mahasiswa = mahasiswaDiubah;
    });
  }

  Future<void> _konfirmasiHapus() async {
    final yakinHapus = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Mahasiswa'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (yakinHapus == true && mounted) {
      Navigator.pop(
        context,
        DetailMahasiswaResult.hapus(indeks: widget.indeks),
      );
    }
  }

  void _kembali() {
    Navigator.pop(
      context,
      DetailMahasiswaResult.ubah(
        indeks: widget.indeks,
        mahasiswa: _mahasiswa,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _kembali();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Mahasiswa'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _kembali,
          ),
          actions: [
            IconButton(
              tooltip: 'Edit',
              onPressed: _editMahasiswa,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              tooltip: 'Hapus',
              onPressed: _konfirmasiHapus,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailBaris(label: 'NIM', nilai: _mahasiswa.nim),
                  _DetailBaris(label: 'Nama', nilai: _mahasiswa.nama),
                  _DetailBaris(
                    label: 'Program Studi',
                    nilai: _mahasiswa.programStudi,
                  ),
                  _DetailBaris(label: 'Kelas', nilai: _mahasiswa.kelas),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailBaris extends StatelessWidget {
  const _DetailBaris({required this.label, required this.nilai});

  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 4),
          Text(nilai, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class DetailMahasiswaResult {
  const DetailMahasiswaResult.ubah({
    required this.indeks,
    required this.mahasiswa,
  }) : dihapus = false;

  const DetailMahasiswaResult.hapus({required this.indeks})
      : mahasiswa = null,
        dihapus = true;

  final int indeks;
  final Mahasiswa? mahasiswa;
  final bool dihapus;
}
