import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/viewmodel_builder.dart';
import '../primary/recommendation/recomendation_body.dart';
import 'info_viewmodel.dart';
import 'widgets/top_stack.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    required this.uid,
    Key? key,
  }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) => ViewModelBuilder<InfoVM>(
        viewModelBuilder: () => InfoVM(uid),
        onDispose: (viewModel) => viewModel.onDispose(),
        onModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel) => Scaffold(
          extendBodyBehindAppBar: true,
          body: const _Body(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: const [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: TopStack(),
          ),
          Positioned(
            top: topImageHeight,
            child: _SiteInfo(),
          ),
          Positioned(
            top: topImageHeight - 40,
            right: 0,
            child: ButtonsRow(),
          ),
        ],
      );
}

class _SiteInfo extends StatelessWidget {
  const _SiteInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<InfoVM>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.height - topImageHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                viewModel.site.info.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                viewModel.site.info.description,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 400,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
