interface AddressInterface {
    unitNumber: string;
    streetAddress: string;
    suburb: string;
    state: string;
    postcode: string;
    position: {
        latitude: number;
        longitude: number;
    };
}

interface ItemInterface {
    uid: string;
    name: string;
    category: string;
    merchantUid: string;
    description: string;
    photoUrl: string;
    price: number;
    quantity: number;
}

interface VoucherInterface {
    uid: string;
    userUid: string;
    sharerUid: string;
    value: number;
    threshold: number;
    isValid: boolean;
    expireDate: string;
}

interface ReviewInterface {
    orderUid: string;
    shopping: boolean;
    delivery: boolean;
    products: boolean;
    comment: string;
}

interface OrderInterface {
    status: 'pending' | 'processing' | 'ready' | 'delivering' | 'completed' | 'reviewed' | 'canceled';
    type: 'pickup' | 'delivery';
    paymentStatus: 'deferred' | 'paid' | 'unpaid' | 'refunded';
    requirePayment: boolean;
    paymentId: string;
    note: string;
    uid: string;
    userUid: string;
    merchantUid: string;
    stripeAccountId: string;
    orderNumber: number;
    itemList: ItemInterface[];
    totalItems: number;
    voucherList: VoucherInterface[];
    name: string;
    email: string;
    phone: string;
    address: AddressInterface;
    storeName: string;
    storePhone: string;
    storeAddress: AddressInterface;
    itemsTotalPrice: number;
    voucherAmount: number;
    deliveryFee: number;
    orderTotalPrice: number;
    createTime: number;
    deliveryTime: string;
    review: ReviewInterface;
}

interface InfoSectionInterface {
    photoUrl: string;
    title: string;
    text: string;
}

interface ProductInterface {
    uid: string;
    merchantUid: string;
    name: string;
    category: string;
    isAvailable: boolean;
    description: string;
    photoUrlList: string[];
    infoList: InfoSectionInterface[];
    price: number;
    stock: number;
    sold: number;
}

interface MerchantInterface {
    uid: string;
    name: string;
    stripeAccountInfo: {
        id: string;
        email: string;
        charges_enabled: boolean;
        payouts_enabled: boolean;
    };
    description: string;
    phone: string;
    email: string;
    url: string;
    icon: string;
    address: AddressInterface;
    photoUrlList: string[];
    infoList: InfoSectionInterface[];
    productCategoryList: string[];
    orderTypeList: ('pickup' | 'delivery')[];
    paymentMethodList: ('In Store' | 'On Delivery' | 'Online' | 'Transfer')[];
}

interface UserInterface {
    uid: string;
    stripeCustomerId: string;
    name: string;
    isAnonymous: boolean;
    phone: string;
    email: string;
    address: AddressInterface;
    cart: ItemInterface[];
    createTime: number;
    lastActiveTime: number;
}

interface NotificationInterface {
    uid: string;
    title: string;
    body: string;
    type: 'item' | 'order' | 'voucher';
    targetUid: string;
    sendTime: number;
    viewedTime?: number;
    photoUrl?: string;
    // if notification is viewed by the user
    isViewed: boolean;
}
