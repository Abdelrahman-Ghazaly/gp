import React from 'react'
import LoginForm from './LoginForm';

import {
  BoxContainer,
  TextContainer,
  LoginContainer,
  TextStyle,
} from "../../../Styles/login";

const LoginPage = () => {
  return (
    <BoxContainer >
    <TextContainer>
      <TextStyle>To keep connected with largest shop in the world.</TextStyle>
    </TextContainer>
    <LoginContainer>
        <LoginForm />
    </LoginContainer>
    </BoxContainer>
  )
}

export default LoginPage