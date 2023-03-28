import { Box , Typography } from "@mui/material";
import { styled } from '@mui/material/styles';
import LoginImage from '../../assets/LoginBackgroundImage/LoginBackground.jpg'

export const BoxContainer = styled(Box)(({theme}) => ({
    display : 'flex',
    flexDirection : 'row',
    width : '100%',
    height : '100vh',
    margin : 'auto',
    overflow : 'auto',
    "&:scrollbar" : {
        display : 'none'
    },
    [theme.breakpoints.down('md')]: {
        flexDirection : 'row',
        width: 'auto',
    },
    [theme.breakpoints.down('sm')]: {
        flexDirection : 'column',
        width: 'auto',
    },

  }));

export const TextContainer = styled(Box)(({theme}) => ({
    height : 'auto',
    flexBasis : '60%',
    backgroundImage : `url(${LoginImage})`,
    backgroundRepeat : 'no-repeat',
    backgroundSize : 'cover',

    objectFit  : 'contain',
    [theme.breakpoints.down('md')]: {
        backgroundSize : '100vw 100vh',
        objectFit  : 'contain',
        height : '100%',
        flexBasis : '50%',
    },
    [theme.breakpoints.down('sm')]: {
        backgroundSize : '100% 100%',
        flexBasis : '30%',
        objectFit  : 'contain',
    },
}))



export const TextStyle = styled(Typography)(({theme}) => ({

    textAlign : 'center',
    userSelect : 'none',
    padding : '26px 19px',
    color : 'white',
    fontSize : '3.1rem',
    fontWeight : '200',
    lineHeight : '1.4',
    fontFamily : `'Climate Crisis' ,  'Cairo', cursive`,
    [theme.breakpoints.down('md')]: {
        fontSize : '2.25rem',
        fontWeight : '200',
        lineHeight : '1.9',
        width : '100%',
        marginRight : '10px'
    },
    [theme.breakpoints.down('sm')]: {
        fontSize : '1.25rem',
        fontWeight : '200',
        width : '100%',
        marginRight : '20px auto',
    },
}))

export const LoginContainer = styled(Box)(({theme}) => ({
    width : '40%',
    padding : '20px 20px 0 20px',

    overflow : 'auto',
    [theme.breakpoints.down('md')]: {
        width : '50%',
        margin : 'auto'
    },
    [theme.breakpoints.down('sm')]: {
        width : '100%',
        margin : 'auto',
        overflow : 'unset',
        flexBasis : '70%',
    },
}))

export const LoginBox = styled(Box)(({theme}) => ({

    padding : '0 20px 0 20px',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent : 'center',
    width : '100%',
    margin : 'auto',
    [theme.breakpoints.down('sm')]: {
        padding : '10px 0 10px 0',
        width : '100%',
        margin : 'auto',
    },
}))


