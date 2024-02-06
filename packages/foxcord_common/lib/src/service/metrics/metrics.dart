import 'package:injectable/injectable.dart';
import 'package:prometheus_client/prometheus_client.dart';
import 'package:prometheus_client/runtime_metrics.dart';

/// Service for registering and collecting metrics.
@lazySingleton
final class MetricsService {
  /// Registry of metrics collectors.
  final CollectorRegistry collectorRegistry = CollectorRegistry.defaultRegistry;

  /// Initialize metrics service.
  @PostConstruct()
  Future<void> initialize() async {
    collectorRegistry.register(
      RuntimeCollector(),
    );
  }
}
