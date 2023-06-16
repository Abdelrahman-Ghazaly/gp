import React, { useCallback, useState } from 'react'
import { useForm } from "react-hook-form";
import { Box, Container, TextField, MenuItem, InputAdornment, Button } from '@mui/material';
import { UploadFormContainer, UploadFormTitle } from '../../../Styles/forms';
import UploadImage from '../../../Components/UI/Forms/UploadImage'
import { uploadProduct } from '../../../Store/Ecommerce/productReducer';
import { useNavigate, Link } from 'react-router-dom';
import { useDispatch } from 'react-redux';
// Import Icon From MUI
import SubtitlesIcon from '@mui/icons-material/Subtitles';
import DescriptionIcon from '@mui/icons-material/Description';
import CurrencyPoundIcon from '@mui/icons-material/CurrencyPound';


const AddProductForm = () => {
  const formData = new FormData();
  const [loading, setIsLoading] = useState(false)
  const [error , setError] = useState(null)
  const dispatch = useDispatch()
  const navigate = useNavigate()
  const pricePattern = `(\d+\.\d{1,2})`
  const defaultValues = { title: '', description: '', imgURL: null, category: '', price: '' }
  const { register, handleSubmit, formState: { errors }, setValue } = useForm({ defaultValues: defaultValues });

  const handleSubmitForm = async (data, e) => {
    e.preventDefault();

    if (data.imgURL != null) {
      formData.append("title", data.title);
      formData.append("description", data.description);
      formData.append("imgURL", data.imgURL[0][0]);
      formData.append("price", data.price)

      setIsLoading(true)
      await dispatch(uploadProduct(formData))
        .then((res) => {
          console.log(res)
          if (!res.payload?.message)
            {
              navigate("/");
            }else {
              setError(res.payload?.message)
            }
        })
        .catch((err) => {
          console.log(err);
        });
      setIsLoading(false)

    }
  }

  // Get Image From UploadImage Component
  const imageValue = useCallback((imgArray) => {
    setValue("imgURL", imgArray);
  }, [setValue])

  return (
    <Container>
      <Link to="/">
        <h2
          style={{
            textAlign: "center",
            fontSize: "50px",
            padding: "0px 0px",
            cursor: "pointer",
          }}
        >
          Furniture
        </h2>
      </Link>
      <Box
        style={{
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
        }}
      >
        <UploadFormContainer
          component="form"
          noValidate
          onSubmit={handleSubmit(handleSubmitForm)}
        >
          <Box
            sx={{
              width: "50%",
              textAlign: "center",
              margin: "auto",
              height: "auto",
              overflow: "auto",
            }}
          >
            <UploadFormTitle>Sell Product</UploadFormTitle>
          </Box>
          <TextField
            margin="normal"
            fullWidth
            label="Title"
            name="title"
            InputProps={{
              endAdornment: (
                <InputAdornment position="end">
                  <SubtitlesIcon />
                </InputAdornment>
              ),
            }}
            {...register("title", {
              required: "Please Enter the Product's Title",
            })}
            error={!!errors.title}
            helperText={errors.title?.message}
          />
          <TextField
            margin="normal"
            multiline
            fullWidth
            row={1}
            label="Description"
            name="description"
            InputProps={{
              endAdornment: (
                <InputAdornment position="end">
                  <DescriptionIcon />
                </InputAdornment>
              ),
            }}
            {...register("description", {
              required: "Please Enter Description",
            })}
            error={!!errors.description}
            helperText={errors.description?.message}
          />

          {/* Upload Product Component */}
          <UploadImage imageValue={imageValue} />
          <p style={{color : 'red' , textTransform : 'uppercase' , textAlign : 'center' , fontSize : '22px'}}>{error}</p>

          <TextField
            margin="normal"
            fullWidth
            label="Price"
            name="price"
            type="number"
            InputProps={{
              endAdornment: (
                <InputAdornment position="end">
                  <CurrencyPoundIcon />
                </InputAdornment>
              ),
              inputProps: { min: 0 , max : 11 },
            }}
            {...register("price", {
              required: "Please Enter the Product's Price",
              pattern: pricePattern,
            })}
            error={!!errors.price}
            helperText={errors.price?.message}
          />

          {loading ? (
            <UploadFormTitle
              style={{
                backgroundColor: "black",
                color: "white",
                marginTop: "15px",
              }}
            >
              Loading ....
            </UploadFormTitle>
          ) : (
            <Button
              hidden
              type="submit"
              fullWidth
              variant="contained"
              style={{
                backgroundColor: "black",
                borderRadius: "15px",
                letterSpacing: "10px",
                margin: "20px 0",
                fontWeight: "700",
              }}
            >
              Sell
            </Button>
          )}
        </UploadFormContainer>
      </Box>
    </Container>
  );
}

export default AddProductForm