import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/usecase/harvest/get_harvest_history.dart';

class HarvestInfoPresenter extends StateNotifier<List<HarvestInfo>> {
  final usecase = GetHarvestHistory();
  bool get requesting => usecase.requesting;
  bool get last => usecase.last;

  HarvestInfoPresenter() : super([]);

  Future<void> request(Host host, String publicKey) async {
    final stream = await usecase.call(GetHarvestHistoryParam(
      host: host,
      publicKey: publicKey,
    ));
    stream.listen((data) {
      final list = [...this.state];
      list.addAll(data);
      this.state = list;
    });
  }
}
