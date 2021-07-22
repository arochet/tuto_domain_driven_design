import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kt_dart/kt.dart';
import 'package:provider/provider.dart';
import 'package:tuto_domain_driven_design/application/notes/note_form/note_form_bloc.dart';
import 'package:tuto_domain_driven_design/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:tuto_domain_driven_design/presentation/notes/note_form/misc/build_context_x.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (p, c) => p.note.todos.isFull != c.note.todos.isFull,
      listener: (context, state) {
        if (state.note.todos.isFull) {
          FlushbarHelper.createAction(
            message: "Want longer lists ? Activate premium !",
            button: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "BUY NOW",
                  style: TextStyle(color: Colors.yellow),
                )),
            duration: const Duration(seconds: 5),
          ).show(context);
        }
      },
      child: Consumer<FormTodos>(builder: (context, formTodos, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: formTodos.value.size,
          itemBuilder: (context, index) {
            return TodoTile(index: index);
          },
        );
      }),
    );
  }
}

class TodoTile extends HookWidget {
  final int index;

  const TodoTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo =
        context.formTodos.getOrElse(index, (_) => TodoItemPrimitive.empty());

    return ListTile(
      leading: Checkbox(
        value: todo.done,
        onChanged: (value) {
          if (value != null) {
            context.formTodos = context.formTodos.map((listTodo) =>
                listTodo == todo ? todo.copyWith(done: value) : listTodo);
            context
                .read<NoteFormBloc>()
                .add(NoteFormEvent.todosChanged(context.formTodos));
          } else {
            throw Exception("Value is null !");
          }
        },
      ),
    );
  }
}
