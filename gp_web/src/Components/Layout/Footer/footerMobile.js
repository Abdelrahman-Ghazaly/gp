import React from 'react'
import FooterHeader from './FooterHeader'
import ContentBox from './ContentBox'
import { Divider } from '@mui/material'
const FooterMobile = () => {
  return (
    <div>
        <FooterHeader />
        <Divider sx={{ bgcolor: "white", margin: "20px 0 20px 0" }} />
        <ContentBox sx={{marginTop : '100px'}} />
        <Divider sx={{ bgcolor: "white", margin: "20px 0 20px 0" }} />
      <h5 style={{textAlign : 'center' , paddingBottom : '50px'}}>Copyright © 2023 Furniture, Inc. All rights reserved.</h5>
    </div>
  )
}

export default FooterMobile