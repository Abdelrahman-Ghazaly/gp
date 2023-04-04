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

// export const filterByPrice = createAsyncThunk('filterSlice/filterByCategory' , async ({minPrice , maxPrice} ) => {
//     // const response = await fetch(`http://localhost:8000/Products?q=${value}`)
//      const response = await fetch(`http://localhost:5000/product/search/product/?minPrice=${minPrice}&maxPrice=${maxPrice}`)
//      const data = await response.json()
//      return data
//      }
//  )

// export const filterByMinPrice = createAsyncThunk('filterSlice/filterByMinPrice' , async (value) => {
//      const response = await fetch(`http://localhost:5000/product/search/product/?minPrice=${value}`)
//      const data = await response.json()
//      return data
//  })

//  export const filterByMaxPrice = createAsyncThunk('filterSlice/filterByMinPrice' , async (value) => {
//      const response = await fetch(`http://localhost:5000/product/search/product/?maxPrice=${value}`)
//      const data = await response.json()
//      return data
//  })

const initialState = {filteredData : [] , loading : true , error : null , minPrice : null , maxPrice : null}

const filterSlice = createSlice({
  name: "filterSlice",
  initialState: initialState,
  reducers: {
    setMinPrice: (state, action) => {
        console.log(action.payload)
      state.minPrice = action.payload;
    },
    setMaxPrice: (state, action) => {
        console.log(action.payload)
      state.maxPrice = action.payload;
    },
  },
  extraReducers: (builder) => {
    builder.addCase(filterProducts.fulfilled, (state, action) => {
      console.log(action.payload);
      state.filteredData = action.payload;
      state.loading = false;
    });
  },
});

export const filterAction = filterSlice.actions

export default filterSlice.reducer