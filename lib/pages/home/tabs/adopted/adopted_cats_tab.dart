import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/providers/cats_list.dart';
import 'package:mdevcamp_workshop/shared/widgets/cat_detail_card.dart';
import 'package:mdevcamp_workshop/shared/widgets/cat_tile.dart';

class AdoptedCatsTab extends ConsumerWidget {
  const AdoptedCatsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catsList = ref.watch(catsListProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: switch (catsList) {
        AsyncError() => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Error loading breeds - ${catsList.error}'),
                Text(catsList.stackTrace.toString().substring(30)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.read(catsListProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        AsyncData(:final value) => _CatsList(cats: catsList.value),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _CatsList extends StatelessWidget {
  final List<Cat> cats;

  const _CatsList({required this.cats});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isLoggedIn = user != null;

    final adoptedCats = isLoggedIn ? cats.where((cat) => cat.adoptedBy == user.uid).toList() : <Cat>[];

    if (!isLoggedIn) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(
              'Please log in to see your adopted cats',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            CachedNetworkImage(imageUrl: 'https://http.cat/401'),
          ],
        ),
      );
    }

    if (adoptedCats.isEmpty && isLoggedIn) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(
              'No cats adopted yet',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            CachedNetworkImage(imageUrl: 'https://http.cat/404'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: adoptedCats.length,
      itemBuilder: (context, index) {
        final cat = adoptedCats[index];

        return CatTile(
          cat: cat,
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) => CatDetailCard(catId: cat.id),
            );
          },
        );
      },
    );
  }
}
