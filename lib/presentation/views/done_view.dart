import 'package:animate_do/animate_do.dart';
import 'package:double_v_partners/presentation/providers/new_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoneView extends ConsumerStatefulWidget {
  final VoidCallback? onFinish;

  const DoneView({super.key, this.onFinish});

  @override
  ConsumerState<DoneView> createState() => _DoneViewState();
}

class _DoneViewState extends ConsumerState<DoneView> {
  void _onFinish() {
    ref.read(newUserProvider.notifier).resetUser();
    widget.onFinish?.call();
  }

  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(newUserProvider).name;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideInDown(
              child: Icon(
                Icons.check_circle_rounded,
                size: 100,
                color: colors.primary,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              '¡$userName tu registro ha sido completado!',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              'gracias por registrarte. Tu cuenta ha sido creada exitosamente.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onFinish,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Finalizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
