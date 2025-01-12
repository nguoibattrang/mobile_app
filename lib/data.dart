import 'package:chatview/chatview.dart';

class Data {
  static const profileImage =
      "https://i.ytimg.com/vi/6L7wiCqaytg/maxresdefault.jpg";
  static final messageList = [
    Message(
      id: '1',
      message: "Chào mọi người!",
      createdAt: DateTime.now(),
      sentBy: '1', // userId of who sends the message
      status: MessageStatus.read,
    ),
    Message(
      id: '2',
      message: "Chào! Mọi người đã sẵn sàng cho Hackathon chưa?",
      createdAt: DateTime.now(),
      sentBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '3',
      message: "Rồi, háo hức lắm! Chủ đề năm nay là gì vậy?",
      createdAt: DateTime.now(),
      sentBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '4',
      message: "Chủ đề là 'Đổi mới vì tương lai'.",
      createdAt: DateTime.now(),
      sentBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '5',
      message: "Nghe hấp dẫn quá! Mình có thể chia sẻ ý tưởng trước không?",
      createdAt: DateTime.now(),
      sentBy: '1',
      reaction: Reaction(reactions: ['\u{1F44D}'], reactedUserIds: ['2']),
      status: MessageStatus.read,
    ),
    Message(
      id: '6',
      message: "Được chứ! Có một kênh Slack dành cho thảo luận đấy.",
      createdAt: DateTime.now(),
      sentBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '7',
      message: "Bạn gửi link được không?",
      createdAt: DateTime.now(),
      sentBy: '3',
      status: MessageStatus.read,
    ),
    Message(
      id: '8',
      message: "Đây là link nhé: https://bit.ly/vcs-hackathon",
      createdAt: DateTime.now(),
      sentBy: '2',
      reaction: Reaction(
        reactions: ['\u{1F44D}', '\u{2764}', '\u{1F44D}'],
        reactedUserIds: ['1', '3', '4'],
      ),
      status: MessageStatus.read,
      replyMessage: const ReplyMessage(
        message: "Bạn gửi link được không?",
        replyTo: '3',
        replyBy: '2',
        messageId: '7',
      ),
    ),
    Message(
      id: '9',
      message: "Nhận được rồi, cảm ơn nhé!",
      createdAt: DateTime.now(),
      sentBy: '3',
      status: MessageStatus.read,
      reaction: Reaction(
        reactions: ['\u{2764}', '\u{1F44D}', '\u{2764}'],
        reactedUserIds: ['1', '2', '4'],
      ),
    ),
    Message(
      id: '10',
      message: "Mong chờ ý tưởng từ mọi người quá!",
      status: MessageStatus.read,
      createdAt: DateTime.now(),
      sentBy: '1',
      reaction: Reaction(
        reactions: ['\u{2764}', '\u{1F44D}', '\u{1F44D}'],
        reactedUserIds: ['2', '3', '4'],
      ),
    ),
    Message(
      id: '11',
      message: "https://miro.medium.com/max/1000/0*s7of7kWnf9fDg4XM.jpeg",
      createdAt: DateTime.now(),
      messageType: MessageType.image,
      sentBy: '2',
      reaction: Reaction(reactions: ['\u{2764}'], reactedUserIds: ['1']),
      status: MessageStatus.read,
    ),
    Message(
      id: '12',
      message: "Hackathon lần này sẽ đỉnh lắm! 🤩",
      createdAt: DateTime.now(),
      sentBy: '3',
      status: MessageStatus.read,
    ),
  ];
}