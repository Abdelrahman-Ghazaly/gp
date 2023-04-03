import React , {useEffect} from 'react'
import ProductImage from '../../assets/productImage.png'
import { useSelector , useDispatch} from 'react-redux'
import { fetchUploadedProduct } from '../../Store/productReducer'
import AppBar from '../../Components/Layout/AppBar';
import Footer from '../../Components/Layout/Footer'
import { Container , Box , Divider , Button} from '@mui/material';
import { deleteProduct } from '../../Store/productReducer'
import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
import { BoxUserInfoContainer , Span} from '../../Styles/viewprofile';


const ViewProfile = () => {
    const theme = useTheme();
    const match = useMediaQuery(theme.breakpoints.down("sm"));
    const dispatch = useDispatch()
    const {uploadedList , loading} = useSelector(state => state.product)
    console.log(uploadedList);
    useEffect(() => {
        dispatch(fetchUploadedProduct())
    } , [dispatch])

    const removeProduct = (itemId) => {
        dispatch(deleteProduct(itemId))
    }
  return (
    <>
        <AppBar />
        <Container>
                <h1>My Account</h1>
                <h3>Account Information</h3>
            <Box style={{margin : '30px' , display : 'flex' , justifyContent : 'center' , alignItems : 'center' , gap : '30px' , flexDirection : `${match ? 'column' : 'row'}`}}>
                <BoxUserInfoContainer>
                    <h3>Name : <Span>Ahmed Rashad</Span></h3>
                    <h3>Email : <Span>ahmed@gmail.com</Span></h3>
                </BoxUserInfoContainer>
                <BoxUserInfoContainer>
                    <h3>Address : <Span>45 sf ST, ewfdwefw</Span></h3>
                    <h3>Phone Number : <Span>01060068417</Span></h3>
                </BoxUserInfoContainer>
            </Box>
            <Divider />
            <Box style={{marginTop : '20px'}}>
                <h1>{uploadedList.length === 0 ? 'No Products Uploaded' : 'My Products'}</h1>
                <div style={{marginTop : '45px'}}>
                    {uploadedList.length === 0 ? (
                        <div style={{display : 'flex' , justifyContent : 'center' , alignItems : 'center'}}>
                            <img src={ProductImage} alt="img"/>
                        </div>
                    ) : 
                    <div>
                        {uploadedList.map((item) => {
                            return (
                                <div key={item.id} style={{display : 'flex' , justifyContent: 'space-around' , alignItems : 'center' , marginBottom : '20px'}}>
                                    <div style={{width : '30%'}}>
                                            <img style={{aspectRatio : '3/2' , objectFit : 'contain' ,  width: `${match ? "100% " : "50%"}`}} src={typeof item.image == "string" ?  item.image : item.image[0]} alt={item.title}/>
                                    </div>
                                        <div style={{width : '100%' , fontSize : `${match ? "13px" : "20px"}`}}>
                                                <h2>{item.title}</h2>
                                                <h3>Price:  {item.price}$</h3>
                                        </div>
                                    <div>
                                        <Button variant='contained' color="error" onClick={() => removeProduct(item.id)}>Remove</Button>
                                    </div>
                                </div>
                            )
                        })}
                    </div>
                }
                </div>
            </Box>
        </Container>
        <Footer />
    </>
  )
}

export default ViewProfile


