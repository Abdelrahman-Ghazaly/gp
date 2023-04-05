import { createSlice , createAsyncThunk } from "@reduxjs/toolkit";

export const uploadProduct = createAsyncThunk(
  "uploadProduct/productSlice",
  async (item , thunkAPI) => {
    try {
        let userToken = thunkAPI.getState().auth.userToken;
        const response = await fetch("http://localhost:5000/upload", {
          method: "POST",
          body: JSON.stringify(item),
          headers: {
            token: "Bearer " + userToken,
            "Content-Type": "application/json",
          },
        });
        const data = await response.json();
        return data;
      } catch (error) {
        return thunkAPI.rejectWithValue(error.response.data);
      }
  }
);

export const deleteProduct = createAsyncThunk(
  "deleteProduct/productSlice",
  async (itemId, thunkAPI) => {
    try {
      let userToken = thunkAPI.getState().auth.userToken;
      await fetch(` http://localhost:5000/delete/${itemId}`, {
        method: "DELETE",
        headers: {
          token: "Bearer " + userToken,
          "Content-Type": "application/json",
        },
      });
      return itemId;
    } catch (error) {
      return thunkAPI.rejectWithValue(error.response.data);
    }
  }
);

export const fetchUploadedProduct = createAsyncThunk(
  "fetchUploadedProduct/productSlice",
  async (thunkAPI) => {
    try {
        const response = await fetch("http://localhost:8000/UploadProducts");
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

const initialState = {uploadedList : [] , loading : true , error : null}

const productSlice = createSlice({
    name : 'productSlice',
    initialState : initialState,
    reducers : {},
    extraReducers : builder => {
        builder
            .addCase(uploadProduct.fulfilled , (state , action) => {
                const existingIndex = state.uploadedList.findIndex((favItem) => favItem.id === action.payload.id);
                if (existingIndex === -1) {
                  state.uploadedList.push(action.payload);
                }
                state.loading = false
            })
            .addCase(deleteProduct.fulfilled, (state, action) => {
                const itemId = action.payload;
                state.uploadedList = state.uploadedList.filter((item) => item.id !== itemId);
                state.loading = false
            })
            .addCase(fetchUploadedProduct.fulfilled , (state , action) => {
                state.uploadedList = action.payload
                state.loading = false
            })
    }
})

export default productSlice.reducer