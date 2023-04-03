import { createSlice , createAsyncThunk } from "@reduxjs/toolkit";

export const addToFavorites = createAsyncThunk(
    'favorites/add',
    async (item, thunkAPI ) => {
        try {
          const response = await fetch("http://localhost:8000/Favorite", {
            method: "POST",
            body: JSON.stringify(item),
            headers: { "Content-Type": "application/json" },
          });
          const data = await response.json();
          return data;
        } catch (error) {
          return thunkAPI.rejectWithValue(error.response.data);
        }
    }
  );

export const removeFromFavorites = createAsyncThunk(
    'favorites/remove',
    async (itemId, thunkAPI) => {
      try {
        await fetch(`http://localhost:8000/Favorite/${itemId}` , {method : "DELETE",})
        return itemId;
      } catch (error) {
        return thunkAPI.rejectWithValue(error.response.data);
      }
    }
  );

export const fetchFavList = createAsyncThunk(
    "favorite/fetch",
    async (thunkAPI) => {
      try {
        const response = await fetch("http://localhost:8000/Favorite");
        if (!response.ok) {
          throw new Error("Fetching Error");
        }
        const data = await response.json();
        return data;
      } catch (error) {
        return thunkAPI.rejectWithValue(error.response.data);
      }
    }
  );

const initialState = {favList : [] , loading : true , error : null , status : 'idle'}

const favoriteSlice = createSlice({
    name : 'favoriteSlice',
    initialState : initialState,
    reducers : { },
    extraReducers: builder => {
        builder
          .addCase(fetchFavList.fulfilled , (state , action) => {
            state.favList = action.payload
            state.loading = false
          })
          .addCase(addToFavorites.pending, (state) => {
            state.status = 'loading';
          })
          .addCase(addToFavorites.fulfilled, (state, action) => {
            state.status = 'succeeded';
            const existingIndex = state.favList.findIndex((favItem) => favItem.id === action.payload.id);
            if (existingIndex === -1) {
              state.favList.push(action.payload);
            }
          })
          .addCase(addToFavorites.rejected, (state, action) => {
            state.status = 'failed';
            state.error = action.payload;
          })
          .addCase(removeFromFavorites.pending, (state) => {
            state.status = 'loading';
          })
          .addCase(removeFromFavorites.fulfilled, (state, action) => {
            state.status = 'succeeded';
            const itemId = action.payload;
            state.favList = state.favList.filter((item) => item.id !== itemId);
          })
          .addCase(removeFromFavorites.rejected, (state, action) => {
            state.status = 'failed';
            state.error = action.payload;
          })
      }
})

export const favoriteActions = favoriteSlice.actions

export default favoriteSlice.reducer