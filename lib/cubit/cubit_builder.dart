import 'package:flutter/widgets.dart';

import 'base_cubit.dart';

class CubitBuilder<C extends BaseCubit<S>, S> extends StatelessWidget {
  const CubitBuilder({super.key, required this.cubit, required this.builder});

  final C cubit;
  final Widget Function(BuildContext context, S state) builder;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: cubit, builder: (context, _) => builder(context, cubit.state));
  }
}
