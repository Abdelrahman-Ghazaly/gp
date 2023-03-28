import React from 'react'
import { Box } from "@mui/material";
import { styled } from "@mui/material/styles";

const FlexContainer = styled(Box)(() => ({
    display : 'flex',
    justifyContent : 'space-between'
}))

const ContentBox = () => {
  return (
    <FlexContainer>
        <Box>
        A used furniture ecommerce website is an online platform that specializes in selling pre-owned furniture and home decor items to consumers through the internet. 
        These websites typically offer a range of used furniture options.
        </Box>
    </FlexContainer>
  )
}

export default ContentBox