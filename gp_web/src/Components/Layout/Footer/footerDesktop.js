import React from "react";
import {  Box, Divider } from "@mui/material";
import FooterHeader from "./FooterHeader";
import ContentBox from "./ContentBox";

const FooterDesktop = () => {
  return (
    <div>
      <FooterHeader />
      <Divider sx={{ bgcolor: "white", margin: "20px 0 20px 0" }} />
      <ContentBox />
      <Divider sx={{ bgcolor: "white", margin: "20px 0 20px 0" }} />
      <h5 style={{textAlign : 'center'}}>Copyright © 2023 Furniture, Inc. All rights reserved.</h5>
    </div>
  );
};

export default FooterDesktop;
