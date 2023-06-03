import {
  Box,
  InputAdornment,
  Typography,
  TextField,
  Button,
} from "@mui/material";
import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { LoginBox } from "../../../Styles/login";
// Import Icons From MUI Icons
import EmailIcon from '@mui/icons-material/Email';
import { Visibility, VisibilityOff } from "@mui/icons-material";
import { useDispatch  , useSelector} from "react-redux";
import { userLogin } from "../../../Store/authReducer";

const LoginForm = () => {
  const dispatch = useDispatch()
  const navigate = useNavigate()

  const { error } = useSelector(state =>  state.auth)

  const [showPassword, setShowPassword] = useState(false);
  const handleClickShowPassword = () => setShowPassword((show) => !show);

  const defaultValues = {email : '' , password : '' }
  const {register , handleSubmit , formState : {errors}} = useForm({defaultValues : defaultValues})

  const handleSubmitForm = async (data) => {

        await dispatch(userLogin(data))
        .then((res) => {
          if (res.meta.requestStatus === "fulfilled")
          navigate("/");
        })
        .catch((err) => {
          console.log(err);
        });

  }

  return (
    <LoginBox>
        <Link to="/">
        <Typography component="h1" variant="h4" sx={{ m: 1 , cursor : 'pointer' }}>
        Furniture
      </Typography>
      </Link>
      <Typography component="h1" variant="h5" style={{backgroundColor : '#54E5A2' , borderRadius : '50px' , padding : '8px 19px' , width: 'auto'}}>
        Sign In
      </Typography>
      <Box component="form" noValidate onSubmit={handleSubmit(handleSubmitForm)}>

        <TextField
          margin="normal"
          fullWidth
          id="email"
          label="Email Address"
          name="email"
          InputProps={{
            endAdornment: <InputAdornment position="end" ><EmailIcon /></InputAdornment>
          }}
          {...register("email", {
            required: "Please Enter A Valid Email e.g : ahmed@gmail.com",
            pattern: /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/
          })}
          error = {!!errors.email}
          helperText={errors.email?.message}
        />

        <TextField
          margin="normal"
          fullWidth
          name="password"
          label="Password"
          type={showPassword ? 'text' : 'password'}
          id="password"
          InputProps={{
            endAdornment: (
              <InputAdornment position="end" onClick={handleClickShowPassword} sx={{cursor : 'pointer'}}>
                {showPassword ? <VisibilityOff /> : <Visibility />}
              </InputAdornment>
            ),
          }}
          {...register("password", {
            required: "Please Enter Your Password",
            minLength: {
              value: 5,
              message: "Minimum Length is 6",
            },
          })}
          error={!!errors.password}
          helperText={errors.password?.message}
        />
        <Button
          type="submit"
          fullWidth
          variant="contained"
          sx={{ mt: 3, mb: 2 , backgroundColor : 'black' , borderRadius : '50px' }}
        >
          Log In
        </Button>
        <h4 style={{ textAlign: "center", marginBottom: "30px" }}>
          Not A Member?{" "}
          <span style={{ color: "blue", cursor: "pointer" }}>
            <Link to="/auth/signup">Sign Up</Link>
          </span>
        </h4>

      </Box>
      {error ? <h2 style={{textTransform : 'capitalize' , color : 'red'}}>{error}</h2> : null}
    </LoginBox>
  );
};

export default LoginForm;
