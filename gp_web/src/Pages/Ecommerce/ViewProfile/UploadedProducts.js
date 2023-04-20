import React , {useEffect} from 'react'
import { Box , Button} from '@mui/material';
import { deleteProduct } from '../../../Store/Ecommerce/productReducer'
import LoadingSpinner from '../../../Components/UI/Common/LoadingSpinner'
import { useSelector , useDispatch} from 'react-redux'
import { fetchUploadedProduct } from '../../../Store/Ecommerce/productReducer'
import ProductImage from '../../../assets/productImage.png'


const UploadedProducts = ({tokenId , match}) => {
    const dispatch = useDispatch()

    const uploadedList = useSelector(state => state.product)
    let productList = uploadedList?.uploadedList
    let loading = uploadedList?.loading

    console.log(productList)

    const removeProduct = (itemId) => {
        dispatch(deleteProduct(itemId))
    }

    useEffect(() => {
        dispatch(fetchUploadedProduct(tokenId))
    } , [dispatch , tokenId])

  return (
    <>
            {loading ? <LoadingSpinner /> : (
                            <Box style={{marginTop : '20px'}}>
                            <h1>{productList?.length === 0 ? 'No Products Uploaded' : 'My Products'}</h1>
                            <div style={{marginTop : '45px'}}>
                                {productList?.length === 0 ? (
                                    <div style={{display : 'flex' , justifyContent : 'center' , alignItems : 'center'}}>
                                        <img src={ProductImage} alt="img"/>
                                    </div>
                                ) :
                                <div>
                                    {productList?.map((item) => {
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
            )}
    </>
  )
}

export default UploadedProducts