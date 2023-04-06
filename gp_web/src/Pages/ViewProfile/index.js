import React , {useEffect , useState , useCallback} from 'react'
import ProductImage from '../../assets/productImage.png'
import { useSelector , useDispatch} from 'react-redux'
// import { fetchUploadedProduct } from '../../Store/productReducer'
import AppBar from '../../Components/Layout/AppBar';
import Footer from '../../Components/Layout/Footer'
import { Container , Box , Divider , Button} from '@mui/material';
import { deleteProduct } from '../../Store/productReducer'
import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
import useFetch from '../../CustomHooks/api/useFetch';
import { BoxUserInfoContainer , Span} from '../../Styles/viewprofile';


const ViewProfile = () => {
    const [data, setData] = useState([])
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState(null)

    const theme = useTheme();
    const match = useMediaQuery(theme.breakpoints.down("sm"));
    const dispatch = useDispatch()
    //const {uploadedList} = useSelector(state => state.product)
    const userData = useSelector(state => state.auth)
    let userId = userData.userData?._id
    let tokenId = userData.userData?.accessToken

    const products = data?.product_logs
    console.log(products)


    const fetchData = useCallback(async (url , tokenId) => {
        try{
            const response = await fetch(url , {
                method : 'GET',
                headers: {
                    token : "Bearer " + tokenId,
                    'Content-Type' : 'application/json'
                  },
            })
            const urlData = await response.json()
            setData(urlData["user-data"])
            setLoading(false)
        }catch(error){
            setLoading(false)
            setError(error)
        }
    } , [])

    useEffect(() => {
        fetchData(`http://localhost:5000/user/view/profile/${userId}` , tokenId)
    },[fetchData , userId , tokenId])


    const removeProduct = (itemId) => {
        dispatch(deleteProduct(itemId))
    }

    console.log(data)

  return (
    <>
        <AppBar />
        <Container>
                <h1>My Account</h1>
                <h3>Account Information</h3>
            <Box style={{margin : '30px' , display : 'flex' , justifyContent : 'center' , alignItems : 'center' , gap : '30px' , flexDirection : `${match ? 'column' : 'row'}`}}>
                <BoxUserInfoContainer>
                                <h3>Name : <Span>{data?.name}</Span></h3>
                                <h3>Email : <Span>{data?.email}</Span></h3>
                </BoxUserInfoContainer>
                <BoxUserInfoContainer>
                            <h3>Address : <Span>{data?.address}</Span></h3>
                            <h3>Phone Number : <Span>{data?.phone}</Span></h3>
                </BoxUserInfoContainer>
            </Box>
            <Divider />
            <Box style={{marginTop : '20px'}}>
                <h1>{products?.length === 0 ? 'No Products Uploaded' : 'My Products'}</h1>
                <div style={{marginTop : '45px'}}>
                    {products?.length === 0 ? (
                        <div style={{display : 'flex' , justifyContent : 'center' , alignItems : 'center'}}>
                            <img src={ProductImage} alt="img"/>
                        </div>
                    ) : 
                    <div>
                        {products?.map((item) => {
                            return (
                                <div key={item._id} style={{display : 'flex' , justifyContent: 'space-around' , alignItems : 'center' , marginBottom : '20px'}}>
                                    <div style={{width : '30%'}}>
                                            <img style={{aspectRatio : '3/2' , objectFit : 'contain' ,  width: `${match ? "100% " : "50%"}`}} src={typeof item.imgURL == "string" ?  item.imgURL : item.imgURL[0]} alt={item.title}/>
                                    </div>
                                        <div style={{width : '100%' , fontSize : `${match ? "13px" : "20px"}`}}>
                                                <h2>{item.title}</h2>
                                                <h3>Price:  {item.price}$</h3>
                                        </div>
                                    <div>
                                        <Button variant='contained' color="error" onClick={() => removeProduct(item._id)}>Remove</Button>
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


