import { createSlice , createAsyncThunk } from "@reduxjs/toolkit";

export const getConversations = createAsyncThunk('getConversations/chatSlice' , async (_ , thunkAPI) => {
    try{
        //let {_id} = JSON.parse(localStorage.getItem('userData'));
        let {_id , accessToken} = thunkAPI.getState().auth.userData;
        console.log(_id)
        const response = await fetch(`http://localhost:5000/conversation/${_id}` , {
            headers: {
                token: "Bearer " + accessToken,
                "Content-Type": "application/json",
            },
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

export const createConversation = createAsyncThunk('createConversation/chatSlice' , async (data , thunkAPI) => {
    try{
        let {accessToken} = thunkAPI.getState().auth.userData;
        const response = await fetch(`http://localhost:5000/conversation/` , {
            method : 'POST',
            body : JSON.stringify(data),
            headers : {'Content-Type': 'application/json' ,
            token: "Bearer " + accessToken,}
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

export const getMessages = createAsyncThunk('getMessages/chatSlice' , async (currentChat , thunkAPI) => {
    try{
        let {accessToken} = thunkAPI.getState().auth.userData;
        const response = await fetch(`http://localhost:5000/message/${currentChat?._id}` , {
            headers: {
                token: "Bearer " + accessToken,
                "Content-Type": "application/json",
            },
        })
        if (!response.ok){
            const error = await response.json()
            return thunkAPI.rejectWithValue(error)
        }
        const result = await response.json()
        return {currentChat , result}
    }catch(error) {
        return thunkAPI.rejectWithValue(error.response.data);
    }
})

export const sendMessage = createAsyncThunk('sendMessage/chatSlice' , async (message , thunkAPI) => {
    try{
        let {accessToken} = thunkAPI.getState().auth.userData;
        const response = await fetch(`http://localhost:5000/message/` , {
            method : 'POST',
            body : JSON.stringify(message),
            headers : {'Content-Type': 'application/json' , 
            token: "Bearer " + accessToken,}
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

const initialState = {
  conversations: [],
  currentChat: null, // CurrentChat is The Current Conversation
  messages: [],
  arrivalMessage: null,
  loading: true,
  error: null,
};

const chatSlice = createSlice({
    name : 'chatSlice',
    initialState : initialState ,
    reducers : {
        setCurrentChat (state , action) {
            state.currentChat = action.payload
        },

        setArrivalMessage (state , action) {
            console.log(action.payload)
            state.arrivalMessage = action.payload
        },

        receiveMessage (state , action) {
            console.log(action.payload)
            state.messages =  [...state.messages , action.payload]
        }
    },
    extraReducers : builder => {
        builder
            .addCase(getConversations.fulfilled , (state , action) => {
                state.conversations = action.payload
                state.loading = false
            })
            .addCase(createConversation.fulfilled , (state , action) => {
                console.log(action.payload)
                state.loading = false
            })
            .addCase(getMessages.fulfilled , (state , action) => {
                const {currentChat , result} = action.payload
                console.log(currentChat , result)
                state.currentChat = currentChat
                state.messages = result
                state.loading = false
            })
            .addCase(sendMessage.fulfilled , (state , action) => {
                state.messages = [...state.messages , action.payload]
                state.loading = false
            })

    }
})

export const chatSliceAction = chatSlice.actions

export default chatSlice.reducer