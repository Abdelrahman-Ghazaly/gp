import React from 'react'
import { useState } from 'react'
import joi from 'joi';
import Axios from 'axios';
import Typewriter from 'typewriter-effect';
import { useNavigate } from "react-router-dom";
import './Login.css'


export default function Login(props) {

  const [errorList, setErrorList] = useState([])
  const [isLoading, setIsLoading] = useState(false)
  let navigate = useNavigate();
  const [error, setError] = useState('')
  const [user, setUser] = useState({

    email: '',
    password: ''
  })



  function getuserdata(e) {
    var myUser = { ...user };
    myUser[e.target.name] = e.target.value;
    setUser(myUser);
  }
  async function submitlogin(e) {
    e.preventDefault();
    setIsLoading(true)

    let validationResult = validatelogin();
    if (validationResult.error) {

      setErrorList(validationResult.error.details)
      setIsLoading(false)

    }
    else {
      let { data } = await Axios.post('http://localhost:5000/admin/login', user)
        if (data.accessToken) {
        setIsLoading(false)
        localStorage.setItem('accessToken', data.accessToken)
        props.saveuserData()
        navigate("/");
      }
      else {
        setError(data.message)
        setIsLoading(false)

      }
    }


  }
  function validatelogin() {
    let scheme = joi.object(
      {

        email: joi.string().email({ minDomainSegments: 2, tlds: { allow: ['com', 'net'] } }),
        password: joi.string().required(),
      })
    return scheme.validate(user, { abortEarly: false });
  }



  return (
    <>
      <div className='w-75  mx-auto'>
        <h1>
          <Typewriter
            options={{
              autoStart: true,
              loop: true,
              delay: 50,
              strings: [' welcome my developer']
            }}
          />
        </h1>
        <h2> Login now</h2>

        {errorList.map((error) => <div className='alert py-2 alert-info'>{error.message}</div>)}

        {error ? <div className='alert alert-danger'>{error}</div> : ''}

        <form onSubmit={submitlogin}>



          <label htmlFor="email">email :</label>
          <input onChange={getuserdata} type="email" className='form-control mb-2  bg-transparent text-dark' id='email' name='email' />




          <label htmlFor="password">password :</label>
          <input onChange={getuserdata} type="password" className='form-control mb-2  bg-transparent text-dark' id='password' name='password' />

          <button className='btn btn-transparent btn-info border-1  text-white' type='submit'>
            {isLoading === true ? <i className='fa fa-spinner fa-spin'></i> : 'LOgin'}
          </button>
        </form>

      </div>
    </>
  )
}

