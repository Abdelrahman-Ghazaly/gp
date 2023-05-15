import { configureStore } from '@reduxjs/toolkit';
import authReducer from './authReducer';
import chatReducer from './Chat'

import searchReducer from './Ecommerce/searchReducer';
import favoriteReducer from './Ecommerce/favoriteReducer';
import productReducer from './Ecommerce/productReducer';
import filterReducer from './Ecommerce/filterReducer';
import reportReducer from './Ecommerce//reportReducer';

export const store = configureStore({
  reducer: {
    search: searchReducer,
    favorite: favoriteReducer,
    product: productReducer,
    filter : filterReducer,
    auth : authReducer,
    report : reportReducer,
    chat : chatReducer
  },
});