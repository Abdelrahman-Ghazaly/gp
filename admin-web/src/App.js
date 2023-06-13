
import 'bootstrap/dist/css/bootstrap.min.css'
import './App.css';

import Login from './Login/Login';
import Auction from './Auction/Auction';
import jwtDecode from 'jwt-decode';
import { useEffect, useState } from 'react'
import { Routes, Route } from 'react-router-dom'
import { useNavigate } from 'react-router-dom';
import Reports from './Reports/Reports';






// let routers = createBrowserRouter([
//   {
//     path: '/', element: <Route />,
//     children: [
//       {
//         index: true, element: <Home />
//       }
//       , {
//         path: '/login', element: <Login />

//       },
//       {
//         path: '/sidebar', element: <Sidebar />

//       }
//       ,
//       {
//         path: '/productlist', element: <ProductList />

//       },
//       {
//         path: '/List', element: <AdminReportProduct />

//       },
//       {
//         path: '/Product', element: <Product />

//       }, {
//         path: '/reports', element: <Reports />

//       }

//     ]




//   }
// ])
function App() {
  let navigate = useNavigate();
  const [userdata, setuserData] = useState(null)


  function saveuserData() {
    let encodedtoken = localStorage.getItem('accessToken')
    let decodedtoken = jwtDecode(encodedtoken)
    setuserData(decodedtoken)
  }
  useEffect(() => {
    if (localStorage.getItem('accessToken')) {
      saveuserData();

    }
  }, [])
  useEffect(() => {
  if (localStorage.getItem('accessToken') == null) {  
    navigate('/login')

    }
  }, [])
   
  return (
      <>
       <div className="container">
    
      <Routes>

     
        <Route path='' element={ <Reports />  } />
        <Route path='login' element={<Login saveuserData={saveuserData} />} />
        <Route path='/reports' element={< Reports/>} />
        <Route path='/auction' element={< Auction/>} />


        </Routes>
        </div>
      </>

      )
}
      export default App;
      