Return-Path: <linux-kernel+bounces-281631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEAD94D911
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716D2283C91
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1693416D4CA;
	Fri,  9 Aug 2024 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vTkuO86B";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RIVsOiDb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uu+XFacp"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CC26AE4;
	Fri,  9 Aug 2024 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723245579; cv=fail; b=JWUxATvraX/DQjZuRgwiLwhHvND8Xp2PqGj2W2jrIpExUu3/O1wrVnrXOZIfUJkwplKzOWeb2wKiRF7ApZxvbSrvzZdpKa/vPmHZM7eKwwX+sGgTrpirqYUSNkCfgSfmTne5eIMIjdoVcHVGkB5bROlY3YbKVXG8LkErzm/iNpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723245579; c=relaxed/simple;
	bh=Hhn/iHDpFJF2CHEJNyCHXOKH1PSX3pNfhJSnady6z4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=psNmaKVFvFkYL4GuUAxsoUALwuWwcucX5SYm7+JoUfFclz1w7dyXuaOB9zgSpNmnt5O6gdmSRrBDlhGnmxU8LQzFYZ7Cw2aSTw1aD7bPxq3O04DO+8vT/HBE2XoROofvUBBboLJqsKObrwZxnGcPafFTMm5ds4Ss7uT+WG37aIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vTkuO86B; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RIVsOiDb; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uu+XFacp reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479MCAtH010387;
	Fri, 9 Aug 2024 16:19:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Hhn/iHDpFJF2CHEJNyCHXOKH1PSX3pNfhJSnady6z4Y=; b=
	vTkuO86B2W487xBXudDE9WBpcQQ0IO0/BBWjr19pBJ7hX42PgAmnPqnJY0UVjNHE
	PGk0X9xTcDAoP8hY1lk3n0CieLs3Kq190V+ryw3vuBe7bvTGlGsSqaSS0Zz1SW5k
	+0Whkrs93BEs/AZQhsti7S1p4JNuYTShHTmfgWM5Q93ZaFVpXoiA1Apx2TKI3rDk
	5X9NTsfgxZMzRttpyk6b+k51wKX1eHdT+x0uW44l5r8Xb8P6ugsRW5skkBnBJWuv
	Hrgpgtll+gw4IgBlfNPciffhWQCpo7Pc+WCrhLXlNAArJNyLvJ+dKK+eY2jJDnmR
	fBupTLu4uMINbtemrfdCTQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uujbthg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723245543; bh=Hhn/iHDpFJF2CHEJNyCHXOKH1PSX3pNfhJSnady6z4Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RIVsOiDb/sD1Q5JXR+BfvO4B1g/p7X9swI/wa+FzrVxfRD9+C9W9L5hQp4/sYvBj8
	 /YJiuqI7jA4ZGQS+VCPw17Yd7cDGrJyI5jD18ltFYX71x0Jc9Kgis87yvd95FT3o/N
	 BJENlQZPmeCLVBhJGMXYbOlGUq1qIpHkycwlnXmB+Q7W2kqyeo8BceXxVNa/KDxueW
	 2NyHA+9DolnNomxWQFlulHXXSUj6kS9nm1ODsYJNgw/jbPYu7xX8acnQSP3O/lHjUL
	 wPZbdVTmXWVlheOHHWueKwft81/Xiy2qx0eqhxxNssedsMeGrBdbVTpbuKmcVzf3MA
	 IlD9tLzzUo6Yg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9EB6A4035A;
	Fri,  9 Aug 2024 23:19:01 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 222FEA00AC;
	Fri,  9 Aug 2024 23:18:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=uu+XFacp;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 386194044C;
	Fri,  9 Aug 2024 23:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0YLswXi9T8zXUDher15TdHo/ugvOZj3lYHTlkheHL2YtX5hp55EYvlcZ4DYq+/+MAoltzltkkwegH+4qQtxDIqHUQgo0NIDVAG1SxFQd3rWB8jUcVsLuzCM1l4reE3Yn+iQNU9mtOLCFRDqRSt0fx7I2SjNiXGvsh0jdBpRn75v7mmXRSgxn/V4Ik3xq+dvzKLO4ANH9Y2J4PPG1vsU7btbALBILK5akaOdVAc6noSWpoG12hRYuyexCaw+kSkGtLG62vx9RdtXjOSvJMq7ERMvIXTqmzFITFK4JLn/JVQUUdM9KX7+KSVE64suRy0fnAV0UEJKrC458wz81qrG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hhn/iHDpFJF2CHEJNyCHXOKH1PSX3pNfhJSnady6z4Y=;
 b=TlqqMNkru3hqhKyUurqx5Ixb1LpTBiGHIMfgsWTs7Jx0UGrYY+2t14ZowAtQsgXZI/GIwMe6MDEgAEYJZkVMj7/5kXuEPe/aEDSCK4bTC63mGdDWpCGqb+5D4oy/j8WiuNdJdRD5eKSmiMqClcxLABNlm2P6Qyk4/jAXn4SUXKC3rHMdSRJg5L9k28qwC0xmuhvHukFo66ywmLvarVHqRdpWfeaxG58Yv0tuYp3l91+XzJvYONRsXUKmdGBAzI1OiRk3gcbWISsgWc0/RuZjVwOGoHxx7SaKGOpOReeQtur9iQDU2UW3I8qGhTjm4dCOWRE12GGbm3tCT5NK8wgFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhn/iHDpFJF2CHEJNyCHXOKH1PSX3pNfhJSnady6z4Y=;
 b=uu+XFacp1ZBZn7YygilKQgVDXoAn1X6hlw8humEg9IVXfebtO8ej4YibiDreIlh2ZFBs92IXfGCT5krnf7GImsvADqCHI4IGu2hAf4S6RGvceL/WA9bLRZ8Lh2QblI//rLQexozV4wgXDInzd1bmoBIB/ye+sY+CmM3O1IVRHfk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 23:18:53 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 23:18:53 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.li@nxp.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "jun.li@nxp.com" <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH 3/4] usb: dwc3: core: add a core init flag for device mode
 resume
Thread-Topic: [PATCH 3/4] usb: dwc3: core: add a core init flag for device
 mode resume
Thread-Index: AQHa1HHqM5Cvp3uK6EGalLdh+Cd9ErIbJTeAgAQjWQCAAHOBAA==
Date: Fri, 9 Aug 2024 23:18:53 +0000
Message-ID: <20240809231844.okzwndlds3zh75rh@synopsys.com>
References: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
 <20240712-dwc-mp-v1-3-295e5c4e3ec9@nxp.com>
 <20240807011347.ucxlxmcikizreioj@synopsys.com>
 <ZrZC8AFtmR3Zn1c9@lizhi-Precision-Tower-5810>
In-Reply-To: <ZrZC8AFtmR3Zn1c9@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM6PR12MB4332:EE_
x-ms-office365-filtering-correlation-id: 72e82d4d-d77b-4680-5045-08dcb8c9a2a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFVOdGhOSDJVZmRvdDBJUS9BY29tdFlzbEJCc2thTG94aUZSR0lVRjVTdkM2?=
 =?utf-8?B?T1lVak5JdXhFeWRMWVpkSWJsbnplcDZTWDd5ZjhENEhmbC9OVDljSFdoSUg0?=
 =?utf-8?B?S05vYXZhVFEzczZPMGt6bHJkTE1mcjFManloZ1NLajZLUk5CcFVEWkpkemhR?=
 =?utf-8?B?ZzVWblI5MC9RV3pmbFBSeW1OUGFPZ21iY0U0bzlLWmFwUEFLQTBYaXNnOGlv?=
 =?utf-8?B?NTY1aXd6TXU3bmgrMGFlL3Z0Rm5GTFcvd3FGL3UxUHRCcHVBcCszUksxbHU1?=
 =?utf-8?B?N3N6cnVyK2NHY0M0aWxoSTQ5N2QwbFJ1UWdqYnFMbVVtMEFuTDNrMW1QRzNB?=
 =?utf-8?B?MmxVOUZvb1VObnlram1nZloweXpqakJPK0g0b05vU2NhZ3UyNlUybytPck1J?=
 =?utf-8?B?R2N0bHNLS2RZR3pmQ1A4QlRwTU8yYW5iakE4d0M2QkRqejFkSzVkUkZvalBH?=
 =?utf-8?B?U3BIUENXa0w5aGtFWXV0RE1Ua0xYdGRKYXpjbHlpK1l4ZCtQaWVpZVY0cm1I?=
 =?utf-8?B?cWh6T2piWk1XcmxFSDFFV3VzYWtLQ2E4dHBlVXBSSU9Fd29TcUNEVnEwd0F6?=
 =?utf-8?B?Z2hnSVoyVTc4U0hZZ1VSUnRTam5iUk96NlJMWVpJcGNZQzlvTmFaVUdjZmpv?=
 =?utf-8?B?K2FaMU9oc3k0cXBMZEhrTnZSK0NobXdhdWZ0aHFkZnpLbTZjYXVDZjdzak1u?=
 =?utf-8?B?cldSZmpXbjI0QW10TkN3Zkd1c0cwUlU1d2NJam5oYUNPY3pWMitHN1pXY2Ey?=
 =?utf-8?B?Y0tLMHJzL3UyTW9rL2taRjgvZC9zVGZhdFNlaWRuaHk1R0RBdFl1bGlDNCt0?=
 =?utf-8?B?QWh1MDNlYk9RVVBrZ2lxNUxublcwNzJkZE94SkwvdFB4YWtEUm9mSXhDZ0ly?=
 =?utf-8?B?eDA1YXBqbjM1SWRQcStMT1BKMkVZRlhkWGQvVE83L2o4MjU5U1NRYk9NY0JY?=
 =?utf-8?B?THlITEFCWUJQd0J6aGUrQWYzTHJVZ29Ud0gzQkV4RUhDeGNIYVdlU0IzQmNT?=
 =?utf-8?B?V2FJWjZDYW5FenVkYlBVR3AzcjE3QU1GbnMxdzVJeTVVOFA2QjNPZ09aemZs?=
 =?utf-8?B?dG0xQ09TdkxPVGxvajRvdWgyMXNsNXZ2TkNUZldSNU1rQ0FzbXgwV0ExaTc4?=
 =?utf-8?B?MERsbDBGdHd1VXZmQlZ5bDhxR1dYYzJkS2hyZ3B4SVRuOVg3clJ3Q0ZlRkY1?=
 =?utf-8?B?L2lWTTZEQURBL1JGQnFsM0RNUUtMRGVYamZ0eDU5dldKaFFmUFlNNk1HaXNX?=
 =?utf-8?B?WWUyRElrNmJYdjc2cTU3NkRMaDVkd29yWFdic04vMWo5bVhjZjE3RTJjbm95?=
 =?utf-8?B?VGRENUg4NXBUTzg2czV0TkxZdlpHRGROOVZ6cURhT2lDWmRWTzJsdStCRmxE?=
 =?utf-8?B?QXUwSW44S3VMZEdEREhtbkhUdzlWWHFhS0tyb3RxVEVlUmxvNUpJcXBNQ1Bj?=
 =?utf-8?B?bXdnbmtHVDQ2UDFRMEJDN1lJNWdObm5kbHNUTkE0V3hXL09obmUwdlpRWnUw?=
 =?utf-8?B?UzlWK3lkYnAxSDVVRmYwTTVCT0NzYlpuaWppWmhyTzdyQ2xWczl6RFNEQjk2?=
 =?utf-8?B?VkczZDAzUUt4QjBUSHpzRUhYQi8vN2c4aktYNE1HTWxlaFlIaEJvVDFYWVBl?=
 =?utf-8?B?THJKa2JuMGpCWGR0MnZlYmhqRGpZRXllMzF6cE16Q3JZcUgrbmhxa3dyYTNL?=
 =?utf-8?B?NGVEN1JSVS9QZFpOWlVUUk9CQkVSL3RnTFFZTDl5WDZGZG14NVh5bkZPMjBU?=
 =?utf-8?B?aXoxbE1keVc2Z3d4NkhsMitjNTFtSUZJam1wcFE3VC8zYVoxS2prYTJNOS9u?=
 =?utf-8?B?L0pva0VCOVJ5S1UrU252RTFhREhpOWc4aEVrcGJyQnYyYXlSaE9NN2xCMm1Z?=
 =?utf-8?B?YzhmSmNYZmQ4ZE1wRGtFdVRKMGt5UTNTNnZqbTJrMXQ3ZWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTh5Z1NlNjJ6MS9QZ0JTT0plMHM1MGhlQ2hmQkdTdTlNY2pCam8raS9mRVFq?=
 =?utf-8?B?eUt3dm9tTUdoWDJKaElwTzg5cDdhcE52VE5BS0RSdG1rejR0MTNDVzNtNWpz?=
 =?utf-8?B?M2tVSlBkU3FqZHV6VDBQSWRVUDZjVXdQbUJPclVkRFdvZlRtQmdzSDd2T1pn?=
 =?utf-8?B?MFBXNlF6ZC91ZmNYK1dxWXV5VjlHcXhhOHVxS0tKVFB5NWQwZXAyTVgzOVNs?=
 =?utf-8?B?cFhFRy91U1phNDZVVGV3RG5JVnUrL2dsWFJubFhId3kvdkdha1BtYlFpWUtC?=
 =?utf-8?B?N3JLbm1Lc1ozVFE2UVFYTEFva24wREFoUnZEem9PZGkyamlDSm1Od2piWVph?=
 =?utf-8?B?S296czVBaFNkVUFjSkVmSEoxeXVFTUI4TXZlSmM4akppLzR0QUZIVHpMTWN4?=
 =?utf-8?B?WURIaTJVcklBbE5XVnhpcDlycnU3VFlGZy9ack5BYnJPT3prdCtRNUlFSmQz?=
 =?utf-8?B?eXcwY01tVkh2Uit4cU1MMW9PUE9RMi8vQmthNWl6KzVFam8zQjcxbU9yV2tw?=
 =?utf-8?B?UVFOTjZSM3NwOFBuUmx5OHJUVDByVU1mbGZYbXF4T2ZzVmlhNERxdytINytq?=
 =?utf-8?B?UG1TSFVVQkhiUXJOdjB1dW4reHJoMXVuZDhBSXRsVGRZNk9mTXVEbVQ3c2Jl?=
 =?utf-8?B?a3RVU3JVemZnQ1IzM05wUVowT09oelJoM0tJd3lQaFdUVUVzZnhELzZjbXVT?=
 =?utf-8?B?Qkc5VDlDYTV3TlNpbGQyTnNBbVFicVo5L1NlZFlHNmtyelEwckhOL2IzTVN2?=
 =?utf-8?B?dlYxT0h4Tnl6cWZGYUNOVFZUZmN4Y05LRkd6VHA5NldLUEVhY1I1WG05NUhT?=
 =?utf-8?B?OHdYaFVnWHdHVENBTE1WOUcxUEkyOExCS0dVcGJWLzRlS2dDMTJrTDBIQ3k3?=
 =?utf-8?B?dURJWndqWTlRbG1nSWFxczQyUzY0aDRKNHREa0pDSnRDVGYyRGFUZWkwSGli?=
 =?utf-8?B?Uk1rNmtsUW1lc0V0ZXRITTJrWTU3Uzd2cUhMSHVNR25wKzVWR3hXVFljNHNv?=
 =?utf-8?B?Z2xUVXVDelVSLyt5Q1FpZmpUZXRkanFBbW5HNG1LS2g2cWVia0Z0ZitjYTlM?=
 =?utf-8?B?UEJOcHV0T0ZDZ2tZTHBQVHdBeG9Nc3JUdkNNcmxSRllOQ3B0NDZHcTJJblBK?=
 =?utf-8?B?Zzd6eGhVeUwxejEzWlJ4cU9hM2UvNDdndS81OGJSVVV1UnRVS1BwcWIwQnpl?=
 =?utf-8?B?c0gza2RvNTBCaER5OU55aGpySGJlWnphNDRFdHNKbDNEcVZGWmtOS213ZlZ4?=
 =?utf-8?B?MkRycmhxbW53QXVvTzVrTENOQkgrNXBtOEdQZW05R2VzalR4S2wza0MyTWlo?=
 =?utf-8?B?d0tVcURUSmYzUVVzVkM0MFpYdWxldmY4TmkyZS9yejNWSk85Z0tITGhNbzVP?=
 =?utf-8?B?Vlk2WHZMZzJOaUdBOERrM2wxRjZiamFYQUQzRkRpaXV4U3hWQU92OFo4TE84?=
 =?utf-8?B?UCtxZXJib1NZQnRnTmlvVTFWVFphR1Y3Y3hONW12YVVxZk9OZzl6dUhVM1dt?=
 =?utf-8?B?YkdrSGVPUmtoZmdPajBuQmxFUUVtQlZ3YmxHbDJwV3EzS2YrVDhyejhOSTNW?=
 =?utf-8?B?aEZhOWpTZEdLRW9pdXMza3FIbEgrck1DL0ROWjdweFhhMFBNVDMxTlRsZlZ1?=
 =?utf-8?B?TUZ1UkZESFIxZ1hqS2R1TWw5NHUrNXMxSTVYRWZkM1J5L0o2d1hpbGhUT2gr?=
 =?utf-8?B?S1VucERXUk1JMXU2ZVdZSHhDR0kwaFg3bEN2cjI4Q3YwVCttQ0VUM3JZeVNm?=
 =?utf-8?B?aVg4c1JMenVQclJ2SmYrVVQ1YWFXK3pKaXk1Wko3bkVGNkVwS2VlQmNjUlY1?=
 =?utf-8?B?NGFyck9Cbk94QjF3eHRUemZLaGMvUTBPNkZRQ1pYSkpyaG52MDA1N0IyZDdM?=
 =?utf-8?B?N1Rkd0FwZk4zUnRyM0NIZUZncEpqNUxpNTRRdTVhd3BUbUh5dDdTN2tjU0JV?=
 =?utf-8?B?Uno1NitTUC8zeGhhN0FGaGRIaEpocCtKV2lueDFNa3crV2pYdFc5ZWdjVzV6?=
 =?utf-8?B?YjM2V00yV3NRc1VUZTRueVBRMnUvcUtBTkIzcFlBdURoa0pvaXBWYVV5TmNT?=
 =?utf-8?B?R2Jvck54cWpCT24rSmlyTDh1aE95VmhING9BVXNKY3N0V0UrTlUvMDdDcG1B?=
 =?utf-8?B?eWY2ZDZBc1p6eFVmRTN4V3h1NDloZlNIbXJ2bDFWTEVsOXdoSDB3Mmw0UWh2?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCD9752C132ADC4CA99260B736D5E021@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/DPL970yWPVRI1WScPjGL0dfTc3R7eS9tfeB+bzujn0TtSLIVhXvuWruCiYnWku4W9AzMqshhE+P8F08dSdlL6cXD2WuhsDbsFqlVGK0JztE7RNT9F2rQwzcDv/+YnURg/ndbOHgFYLsb8nZuMEBfBU21yksvYLB5dIyWjtlptge+SUdTI62G07LhlzkUZ3WckkoUf+EfLoidRj0XxpVTzYFGl5uXdXkKV3VHAUdKxI+yn8wGO2ziNqGvr6UlIJNicMQQzhteo4BIIxKytRa3MULHYQ/Pprr1ZfwV0gID6rJBfBvEG9ttyup7M2Q7eFE9k/lWbuRU/IlRiDQeQcFMQ7do/wi+N5F5iGp0XEDpKgu3edkkNg2UM3PzIRJnSsE0ylJDQCP44N+Gqngryh15rYVh2W7VoJCBRhh1pq06idfZwXLiW/hG707EGju/r/cycW6sXA2Mv6N7k5927s5nvaVQc2PVxaT7SEpQR0YThfVCocrwptEUJfzrqxlKk2C7A+0uYhvccnqKBoi5zXzmoKk7ajuVv6BKQ98HrgoEUx4Y4czaISW8ivJpKg0lccEmiOJayCVzMm9keaNa2jfwdYCQe0nQ3WBl319t7gwf8Eb4UOpmSDGbsZPgBpAeoR14C8NmcLGYLkFn5eLtULjnQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e82d4d-d77b-4680-5045-08dcb8c9a2a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 23:18:53.6248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCxvuaDZXl2+1YV5sybN0qU23fme4acWSJvGkz1Y61IF67zDRtDjq1VZhC7oBFF1KBfj/gq74qm5LkRS892rCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
X-Proofpoint-GUID: HMIWmf_8TxEHc9iqakm5BvpgO2Es3zjP
X-Proofpoint-ORIG-GUID: HMIWmf_8TxEHc9iqakm5BvpgO2Es3zjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_18,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408090169

T24gRnJpLCBBdWcgMDksIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAwNywg
MjAyNCBhdCAwMToxMzo1MkFNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gRnJp
LCBKdWwgMTIsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiA+ID4gRnJvbTogTGkgSnVuIDxqdW4u
bGlAbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGUgcnVudGltZSByZXN1bWUgd2lsbCBoYXBwZW4g
YmVmb3JlIHN5c3RlbSByZXN1bWUgaWYgc3lzdGVtIHdha2V1cCBieQ0KPiA+ID4gZGV2aWNlIG1v
ZGUgd2FrZXVwIGV2ZW50KGUuZywgVkJVUykuIEFkZCBhIGZsYWcgdG8gYXZvaWQgaW5pdCB0d2lj
ZS4NCj4gPg0KPiA+IFdoYXQncyB0aGUgY29uc2VxdWVuY2Ugb2YgZ29pbmcgdGhyb3VnaCB0aGUg
cmVzdW1pbmcgc2VxdWVuY2UgdHdpY2U/DQo+ID4gV2lsbCB0aGlzIGNhdXNlIGFueSBmdW5jdGlv
bmFsIGlzc3VlPw0KPiANCj4gc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKHN0
cnVjdCBkd2MzICpkd2MpDQo+IHsNCj4gDQo+IAkuLi4NCj4gICAgICAgICByZXQgPSBkd2MzX2Ns
a19lbmFibGUoZHdjKTsNCj4gICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgZ290
byBhc3NlcnRfcmVzZXQ7DQo+IA0KPiAJLi4uDQo+IH0NCj4gDQo+IGNsayB3aWxsIGJlIGVuYWJs
ZWQgdHdpY2UsIHRoZSByZWZlcmVuY2UgY291bnQgaW4gY2xrIHdpbGwgYmUgd3JvbmcgYmVjYXVz
ZQ0KPiBjbGtfZGlzYWJsZSgpIG9ubHkgb25jZSBhdCBzdXNwZW5kLg0KDQpQbGVhc2UgY2FwdHVy
ZSB0aGVzZSBpbmZvIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KPiANCj4gU28gY2xrIHdpbGwg
YmUgYWx3YXlzIE9OIGF0IG5leHQgc3VzcGVuZC4NCj4gDQo+IEZyYW5rIExpDQo+IA0KDQpkd2Mz
X2Nsa19lbmFibGUoKSBoYXBwZW5zIGluIHByb2JlKCkgYW5kIGR3YzNfY29yZV9pbml0X2Zvcl9y
ZXN1bWUoKSwNCmJ1dCB5b3UncmUgY2hlY2tpbmcgZHdjLT5jb3JlX2luaXRlZCBpbiBkd2MzX2Nv
cmVfaW5pdCgpLiBXaHk/DQoNCklmIHRoZSBpc3N1ZSBpcyBvbmx5IHJlbGF0ZWQgdG8gY2xrX2Vu
YWJsZSgpLCBwZXJoYXBzIGp1c3QgY2hlY2sgdGhhdD8NCg0KKG1pbm9yIG5pdDogcmVuYW1lIGNv
cmVfaW5pdGVkIHRvIGNvcmVfaW5pdGlhbGl6ZWQgaWYgeW91IHBsYW4gdG8gZG8NCnRoYXQpDQoN
ClRoYW5rcywNClRoaW5oDQoNCj4gPiA+DQo+ID4gPiBSZXZpZXdlZC1ieTogUGV0ZXIgQ2hlbiA8
cGV0ZXIuY2hlbkBueHAuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTGkgSnVuIDxqdW4ubGlA
bnhwLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAxMyArKysrKysr
KysrKysrDQo+ID4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAgMSArDQo+ID4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+
IGluZGV4IDczNGRlMmE4YmQyMTIuLmQ2MDkxN2ZhZDhjNTIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gPiA+IEBAIC05NTAsNiArOTUwLDggQEAgc3RhdGljIHZvaWQgZHdjM19jb3JlX2V4aXQo
c3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ICAJZHdjM19waHlfZXhpdChkd2MpOw0KPiA+ID4gIAlk
d2MzX2Nsa19kaXNhYmxlKGR3Yyk7DQo+ID4gPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGR3Yy0+
cmVzZXQpOw0KPiA+ID4gKw0KPiA+ID4gKwlkd2MtPmNvcmVfaW5pdGVkID0gZmFsc2U7DQo+ID4g
PiAgfQ0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgYm9vbCBkd2MzX2NvcmVfaXNfdmFsaWQoc3RydWN0
IGR3YzMgKmR3YykNCj4gPiA+IEBAIC0xNDQ2LDYgKzE0NDgsOCBAQCBzdGF0aWMgaW50IGR3YzNf
Y29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiAgCQlkd2MzX3dyaXRlbChkd2MtPnJl
Z3MsIERXQzNfTExVQ1RMLCByZWcpOw0KPiA+ID4gIAl9DQo+ID4gPg0KPiA+ID4gKwlkd2MtPmNv
cmVfaW5pdGVkID0gdHJ1ZTsNCj4gPiA+ICsNCj4gPiA+ICAJcmV0dXJuIDA7DQo+ID4gPg0KPiA+
ID4gIGVycl9wb3dlcl9vZmZfcGh5Og0KPiA+ID4gQEAgLTIzNzUsNiArMjM3OSwxNSBAQCBzdGF0
aWMgaW50IGR3YzNfcmVzdW1lX2NvbW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdlX3Qg
bXNnKQ0KPiA+ID4NCj4gPiA+ICAJc3dpdGNoIChkd2MtPmN1cnJlbnRfZHJfcm9sZSkgew0KPiA+
ID4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFOg0KPiA+ID4gKwkJLyoNCj4gPiA+ICsJ
CSAqIHN5c3RlbSByZXN1bWUgbWF5IGNvbWUgYWZ0ZXIgcnVudGltZSByZXN1bWUNCj4gPiA+ICsJ
CSAqIGUuZy4gcnBtIHN1c3BlbmQgLT4gcG0gc3VzcGVuZCAtPiB3YWtldXANCj4gPiA+ICsJCSAq
IC0+IHJwbSByZXN1bWUgLT4gc3lzdGVtIHJlc3VtZSwgc28gaWYgYWxyZWFkeQ0KPiA+ID4gKwkJ
ICogIHJ1bnRpbWUgcmVzdW1lZCwgc3lzdGVtIHJlc3VtZSBzaG91bGQgc2tpcCBpdC4NCj4gPiA+
ICsJCSAqLw0KPiA+ID4gKwkJaWYgKGR3Yy0+Y29yZV9pbml0ZWQpDQo+ID4gPiArCQkJYnJlYWs7
DQo+ID4gPiArDQo+ID4gPiAgCQlyZXQgPSBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKGR3Yyk7
DQo+ID4gPiAgCQlpZiAocmV0KQ0KPiA+ID4gIAkJCXJldHVybiByZXQ7DQo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0K
PiA+ID4gaW5kZXggMWU1NjFmZDhiODZlMi4uOGE0YmZkOWEyNWIxOSAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuaA0KPiA+ID4gQEAgLTExOTUsNiArMTE5NSw3IEBAIHN0cnVjdCBkd2MzIHsNCj4gPiA+
ICAJc3RydWN0IGNsawkJKnV0bWlfY2xrOw0KPiA+ID4gIAlzdHJ1Y3QgY2xrCQkqcGlwZV9jbGs7
DQo+ID4gPg0KPiA+ID4gKwlib29sCQkJY29yZV9pbml0ZWQ7DQo+ID4gPiAgCXN0cnVjdCByZXNl
dF9jb250cm9sCSpyZXNldDsNCj4gPiA+DQo+ID4gPiAgCXN0cnVjdCB1c2JfcGh5CQkqdXNiMl9w
aHk7DQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IDIuMzQuMQ0KPiA+ID4=

