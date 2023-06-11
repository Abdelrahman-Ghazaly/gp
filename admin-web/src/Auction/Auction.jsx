import React, { useState, useEffect } from 'react';
import '../Reports/Reports.css'
import axios from "axios";
import Sidebar from '../Sidebar/Sidebar';

function Report(props) {
    const [reportData, setReportData] = useState(null);
    const authToken = localStorage.getItem('accessToken')

    async function fetchData() {
        try {
            const response = await fetch('http://localhost:5000/auction/view/requests', {
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
    useEffect(() => {
        fetchData()
        if (authToken) {
            fetchData();
        }
    }, [authToken]);
    
  

    if (!authToken) {
        return <div>Please log in to view the report</div>;
    }

    if (!reportData) {
        return <div>Loading report data...</div>;
    }

    const AcceptHandler = async (ID) => {
    try {
        const response = await fetch(`http://localhost:5000/auction/accept/${ID}`, {
            method: 'PUT',
            headers: {
                token: `Bearer ` + `${authToken}`,
                'Content-Type': 'application/json'
            },
        });
        if (response.status ===200) {
            fetchData()
        }   
        
    } catch (error) {
        console.error(error);
    }
};
    const RefuseHandler = async (ID) => {
        try {
            const response = await fetch(`http://localhost:5000/auction/refuse/${ID}`, {
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


//   const handleRefuse = () => {
//     axios
//       .delete("https://exampleapi.com/items/1", {
//         headers: {
//           Authorization: "Bearer " + authToken,
//         },
//       })
//       .then(() => {
//         // setShowReport(false);
//       })
//       .catch((error) => {
//         console.log(error);
//       });
//   };

return (
    <>
        {reportData ?
            <div className="cartContainer">

                <div className="d-flex gap-4 flex-wrap justify-content-center">
                    {reportData.map((report) => (<>
                        <div className="card" key={report._id}>
                            <img src={report.imgURL} className="card-img-top" alt="..." />
                            <div className="card-body">
                                <div className="d-flex justify-content-between flex-column h-100">

                                    <div className="">
                                        {/* <h5 className="card-title">Report Type : <span> {report.report_type}</span> </h5>
                                    <p className="card-text mt-2">Description : <span>{report.description}   </span></p> */}
                                        <p className="card-text"> Tittle : <span>{report.title}   </span></p>
                                        <p className="card-text"> Product Discription :<span> {report.description}   </span></p>
                                        <p className="card-text"> Product Category : <span>{report.category}   </span></p>
                                        <p className="card-text"> Product Price :<span> {report.start_price}  $   </span></p>
                                    </div>
                                    <div className="d-flex flex-column w-100 mt-3 gap-2">


                                        <button className="btn d-block btn-sm btn-success" onClick={()=>AcceptHandler(report._id)}  >Accept</button>

                                        <button className="btn d-block btn-sm btn-danger" onClick={()=>RefuseHandler(report._id)}>Refuse</button>
                                    </div>
                                </div>

                            </div>
                        </div>
                        {/* <div className="card p-2 mx-2" key={report._id}>
                                    <div className="card-image ">
                                        <img className='w-50' src={report.product_id.imgURL} alt="" />
                                    </div>
                                    <div className="card-details mt-4">
                                        <h5 className="card-title">Report Type : <span> {report.report_type}</span> </h5>
                                        <p className="card-text mt-2"> Report Discription : <span>{report.description}   </span></p>
                                        <p className="card-text"> Tittle : <span>{report.product_id.title}   </span></p>
                                        <p className="card-text"> Product Discription :<span> {report.product_id.description}   </span></p>
                                        <p className="card-text"> Product Category : <span>{report.product_id.category}   </span></p>
                                        <p className="card-text"> Product Price :<span> {report.product_id.price}  $   </span></p> 
                                        <button className="btn btn-sm btn-success " >Accept</button>
                                        <button className="btn btn-sm btn-danger" >Refuse</button>
                                    </div>

                                </div> */}

                    </>


                    ))}

                </div>
            </div> : 'no report found '}

        <Sidebar />




    </>
)
}

export default Report;

