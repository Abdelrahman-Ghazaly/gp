import { createSlice , createAsyncThunk } from "@reduxjs/toolkit";

export const userRegister = createAsyncThunk('userRegister/authSlice' , async (data , thunkAPI) => {
    try{
        await fetch('http://localhost:5000/auth/signup' , {
            method : 'POST',
            body : JSON.stringify(data),
            headers : {'Content-Type': 'application/json'}
        })
    }catch(error) {
        return thunkAPI.rejectWithValue(error.response.data);
    }
})

export const userLogin = createAsyncThunk('userLogin/authSlice' , async (data , thunkAPI) => {
    try{
       const response = await fetch('http://localhost:5000/auth/login' , {
            method : 'POST',
            body : JSON.stringify(data),
            headers : {'Content-Type': 'application/json'}
        })
        if (!response.ok){
            const error = await response.json()
            return thunkAPI.rejectWithValue(error)
        }
        const result = await response.json()
        return result
    }catch(error) {
        return thunkAPI.rejectWithValue(error.response.data);
    }
})

const initialState = {userData : null  , userToken : '' , userId : '' , loading : true , error : null , status : 'idle'}

const authSlice = createSlice({
    name : 'authSlice',
    initialState : initialState,
    reducers : {
        login (state , action) {
            state.userData = action.payload
            state.userToken = action.payload?.accessToken
            state.userId = action.payload?.userId
        },
        logout (state)  {
            state.userData = null
            state.userToken = null
            localStorage.clear();
        }
    },
    extraReducers : builder => {
        builder
            .addCase(userLogin.fulfilled , (state , action) => {
                state.status = 'success'

                console.log(state.adminRole)
                if(action.payload?.message){
                    state.error = action.payload?.message
                }

                state.userData = action.payload.userData
                state.userToken = action.payload.userData?.accessToken
                state.userId = action.payload.userData?._id


                localStorage.setItem('userData', JSON.stringify(action.payload.userData))
                state.loading = false
            })
            .addCase(userLogin.pending , (state , action) => {
                state.status = 'pending'
                state.error = action.payload?.message
            })
            .addCase(userLogin.rejected , (state , action) => {
                state.status = 'failed'
                state.error = action.payload?.message
            })
    }
})

export const authSliceAction = authSlice.actions

export default authSlice.reducer