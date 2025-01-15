import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/crud/notes_service.dart';
import 'package:mynotes/utilities/dialogs/logout_dialog.dart';
import 'package:mynotes/view/notes/note_list_view.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  late final NotesService _noteService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _noteService = NotesService();
    _noteService.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Notes'), actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(newNoteRoute);
          },
          icon: const Icon(Icons.add),
        ),
        PopupMenuButton<MenuAction>(onSelected: (value) async {
          switch (value) {
            case MenuAction.logout:
              final shouldLogout = await showLogOutDialog(context);
              if (shouldLogout) {
                await AuthService.firebase().logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (_) => false);
              }
          }
        }, itemBuilder: (context) {
          return const [
            PopupMenuItem<MenuAction>(
                value: MenuAction.logout, child: Text('Logout'))
          ];
        })
      ]),
      body: FutureBuilder(
          future: _noteService.createUser(email: userEmail),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return StreamBuilder(
                  stream: _noteService.allNotes,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          final allNotes = snapshot.data as List<DatabaseNote>;
                          return NotesListView(
                            notes: allNotes,
                            onDeleteNote: (note) async {
                              await _noteService.deleteNote(id: note.id);
                            },
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      default:
                        return const CircularProgressIndicator();
                    }
                  },
                );
              default:
                return const CircularProgressIndicator();
            }
          }),
    );
  }
}

// Future<bool> showLogOutDialog(BuildContext context) {
//   return showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//             title: const Text('Sign Out'),
//             content: const Text('Are you sure you want to sign out?'),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(false);
//                   },
//                   child: const Text('Cancel')),
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(true);
//                   },
//                   child: const Text('Log out'))
//             ]);
//       }).then((value) => value ?? false);
// }
