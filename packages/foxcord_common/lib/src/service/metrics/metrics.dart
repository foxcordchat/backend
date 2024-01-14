import 'package:injectable/injectable.dart';
import 'package:prometheus_client/prometheus_client.dart';
import 'package:prometheus_client/runtime_metrics.dart';

@lazySingleton
final class MetricsService {
  final CollectorRegistry collectorRegistry = CollectorRegistry.defaultRegistry;

  @PostConstruct()
  Future<void> initialize() async {
    collectorRegistry.register(
      RuntimeCollector(),
    );
  }
}
