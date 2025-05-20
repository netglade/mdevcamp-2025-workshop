import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/breeds_filter_modal.dart';
import 'package:mdevcamp_workshop/providers/cats_filter.dart';

class FilterCatsButton extends ConsumerWidget {
  const FilterCatsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(catsFilterProvider);
    final selectedBreeds = filter?.breeds ?? {};

    return Stack(
      children: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.filter),
          onPressed: () async {
            final result = await showModalBottomSheet<Set<String>>(
              context: context,
              builder: (context) => BreedsFilterModal(
                selectedBreeds: selectedBreeds,
                onClearFilter: () async {
                  ref.read(catsFilterProvider.notifier).clearFilter();

                  if (context.mounted) Navigator.pop(context);
                },
              ),
            );

            if (result != null && context.mounted) {
              ref.read(catsFilterProvider.notifier).setFilter(
                    CatFilter(
                      breeds: result,
                    ),
                  );
            }
          },
        ),
        if (filter != null)
          Positioned(
            right: 5,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
      ],
    );
  }
}
