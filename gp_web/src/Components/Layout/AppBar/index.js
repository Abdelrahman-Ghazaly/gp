import React from 'react'
import { useTheme } from '@mui/material/styles'
import { useMediaQuery } from '@mui/material'
import AppBarDesktop from './appBarDesktop'
import AppBarMobile from './appBarMobile'

const AppBar = ({Categories}) => {
    const theme = useTheme()
    const match = useMediaQuery(theme.breakpoints.down('sm'))
  return (
    <div>
        {match ? <AppBarMobile match={match} Categories={Categories}/> : <AppBarDesktop  match={match}/>}
    </div>
  )
}

export default AppBar