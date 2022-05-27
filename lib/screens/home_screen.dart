import 'package:flutter/material.dart';
import 'package:lista_compras/models/item.dart';
import 'package:swipe_to/swipe_to.dart';

class HomeScreen extends StatefulWidget {


  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _compradosKey = GlobalKey();
  final _paraComprar = GlobalKey();
  List<Item> data = [
    Item("Tomate"),
    Item("Cebola"),
    Item("Arroz"),
    Item("Arroz"),
    Item("Arroz"),
    Item("Arroz"),
    Item("Arroz"),
    Item("Arroz"),
    Item("Arroz"),
    Item("Arroz")
  ];
  List<Item> itensComprados = [];
  final List<TextEditingController> _textEditingController = [];
  final Map<int, bool> _mapEnable = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _SLiverAppBarDelegate(_compradosKey, _paraComprar),
            pinned: true,
          ),
          SliverToBoxAdapter(
            key: _paraComprar,
            child: Visibility(
              visible: data.isNotEmpty,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 15),
                child: const Text(
                  'Para Comprar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                _textEditingController.add(TextEditingController());
                _mapEnable.putIfAbsent(index, () => false);
                return SwipeTo(
                  animationDuration: const Duration(milliseconds: 200),
                  rightSwipeWidget: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.check),
                  ),
                  onRightSwipe: () {
                    var value = data[index];
                    data[index].isComprado = true;
                    itensComprados.add(value);
                    print(itensComprados[0].nome);
                    data.removeAt(index);
                    setState(() {});
                  },
                  leftSwipeWidget: Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.close),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      child: Container(
                        height: 70,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: ListTile(
                                        title: Text(data[index].nome),
                                        subtitle: Text(data[index].usuario),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: InkWell(
                                onTap: () {
                                  print('clicou em editar');
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: const Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: data.length,
            ),
          ),
          SliverToBoxAdapter(
            key: _compradosKey,
            child: Visibility(
              visible: itensComprados.isNotEmpty,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 15),
                child: const Text(
                  'Comprados',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
              visible: itensComprados.isNotEmpty,
              child: const Divider(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SwipeTo(
                  animationDuration: const Duration(milliseconds: 200),
                  rightSwipeWidget: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.check),
                  ),
                  leftSwipeWidget: Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.close),
                  ),
                  onLeftSwipe: () {
                    data.add(itensComprados[index]);
                    itensComprados.removeAt(index);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      child: Container(
                        color: Colors.green[50],
                        height: 70,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: ListTile(
                                        title: Text(itensComprados[index].nome),
                                        subtitle: Text(itensComprados[index].usuario),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: InkWell(
                                onTap: () {
                                  print('clicou em editar');
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: const Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: itensComprados.length,
            ),
          )
        ],
      ),
    );
  }
}

class _SLiverAppBarDelegate extends SliverPersistentHeaderDelegate {
  late final GlobalKey keyParaComprar;
  late final GlobalKey keyComprados;
  _SLiverAppBarDelegate(this.keyComprados, this.keyParaComprar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.grey[50], boxShadow: [
        overlapsContent
            ? BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              )
            : const BoxShadow()
      ]),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 2),
            child: ElevatedButton(
              onPressed: () => Scrollable.ensureVisible(keyParaComprar.currentContext!),
              child: const Text('Para Comprar'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 2),
            child: ElevatedButton(
              onPressed: () => Scrollable.ensureVisible(keyComprados.currentContext!),
              child: const Text("Comprados"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent {
    return 50.0;
  }

  @override
  double get minExtent {
    return 50.0;
  }
}
