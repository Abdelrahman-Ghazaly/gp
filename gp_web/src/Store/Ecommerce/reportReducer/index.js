import { createAsyncThunk , createSlice } from "@reduxjs/toolkit";

export const sendReport = createAsyncThunk('sendReport/reportSlice' ,  async ({reportValues , id}, thunkAPI) => {
    try {
        let userToken = thunkAPI.getState().auth.userToken;
        console.log(reportValues , id)
        const response = await fetch(`http://localhost:5000/report/${id}`, {
          method: "POST",
          body: JSON.stringify(reportValues),
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
)

const initialState = {reportList : [] , loading : true , error : null}

const reportSlice = createSlice({
    name : 'reportSlice',
    initialState : initialState,
    reducers : {},
    extraReducers : builder => {
        builder
            .addCase(sendReport.fulfilled , (state , action) => {
                state.reportList = action.payload
                state.loading = false
            })
    }
})

export default reportSlice.reducer