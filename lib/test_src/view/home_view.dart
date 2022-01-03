import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_with_riverpod/test_src/data_source/api_data_source.dart';

final dataProvider = Provider((ref) => ApiDataSource());

final responseData = FutureProvider.autoDispose((ref) {
  final client = ref.read(dataProvider);
  return client.getData();
});

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final response = ref.watch(responseData);

    return response.when(
      data: (value) {
        return Scaffold(
          body: ListView.builder(
            itemCount: value.length,
            itemBuilder: (_, index) {
              final data = value[index];
              return Card(
                child: ListTile(
                  title: Text(
                    data.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    //viewModel.listDataModel[index].body,
                    data.body,
                    style: const TextStyle(fontSize: 12),
                  ),
                  leading: Container(
                    alignment: Alignment.center,
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      data.id.toString(),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      error: (e, stack) {
        return Text('error en: $e');
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
