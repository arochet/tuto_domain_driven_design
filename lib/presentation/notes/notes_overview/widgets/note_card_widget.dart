import 'package:flutter/material.dart';
import 'package:tuto_domain_driven_design/application/notes/note_actor/note_actor_bloc.dart';
import 'package:tuto_domain_driven_design/domain/notes/note.dart';
import 'package:kt_dart/collection.dart';
import 'package:tuto_domain_driven_design/domain/notes/todo_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuto_domain_driven_design/presentation/notes/note_form/note_form_page.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.color.getOrCrash(),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/note-form-page",
              arguments: NoteFormArguments(note));
        },
        onLongPress: () {
          final noteActorBloc = context.read<NoteActorBloc>();
          _showDeletingDiaglog(context, noteActorBloc);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              note.body.getOrCrash(),
              style: const TextStyle(fontSize: 18),
            ),
            if (note.todos.length > 0) ...[
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                children: <Widget>[
                  ...note.todos
                      .getOrCrash()
                      .map(
                        (todo) => TodoDisplay(todo: todo),
                      )
                      .iter,
                ],
              ),
            ]
          ]),
        ),
      ),
    );
  }

  void _showDeletingDiaglog(BuildContext context, NoteActorBloc noteActorBloc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Selected note ... "),
          content: Text(
            note.body.getOrCrash(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL"),
            ),
            ElevatedButton(
              onPressed: () {
                noteActorBloc.add(NoteActorEvent.deleted(note));
                Navigator.pop(context);
              },
              child: const Text("DELETE"),
            )
          ],
        );
      },
    );
  }
}

class TodoDisplay extends StatelessWidget {
  final TodoItem todo;

  const TodoDisplay({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (!todo.done)
          Icon(Icons.check_box, color: Theme.of(context).accentColor)
        else
          Icon(Icons.check_box, color: Theme.of(context).disabledColor),
        Text(todo.name.getOrCrash())
      ],
    );
  }
}
