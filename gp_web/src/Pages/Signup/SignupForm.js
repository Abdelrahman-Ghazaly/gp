import {
  Box,
  InputAdornment,
  Typography,
  TextField,
  Button,
} from "@mui/material";

import React, { useState , useRef } from "react";
import { Link } from "react-router-dom";
import { LoginBox } from "../../Styles/login";

import { useForm } from "react-hook-form";
// Import Icons From MUI Icons
import EmailIcon from "@mui/icons-material/Email";
import PasswordIcon from "@mui/icons-material/Password";
import PersonIcon from '@mui/icons-material/Person';
import LocationOnIcon from "@mui/icons-material/LocationOn";
import DialpadIcon from "@mui/icons-material/Dialpad";
import { Visibility, VisibilityOff } from "@mui/icons-material";

const SignupForm = () => {
  const [showPassword, setShowPassword] = useState(false);
  const handleClickShowPassword = () => setShowPassword((show) => !show);

  const phoneNumberPattern =
    /(\+\d{1,3}\s?)?((\(\d{3}\)\s?)|(\d{3})(\s|-?))(\d{3}(\s|-?))(\d{4})(\s?(([E|e]xt[:|.|]?)|x|X)(\s?\d+))?/g;
  const defaultValues = {email: "", password: "", confirmPassword: "", address: "", fullName: "", phoneNumber: ""};
  const {register, handleSubmit, formState: { errors }, watch,} = useForm({ defaultValues: defaultValues });
  const password = useRef({});
  password.current = watch("password", "");
  const handleSubmitForm = (data, e) => {
    e.preventDefault();
    if (errors && data.password === data.confirmPassword) {
      console.log(data);
    }
  };
  return (
    <LoginBox>
      <Link to="/">
        <Typography
          component="h1"
          variant="h4"
          sx={{ m: 1, cursor: "pointer" }}
        >
          Furniture
        </Typography>
      </Link>
      <Typography
        component="h1"
        variant="h5"
        style={{
          backgroundColor: "#54E5A2",
          borderRadius: "50px",
          padding: "8px 19px",
        }}
      >
        Sign Up
      </Typography>
      <Box
        component="form"
        noValidate
        onSubmit={handleSubmit(handleSubmitForm)}
      >
        <TextField
          margin="normal"
          fullWidth
          id="email"
          label="Email Address"
          name="email"
          InputProps={{
            endAdornment: (
              <InputAdornment position="end">
                <EmailIcon />
              </InputAdornment>
            ),
          }}
          {...register("email", {
            required: "Please Enter A Valid Email e.g : ahmed@gmail.com",
            pattern: /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/,
          })}
          error={!!errors.email}
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
              value: 6,
              message: "Minimum Length is 6",
            },
          })}
          error={!!errors.password}
          helperText={errors.password?.message}
        />
        <TextField
          margin="normal"
          required
          fullWidth
          name="ConfirmPassword"
          label="Confirm Password"
          type={showPassword ? 'text' : 'password'}
          id="confirmPassword"
          InputProps={{
            endAdornment: (
              <InputAdornment position="end" onClick={handleClickShowPassword} sx={{cursor : 'pointer'}}>
                {showPassword ? <VisibilityOff /> : <Visibility />}
              </InputAdornment>
            ),
          }}
          {...register("confirmPassword", {
            required: "Please Enter Your Confirm Password",
            minLength: {
              value: 6,
              message: "Minimum Length is 6",
            },
            validate: (value) =>
              value === password.current || "The passwords do not match",
          })}
          error={!!errors.confirmPassword}
          helperText={errors.confirmPassword?.message}
        />
        <TextField
          margin="normal"
          required
          fullWidth
          id="name"
          label="Full Name"
          name="name"
          InputProps={{
            endAdornment: (
              <InputAdornment position="end">
                <PersonIcon />
              </InputAdornment>
            ),
          }}
          {...register("fullName", {
            required: "Please Enter Your Full Name",
          })}
          error={!!errors.fullName}
          helperText={errors.fullName?.message}
        />
        <TextField
          margin="normal"
          required
          fullWidth
          name="address"
          label="Address"
          type="text"
          id="address"
          InputProps={{
            endAdornment: (
              <InputAdornment position="end">
                <LocationOnIcon />
              </InputAdornment>
            ),
          }}
          {...register("address", {
            required: "Please Enter A Your Address",
          })}
          error={!!errors.address}
          helperText={errors.address?.message}
        />
        <TextField
          margin="normal"
          required
          fullWidth
          id="phone"
          label="Phone Number"
          name="phone"
          autoComplete="email"
          InputProps={{
            endAdornment: (
              <InputAdornment position="end">
                <DialpadIcon />
              </InputAdornment>
            ),
          }}
          {...register("phoneNumber", {
            required: true,
            pattern: {
              value: phoneNumberPattern,
              message: "Please Enter A Valid Phone Number",
            },
          })}
          error={!!errors.phoneNumber}
          helperText={errors.phoneNumber?.message}
        />
        <Button
          type="submit"
          fullWidth
          variant="contained"
          sx={{ mt: 3, mb: 2 , "&:hover" : "{backgroundColor : '#54E5A2'}"}}
          style={{"&:hover" : "{backgroundColor : '#54E5A2'}" , backgroundColor: "black", borderRadius: "50px"}}
        >
          Sign Up
        </Button>

        <h4 style={{ textAlign: "center", marginBottom: "30px" }}>
          Already a member?{" "}
          <span style={{ color: "blue", cursor: "pointer" }}>
            <Link to="/auth/login">Sign In</Link>
          </span>
        </h4>
      </Box>
    </LoginBox>
  );
};

export default SignupForm;
