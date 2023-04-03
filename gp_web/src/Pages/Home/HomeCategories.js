import React, { useRef } from "react";
import { Box, Grid } from "@mui/material";
import { Item, Thumbnail } from "../../Styles/home";
import { motion } from "framer-motion";
import { Link } from "react-router-dom";
const imgStyle = {
  width: "100%",
  height: "300px",
  objectFit: "cover",
  transition: "transform .5s",
  zIndex: "-1",
  "&:hover": {
    transition: ".25s ease",
  },
};

const HomeCategories = ({match , Categories }) => {
  const scrollRef = useRef(null);

  return (
    <div>
      <Box sx={{ flexGrow: 1, marginTop: "15px" }}>
        <h1
          style={{
            color: "#20284f",
            padding: "18px 5px",
            fontSize: `${!match ? "50px" : "25px"}`,
          }}
        >
          Our Categories
        </h1>
        <Grid
          container
          spacing={{ xs: 2, md: 3 }}
          columns={{ xs: 4, sm: 8, md: 12 }}
        >
          {Categories.map((cat, index) => (
            <Grid item xs={12} sm={4} md={4} key={index}>
              <motion.div
                initial={{ opacity: 0, scale: 0.5, x: -150 }}
                whileInView={{
                  opacity: 1,
                  scale: 1,
                  transition: {
                    duration: 1,
                    delay: 0.25,
                    ease: [0, 0.71, 0.2, 1.01],
                  },
                  x: 0,
                }}
                viewport={{ root: scrollRef }}
                animate={{ scale: 1 }}
              >
                <Link
                  to={`/categorypage/${cat.categoryName}`}
                  style={{ cursor: "pointer" }}
                >
                  <Item>
                    <Thumbnail>
                      <img
                        src={cat.Thumbnail}
                        alt={cat.categoryName}
                        style={imgStyle}
                      />
                    </Thumbnail>
                    <h2>{cat.categoryName}</h2>
                  </Item>
                </Link>
              </motion.div>
            </Grid>
          ))}
        </Grid>
      </Box>
    </div>
  );
};

export default HomeCategories;
