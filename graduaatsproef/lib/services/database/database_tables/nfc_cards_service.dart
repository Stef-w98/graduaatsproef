import 'package:graduaatsproef/models/nfc_cards_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NfcCardsService {
  final supabase = Supabase.instance.client;

  Future<List<NfcCards>> getCards() async {
    final response = await supabase.from('nfc_cards').select().execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    final cards =
        response.data!.map((json) => NfcCards.fromJson(json)).toList();
    cards.forEach(
        (card) => print('${card.cardId}: ${card.userId} - ${card.cardUid}'));
    return cards;
  }

  Future<int> addCard({
    required int userId,
    required String cardUid,
    String? encryptionKey,
  }) async {
    final response = await supabase.from('nfc_cards').insert({
      'user_id': userId,
      'card_uid': cardUid,
      'encryption_key': encryptionKey,
    }).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return response.data!.first['card_id'];
  }

  Future<void> updateCard({
    required int id,
    required int userId,
    required String cardUid,
    String? encryptionKey,
  }) async {
    final updates = <String, dynamic>{
      'user_id': userId,
      'card_uid': cardUid,
      'encryption_key': encryptionKey,
    };
    final response = await supabase
        .from('nfc_cards')
        .update(updates)
        .eq('card_id', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> deleteCard(int id) async {
    final response =
        await supabase.from('nfc_cards').delete().eq('card_id', id).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}
