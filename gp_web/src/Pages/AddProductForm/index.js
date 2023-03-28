import React, { useState , memo  ,useCallback, useEffect, useMemo} from 'react'
import { useForm } from "react-hook-form";
import {Box , Container , TextField , MenuItem , InputAdornment , Button} from '@mui/material';
import { UploadFormContainer , UploadFormTitle} from '../../Styles/forms';
import UploadImage from '../../Components/UI/Forms/UploadImage'
import useSendRequest from '../../CustomHooks/api/useSendRequest'
import { useNavigate , Link } from 'react-router-dom';
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

    const Url = "http://localhost:8000/Products"
    const { sendRequest } = useSendRequest()
    const navigate = useNavigate()
    const pricePattern = `(\d+\.\d{1,2})`
    const defaultValues = {title : '' , description : '' , image : [] , category : '' , price : ''}
    const {register, handleSubmit, formState: { errors } , setValue} = useForm({ defaultValues: defaultValues });

    const handleSubmitForm = async (data, e) => {
        e.preventDefault();

        if(data.image.length != 0){
          console.log(data);
          await sendRequest(data , Url , "POST")
          navigate("/")
        }
      }
 
      // Get Image Array
    const imageValue = useCallback((imgArray) => {
          setValue("image", imgArray);
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