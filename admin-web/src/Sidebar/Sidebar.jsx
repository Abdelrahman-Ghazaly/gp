import React from "react";
import './Sidebar.css'
import { Link } from 'react-router-dom';

const Sidebar = () => {
  return (
    <div className="sidebar-wrapper">
      <div className="sidebar">
        <div className="d-flex flex-column h-100 justify-content-around text-center">
          <Link to={"/reports"}>
          <p>Reports</p>
          </Link>
          <Link to={"/auction"}>
          <p>Auction</p>
          </Link>
        </div>
      </div>
    </div>
  );
};

export default Sidebar;