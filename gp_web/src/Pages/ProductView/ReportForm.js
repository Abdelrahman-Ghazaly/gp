import React, { useState } from "react";
import {
  Box,
  Button,
  TextField,
  MenuItem,
  Alert,
} from "@mui/material";
import { useDispatch } from "react-redux";
import { useForm } from "react-hook-form";
import { sendReport } from "../../Store/reportReducer";

const ReportList = [
  {
    id: 1,
    reportName: "wrong Category",
  },
  {
    id: 2,
    reportName: "offensive title or description",
  },
];

const ReportForm = ({ userData, id }) => {
  const dispatch = useDispatch();
  const [hideReport, setHideReport] = useState(false);

  const defaultValues = { report_type: "", description: "" };
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({ defaultValues: defaultValues });

  const reportFormHandler = (reportValues, e) => {
    e.preventDefault();
    dispatch(sendReport({ reportValues, id }));
    setHideReport(true);
  };
  return (
    <>
      {userData ? (
        hideReport ? (
          <Alert
            variant="filled"
            severity="success"
            style={{ padding: "8px 18px", margin: "15px 0" }}
            className="alert"
          >
            Report Sent Successfully
          </Alert>
        ) : (
          <Box
            style={{
              border: "2px solid red",
              padding: "8px 18px",
              margin: "15px 0",
              borderRadius: "15px",
              textAlign: "center",
            }}
            component="form"
            noValidate
            onSubmit={handleSubmit(reportFormHandler)}
          >
            <h2
              style={{
                color: "red",
                textAlign: "center",
                marginBottom: "15px",
              }}
            >
              Report{" "}
            </h2>
            <TextField
              fullWidth
              defaultValue={defaultValues.report_type}
              margin="normal"
              select
              label="Select Report Type"
              name="report_type"
              {...register("report_type", {
                required: "Please Enter The Report Type",
              })}
              error={!!errors.report_type}
              helperText={errors.report_type?.message}
              style={{ display: "inline-block" }}
            >
              {ReportList.map((option) => (
                <MenuItem key={option.id} value={option.reportName}>
                  {option.reportName}
                </MenuItem>
              ))}
            </TextField>
            <TextField
              margin="normal"
              multiline
              fullWidth
              row={1}
              label="Description"
              name="description"
              {...register("description", {
                required: "Please Enter Description",
              })}
              error={!!errors.description}
              helperText={errors.description?.message}
            />
            <Button
              type="submit"
              style={{ background: "red" }}
              variant="contained"
            >
              {" "}
              Send Report
            </Button>
          </Box>
        )
      ) : null}
    </>
  );
};

export default ReportForm;
