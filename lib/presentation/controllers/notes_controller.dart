import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/notes_model.dart';
import '../../data/repositories/note_repository.dart';
import '../../main.dart';
import '../screens/home_screen.dart';


class NotesController extends GetxController {
  final NoteRepository _nr = NoteRepository();
  final viewMode = 2.obs;
  Rx<Color> noteColor = Colors.white.obs;
  final isload = false.obs;
  RxBool isFavorite = false.obs;

  final count_notes = 0.obs;
  final getTrashcount = 0.obs;
  final favorite_count = 0.obs;

  final notes = <NotesModel>[].obs;
  final trash_notes = <NotesModel>[].obs;
  final favorite_notes = <NotesModel>[].obs;

  var isDarkMode = false.obs;

  RxList<NotesModel> searchResults = <NotesModel>[].obs;
  RxBool isSearching = false.obs;
  RxBool ischangs = false.obs;

  ischang() {
    ischangs.value = !ischangs.value;
  }

  // دالة تبديل بسيطة
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  @override
  void onInit() async {
    super.onInit();
    // await removeAll();
    viewMode.value = getStorage.read('viewMode') ?? 2;
    await inil();
  }

  void toggleGridColumns() {
    if (viewMode.value == 2) {
      viewMode.value = 1;
    } else {
      viewMode.value = 2;
    }

    // حفظ القيمة
    getStorage.write('viewMode', viewMode.value);
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  ///////////////////////////////////////////
  //////////////////////////////////////////////

  Future<List<NotesModel>> searchNotes(String query) async {
    try {
      isSearching.value = true;
      searchResults.value = await _nr.searchNotes(query);
      return searchResults.value;
    } catch (e) {
      print('Search error: $e');
      return [];
    } finally {
      isSearching.value = false;
    }
  }

  // ========== الملاحظات الأساسية ==========
  Future<void> insertnote(
    String title,
    String content, {
    Color? cardColor,
  }) async {
    try {
      isload(true);

      String? cardColorHex;
      // ⬅️ تحويل فقط إذا كان ليس الأبيض الافتراضي
      if (cardColor != null && cardColor != Colors.white) {
        cardColorHex = colorToHex(cardColor);
      }
      // إذا كان أبيض أو null ← لا نرسل لون (يصبح null في قاعدة البيانات)

      final notes = await _nr.insert(title, content, cardColor: cardColorHex);

      if (notes) {
        await inil();
        Get.off(HomeScreen(),duration:Duration(milliseconds: 400),transition:Transition.zoom );
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isload(false);
    }
  }

  Future<void> updatenote(
    String title,
    String content,
    int id, {
    Color? cardColor,
  }) async {
    try {
      isload(true);

      String? cardColorHex;
      // ⬅️ نفس المنطق
      if (cardColor != null && cardColor != Colors.white) {
        cardColorHex = colorToHex(cardColor);
      }

      final notes = await _nr.update(
        title,
        content,
        id,
        cardColor: cardColorHex,
      );
      if (notes) {
        await inil();
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isload(false);
    }
  }

  Future<void> deletenote(int id) async {
    try {
      isload(true);
      final notes = await _nr.delete(id);
      if (notes) {
        await inil();
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isload(false);
    }
  }

  Future<void> removeAll() async {
    try {
      isload(true);
      final notes = await _nr.removeAll();
      if (notes) {
        await inil();
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isload(false);
    }
  }

  Future<List<NotesModel>> getAllNotes() async {
    try {
      isload(true);
      notes.value = await _nr.getAllNotes();
      return notes.value;
    } catch (e) {
      print(e.toString());
      return [];
    } finally {
      isload(false);
    }
  }

  Future<int> getNotesCount() async {
    try {
      int count = await _nr.getNotesCount();
      count_notes.value = count;
      return count_notes.value;
    } catch (e) {
      return 0;
    }
  }

  // ========== المحذوفات ==========
  Future<void> moveToTrash(int id) async {
    try {
      isload(true);
      final notes = await _nr.moveToTrash(id);
      if (notes) {
        await inil();
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isload(false);
    }
  }

  Future<void> restoreFromTrash(int id) async {
    try {
      isload(true);
      final notes = await _nr.restoreFromTrash(id);
      if (notes) {
        await inil();
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isload(false);
    }
  }

  Future<List<NotesModel>> getDeletedNotess() async {
    try {
      isload(true);
      trash_notes.value = await _nr.getDeletedNotes();
      return trash_notes.value;
    } catch (e) {
      print(e.toString());
      return [];
    } finally {
      isload(false);
    }
  }

  Future<int> getTrashCount() async {
    try {
      int count = await _nr.getTrashCount();
      getTrashcount.value = count;
      return getTrashcount.value;
    } catch (e) {
      return 0;
    }
  }

  Future<void> removeAlltrash() async {
    try {
      isload(true);
      final notes = await _nr.removeAlltrash();
      if (notes) {
        await inil();
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isload(false);
    }
  }

  /////////////////////////////////
  // ========== المفضلات ==========//
  /////////////////////////////////
  Future<void> toggleFavorite(int id) async {
    try {
      isload(true);
      final notes = await _nr.toggleFavorite(id);
      if (notes) {
        await inil();
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isload(false);
    }
  }

  Future<void> removeFromFavorites(int id) async {
    try {
      isload(true);
      final notes = await _nr.removeFromFavorites(id);
      if (notes) {
        await inil();
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isload(false);
    }
  }

  Future<List<NotesModel>> getFavoriteNotes() async {
    try {
      isload(true);
      favorite_notes.value = await _nr.getFavoriteNotes();
      return favorite_notes.value;
    } catch (e) {
      print(e.toString());
      return [];
    } finally {
      isload(false);
    }
  }

  Future<int> getFavoritesCount() async {
    try {
      int count = await _nr.getFavoritesCount();
      favorite_count.value = count;
      return favorite_count.value;
    } catch (e) {
      return 0;
    }
  }

  Future<void> removeAllfav() async {
    try {
      isload(true);
      final notes = await _nr.removeAllfav();
      if (notes) {
        await inil();
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isload(false);
    }
  }

  Future<bool> isFavorites(int id) async {
    return await _nr.isFavorite(id);
  }

  Future<void> inil() async {
    await getAllNotes();
    await getNotesCount();
    await getDeletedNotess();
    await getTrashCount();
    await getFavoriteNotes();
    await getFavoritesCount();
  }
}
