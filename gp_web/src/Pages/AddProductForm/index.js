import React, { useCallback } from 'react'
import { useForm } from "react-hook-form";
import {Box , Container , TextField , MenuItem , InputAdornment , Button} from '@mui/material';
import { UploadFormContainer , UploadFormTitle} from '../../Styles/forms';
import UploadImage from '../../Components/UI/Forms/UploadImage'
import { uploadProduct } from '../../Store/productReducer';
import { useNavigate , Link } from 'react-router-dom';
import { useDispatch } from 'react-redux';
// Import Icon From MUI
import SubtitlesIcon from '@mui/icons-material/Subtitles';
import DescriptionIcon from '@mui/icons-material/Description';
import CurrencyPoundIcon from '@mui/icons-material/CurrencyPound';

const CategoriesList = [
    {
        id : 0,
      categoryName : 'Bed',
    },
    {
        id : 1,
      categoryName : 'Chair',
    },
    {
        id : 2,
      categoryName : 'Dresser',
    },
    {
        id : 3,
      categoryName : 'Table',
    },
    {
        id : 4,
      categoryName : 'Sofa',
    },
    {
        id : 5,
      categoryName : 'Lamp',
    },
  ]
const AddProductForm = () => {
    const formData = new FormData();
    const dispatch = useDispatch()
    const navigate = useNavigate()
    const pricePattern = `(\d+\.\d{1,2})`
    const defaultValues = {title : '' , description : '' , imgURL : null , category : '' , price : ''}
    const {register, handleSubmit, formState: { errors } , setValue} = useForm({ defaultValues: defaultValues });

    const handleSubmitForm = async (data, e) => {
        e.preventDefault();

        if(data.imgURL.length != 0){
          console.log(data);
          // const formData = new FormData();
              formData.append("title", data.title);
              formData.append("description", data.description);
              for(var i = 0 ; i < data.imgURL.length ; i ++){
                formData.append("imgURL", data.imgURL[i]);
              }
              formData.append("category" , data.category)
              formData.append("price" , data.price)
          console.log(formData.get("imgURL"))
           dispatch(uploadProduct(formData))
          navigate("/")
        }
    }
 
      // Get Image Array
    const imageValue = useCallback((imgArray) => {
          setValue("imgURL", imgArray);
    } , [setValue])

    return (
      <Container>
        <Link to="/">
          <h2
            style={{
              textAlign: "center",
              fontSize: "50px",
              padding: "0px 0px",
              cursor : 'pointer'
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
            <TextField
              fullWidth
              margin="normal"
              select
              defaultValue={defaultValues.category}
              label="Select Category"
              name="category"
              {...register("category", {
                required: "Please Enter The Category",
              })}
              error={!!errors.category}
              helperText={errors.category?.message}
            >
              {CategoriesList.map((option) => (
                <MenuItem key={option.id} value={option.categoryName}>
                  {option.categoryName}
                </MenuItem>
              ))}
            </TextField>

            <h3 style={{textAlign : "center" , color : 'red'}}>*Only 4 Images Are Allowed*</h3>

            {/* Upload Product Component */}
            <UploadImage imageValue={imageValue} />

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
                inputProps: { min: 0 }
              }}
              {...register("price", {
                required: "Please Enter the Product's Price",
                pattern: pricePattern,
              })}
              error={!!errors.price}
              helperText={errors.price?.message}
            />

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
          </UploadFormContainer>
        </Box>
      </Container>
    );
}

export default AddProductForm