import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/providers/cat_breeds.dart';

class BreedsFilterModal extends ConsumerWidget {
  final VoidCallback onClearFilter;
  final Set<String> selectedBreeds;

  const BreedsFilterModal({required this.onClearFilter, required this.selectedBreeds, super.key});

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
                ElevatedButton(
                  onPressed: () => ref.read(catBreedsProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        AsyncData(:final value) => _CatBreedsList(
            breeds: value,
            initialySelectedBreeds: selectedBreeds,
            onClearFilter: onClearFilter,
          ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _CatBreedsList extends StatefulWidget {
  final List<CatBreed> breeds;
  final Set<String> initialySelectedBreeds;
  final VoidCallback onClearFilter;

  const _CatBreedsList({
    required this.breeds,
    required this.initialySelectedBreeds,
    required this.onClearFilter,
  });

  @override
  State<_CatBreedsList> createState() => _CatBreedsListState();
}

class _CatBreedsListState extends State<_CatBreedsList> {
  Set<String> selectedBreeds = {};

  @override
  void initState() {
    selectedBreeds = widget.initialySelectedBreeds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Select breeds to filter',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(onPressed: widget.onClearFilter, child: const Text('Clear filter')),
            ),
            SliverList.builder(
              itemCount: widget.breeds.length,
              itemBuilder: (context, index) {
                final breed = widget.breeds[index];

                return CheckboxListTile(
                  title: Text(breed.name),
                  value: selectedBreeds.contains(breed.id),
                  onChanged: (value) {
                    setState(() {
                      if (value ?? false) {
                        selectedBreeds.add(breed.id);
                      } else {
                        selectedBreeds.remove(breed.id);
                      }
                    });
                  },
                );
              },
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 64)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, selectedBreeds),
            child: const Text('Apply filter'),
          ),
        ),
      ],
    );
  }
}
