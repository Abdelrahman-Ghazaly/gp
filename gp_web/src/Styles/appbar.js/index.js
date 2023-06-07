import {List , ButtonBase , Box } from '@mui/material'
import { styled } from '@mui/material/styles';


export const AppContainer = styled(Box)(() => ({
    display : 'flex',
    marginTop : 4,
    justifyContent : 'center',
    alignItems : 'center',
    padding : '2px 8px'
}))

export const MyList = styled(List)(({type}) => ({
    display : type === 'row' ? 'flex' : 'block',
    flexGrow : 3,
    justifyContent : 'center',
    alignItems : 'center',
    backgroundColor : '#F7F8F8'
}))

export const SellButton = styled(ButtonBase)(() => ({
    borderRadius: "50px",
    width: "130px",
    border: "3px solid #D16BA5",
    backgroundColor : '#54E5A2',
    color : 'black',
    padding : '9px 8px',
    fontSize : '18px',
    marginRight : '15px'
}))


export const ActionIconsContainerMobile = styled(Box)(() => ({
  display: 'flex',
  background: 'inherit',
  position: "fixed",
  bottom: 0,
  left: 0,
  width: '100%',
  alignItems: 'center',
  zIndex: 9999,
  borderTop: `1px solid black`
}));

export const ActionIconsContainerDesktop = styled(Box)(() => ({
  flexGrow: 0,
}));

