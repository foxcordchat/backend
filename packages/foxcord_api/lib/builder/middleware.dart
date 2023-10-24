import 'package:minerva/minerva.dart';

final class MiddlewaresBuilder extends MinervaMiddlewaresBuilder {
  @override
  List<Middleware> build() => [
        ErrorMiddleware(),
        EndpointMiddleware(),
      ];
}
