import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/breeds/widgets/breed_detail_card.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/breeds/widgets/breed_tile.dart';

import '../../../../domain/domain.dart';
import '../../providers/cat_breeds.dart';

class BreedsTab extends ConsumerWidget {
  const BreedsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breeds = ref.watch(catBreedsProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: switch (breeds) {
        AsyncError() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error loading breeds - ${breeds.error}'),
              Text(breeds.stackTrace.toString().substring(30)),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: () => ref.read(catBreedsProvider.notifier).load(), child: const Text('Retry')),
            ],
          ),
        ),
        AsyncData(:final value) => _CatBreedsList(breeds: value),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _CatBreedsList extends StatelessWidget {
  final List<CatBreed> breeds;

  const _CatBreedsList({super.key, required this.breeds});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: breeds.length,
      itemBuilder: (context, index) {
        final breed = breeds[index];

        return BreedTile(
          breed: breed,
          onTap: () {
            showCupertinoModalPopup(context: context, builder: (context) => BreedDetailCard(breed: breed));
          },
        );
      },
    );
  }
}
