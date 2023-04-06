import React , {useState} from 'react'
import { Box, Container  , Grid , Button , Fade, Alert, AlertTitle} from '@mui/material'
import FavoriteIcon from "@mui/icons-material/Favorite";
import { useParams } from 'react-router-dom'
import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
import useFetch from '../../CustomHooks/api/useFetch'
import AppBar from '../../Components/Layout/AppBar'
import Footer from '../../Components/Layout/Footer';
import LoadingSpinner from '../../Components/UI/Common/LoadingSpinner';
import { useDispatch  , useSelector} from 'react-redux';
import { addToFavorites } from '../../Store/favoriteReducer';
import ReportForm from './ReportForm';
import RenderImages from './RenderImages';

const ProductView = () => {
  let {id} = useParams()
  const {data , loading} = useFetch(`http://localhost:5000/product/view/item/${id}`)


  const dispatch = useDispatch();
  const {userData} = useSelector(state => state.auth)

  const AddProduct = (itemId) => {
    dispatch(
      addToFavorites(itemId)
    );
 }
  const theme = useTheme();
  const match = useMediaQuery(theme.breakpoints.down("md"));
  const [show , setIsShow] = useState(false)

  const rednerToast = () => {
    return (
      <Fade
        in={show}
        timeout={{ enter: 1000, exit: 1000 }}
        addEndListener={() => {
          setTimeout(() => {
            setIsShow(false);
          }, 4000);
        }}
        style={{marginTop : '15px' , width : `${match ? "100% " : "60%"}` , borderRadius : "15px" }}
      >
        <Alert severity="warning" variant="standard" className="alert">
          <AlertTitle>Warning</AlertTitle>
          Please login first to add item to favorite
        </Alert>
      </Fade>
    );
  }



  return (
    <>
      <AppBar />
      <div>
        {loading ? (
          <LoadingSpinner />
        ) : (
          <Box>
            <Container>
              <Grid
                container
                spacing={{ xs: 2, md: 1 }}
                columns={{ xs: 12, sm: 12, md: 12 }}
              >
                <Grid item xs={12} sm={6} md={6}>
                  <div style={{ width: `${match ? "100% " : "60%"}` }}>
                    <RenderImages data={data}/>
                  </div>
                </Grid>
                <Grid item xs={0} sm={6} md={6} style={{ marginBottom: "15px" }} >
                  <h1 style={{ marginBottom: "15px" , textTransform : 'capitalize'}}>{data.title}</h1>
                  <h3 style={{ marginBottom: "15px" }}>
                    Category :{" "}
                    <span style={{ fontWeight: "500" , textTransform : 'capitalize'}}>{data.category}</span>
                  </h3>
                  <h3 style={{ marginBottom: "15px" }}>
                    Price :{" "}
                    <span style={{ fontWeight: "500", color: "red" }}>
                      {data.price}$
                    </span>
                  </h3>
                  <h3 style={{ marginBottom: "15px" , textTransform : 'capitalize'}}>Seller Name : {data.user_id?.name}</h3>
                  <h3 style={{ marginBottom: "15px" }}>Description :</h3>
                  <p style={{ marginBottom: "15px" }}>{data.description}</p>
                  <Button
                    onClick={
                      userData
                        ? () => AddProduct(data._id)
                        : () => setIsShow(true)
                    }
                    sx={{
                      backgroundColor: "black",
                      "&:hover": { background: "#009933" },
                    }}
                    variant="contained"
                    endIcon={
                      <FavoriteIcon sx={{ "&:hover": { color: "red" } }} />
                    }
                  >
                    Add To Favorite
                  </Button>
                  {show && rednerToast()}
                </Grid>
              </Grid>

              <ReportForm userData={userData} id={id} />

            </Container>
          </Box>
        )}
      </div>
      <Footer />
    </>
  );
}

export default ProductView