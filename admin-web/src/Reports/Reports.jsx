import React, { useState, useEffect } from 'react';
import './Reports.css'
import axios from "axios";
import Sidebar from '../Sidebar/Sidebar';

function Report(props) {
    const [reportData, setReportData] = useState(null);
    const authToken = localStorage.getItem('accessToken')
    async function fetchData() {
        try {
            const response = await fetch('http://localhost:5000/report/view', {
                headers: {
                    token: `Bearer ` + `${authToken}`,
                    'Content-Type': 'application/json'
                },
            });
            if (!response.ok) {
                throw new Error('API request failed');
            }
            const data = await response.json();
            setReportData(data);
        } catch (error) {
            console.error(error);
        }
    }

    if (authToken) {
        fetchData();
    }
    useEffect(() => {
        fetchData();
    }, [authToken]);

    if (!authToken) {
        return <div>Please log in to view the report</div>;
    }

    if (!reportData) {
        return <div>Loading report data...</div>;
    }

    const AcceptHandler = async (ID) => {

        try {
            const response = await axios.delete(`http://localhost:5000/report/accept/${ID}`, {
                headers: {
                    token: `Bearer ` + `${authToken}`,
                    'Content-Type': 'application/json'
                },
            });
            console.log(response);
        } catch (error) {
            console.error(error);
        }


    };
    const RefuseHandler = async (ID) => {
        try {
            const response = await fetch(`http://localhost:5000/report/refuse/${ID}`, {
                method: 'DELETE',
                headers: {
                    token: `Bearer ` + `${authToken}`,
                    'Content-Type': 'application/json'
                },
            });
            if (!response.status ==200) {
                fetchData()
            }   
            else{
                const updatedItems = reportData.filter(report => report.id !== report._id);
                setReportData(updatedItems)
                fetchData()

            }
            
        } catch (error) {
            console.error(error);
        }
};

    return (
        <>
            {reportData ?
                <div className="cartContainer">
                    
                    <div className="d-flex gap-4 flex-wrap justify-content-center">
                        {reportData.map((report) => (<>
                            <div className="card" key={report._id}>
                                <img src={report.product_id.imgURL} className="card-img-top" alt="..." />
                                <div className="card-body">
                                <div className="d-flex justify-content-between flex-column h-100">

                                    <div className="">
                                    <h5 className="card-title">Report Type : <span> {report.report_type}</span> </h5>
                                    <p className="card-text mt-2">Description : <span>{report.description}   </span></p>
                                        <p className="card-text"> Tittle : <span>{report.product_id.title}   </span></p>
                                        <p className="card-text"> Product Discription :<span> {report.product_id.description}   </span></p>
                                        <p className="card-text"> Product Category : <span>{report.product_id.category}   </span></p>
                                        <p className="card-text"> Product Price :<span> {report.product_id.price}  $   </span></p> 
                                    </div>
                                <div className="d-flex flex-column w-100 mt-3 gap-2">


                                    <button onClick={()=>AcceptHandler(report._id)} className="btn d-block btn-sm btn-success">Accept</button>

                                    <button className="btn d-block btn-sm btn-danger">Refuse</button>
                                </div>
                                </div>
                                
                                </div>
                            </div>
                           

                        </>


                        ))}

                    </div>
                </div> : 'no report found '}
                              
                <Sidebar/>




        </>
    )
}

export default Report;

{/* 
    
        "_id": ,
        "report_type":
        "description":        
        "product_id": 
            "_id": ,
            "title": 
            "description": 
            "imgURL" [
            "category": "sofa",
            "price": 7000,
     */}