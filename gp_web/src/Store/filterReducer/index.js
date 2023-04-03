import { createSlice  , createAsyncThunk} from "@reduxjs/toolkit";


export const filterByCategory = createAsyncThunk('filterSlice/filterByCategory' , async (value) => {
   // const response = await fetch(`http://localhost:8000/Products?q=${value}`)
    const response = await fetch(`http://localhost:8000/Products?category=${value}`)
    const data = await response.json()
    return data
})

// export const filterByMinPrice = createAsyncThunk('filterSlice/filterByMinPrice' , async (value) => {
//      const response = await fetch(`http://localhost:8000/Products?category=${value}`)
//      const data = await response.json()
//      return data
//  })

//  export const filterByMaxPrice = createAsyncThunk('filterSlice/filterByMinPrice' , async (value) => {
//      const response = await fetch(`http://localhost:8000/Products?category=${value}`)
//      const data = await response.json()
//      return data
//  })

const initialState = {filteredData : [] , loading : true , error : null}

const filterSlice = createSlice({
    name : 'filterSlice',
    initialState : initialState,
    reducers : {},
    extraReducers : (builder) => {
        builder
            .addCase(filterByCategory.fulfilled , (state , action) => {
                state.filteredData = action.payload
                state.loading = false
            })
    }
})

export default filterSlice.reducer