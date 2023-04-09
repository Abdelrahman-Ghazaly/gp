import React  from "react";
import SignupForm from "./SignupForm";

import {
  BoxContainer,
  TextContainer,
  LoginContainer,
  TextStyle,
} from "../../../Styles/login";

const SignupPage = () => {


  return (
    <BoxContainer >
      <TextContainer >
        <TextStyle>To keep connected with largest shop in the world.</TextStyle>
      </TextContainer>
      <LoginContainer>
        <SignupForm  />
      </LoginContainer>
    </BoxContainer>
  );
};

export default SignupPage;
