import React from "react";
import { Box } from "@mui/material";
import { Typography } from "@mui/material";

import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
// Import Styled Functions
import { FlexContainerMobile , FlexContainerWeb } from "../../../Styles/footer";
// Import Icons
import AppleIcon from "@mui/icons-material/Apple";
import AndroidIcon from "@mui/icons-material/Android";



const FooterHeader = () => {
    const theme = useTheme();
const match = useMediaQuery(theme.breakpoints.down("sm"));

const Container = match ? FlexContainerMobile : FlexContainerWeb
  return (
    <Container>
      <Typography variant="h5" sx={{ fontSize: `${match ? '16px' : "26px"}`, fontWeight: "700" }}>
        Join Our Community For Exclusive Offers
      </Typography>
      <Box sx={{ display: "flex", justifyContent: "space-between"  , flexDirection : 'row' , paddingTop : `${match ? "10px" : "0"}` ,}}>
        <Typography
          sx={{ marginRight: `${match ? "10px" : "20px"}`, fontSize: `${match ? "20px" : "26px"}`, fontWeight: "700" }}
        >
          Download Our App
        </Typography>
        <Box>
          <AppleIcon sx={{ marginRight: `${match ? "5px" : "20px"}`, fontSize: `${match ? "30px" : "40px"}` }} />
          <AndroidIcon sx={{ fontSize: `${match ? "30px" : "40px"}` }} />
        </Box>
      </Box>
    </Container>
  );
};

export default FooterHeader;
