import 'package:flutter/material.dart';

class EventTile extends StatefulWidget {
  const EventTile({super.key});

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  bool attending = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.event_outlined),
      ),
      tileColor: Colors.grey.shade200,
      title: const Text('Event Title'),
      subtitle: Text(DateTime.now().toString().split('.')[0]),
      trailing: TextButton.icon(
        onPressed: () => setState(() {
          attending = !attending;
        }),
        icon: Icon(attending ? Icons.join_full_rounded : Icons.join_inner_rounded),
        label: Text(attending ? 'Attending' : 'Attend'),
      ),
    );
  }
}
