import React from 'react'
import { useTheme } from "@mui/material/styles";
import { Container, useMediaQuery } from "@mui/material";
import FooterDesktop from './footerDesktop';
import FooterMobile from './footerMobile';

const Footer = () => {
    const theme = useTheme();
    const match = useMediaQuery(theme.breakpoints.down("sm"));

  return (
        <div style={{background : '#222935' , color : '#fff' }}>
            <Container sx={{padding : `${match ? '20px' : '50px'}`}}>
                {match ? <FooterMobile />  : <FooterDesktop />}
            </Container>
        </div>
  )
}

export default Footer