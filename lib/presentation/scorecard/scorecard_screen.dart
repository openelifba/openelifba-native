import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:openelifba/di/service_locator.dart';

import 'store/scorecard_store.dart';

class ScorecardScreen extends StatefulWidget {
  const ScorecardScreen({super.key});

  @override
  State<ScorecardScreen> createState() => _ScorecardScreenState();
}

class _ScorecardScreenState extends State<ScorecardScreen> {
  final ScorecardStore _store = getIt<ScorecardStore>();

  @override
  void initState() {
    super.initState();
    _store.fetchScoreboard();
  }

  Future<void> _refresh() => _store.fetchScoreboard();

  String _formatUserId(String userId) {
    if (userId.length <= 8) return userId;
    return userId.substring(0, 8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoreboard'),
        centerTitle: true,
      ),
      body: Observer(
        builder: (context) {
          if (_store.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!_store.success && _store.topScores.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.leaderboard_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No scores yet',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _refresh,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHeader(context),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final entry = _store.topScores[index];
                      final isCurrentUser =
                          entry.userId == _store.currentUserId;
                      return _buildRankRow(
                        context,
                        rank: entry.rank,
                        userId: entry.userId,
                        score: entry.score,
                        isCurrentUser: isCurrentUser,
                      );
                    },
                    childCount: _store.topScores.length,
                  ),
                ),
                if (_store.myRank != null &&
                    !_store.topScores
                        .any((e) => e.userId == _store.currentUserId))
                  SliverToBoxAdapter(
                    child: _buildMyRankBanner(context),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.leaderboard,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                'Top Learners',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Ranked by total correct answers',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  child: Text(
                    'Rank',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.5),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'User',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.5),
                    ),
                  ),
                ),
                Text(
                  'Score',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankRow(
    BuildContext context, {
    required int rank,
    required String userId,
    required int score,
    required bool isCurrentUser,
  }) {
    final Color rankColor = _rankColor(rank);
    final bool isTopThree = rank <= 3;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: isCurrentUser
            ? Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 48,
              child: isTopThree
                  ? _buildMedalIcon(rank)
                  : Text(
                      '#$rank',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: rankColor,
                      ),
                    ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: isCurrentUser
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade300,
                    child: Text(
                      isCurrentUser ? 'Y' : _formatUserId(userId)[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isCurrentUser ? Colors.white : Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCurrentUser ? 'You' : _formatUserId(userId),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isCurrentUser
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (!isCurrentUser)
                          Text(
                            'ID: ${userId.length > 8 ? '${userId.substring(0, 8)}...' : userId}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.4),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: rankColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$score',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: rankColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedalIcon(int rank) {
    final icons = {
      1: ('🥇', const Color(0xFFFFD700)),
      2: ('🥈', const Color(0xFFC0C0C0)),
      3: ('🥉', const Color(0xFFCD7F32)),
    };
    final medal = icons[rank]!;
    return Text(
      medal.$1,
      style: const TextStyle(fontSize: 24),
    );
  }

  Widget _buildMyRankBanner(BuildContext context) {
    final myRank = _store.myRank!;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Your ranking',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
          ),
          _buildRankRow(
            context,
            rank: myRank.rank,
            userId: myRank.userId,
            score: myRank.score,
            isCurrentUser: true,
          ),
        ],
      ),
    );
  }

  Color _rankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFF9E9E9E);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return const Color(0xFF5C6BC0);
    }
  }
}
