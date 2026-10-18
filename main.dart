import 'package:flutter/material.dart';

void main() => runApp(const AnwarApp());

const forest = Color(0xFF0B241D);
const forestLight = Color(0xFF173A2F);
const gold = Color(0xFFE5C77C);
const cream = Color(0xFFF5EBD4);

class AnwarApp extends StatefulWidget {
  const AnwarApp({super.key});
  @override
  State<AnwarApp> createState() => _AnwarAppState();
}

class _AnwarAppState extends State<AnwarApp> {
  final Set<String> favorites = {};
  void toggleFavorite(String item) {
    setState(() {
      if (!favorites.add(item)) favorites.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'أنوار أهل البيت',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: forest, primary: forest),
      scaffoldBackgroundColor: const Color(0xFFF7F5EF),
    ),
    home: Directionality(
      textDirection: TextDirection.rtl,
      child: MainShell(
        favorites: favorites,
        onToggleFavorite: toggleFavorite,
      ),
    ),
  );
}

class Section {
  final String title, subtitle;
  final IconData icon;
  final List<String> items;
  const Section(this.title, this.subtitle, this.icon, this.items);
}

const sections = <Section>[
  Section('القرآن الكريم', 'تلاوة وتدبّر', Icons.menu_book_rounded, [
    'سورة الفاتحة', 'سورة الإخلاص', 'سورة الفلق', 'سورة الناس',
    'فهرس القرآن الكريم الكامل — قيد الإضافة'
  ]),
  Section('الأدعية والزيارات', 'زاد الروح والزيارة', Icons.favorite_rounded, [
    'دعاء كميل', 'دعاء التوسل', 'زيارة عاشوراء', 'زيارة أمين الله',
    'النصوص الكاملة مع توثيق المصادر — قيد الإضافة'
  ]),
  Section('سيرة أهل البيت', 'مواقف ودروس', Icons.account_balance_rounded, [
    'النبي محمد (صلى الله عليه وآله)', 'الإمام علي (عليه السلام)',
    'السيدة فاطمة الزهراء (عليها السلام)', 'الإمام الحسن (عليه السلام)',
    'الإمام الحسين (عليه السلام)', 'بقية الأئمة (عليهم السلام)'
  ]),
  Section('المكتبة الدينية', 'كتب وبحوث', Icons.local_library_rounded, [
    'العقائد', 'الأخلاق وتزكية النفس', 'السيرة والتاريخ', 'الفقه والأحكام',
    'تضاف الكتب بعد مراجعة حقوق النشر والمصادر'
  ]),
  Section('مواقيت الصلاة والقبلة', 'صلاتك في وقتها', Icons.access_time_rounded, [
    'اختيار المدينة أو السماح باستخدام الموقع',
    'اختيار طريقة حساب مواقيت الصلاة',
    'تحديد اتجاه القبلة باستخدام مستشعرات الهاتف'
  ]),
  Section('الصوتيات واللطميات', 'استمع بتأمل', Icons.headphones_rounded, [
    'القرآن الكريم', 'الأدعية الصوتية', 'الزيارات الصوتية', 'اللطميات',
    'تضاف ملفات مرخّصة أو روابط موثوقة'
  ]),
];

class MainShell extends StatefulWidget {
  final Set<String> favorites;
  final ValueChanged<String> onToggleFavorite;
  const MainShell({super.key, required this.favorites, required this.onToggleFavorite});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeContent(onOpen: _openSection),
      FavoritesPage(favorites: widget.favorites, onToggle: widget.onToggleFavorite),
      const SettingsPage(),
    ];
    return Scaffold(
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFEAF0E9),
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.bookmark_border_rounded), selectedIcon: Icon(Icons.bookmark_rounded), label: 'المحفوظات'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings_rounded), label: 'الإعدادات'),
        ],
      ),
    );
  }

  void _openSection(Section section) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => SectionPage(section: section, favorites: widget.favorites, onToggle: widget.onToggleFavorite),
    ));
  }
}

class HomeContent extends StatelessWidget {
  final ValueChanged<Section> onOpen;
  const HomeContent({super.key, required this.onOpen});

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [forest, Color(0xFF174536)], begin: Alignment.topRight, end: Alignment.bottomLeft),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 54, 20, 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 58, height: 58, decoration: BoxDecoration(
                border: Border.all(color: gold, width: 1.4), borderRadius: BorderRadius.circular(18),
                color: Colors.white.withOpacity(.06)),
                child: const Icon(Icons.auto_awesome, color: gold, size: 31)),
              const SizedBox(width: 13),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('أنوار أهل البيت', style: TextStyle(color: gold, fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('نور المعرفة • هداية الروح', style: TextStyle(color: cream, fontSize: 13)),
              ])),
              IconButton(tooltip: 'حول التطبيق', onPressed: () => showAboutDialog(
                context: context, applicationName: 'أنوار أهل البيت', applicationVersion: '0.2.0',
                applicationLegalese: 'تطبيق ديني مجاني قيد التطوير.'),
                icon: const Icon(Icons.info_outline, color: cream)),
            ]),
            const SizedBox(height: 28),
            const Text('السلام عليكم ورحمة الله', style: TextStyle(color: cream, fontSize: 23, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('اجعل يومك عامراً بذكر الله والصلاة على محمد وآل محمد.',
              style: TextStyle(color: Color(0xFFD8DCCF), height: 1.6)),
            const SizedBox(height: 20),
            Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(
              color: Colors.white.withOpacity(.08), border: Border.all(color: gold.withOpacity(.38)),
              borderRadius: BorderRadius.circular(18)),
              child: const Row(children: [
                Icon(Icons.menu_book_rounded, color: gold, size: 30), SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('وردك القرآني', style: TextStyle(color: cream, fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4), Text('افتح قسم القرآن وابدأ رحلة القراءة',
                    style: TextStyle(color: Color(0xFFD8DCCF), fontSize: 12)),
                ])),
                Icon(Icons.chevron_left, color: gold),
              ]),
            ),
          ]),
        ),
      ),
      const SliverPadding(padding: EdgeInsets.fromLTRB(16, 22, 16, 10),
        sliver: SliverToBoxAdapter(child: Row(children: [
          Expanded(child: Text('أقسام التطبيق', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: forest))),
          Text('6 أقسام', style: TextStyle(color: Colors.black54, fontSize: 12)),
        ]))),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            final s = sections[index];
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => onOpen(s),
              child: Ink(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8E2D4)),
                boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 4))]),
                child: Padding(padding: const EdgeInsets.all(14), child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFFEAF0E9), borderRadius: BorderRadius.circular(15)),
                      child: Icon(s.icon, color: forest, size: 26)),
                    const Spacer(),
                    Text(s.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: forest)),
                    const SizedBox(height: 5),
                    Text(s.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, color: Colors.black54)),
                  ])),
              ),
            );
          }, childCount: sections.length),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.08),
        ),
      ),
    ],
  );
}

class SectionPage extends StatelessWidget {
  final Section section;
  final Set<String> favorites;
  final ValueChanged<String> onToggle;
  const SectionPage({super.key, required this.section, required this.favorites, required this.onToggle});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(section.title), backgroundColor: forest, foregroundColor: cream),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          Icon(section.icon, color: gold, size: 34), const SizedBox(width: 12),
          Expanded(child: Text(section.subtitle, style: const TextStyle(color: cream, fontSize: 17))),
        ])),
      const SizedBox(height: 16),
      ...section.items.map((item) => Card(
        elevation: 0, color: Colors.white,
        child: ListTile(
          leading: const Icon(Icons.menu_book_outlined, color: forest),
          title: Text(item, style: const TextStyle(fontSize: 14)),
          trailing: IconButton(
            tooltip: favorites.contains(item) ? 'إزالة من المحفوظات' : 'إضافة إلى المحفوظات',
            icon: Icon(favorites.contains(item) ? Icons.bookmark : Icons.bookmark_border,
              color: favorites.contains(item) ? forest : Colors.black45),
            onPressed: () {
              onToggle(item);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(favorites.contains(item) ? 'أُضيف إلى المحفوظات' : 'أُزيل من المحفوظات'),
                duration: const Duration(seconds: 1),
              ));
            },
          ),
          onTap: () => showDialog<void>(context: context, builder: (context) => AlertDialog(
            title: Text(item),
            content: const Text('هذه نسخة أولية. سيُضاف المحتوى الكامل بعد مراجعة النصوص والمصادر وحقوق الاستخدام.'),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))],
          )),
        ),
      )),
    ]),
  );
}

class FavoritesPage extends StatelessWidget {
  final Set<String> favorites;
  final ValueChanged<String> onToggle;
  const FavoritesPage({super.key, required this.favorites, required this.onToggle});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('المحفوظات'), backgroundColor: forest, foregroundColor: cream),
    body: favorites.isEmpty
      ? const Center(child: Padding(padding: EdgeInsets.all(28), child: Column(
          mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.bookmark_border, size: 58, color: forest),
            SizedBox(height: 12),
            Text('لا توجد عناصر محفوظة بعد', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('افتح أي قسم واضغط علامة الحفظ بجانب العنصر.', textAlign: TextAlign.center),
          ])))
      : ListView(padding: const EdgeInsets.all(16), children: favorites.map((item) => Card(
          child: ListTile(title: Text(item), trailing: IconButton(
            icon: const Icon(Icons.delete_outline), onPressed: () => onToggle(item))),
        )).toList(),
      ),
  );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('الإعدادات'), backgroundColor: forest, foregroundColor: cream),
    body: ListView(padding: const EdgeInsets.all(16), children: const [
      ListTile(leading: Icon(Icons.palette_outlined), title: Text('المظهر'), subtitle: Text('الأخضر الزمردي والذهبي')),
      Divider(),
      ListTile(leading: Icon(Icons.language), title: Text('اللغة'), subtitle: Text('العربية')),
      Divider(),
      ListTile(leading: Icon(Icons.verified_outlined), title: Text('المصادر والتوثيق'), subtitle: Text('سيضاف قسم توثيق النصوص والروايات')),
      Divider(),
      ListTile(leading: Icon(Icons.info_outline), title: Text('عن التطبيق'), subtitle: Text('أنوار أهل البيت — نسخة تجريبية 0.2.0')),
    ]),
  );
}
