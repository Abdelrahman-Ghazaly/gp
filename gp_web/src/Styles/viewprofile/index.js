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