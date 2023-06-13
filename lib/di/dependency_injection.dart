import 'package:get_it/get_it.dart';
import 'package:symbol_node_watcher/data/repositories/harvesting/harvesting_repository_firestore.dart';
import 'package:symbol_node_watcher/data/repositories/interval_task/interval_task_repository_background_fetch.dart';
import 'package:symbol_node_watcher/data/repositories/notification/notification_repository_local.dart';
import 'package:symbol_node_watcher/data/repositories/setting/setting_repository_hive.dart';
import 'package:symbol_node_watcher/data/repositories/symbol/account_repository_http.dart';
import 'package:symbol_node_watcher/data/repositories/symbol/block_repository_http.dart';
// import 'package:symbol_node_watcher/data/repositories/setting/setting_repository_local.dart';
import 'package:symbol_node_watcher/data/repositories/symbol/node_repository_http.dart';
import 'package:symbol_node_watcher/data/repositories/symbol/receipt_repository_http.dart';
import 'package:symbol_node_watcher/domain/entities/common/host.dart';
import 'package:symbol_node_watcher/domain/repositories/harvesting/harvesting_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/interval_task/intarval_task_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/notification/notification_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/setting/setting_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/account_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/block_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/node_repository.dart';
import 'package:symbol_node_watcher/domain/repositories/symbol/receipt_repository.dart';

GetIt getIt = GetIt.instance;

void initDependencyInjection() {
  // Repositories
  // getIt.registerSingleton<SettingRepository>(SettingRepositoryLocal());
  getIt.registerSingleton<SettingRepository>(
    SettingRepositoryHive(),
  );
  getIt.registerSingleton<IntervalTaskRepository>(
    IntervalTaskRepositoryBackgroundFetch(),
  );
  getIt.registerSingleton<NotificationRepository>(
    NotificationRepositoryLocal(),
  );
  getIt.registerFactoryParam<NodeRepository, Host, void>(
    (Host? host, _) => NodeRepositoryHttp(host: host!),
  );
  getIt.registerFactoryParam<AccountRepository, Host, void>(
    (Host? host, _) => AccountRepositoryHttp(host: host!),
  );
  getIt.registerFactoryParam<ReceiptRepository, Host, void>(
    (Host? host, _) => ReceiptRepositoryHttp(host: host!),
  );
  getIt.registerFactoryParam<BlockRepository, Host, void>(
    (Host? host, _) => BlockRepositoryHttp(host: host!),
  );
  getIt.registerFactory<HarvestingRepository>(
    () => HarvestingRepositoryFirestore(),
  );
}
