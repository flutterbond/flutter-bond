import 'package:bond/features/post/data/models/post.dart';
import 'package:bond/features/post/presentations/providers/list_state.dart';
import 'package:bond_network/bond_network.dart';
import 'package:flutter_test/flutter_test.dart';

class _Item extends Model {
  const _Item(int id) : super(id: id);

  @override
  Map<String, dynamic> toJson() => {'id': id};
}

ListResponse<_Item> _page(List<int> ids, {String? next}) => ListResponse(
      data: ids.map(_Item.new).toList(),
      links: Links(next: next),
    );

Post _post(String uuid) => Post.fromJson({
      'uuid': uuid,
      'created_at': '2024-07-31T12:00:00Z',
      'updated_at': '2024-07-31T12:00:00Z',
      'color': '#FFFFFF',
      'urls': {
        for (final size in ['raw', 'full', 'regular', 'small', 'thumb'])
          size: 'https://example.com/$size.jpg',
        'small_s3': 'https://example.com/small_s3.jpg',
      },
      'likes': 0,
      'author': {
        'uuid': 'author',
        'updated_at': '2024-07-31T12:00:00Z',
        'username': 'bond',
        'name': 'Bond',
        'first_name': 'Bond',
        'avatar': 'https://example.com/avatar.jpg',
        'total_likes': 0,
        'total_photos': 0,
      },
      'views': 0,
      'downloads': 0,
    });

void main() {
  test('data -> loading -> success appends the next page', () {
    final first = ListState<_Item>.data(_page([1, 2], next: '/posts?page=2'));
    expect(first.status, ListStatus.success);
    expect(first.hasMoreData, isTrue);

    final loading = first.loading();
    expect(loading.isLoading, isTrue);
    expect(loading.data.data, first.data.data);

    final second = loading.success(_page([3]));
    expect(second.status, ListStatus.success);
    expect(second.data.data.map((item) => item.id), [1, 2, 3]);
    expect(second.hasMoreData, isFalse);
  });

  test('failed keeps the loaded items and the error', () {
    final failed = ListState<_Item>.data(_page([1])).failed('offline');

    expect(failed.status, ListStatus.failed);
    expect(failed.error, 'offline');
    expect(failed.data.data.single.id, 1);
  });

  test('states with different posts are not equal', () {
    // Riverpod 3 drops a state update that is == to the previous state.
    ListState<Post> withPost(String uuid) =>
        ListState.data(ListResponse(data: [_post(uuid)]));

    expect(withPost('a'), isNot(withPost('b')));
    expect(withPost('a'), withPost('a'));
  });

  test('initial state is empty without more data', () {
    final initial = ListState<_Item>.initial();

    expect(initial.status, ListStatus.initial);
    expect(initial.data.data, isEmpty);
    expect(initial.hasMoreData, isFalse);
  });
}
