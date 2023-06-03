import React , {useEffect , useState} from 'react'
import { Backdrop, Box , Button, Fade, Modal, Typography} from '@mui/material';
import { deleteProduct } from '../../../Store/Ecommerce/productReducer'
import LoadingSpinner from '../../../Components/UI/Common/LoadingSpinner'
import { useSelector , useDispatch} from 'react-redux'
import { fetchUploadedProduct } from '../../../Store/Ecommerce/productReducer'
import ProductImage from '../../../assets/productImage.png'

const style = {
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    width: '50%',
    bgcolor: 'background.paper',
    border: '2px solid #000',
    boxShadow: 24,
    padding : '40px  0',
    borderRadius : '20px'
  };

const UploadedProducts = ({tokenId , match}) => {
    const [open, setOpen] = React.useState(false);
    const handleOpen = () => setOpen(true);
    const handleClose = () => setOpen(false);

    const [deleteLoading, setDeleteIsLoading] = useState(false)
    const dispatch = useDispatch()

    const uploadedList = useSelector(state => state.product)
    let productList = uploadedList?.uploadedList
    let loading = uploadedList?.loading

    console.log(productList)

    const removeProduct = async (itemId) => {
        setDeleteIsLoading(true)
        await dispatch(deleteProduct(itemId))
        setDeleteIsLoading(false)
        handleClose()
    }

    useEffect(() => {
        dispatch(fetchUploadedProduct(tokenId))
    } , [dispatch , tokenId])

  return (
    <>
      {loading ? (
        <LoadingSpinner />
      ) : (
        <Box style={{ marginTop: "20px" }}>
          <h1>
            {productList?.length === 0 ? "No Products Uploaded" : "My Products"}
          </h1>
          <div style={{ marginTop: "45px" }}>
            {productList?.length === 0 ? (
              <div
                style={{
                  display: "flex",
                  justifyContent: "center",
                  alignItems: "center",
                }}
              >
                <img src={ProductImage} alt="img" />
              </div>
            ) : (
              <div>
                {productList?.map((item) => {
                  return (
                    <div
                      key={item._id}
                      style={{
                        display: "flex",
                        justifyContent: "space-around",
                        alignItems: "center",
                        marginBottom: "20px",
                      }}
                    >
                      <div style={{ width: "30%" }}>
                        <img
                          style={{
                            aspectRatio: "3/2",
                            objectFit: "contain",
                            width: `${match ? "100% " : "50%"}`,
                          }}
                          src={
                            typeof item.imgURL == "string"
                              ? item.imgURL
                              : item.imgURL[0]
                          }
                          alt={item.title}
                        />
                      </div>
                      <div
                        style={{
                          width: "100%",
                          fontSize: `${match ? "13px" : "20px"}`,
                        }}
                      >
                        <h2>{item.title}</h2>
                        <h3>Price: {item.price}$</h3>
                      </div>
                      <div>
                        <Button
                          variant="contained"
                          color="error"
                          onClick={handleOpen}
                        >
                          Delete
                        </Button>
                        <Modal
                          aria-labelledby="transition-modal-title"
                          aria-describedby="transition-modal-description"
                          open={open}
                          closeAfterTransition
                          slots={{ backdrop: Backdrop }}
                          slotProps={{
                            backdrop: {
                              timeout: 500,
                            },
                          }}
                        >
                          <Fade in={open}>
                            <Box sx={style}>
                              <Typography
                                id="transition-modal-title"
                                variant="h6"
                                component="h2"
                                style={{ textAlign: "center" }}
                              >
                                Are You Sure That You Want To Delete This Item !
                              </Typography>
                              <Box
                                style={{
                                  display: "flex",
                                  gap: "15px",
                                  justifyContent: "center",
                                  alignItems: "center",
                                  marginTop: "15px",
                                }}
                              >
                                {deleteLoading ? (
                                  <h3>Loading ...</h3>
                                ) : (
                                  <>
                                    <Button
                                      variant="contained"
                                      color="error"
                                      onClick={() => removeProduct(item._id)}
                                    >
                                      Remove
                                    </Button>
                                    <Button
                                      variant="contained"
                                      color="primary"
                                      onClick={() => handleClose()}
                                    >
                                      Cancel
                                    </Button>
                                  </>
                                )}
                              </Box>
                            </Box>
                          </Fade>
                        </Modal>
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </div>
        </Box>
      )}
    </>
  );
}

export default UploadedProducts