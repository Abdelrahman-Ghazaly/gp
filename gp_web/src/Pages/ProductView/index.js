import React , {useState} from 'react'
import { Box, Container  , Grid , Button , TextField , MenuItem, Fade, Alert, AlertTitle} from '@mui/material'
import FavoriteIcon from "@mui/icons-material/Favorite";
import { useParams } from 'react-router-dom'
import { useForm } from "react-hook-form";
import { useTheme } from "@mui/material/styles";
import { useMediaQuery } from "@mui/material";
import useFetch from '../../CustomHooks/api/useFetch'
import AppBar from '../../Components/Layout/AppBar'
import Footer from '../../Components/Layout/Footer';
import LoadingSpinner from '../../Components/UI/Common/LoadingSpinner';
import { useDispatch  , useSelector} from 'react-redux';
import { addToFavorites } from '../../Store/favoriteReducer';
import { sendReport } from '../../Store/reportReducer';

// Swiper Imports
import { Swiper, SwiperSlide } from "swiper/react";

// Import Swiper styles
import "swiper/css";
import "swiper/css/free-mode";
import "swiper/css/navigation";
import "swiper/css/thumbs";

// import required modules
import { FreeMode, Navigation, Thumbs } from "swiper";

const ReportList = [
  {
    id : 1,
    reportName : 'wrong Category'
  },{
    id : 2,
    reportName : 'offensive title or description'
  }
]

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

  const [thumbsSwiper, setThumbsSwiper] = useState(null);
  const defaultValues = {report_type: '' , description : ''}
  const {register, handleSubmit, formState: { errors }} = useForm({ defaultValues: defaultValues });

  const reportFormHandler = (reportValues , e) => {
    e.preventDefault();
    dispatch(sendReport({reportValues , id}))
  }
 

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

  const renderImages = () => {
    if (typeof data.imgURL !== "string") {
      return (
        <>
          <Swiper
            loop={true}
            spaceBetween={10}
            thumbs={{ swiper: thumbsSwiper }}
            modules={[FreeMode, Navigation, Thumbs]}
          >
            {data.imgURL.map((img, idx) => {
              return (
                <SwiperSlide key={idx}>
                  <img style={{ aspectRatio : '3/3' , width : '100%' , objectFit : 'contain' , borderRadius : '15px'}} src={img} alt="product_image" />
                </SwiperSlide>
              );
            })}
          </Swiper>
          <Swiper
            onSwiper={setThumbsSwiper}
            loop={true}
            spaceBetween={10}
            slidesPerView={4}
            freeMode={true}
            watchSlidesProgress={true}
            modules={[FreeMode, Navigation, Thumbs]}
          >
            {data.imgURL.map((img, idx) => {
              return (
                <SwiperSlide key={idx}>
                  <img style={{ width: "100%" , aspectRatio : '3/3' , objectFit : 'contain'  , borderRadius : '15px'}} src={img} alt="product_image" />
                </SwiperSlide>
              );
            })}
          </Swiper>
        </>
      );
    } else {
      return <img style={{ width: "100%" , aspectRatio : '3/3' , objectFit : 'contain' , borderRadius : '15px'}} src={data.imgURL} alt="product_image" />;
    }
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
                    {renderImages()}
                  </div>
                </Grid>
                <Grid item xs={0} sm={6} md={6} style={{marginBottom : '15px'}}>
                  <h1 style={{marginBottom : '15px'}}>{data.title}</h1>
                  <h3 style={{marginBottom : '15px'}}>
                    Category :{" "}
                    <span style={{ fontWeight: "500" }}>{data.category}</span>
                  </h3>
                  <h3 style={{marginBottom : '15px'}}>
                    Price :{" "}
                    <span style={{ fontWeight: "500", color: "red" }}>
                      {data.price}
                    </span>
                  </h3>
                  <h3 style={{marginBottom : '15px'}}>Seller Name : Rashad</h3>
                  <h3 style={{marginBottom : '15px'}}>Description :</h3>
                  <p style={{marginBottom : '15px'}}>{data.description}</p>
                  <Button
                    onClick={userData ? () => AddProduct(data._id) : () => setIsShow(true)}
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
              {userData && (
                              <Box
                              style={{
                                border: "2px solid red",
                                padding: "8px 18px",
                                margin: "15px 0",
                                borderRadius: "15px",
                                textAlign: "center",
                              }}
                              component="form"
                              noValidate
                              onSubmit={handleSubmit(reportFormHandler)}
                            >
                              <h2
                                style={{
                                  color: "red",
                                  textAlign: "center",
                                  marginBottom: "15px",
                                }}
                              >
                                Report{" "}
                              </h2>
                              <TextField
                                fullWidth
                                defaultValue={defaultValues.report_type}
                                margin="normal"
                                select
                                label="Select Report Type"
                                name="report_type"
                                {...register("report_type", {
                                  required: "Please Enter The Report Type",
                                })}
                                error={!!errors.report_type}
                                helperText={errors.report_type?.message}
                                style={{ display: "inline-block" }}
                              >
                                {ReportList.map((option) => (
                                  <MenuItem key={option.id} value={option.reportName}>
                                    {option.reportName}
                                  </MenuItem>
                                ))}
                              </TextField>
                              <TextField
                                margin="normal"
                                multiline
                                fullWidth
                                row={1}
                                label="Description"
                                name="description"
                                {...register("description", {
                                  required: "Please Enter Description",
                                })}
                                error={!!errors.description}
                                helperText={errors.description?.message}
                              />
                              <Button
                                type="submit"
                                style={{ background: "red" }}
                                variant="contained"
                              >
                                {" "}
                                Send Report
                              </Button>
                            </Box>
              )}
            </Container>
          </Box>
        )}
      </div>
      <Footer />
    </>
  );
}

export default ProductView