import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/entities/node/node_info.dart';
import 'package:symbol_node_watcher/domain/usecase/node/get_node_info.dart';

class NodeInfoPresenter extends StateNotifier<NodeInfo?> {
  NodeInfoPresenter() : super(null);

  Future<void> request(Host host) async {
    final usecase = GetNodeInfo();
    final stream = await usecase.call(host);
    stream.listen((data) {
      this.state = data;
    });
  }
}
