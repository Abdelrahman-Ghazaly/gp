import { Box , Paper} from "@mui/material";
import { styled } from '@mui/material/styles';

export const FlexContainerWeb = styled(Box)(() => ({
    display: "flex",
    justifyContent: "space-between",
  }));

export const FlexContainerMobile = styled(Box)(() => ({
    display: "flex",
    flexDirection : 'column'
  }));