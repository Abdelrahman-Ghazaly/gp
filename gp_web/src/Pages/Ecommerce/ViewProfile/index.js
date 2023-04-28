import React , {useEffect , useState , useCallback} from 'react'
import { useSelector } from 'react-redux'
import AppBar from '../../../Components/Layout/AppBar';
import Footer from '../../../Components/Layout/Footer'
import { Container , Box , Divider } from '@mui/material';
import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
import { BoxUserInfoContainer , Span} from '../../../Styles/viewprofile';
import UploadedProducts from './UploadedProducts';

const ViewProfile = () => {
    const [data, setData] = useState([])
    const [error, setError] = useState(null)

    const theme = useTheme();
    const match = useMediaQuery(theme.breakpoints.down("sm"));


    const userData = useSelector(state => state.auth)
    let userId = userData.userData?._id
    let tokenId = userData.userData?.accessToken

    const fetchUserData = useCallback(async (url , tokenId) => {
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
        }catch(error){
            setError(error)
        }
    } , [])

    useEffect(() => {
        fetchUserData(`http://localhost:5000/user/view/profile/${userId}` , tokenId)
    },[fetchUserData , userId , tokenId])

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

            {/* Get The Products that User has been uploaded to the E-commerce */}
            <UploadedProducts tokenId={tokenId} match={match}/>

        </Container>
        <Footer />
    </>
  )
}

export default ViewProfile


