import { createSlice  , createAsyncThunk} from "@reduxjs/toolkit";


export const filterProducts = createAsyncThunk('filterSlice/filterByCategory' , async (selectedValue , thunkAPI) => {
    const transformValue = selectedValue.toLowerCase()
    let minPrice = thunkAPI.getState().filter.minPrice
    let maxPrice = thunkAPI.getState().filter.maxPrice

    if(minPrice  && maxPrice){
        const response = await fetch(`http://localhost:5000/product/search/product/?category=${transformValue}&minPrice=${minPrice}&maxPrice=${maxPrice}`)
        const data = await response.json()
        return data
    }else {
        const response = await fetch(`http://localhost:5000/product/search/product/?category=${transformValue}`)
        const data = await response.json()
        return data
    }


    }
)


const initialState = {filteredData : [] , loading : true , error : null , minPrice : null , maxPrice : null}

const filterSlice = createSlice({
  name: "filterSlice",
  initialState: initialState,
  reducers: {
    setMinPrice: (state, action) => {
        state.minPrice = action.payload;
    },
    setMaxPrice: (state, action) => {
        state.maxPrice = action.payload;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(filterProducts.fulfilled, (state, action) => {
      state.filteredData = action.payload;
      state.loading = false;
    });
  },
});

export const filterAction = filterSlice.actions

export default filterSlice.reducer