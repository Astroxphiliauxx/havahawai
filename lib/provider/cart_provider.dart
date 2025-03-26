import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:havahawai/model/cart_item.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(CartItem newItem) {
    final index = state.indexWhere(
      (item) => item.product.id == newItem.product.id,
    );

    if (index >= 0) {
      state = [
        ...state,
        state[index].copyWith(
          quantity: state[index].quantity + newItem.quantity,
        ),
      ]..removeAt(index);
    } else {
      state = [...state, newItem];
    }
  }

  void removeItem(int productId) {
    state = [
      for (final item in state)
        if (item.product.id != productId) item,
    ];
  }

  void incrementQuantity(int productId) {
    state = [
      for (final item in state)
        if (item.product.id == productId)
          item.copyWith(quantity: item.quantity + 1)
        else
          item,
    ];
  }

  void decrementQuantity(int productId) {
    state = [
      for (final item in state)
        if (item.product.id == productId)
          item.copyWith(quantity: item.quantity - 1)
        else
          item,
    ];

    // Remove item if quantity is 0
    state = [
      for (final item in state)
        if (item.quantity > 0) item,
    ];
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);