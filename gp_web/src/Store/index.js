import { configureStore } from '@reduxjs/toolkit';
import searchReducer from './searchReducer';
import favoriteReducer from './favoriteReducer';
import productReducer from './productReducer';
import filterReducer from './filterReducer';
import authReducer from './authReducer';

export const store = configureStore({
  reducer: {
    search: searchReducer,
    favorite: favoriteReducer,
    product: productReducer,
    filter : filterReducer,
    auth : authReducer
  },
});