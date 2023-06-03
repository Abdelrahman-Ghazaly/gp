import { Box, Typography } from "@mui/material";
import { styled } from '@mui/material/styles';

export const BoxUserInfoContainer = styled(Box)(() => ({
  border: "2px solid black",
  borderRadius: "15px",
  backgroundColor: "#ffffff",
  padding: "30px 50px",
}));

export const Span = styled(Typography)(() => ({
  fontStyle: "italic",
  fontWeight: "300",
  display : 'inline-block'
}));

export const ModalStyle = styled(Box)(({theme}) => ({
  position: 'absolute',
  top: '50%',
  left: '50%',
  transform: 'translate(-50%, -50%)',
  width: '50%',
  backgroundColor: 'white',
  border: '2px solid #000',
  boxShadow: 24,
  padding : '40px  0',
  borderRadius : '20px',
  [theme.breakpoints.down('md')]: {
    width : '100%',
  }
}));