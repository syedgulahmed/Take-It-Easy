import 'package:tie_service_provider_app/model/category.dart';
import 'package:tie_service_provider_app/model/customer.dart';
import 'package:tie_service_provider_app/model/order_item.dart';
import 'package:tie_service_provider_app/model/serviceProvider.dart';

var CATEGORIES = [
  Category('c1', 'Home Cleaning', 'assets/home_cleaning.jpg', ''),
  Category(
    'c2',
    'Electrician',
    'assets/electrician.jpg',
    '',
  ),
  Category('c3', 'Plumbers', 'assets/plumber.jpg', ''),
  Category(
    'c4',
    'Mechanic',
    'assets/mechanic.jpg',
    '',
  ),
  Category(
    'c5',
    'Home Movers',
    'assets/home_movers.jpg',
    '',
  ),
  Category(
    'c6',
    'Carpenter',
    'assets/carpenter.jpg',
    '',
  ),
];
var p1 = [CATEGORIES[0].title, CATEGORIES[1].title];
var p2 = [CATEGORIES[4].title, CATEGORIES[5].title, CATEGORIES[3].title];
var Profiles = [
  ServiceProvider(
    'P1',
    'John Wisconsin',
    'john@gmail.com',
    'https://qph.fs.quoracdn.net/main-thumb-108685783-200-xrelathtpdgbxpnxyqlewgueikjkgjqb.jpeg',
    'Sukkur',
    '200',
    p1,
    2.0,
    1
  ),
  ServiceProvider(
    'P2',
    'David Adobe',
    'david@gmail.com',
    'https://rmc-cdn.s3.amazonaws.com/media/uploads/iat/sites/36/2020/08/2020_August_Social_PSM_Spotlight_BRJ_IG_Portrait_1080x1350.jpg',
    'Sukkur',
    '200',
    p2,
    2.0,
    1
  ),
];

var customers = [
  Customer(
    'P1',
    'Gul Ahmed',
    'gul@gmail.com',
    'https://qph.fs.quoracdn.net/main-thumb-108685783-200-xrelathtpdgbxpnxyqlewgueikjkgjqb.jpeg',
    'Sukkur',
  ),
  Customer(
    'P2',
    'Sunil Kumar',
    'sunil@gmail.com',
    'https://rmc-cdn.s3.amazonaws.com/media/uploads/iat/sites/36/2020/08/2020_August_Social_PSM_Spotlight_BRJ_IG_Portrait_1080x1350.jpg',
    'Sukkur',
  ),
];

var Orders = [
  OrderItem(
    'asdf324',
    customers[0],
    Profiles[0],
    '5-5-2021 08:45 PM',
    '5-5-2021 11:45 PM',
    CATEGORIES[0],
    2,
    OrderStatus.ACCEPTED,
    'Sukkur',
    ''
    // 1 = Requested, 2 = Accepted, 3 = Started, 4 = Finished, 5 = PastOrder
  ),
];
