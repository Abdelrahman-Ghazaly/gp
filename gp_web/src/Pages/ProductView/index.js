import React from 'react'
import { Box, Container } from '@mui/material'
import { useParams } from 'react-router-dom'
import useFetch from '../../CustomHooks/api/useFetch'
import AppBar from '../../Components/Layout/AppBar'

const ProductView = () => {
  let {id} = useParams()
  const {data , loading} = useFetch(`http://localhost:8000/Products/${id}`)

  const renderImages = () => {
    if(typeof data.image !== "string"){
      console.log(data.image);
      return(
        data.image.map((img , idx) => {
          return (
            <img src={img} alt="wefwe" key={idx}/>
          )
        })
        )
    }else{
      console.log(data.image);
      return(
        <img src={data.image} alt="qwdqwd"/>
      )
    }
  }

  return (
    <div>
      {loading ? (
        <h2>Loading ...</h2>
      ) : (
        <Box>
                <AppBar />
                <Container>
                {renderImages()}
                <h4>{data.title}</h4>
                <h5>{data.price}</h5>
                </Container>
        </Box>
      )}
    </div>
  );
}

export default ProductView