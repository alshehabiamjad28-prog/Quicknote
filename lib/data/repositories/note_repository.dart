import '../../core/constants/services/notes_database_helper.dart';
import '../models/notes_model.dart';

class NoteRepository {
  final NotesDatabaseHelper _dbHelper = NotesDatabaseHelper();

  // ========== الملاحظات الأساسية ==========

  Future<bool> insert(String title, String content, {String? cardColor}) async {
    return await _dbHelper.insert(title, content, cardColor: cardColor);
  }

  Future<bool> update(String title, String content, int id, {String? cardColor}) async {
    return await _dbHelper.update(title, content, id, cardColor: cardColor);
  }

  /// حذف ملاحظة نهائياً
  Future<bool> delete(int id) async {
    return await _dbHelper.delete(id);
  }
  Future<bool> removeAll()async{
    return await _dbHelper.deleteAll();
  }

  /// عرض جميع الملاحظات النشطة
  Future<List<NotesModel>> getAllNotes() async {
    List<Map<String,dynamic>> data = await _dbHelper.getallnotes();
    return data.map((e) => NotesModel.fromMap(e)).toList();
  }

  /// عدد الملاحظات النشطة
  Future<int> getNotesCount() async {
    return await _dbHelper.getNotesCount();
  }


  // ========== المحذوفات ==========
  /// نقل ملاحظة إلى سلة المحذوفات
  Future<bool> moveToTrash(int id) async {
    return await _dbHelper.moveToTrash(id);
  }

  /// استرجاع ملاحظة من سلة المحذوفات
  Future<bool> restoreFromTrash(int id) async {
    return await _dbHelper.restoreFromTrash(id);
  }
  Future<bool> removeAlltrash()async{
    return await _dbHelper.trashAll();
  }

  /// عرض جميع الملاحظات المحذوفة
  Future<List<NotesModel>> getDeletedNotes() async {
    List<Map<String,dynamic>> data = await _dbHelper.getDeletedNotes();
    return data.map((e) => NotesModel.fromMap(e)).toList();
  }

  Future<List<NotesModel>> searchNotes(String query) async {
    List<Map<String,dynamic>> data = await _dbHelper.searchNotes(query);
    return data.map((e) => NotesModel.fromMap(e)).toList();
  }

  /// عدد الملاحظات في سلة المحذوفات
  Future<int> getTrashCount() async {
    return await _dbHelper.getTrashCount();
  }




  // ========== المفضلات ==========
  /// إضافة ملاحظة إلى المفضلات
  Future<bool> toggleFavorite(int id) async {
    return await _dbHelper.toggleFavorite(id);
  }

  /// إزالة ملاحظة من المفضلات
  Future<bool> removeFromFavorites(int id) async {
    return await _dbHelper.removeFromFavorites(id);
  }
  Future<bool> removeAllfav()async{
    return await _dbHelper.delertAllfav();
  }
  /// عرض جميع الملاحظات المفضلة
  Future<List<NotesModel>> getFavoriteNotes() async {
    List<Map<String,dynamic>> data = await _dbHelper.getFavoriteNotes();
    return data.map((e) => NotesModel.fromMap(e)).toList();
  }

  /// عدد الملاحظات المفضلة
  Future<int> getFavoritesCount() async {
    return await _dbHelper.getFavoritesCount();
  }

  /// التحقق إذا كانت الملاحظة مفضلة
  Future<bool> isFavorite(int id) async {
    return await _dbHelper.isFavorite(id);
  }
}