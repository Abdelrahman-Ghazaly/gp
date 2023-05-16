import React , {useEffect , useState} from 'react'
import Avatar from '@mui/material/Avatar';
import {User} from '../../../Styles/chatmenu'
import {stringToColor} from '../../../Utilities/chatUserList'
import { Box } from '@mui/material';


const UsersList = ({conversation , user}) => {
    const [userData, setUserData] = useState(null);
    console.log(conversation)
    useEffect(() => {
        const friendId = conversation.members.find((m) => m !== user._id);
        console.log(friendId)
        const getUser = async () => {
          try {
            const res = await fetch(
              `http://localhost:5000/user/${friendId}`
            );
            const data = await res.json();
            setUserData(data);

          } catch (err) {
            console.log(err);
          }
        };
        getUser();
    }, [ conversation , user?._id]);

    function stringAvatar(name = "Avatar") {

        return {
          sx: {
            bgcolor: stringToColor(name),
          },
          children: `${name.split(' ')[0][0]}${name.split(' ').length > 1 ? name.split(' ')[1][0] : ""}`,
        };
      }

  return (
    <div>
      <Box style={{ textAlign: "center" }}>
        <User>
          <Avatar
            style={{ marginRight: "10px" }}
            {...stringAvatar(userData?.name)}
          />
          <h3 style={{ textAlign: "center" , fontWeight : '500'}}>{userData?.name}</h3>
        </User>
      </Box>
    </div>
  );
}

export default UsersList