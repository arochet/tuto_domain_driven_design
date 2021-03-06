import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:tuto_domain_driven_design/application/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuto_domain_driven_design/application/notes/note_actor/note_actor_bloc.dart';
import 'package:tuto_domain_driven_design/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:tuto_domain_driven_design/injection.dart';
import 'package:tuto_domain_driven_design/presentation/notes/note_form/note_form_page.dart';
import 'package:tuto_domain_driven_design/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:tuto_domain_driven_design/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
            create: (context) => getIt<NoteWatcherBloc>()
              ..add(const NoteWatcherEvent.watchAllStarted())),
        BlocProvider<NoteActorBloc>(
            create: (context) => getIt<NoteActorBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            state.maybeMap(
              unauthenticated: (_) =>
                  Navigator.pushReplacementNamed(context, '/sign-in'),
              orElse: () {},
            );
          }),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                deleteFailure: (state) {
                  FlushbarHelper.createError(
                      message: state.noteFailure.map(
                    unexpected: (_) =>
                        'Unexpected error occured while deleting, please contact support.',
                    insufficientPermission: (_) => 'Insufficient permissions ???',
                    unableToUpdate: (_) => 'Impossible error',
                  )).show(context);
                },
                orElse: () {},
              );
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(
              title: const Text("Notes"),
              leading: IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.signedOut());
                },
                icon: const Icon(Icons.exit_to_app),
              ),
              actions: <Widget>[UncompletedSwitch()]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/note-form-page',
                arguments: NoteFormArguments(null),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: NotesOverviewBody(),
        ),
      ),
    );
  }
}
