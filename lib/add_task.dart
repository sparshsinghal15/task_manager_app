import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
// import 'package:task_manager_app/data/pending_tasks.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:provider/provider.dart';
import './providers/pending_tasks_provider.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Task'),
          leading: IconButton(
            onPressed: () => GoRouter.of(context).go('/'),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: const Center(
          child: Form(),
        ));
  }
}

class Form extends StatefulWidget {
  const Form({
    Key? key,
  }) : super(key: key);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  var task = Task(
    title: "",
    date: DateTime.now(),
    priority: "Low",
  );

  Widget buildTitle() {
    return TextField(
      decoration: const InputDecoration(
        hintText: "Send an email to the team",
        labelText: "Title",
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      onChanged: ((value) {
        setState(() {
          task.title = value;
        });
      }),
    );
  }

  final _textFieldValueHolder = TextEditingController();

  Widget buildDate() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "01/01/2023",
        labelText: "Date",
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      controller: _textFieldValueHolder,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context, //context of current state
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          setState(() {
            task.date = pickedDate;
            _textFieldValueHolder.text = DateFormat.yMMMMd().format(pickedDate);
          });
        }
      },
    );
  }

  Widget buildPriority() {
    return InputDecorator(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 7,
        ),
        labelText: 'Priority',
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          onChanged: ((String? value) {
            setState(() {
              task.priority = value as String;
            });
          }),
          value: task.priority,
          items: const [
            DropdownMenuItem(value: 'High', child: Text('High')),
            DropdownMenuItem(value: 'Medium', child: Text('Medium')),
            DropdownMenuItem(value: 'Low', child: Text('Low')),
          ],
        ),
      ),
    );
  }

  void _submit() {
    // setState(() {
    //   pendingTasks.add(task);
    // });
    context.read<PendingTasks>().addTask(task);
    GoRouter.of(context).go('/');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 40,
      ),
      children: <Widget>[
        buildTitle(),
        const SizedBox(height: 40),
        buildDate(),
        const SizedBox(height: 40),
        buildPriority(),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _submit,
          child: const Text("Add"),
        )
      ],
    );
  }
}
