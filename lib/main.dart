
import 'package:flutter/material.dart';

void main() {
  runApp(const BeanCounterApp());
}

class BeanCounterApp extends StatelessWidget {
  const BeanCounterApp({super.key});

  static const Color primary = Color(0xFF2E4A3F);
  static const Color secondary = Color(0xFFC9A66B);
  static const Color background = Color(0xFFF4F1EA);

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      primary: primary,
      secondary: secondary,
      surface: Colors.white,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bean Counter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: background,
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: primary, width: 1.5),
          ),
        ),
      ),
      routes: {
        '/': (_) => const AppShell(),
        '/new-sale': (_) => const NewSalePage(),
        '/purchases': (_) => const PurchasesPage(),
        '/new-purchase': (_) => const NewPurchasePage(),
        '/reports': (_) => const ReportsPage(),
        '/employees': (_) => const EmployeesPage(),
        '/suppliers': (_) => const SuppliersPage(),
        '/settings': (_) => const SettingsPage(),
      },
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [
    DashboardPage(),
    SalesPage(),
    InventoryPage(),
    WastePage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Sales'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2), label: 'Stock'),
          NavigationDestination(icon: Icon(Icons.delete_outline), selectedIcon: Icon(Icons.delete), label: 'Waste'),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

class PageFrame extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final List<Widget>? actions;

  const PageFrame({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle != null)
                    Text(subtitle!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
                  Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            ...?actions,
          ],
        ),
        const SizedBox(height: 18),
        child,
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: c.withValues(alpha: 0.12),
              child: Icon(icon, color: c, size: 20),
            ),
            const SizedBox(height: 12),
            Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const SectionCard({super.key, required this.title, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700))),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      subtitle: 'Good evening',
      title: 'Bean Counter',
      actions: const [Icon(Icons.notifications_none)],
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.35,
            children: const [
              MetricCard(label: "Today's Sales", value: 'AED 1,840', icon: Icons.payments_outlined),
              MetricCard(label: 'Orders', value: '72', icon: Icons.shopping_bag_outlined),
              MetricCard(label: 'Low Stock', value: '4', icon: Icons.warning_amber_rounded, color: Colors.orange),
              MetricCard(label: 'Waste Today', value: 'AED 34', icon: Icons.delete_outline, color: Colors.redAccent),
            ],
          ),
          const SizedBox(height: 12),
          const SectionCard(
            title: 'Sales This Week',
            child: SimpleBarChart(values: [0.45, 0.62, 0.50, 0.78, 0.92, 0.66, 0.55]),
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: 'Top Products',
            trailing: TextButton(onPressed: () {}, child: const Text('View all')),
            child: const Column(
              children: [
                ProductRank(name: 'Spanish Latte', detail: '48 sold', value: 'AED 1,008'),
                Divider(),
                ProductRank(name: 'V60', detail: '32 sold', value: 'AED 768'),
                Divider(),
                ProductRank(name: 'Matcha Latte', detail: '29 sold', value: 'AED 638'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionCard(
            title: 'Inventory Alerts',
            child: Column(
              children: [
                AlertRow(name: 'Espresso Beans', amount: '1.8 kg', status: 'Critical', color: Colors.redAccent),
                Divider(),
                AlertRow(name: 'Full Fat Milk', amount: '3.2 L', status: 'Low', color: Colors.orange),
                Divider(),
                AlertRow(name: '12 oz Cups', amount: '45 pcs', status: 'Low', color: Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleBarChart extends StatelessWidget {
  final List<double> values;
  const SimpleBarChart({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return SizedBox(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (i) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: values[i].clamp(0.05, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(labels[i], style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ProductRank extends StatelessWidget {
  final String name;
  final String detail;
  final String value;
  const ProductRank({super.key, required this.name, required this.detail, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(detail),
      trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class AlertRow extends StatelessWidget {
  final String name;
  final String amount;
  final String status;
  final Color color;

  const AlertRow({super.key, required this.name, required this.amount, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(amount),
      trailing: Chip(
        label: Text(status),
        backgroundColor: color.withValues(alpha: 0.1),
        side: BorderSide.none,
        labelStyle: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Sales',
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/new-sale'),
              icon: const Icon(Icons.add),
              label: const Text('New Sale'),
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.45,
            children: const [
              MetricCard(label: 'Today Sales', value: 'AED 1,840', icon: Icons.payments_outlined),
              MetricCard(label: 'Orders', value: '72', icon: Icons.receipt_long_outlined),
            ],
          ),
          const SizedBox(height: 12),
          const SectionCard(
            title: 'Recent Orders',
            child: Column(
              children: [
                OrderTile(id: 'ORD-001', time: '4:25 PM', product: 'Spanish Latte × 2', amount: 'AED 42', payment: 'Card'),
                Divider(),
                OrderTile(id: 'ORD-002', time: '4:19 PM', product: 'V60 × 1', amount: 'AED 24', payment: 'Apple Pay'),
                Divider(),
                OrderTile(id: 'ORD-003', time: '4:10 PM', product: 'Matcha Latte × 1', amount: 'AED 22', payment: 'Cash'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final String id, time, product, amount, payment;
  const OrderTile({super.key, required this.id, required this.time, required this.product, required this.amount, required this.payment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(id, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text('$time • $product • $payment'),
      trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class NewSalePage extends StatefulWidget {
  const NewSalePage({super.key});

  @override
  State<NewSalePage> createState() => _NewSalePageState();
}

class _NewSalePageState extends State<NewSalePage> {
  final products = const [
    ('Espresso', 12.0),
    ('Americano', 14.0),
    ('Latte', 18.0),
    ('Flat White', 18.0),
    ('Spanish Latte', 21.0),
    ('V60', 24.0),
    ('Cold Brew', 20.0),
    ('Matcha Latte', 22.0),
  ];

  String? selected;
  double price = 0;
  int qty = 1;
  String payment = 'Card';

  @override
  Widget build(BuildContext context) {
    final total = price * qty;

    return Scaffold(
      appBar: AppBar(title: const Text('New Sale')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Products', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.6,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, i) {
              final p = products[i];
              final active = selected == p.$1;
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => setState(() {
                  selected = p.$1;
                  price = p.$2;
                  qty = 1;
                }),
                child: Card(
                  color: active ? Theme.of(context).colorScheme.primaryContainer : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(p.$1, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        Text('AED ${p.$2.toStringAsFixed(0)}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          SectionCard(
            title: 'Order Summary',
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(selected ?? 'Select a product'),
                  subtitle: Text(selected == null ? 'No item selected' : 'AED ${price.toStringAsFixed(2)} each'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: qty > 1 ? () => setState(() => qty--) : null, icon: const Icon(Icons.remove_circle_outline)),
                      Text('$qty', style: const TextStyle(fontWeight: FontWeight.w700)),
                      IconButton(onPressed: selected == null ? null : () => setState(() => qty++), icon: const Icon(Icons.add_circle_outline)),
                    ],
                  ),
                ),
                const Divider(),
                DropdownButtonFormField<String>(
                  initialValue: payment,
                  decoration: const InputDecoration(labelText: 'Payment method'),
                  items: const ['Cash', 'Card', 'Apple Pay', 'Delivery App', 'Complimentary']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => payment = v ?? 'Card'),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Expanded(child: Text('Total', style: TextStyle(fontWeight: FontWeight.w700))),
                    Text('AED ${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: selected == null
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sale saved locally (demo mode).')));
                            Navigator.pop(context);
                          },
                    child: const Text('Complete Sale'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  static const items = [
    ('Espresso Beans', 'Coffee', '1.8 kg', 'Critical'),
    ('Filter Coffee Beans', 'Coffee', '3.7 kg', 'Good'),
    ('Full Fat Milk', 'Dairy', '3.2 L', 'Low'),
    ('Oat Milk', 'Dairy', '0 L', 'Out of Stock'),
    ('12 oz Cups', 'Packaging', '45 pcs', 'Low'),
    ('Cup Lids', 'Packaging', '220 pcs', 'Good'),
  ];

  Color statusColor(String status) {
    switch (status) {
      case 'Critical':
      case 'Out of Stock':
        return Colors.redAccent;
      case 'Low':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Inventory',
      child: Column(
        children: [
          const TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search inventory')),
          const SizedBox(height: 12),
          ...items.map((item) {
            final c = statusColor(item.$4);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: ListTile(
                  title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text('${item.$2} • ${item.$3}'),
                  trailing: Chip(
                    label: Text(item.$4),
                    backgroundColor: c.withValues(alpha: 0.1),
                    side: BorderSide.none,
                    labelStyle: TextStyle(color: c, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class WastePage extends StatelessWidget {
  const WastePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Waste',
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.45,
            children: const [
              MetricCard(label: 'Today', value: 'AED 34', icon: Icons.delete_outline, color: Colors.redAccent),
              MetricCard(label: 'This Month', value: 'AED 420', icon: Icons.calendar_month_outlined, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 12),
          const SectionCard(
            title: 'Recent Waste',
            child: Column(
              children: [
                ListTile(contentPadding: EdgeInsets.zero, title: Text('Full Fat Milk'), subtitle: Text('Spillage • 250 ml'), trailing: Text('AED 1.75')),
                Divider(),
                ListTile(contentPadding: EdgeInsets.zero, title: Text('Spanish Latte'), subtitle: Text('Wrong Order • 1 pcs'), trailing: Text('AED 5.20')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'More',
      child: Card(
        child: Column(
          children: [
            MoreTile(icon: Icons.local_shipping_outlined, title: 'Purchases', route: '/purchases'),
            const Divider(height: 1),
            MoreTile(icon: Icons.analytics_outlined, title: 'Reports', route: '/reports'),
            const Divider(height: 1),
            MoreTile(icon: Icons.groups_outlined, title: 'Employees', route: '/employees'),
            const Divider(height: 1),
            MoreTile(icon: Icons.storefront_outlined, title: 'Suppliers', route: '/suppliers'),
            const Divider(height: 1),
            MoreTile(icon: Icons.settings_outlined, title: 'Settings', route: '/settings'),
          ],
        ),
      ),
    );
  }
}

class MoreTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  const MoreTile({super.key, required this.icon, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}

class PurchasesPage extends StatelessWidget {
  const PurchasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchases')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/new-purchase'),
        icon: const Icon(Icons.add),
        label: const Text('New Purchase'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          MetricCard(label: 'This Month', value: 'AED 3,200', icon: Icons.shopping_cart_outlined),
          SizedBox(height: 12),
          SectionCard(
            title: 'Recent Purchases',
            child: Column(
              children: [
                ListTile(contentPadding: EdgeInsets.zero, title: Text('PUR-001 • Sample Roasters'), subtitle: Text('Espresso Beans • 10 kg'), trailing: Text('AED 850')),
                Divider(),
                ListTile(contentPadding: EdgeInsets.zero, title: Text('PUR-002 • Dairy Supply'), subtitle: Text('Full Fat Milk • 24 L'), trailing: Text('AED 168')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewPurchasePage extends StatefulWidget {
  const NewPurchasePage({super.key});

  @override
  State<NewPurchasePage> createState() => _NewPurchasePageState();
}

class _NewPurchasePageState extends State<NewPurchasePage> {
  final qtyController = TextEditingController();
  final costController = TextEditingController();

  double get total {
    final q = double.tryParse(qtyController.text) ?? 0;
    final c = double.tryParse(costController.text) ?? 0;
    return q * c;
  }

  @override
  void dispose() {
    qtyController.dispose();
    costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Purchase')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextField(decoration: InputDecoration(labelText: 'Supplier')),
          const SizedBox(height: 10),
          const TextField(decoration: InputDecoration(labelText: 'Inventory Item')),
          const SizedBox(height: 10),
          TextField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Quantity'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: costController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Cost per Unit'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              title: const Text('Total Cost'),
              trailing: Text('AED ${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Purchase saved locally (demo mode).')));
              Navigator.pop(context);
            },
            child: const Text('Save Purchase'),
          ),
        ],
      ),
    );
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SectionCard(title: 'Sales Performance', child: SimpleBarChart(values: [0.4, 0.6, 0.7, 0.5, 0.9, 0.8, 0.65])),
          SizedBox(height: 12),
          SectionCard(
            title: 'Summary',
            child: Column(
              children: [
                ProductRank(name: 'Gross Profit', detail: 'This month', value: 'AED 18,940'),
                Divider(),
                ProductRank(name: 'Waste Cost', detail: 'This month', value: 'AED 420'),
                Divider(),
                ProductRank(name: 'Purchases', detail: 'This month', value: 'AED 3,200'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employees')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(leading: CircleAvatar(child: Text('A')), title: Text('Ahmed'), subtitle: Text('E001 • Barista • Morning'))),
          SizedBox(height: 10),
          Card(child: ListTile(leading: CircleAvatar(child: Text('S')), title: Text('Sara'), subtitle: Text('E002 • Cashier • Afternoon'))),
        ],
      ),
    );
  }
}

class SuppliersPage extends StatelessWidget {
  const SuppliersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suppliers')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('Sample Roasters'), subtitle: Text('Coffee • Last purchase: 10 Oct'))),
          SizedBox(height: 10),
          Card(child: ListTile(title: Text('Dairy Supply'), subtitle: Text('Dairy • Last purchase: 11 Oct'))),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Column(
              children: [
                ListTile(title: Text('Business Name'), subtitle: Text('Bean Counter')),
                Divider(height: 1),
                ListTile(title: Text('Currency'), subtitle: Text('AED')),
                Divider(height: 1),
                ListTile(title: Text('Branch'), subtitle: Text('Main Branch')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: SwitchListTile(
              value: true,
              onChanged: (_) {},
              title: const Text('Low Stock Alerts'),
            ),
          ),
        ],
      ),
    );
  }
}
