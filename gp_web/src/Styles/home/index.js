import { Box , Paper} from "@mui/material";
import { styled } from '@mui/material/styles';


export const CategoriesList = styled(Box)(() => ({
    display: 'flex',
    background: 'inherit',
    width: '100%',
    alignItems: 'center',
    justifyContent: 'center',
    padding : '10px',
    marginBottom : '10px',

    "@keyframes cateList" : {
        "0%": {  transform : "translateY(-100px)", opacity : '0' },
        "50%": {  transform : "translateY(50px)", opacity : '0.5' },
        "100%": {  transform : "translateY(0px)", opacity : '1' }
    },
    animation : `cateList 1s  ease-in-out`,
}));

export const CategoriesListItem = styled(Box)(() => ({
    padding : '8px 17px',
    marginRight : '5px',
    cursor: 'pointer',
    fontSize : '23px',
    display : 'flex',
    '&:hover': {
        backgroundColor: ' #54E5A2',
        border: '1px solid #002f34',
        borderRadius : '50px',
    },
}));


export const Item = styled(Paper)(({ theme }) => ({
  padding: theme.spacing(2),
  textAlign: "center",
  color: "black",
  borderRadius: "50px",
  boxShadow:
    "rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;",
}));

  export const Thumbnail = styled(Box)(() => ({
    overflow : 'hidden',
    isolation : 'isolation',
    '&:hover img' : {
        transform : "scale(1.1)"
    }
  }));