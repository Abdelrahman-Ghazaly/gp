import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:go_router/go_router.dart';
import 'package:gp_flutter/features/auction/presentation/bloc/bid_auction_bloc/bloc/bid_auction_bloc_bloc.dart'
    as bid_auction;
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../../core/app_constants/api_constants.dart';
import '../../../../core/app_constants/app_colors.dart';
import '../../../../core/utils/utilities.dart';
import '../../../authentication/presentation/bloc/log_in_bloc/log_in_bloc.dart'
    as login_bloc;
import '../bloc/get_all_auctions_bloc/all_auctions_bloc.dart' as all_auction;
import '../bloc/get_auction_by_id/get_auction_by_id_bloc.dart';
import '../widgets/price_container.dart';

class AuctionDetailsScreen extends StatefulWidget {
  final String auctionId;

  const AuctionDetailsScreen({Key? key, required this.auctionId})
      : super(key: key);

  @override
  State<AuctionDetailsScreen> createState() => _AuctionDetailsScreenState();
}

class _AuctionDetailsScreenState extends State<AuctionDetailsScreen> {
  late io.Socket _socket;
  Map<String, dynamic> newbid = {"": ""};
  bool isWinner = false;
  @override
  void initState() {
    _socket = io.io(
      ApiConstants.socketUrl,
      io.OptionBuilder().setTransports(
        ['websocket'],
      ).build(),
    );
    _connectSocket();
    super.initState();
  }

  _connectSocket() {
    _socket.on('connection', (data) => print('connected'));
    _socket.on('bidAuction', ((data) {
      print(data);
      newbid = data;

      setState(() {});
    }));

    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
  }

  @override
  void dispose() {
    _socket.emit("disconnect", (_) => print('disconnected'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logInState = context.read<login_bloc.LogInBloc>().state;
    if (newbid["winner_id"] != null) {
      context
          .read<all_auction.AllAuctionsBloc>()
          .add(all_auction.GetAuctionProductsEvent());
    }
    if (logInState is login_bloc.Success) {
      if (newbid["winner_id"] != null) {
        if (newbid["winner_id"] == logInState.userEntity.id) {
          isWinner = true;
        }
      }
    }
    final width = Utilities.screenWidth;
    final height = Utilities.screenHeight;
    TextEditingController bidAmount = TextEditingController();
    context.read<GetAuctionByIdBloc>().add(GetDataEvent(widget.auctionId));
    return BlocBuilder<GetAuctionByIdBloc, GetAuctionByIdState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          if (logInState is login_bloc.Success) {
            if (state.auctionData.winnerId == logInState.userEntity.id) {
              isWinner = true;
            }
          }
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        width: width,
                        height: height * 0.5,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment(0.8, 1),
                            colors: auctionDetailsLinearGradient,
                            tileMode: TileMode.mirror,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.black26,
                                  radius: width * 0.03,
                                  child: GestureDetector(
                                    onTap: () {
                                      return context.go('/');
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: width * 0.05,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.7,
                                  child: const Text(
                                    textAlign: TextAlign.center,
                                    "Live Auction",
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.15,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width,
                              height: height * 0.37,
                              child: Swiper(
                                autoplay: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: width * 0.8,
                                    height: height * 0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                state.auctionData.image[index]),
                                            fit: BoxFit.fill)),
                                  );
                                },
                                itemCount: state.auctionData.image.length,
                                viewportFraction: 0.8,
                                scale: 0.8,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.35,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  state.auctionData.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.3,
                                      height: height * 0.1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text("Creator",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.person_pin,
                                                size: height * 0.04,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  state.auctionData.owner!.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 23,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.3,
                                      height: height * 0.1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text("Ending in",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey)),
                                          CountdownTimer(
                                            endTime: DateTime.parse(
                                                    state.auctionData.duration)
                                                .millisecondsSinceEpoch,
                                            textStyle:
                                                const TextStyle(fontSize: 15),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const Text("Description",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(state.auctionData.description,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.9,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment(0.8, 1),
                        colors: auctionLinearGradient,
                        tileMode: TileMode.mirror,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: height * 0.07,
                          width: width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Highest Bid",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 22,
                                      color: Colors.white)),
                              Text(
                                  newbid["current_pid"] == null
                                      ? "${state.auctionData.currentPrice} USD"
                                      : "${newbid["current_pid"]} USD",
                                  style: const TextStyle(
                                      fontSize: 22, color: Colors.white))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (logInState is login_bloc.Success) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            PriceContainer(
                                              size: 0.17,
                                              width: width,
                                              height: height,
                                              controller: bidAmount,
                                              label: 'BidAmount',
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        TextButton(
                                          onPressed: () {
                                            if (int.parse(bidAmount.text) >
                                                state
                                                    .auctionData.currentPrice) {
                                              Navigator.pop(context);
                                              context
                                                  .read<
                                                      bid_auction
                                                          .BidAuctionBloc>()
                                                  .add(bid_auction
                                                      .BidAuctionEvent(
                                                          auctionId:
                                                              widget.auctionId,
                                                          bidAmount: int.parse(
                                                              bidAmount.text),
                                                          userToken: logInState
                                                              .userEntity
                                                              .accessToken!));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'please Enter a Vaild Bid')),
                                              );
                                            }
                                          },
                                          child: const Text('Done'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return context.go('/login_screen');
                            }
                          },
                          child: isWinner
                              ? Container(
                                  height: height * 0.07,
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff9f08d),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                    child: Text("You are winner",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )
                              : Container(
                                  height: height * 0.07,
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff9f08d),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                    child: Text("Place a bid",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                        )
                      ],
                    ),
                  )
                ],
              ));
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
