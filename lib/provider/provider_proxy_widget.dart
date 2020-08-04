import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 负责创建viewModel对象和初始化数据加载
class ProviderProxyWidget<T extends ChangeNotifier, T1 extends ChangeNotifier>
    extends StatefulWidget {
  /// viewModel
  final T1 model;
  final ValueWidgetBuilder<T1> builder;
  final Widget child;
  final ProxyProviderBuilder<T, T1> proxyUpdate;

  /// 初始化数据
  final Function(T1 model) initData;

  @override
  State<StatefulWidget> createState() => _ProviderProxyWidgetState<T, T1>();

  ProviderProxyWidget(
      {@required this.model,
      @required this.builder,
      @required this.proxyUpdate,
      this.child,
      this.initData});
}

class _ProviderProxyWidgetState<T extends ChangeNotifier,
    T1 extends ChangeNotifier> extends State<ProviderProxyWidget<T, T1>> {
  T1 model;

  @override
  void initState() {
    model = widget.model;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.initData?.call(model);
    });
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<T, T1>(
      create: (context) => widget.model,
      update: widget.proxyUpdate,
      child: Consumer(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
