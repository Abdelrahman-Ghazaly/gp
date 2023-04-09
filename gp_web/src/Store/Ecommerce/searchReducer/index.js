import { createSlice  , createAsyncThunk} from "@reduxjs/toolkit";


export const fetchDataByTitle = createAsyncThunk('searchSlice/fetchDataByTitle' , async (value) => {
    const response = await fetch(`http://localhost:5000/product/search/product/?query=${value}`)
    const data = await response.json()
    // let result = data.filter(item => {return item.title.trim().toLowerCase().includes(value)})
    return data
})

const initialState = {data : [] , loading : true , error : null}

const searchSlice = createSlice({
    name : 'searchSlice',
    initialState : initialState,
    reducers : {

    },
    extraReducers : (builder) => {
        builder.addCase(fetchDataByTitle.fulfilled , (state , action) => {
            state.data = action.payload
            state.loading = false
        })
    }
})

export const searchActions = searchSlice.actions

export default searchSlice.reducer