Return-Path: <linux-kernel+bounces-218600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8784F90C273
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CB61F21AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8A119B3F9;
	Tue, 18 Jun 2024 03:27:50 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F864D8BF;
	Tue, 18 Jun 2024 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681269; cv=fail; b=T07XxoEo+fOcLnCy15DnbsF779OaAbghohgXS/Zm/i9evqPPzA2qpqBxIc/YfhXvUgPVRqVQca8TGd/HHesUm5BJVIxZ5oxp8iZ2jsArkOW4IyS4apMnFrYZUYfRT26OGJifB4YYXWti7lzAAWeTfTJ4tIXVaEKxfYCcUOXgzAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681269; c=relaxed/simple;
	bh=GJZb0kpWWt1T1LF41c6JowVfME2KuIJYIOi9bWCpWcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rUzft7EmMgi50QVOxYtF7i9zyYIes56YVgE8W6aG2DzLkK+5b1X4ML5l5PnO/p7rl6jk3qiVK2C1F5Pn+HgyNIPyUSOI+AsA+G3M3//guRC5M7zxBfv+MEW/eORSLs7TJrB641waw4r7/rSSSbsUGzqlIfwPVGLqj98lh17MetI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KORBMEwMsV0wgNA11XjUzU0GWykeGzB2fxjj4g82fAsVHQbQstiA91rYeL1X4hGUqZEWUEhQSXgej6iiGoVZdH/ot2jwINvvNVC5RIM9peGl2n/Yv6qfJIzMt5U4tSJkyHkIBBmet8765Jtj6OgvbsX5O67GPnmxHu7OI14EOTL5ryiNpo7vwnumHg0T9o2Tr+iBj55XTfNtVyAHjCsKIsO/yKfLvrO8bDnXyrVUgZzF6oP/8LOFQtlyuhurmMNQhv0pmH2rsFvVK9lzc4M7KPLeHPIJAOAb28fVFN8Ul+DpGGvXWHCb56VXJml47HhpPUtPWjX5TWkYr7peGNcljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJZb0kpWWt1T1LF41c6JowVfME2KuIJYIOi9bWCpWcA=;
 b=PtN3v6HbSmyukC8HYUENl0BClp6ivkrjwq1hl+zMJyTFsDFOMQuEEJgwHYHKBHatW3RQ4gvIH4bBl+PdbChHmvDXkxnU0hiX6tiQU+IqMSDz5FMt34i/JnzQtoJokBWc0pJEKZ9RU7URRLXYPoKokdzew3dj0f9is6+Fk2yUzcO2fWdmF7daFGkdhjImUD/jGWmebXn9HddNzWFVcpBeIYMMP1YTzuE5Q0HaqIA/d6/YiXT2Kee96Tfo4g7IweFfhzfkfMzz39QjJ5OJTKRZzYTN7L+kP9Zs19H1XjKF2SCDH11oEMlbGTAVwBxL1hXWpVnmZb6UVhvyFNuk+Yi1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB7702.apcprd03.prod.outlook.com (2603:1096:101:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 03:27:42 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Tue, 18 Jun 2024
 03:27:42 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Alexey Charkov <alchark@gmail.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>, Nick Xie <nick@khadas.com>,
	"efectn@protonmail.com" <efectn@protonmail.com>, "jagan@edgeble.ai"
	<jagan@edgeble.ai>, "dsimic@manjaro.org" <dsimic@manjaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] arm64: dts: rockchip: Add AP6275P wireless support
 to Khadas Edge 2
Thread-Topic: [PATCH v2 4/5] arm64: dts: rockchip: Add AP6275P wireless
 support to Khadas Edge 2
Thread-Index: AQHawIWUKwv4UGj980e571PV7A8XzbHLtPgAgAAQ92GAAAkAAIABCAP8
Date: Tue, 18 Jun 2024 03:27:42 +0000
Message-ID:
 <TYZPR03MB7001E8C455FBBEF50A49D13280CE2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-5-jacobe.zang@wesion.com>
 <feeb8dcd-661f-415e-be08-afe175d0102e@gmail.com>
 <TYZPR03MB70012C66B789B09195FCD92580CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <CABjd4YyHUzm4EBPPzia5VRXGvJiXDObDHQYNCjpCMJDs=BqALg@mail.gmail.com>
In-Reply-To:
 <CABjd4YyHUzm4EBPPzia5VRXGvJiXDObDHQYNCjpCMJDs=BqALg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEZPR03MB7702:EE_
x-ms-office365-filtering-correlation-id: a13c1d3f-c7a8-445a-1198-08dc8f469d29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|1800799021|366013|376011|7416011|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?w9n/A7xpxq/ZCWIjI5FnrHLaL5t+Fo/IFxyeDPqoJ/Lyp19zAoWCZuHaMt?=
 =?iso-8859-1?Q?se/iVvD/tU/0ZnHRimatKttYggls2es5YxkQCWsFBLymVkFHTKj/iDZngI?=
 =?iso-8859-1?Q?fDDhMS+T1/xrSbcW/qSuOo0SlT4N8OtUwaAQRiMNXIKq4abFehKzSVDAKW?=
 =?iso-8859-1?Q?7LNAj8BVNFj4j6kFnRs9i4v9SBRCQE/koaP5Tw9NihQocS3mB0n+mJsbaS?=
 =?iso-8859-1?Q?V4uyQ8iEYTHkWRZO0CvHiPQv4OMa3Ss2tQO4kAW+so21+DiG8barzrfel5?=
 =?iso-8859-1?Q?+8+0L3qAR4FVcI70nnB40d/FIAnQDe10OatS94RhkL2PLqKp+VfmX3LlnY?=
 =?iso-8859-1?Q?QsB/qudeR9Qyfferz6CgFmFYHhAVrKD8V5TDS3ygFwkGpKrweGPEJSvs+c?=
 =?iso-8859-1?Q?J5OZJpevbpkj9ownphP9ujQN3U9QV1cJl8mudAk69mGrjIqKzKlkL9Zoeu?=
 =?iso-8859-1?Q?+cG4EBt7cdoA5C3NpYVjFcSgN6E7i44fNO45Exksk+Vk6gAyuXnORwVr6u?=
 =?iso-8859-1?Q?pyZEjGkh/1+e0XamSyplM36t+XdO2MSHb0BFlHZh2QKEW2o0PmM3cNYBkE?=
 =?iso-8859-1?Q?b5TiIAespabRmdSMGoiUsIzcW5a5O0h3+TilMGTb2AQo0sssAOicU/Ho9Z?=
 =?iso-8859-1?Q?nAh71s7EOBcBKFhS9qZCDnW2rXE0HrnmbsjXbrezpcWVbD3gMudEfHDjEk?=
 =?iso-8859-1?Q?frVh6HiF2OyZIPM8LEBxwxSh7W9jHdZa5+cKeaY7SPUCJ32qv/8p4uP1Im?=
 =?iso-8859-1?Q?QbC+hu3ddBXlpR2ZQOjDuo/SVjrtzvuZ7Li5iq3snkQCNARccl6Pnpc/3F?=
 =?iso-8859-1?Q?Uq3Br+VvttLEdkcEw2BnyKgHUZScfOnJj366+8AlIyNtezOgg3Uz0oELU+?=
 =?iso-8859-1?Q?5PawO+GyisUMKcqd8CVblkp3XwhifPXdgWH17IRAE1R5Jvrv7uIkxYYZgt?=
 =?iso-8859-1?Q?1+M6C6KRyGEFvSGOMz+TeRli8+KE1X3WT9JnIOu2UWurvwgZGgffnd89XI?=
 =?iso-8859-1?Q?bsk6ijTqPatASsHaxeRyrvq6C7hkOxsqwngjHrtcfaEp3GDm94RZ8EycG4?=
 =?iso-8859-1?Q?n6ZIiaGAkK3DzU+P/F0CrAOOiyI3rh4QVsXovXNGL6QsE39EnGUsbEPqNA?=
 =?iso-8859-1?Q?zOwAhxhNPtO5DX7QeeINteQreEY+ShVvCESzmpyUbCIShuKyOY4NkQQefS?=
 =?iso-8859-1?Q?lJeNZEFq/slu7PR1qgWU+2e8rcS/WqCgUipY4DZhcUXnuhZL8Mqg9GRzvy?=
 =?iso-8859-1?Q?RSo5t6MaTUdqhDzVLPjIyZd3xuSxhhiD4/JkkB0ox2AOJNJNMhz3urzu5h?=
 =?iso-8859-1?Q?iRRx9G78q0NQ+b0XrXMrWg4aHaZbUXRxWIboxOJ9ez8oe7KJIhum/D4HQK?=
 =?iso-8859-1?Q?BFJg+ek8oUaR5sqmfC8tAwpugoAV40rngLXVuMocwxh1yKcn0+4CQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bfx4Z6EfINSX8zHo/B7iyTWXJee+0UkOoPQRr7viVs6P/Tbr6wmkzrBrV6?=
 =?iso-8859-1?Q?v6FBeSMBwCoc1Oit6HKRuCigUiBsnjB865YLSOjGqxg1KtiYPhvu3HKiYM?=
 =?iso-8859-1?Q?4jS7+NVLtD5lQN34slcOG4bN29OUck5wtNdRP/OYZOsxSw37TdVTZd8Z34?=
 =?iso-8859-1?Q?r+mQC/SG0K3naRMBuygv6OyWghhtnfVCVig0fRazR+tPK3SI7oESdniMVT?=
 =?iso-8859-1?Q?CJKd2o7qisyaRFDRtCtQQKKpd7Fk+AovB94FE8qkalrAtpld4t7tFmdcuU?=
 =?iso-8859-1?Q?j3ejZe4bj7/PjUKrbpZqfZcer9MGnLFbS/0y5ne3j/tpsOdLikCyJ1Jvaw?=
 =?iso-8859-1?Q?A80IHZe+quvknDIZjl2FzMH62ODQrFr0GTU99hineKZta64IiRe3fRGVP/?=
 =?iso-8859-1?Q?4uZ0TxCctKpR/oMnONGFRKQNqOmgw+Nh1ySVmGPBBVyGGW1wuQLFu1Sn7l?=
 =?iso-8859-1?Q?caxjU1dXpV7rq9He+iZObHzMBQPapuuAC6OoIEOfTtXqm4nzy9TxPx9sxf?=
 =?iso-8859-1?Q?o6Ha1tj638h5AjHvHa8TifImGjofnlVUDfB+9yWVvFvSeglWuoNKTHcGWP?=
 =?iso-8859-1?Q?HcZd7YjOAeN9Yuz0JGMq2L+y8jfn4MT6fWrmjDKw3LfWCzrpClvBtIK3NH?=
 =?iso-8859-1?Q?jjzBeZudr2A5/iXAIl688/+I9r63jYTeciH7Oy3E5Zvy0camnL2lLv2a8C?=
 =?iso-8859-1?Q?gvv1c/aozTF3+aN16PSxBBv5gROOTtK9UttqoeOBevEZqUDO4vbJFLRVUA?=
 =?iso-8859-1?Q?vV1B087w527bUSLFLP3D2zVgSzDAlwTV5VlD6NsWUECfyG1cv77bZZxXES?=
 =?iso-8859-1?Q?fo/NAH4LshOhuLrmXdUm2aYg7q5/TABFmvMIrWjmPB0phj3ze9TOq1ZwQ4?=
 =?iso-8859-1?Q?SumvPtbJQq3UeQbrQ/jVOZdEjvfIkcPEl/am4JdmudW1UN9Qd4e/Pg7nW8?=
 =?iso-8859-1?Q?ljoCBpzH2gmXQMBQBfsSHIQ58NVWrDXHg9MvldogohiJK2n07LjyCfVYge?=
 =?iso-8859-1?Q?Fvqm4lM68VCG88byoo9hOk2j8YyJ48uW5ergsiRoRvYJrRQl/C8ZmivgKz?=
 =?iso-8859-1?Q?LtIhsQCkWKQqaPKaIv4VTLReeRlrsAMXxMSPStgL05506Ld3XhUoLtXTW4?=
 =?iso-8859-1?Q?W9OIbM9mjQ061ZY5PNeJeWhy14MZSm6piomvWGINl+4SjDX0fLKAD3KeqX?=
 =?iso-8859-1?Q?Aql8nKZrohMlUtXr0Rdce8+i5D04+v0cDT0uh9HDCYGmrtlQF6QorYu+KR?=
 =?iso-8859-1?Q?jQQfWJpU1SuAkiYeqM3oa/FrtSmbcmewfLQZBzQhR24uCdCnrycA/KrV+u?=
 =?iso-8859-1?Q?P9Mt13qTK4bZgacWf+Xmz9v6ScPrNP6jvmNkNhoyaJDS3ocJanH+v6nwrq?=
 =?iso-8859-1?Q?nsNTxdA7Cs56P8r4l1jSHRFbkVy4KKMFGZX6qqe89yVS2oUJcvc2OCryHi?=
 =?iso-8859-1?Q?1xKV4Dk3HkEAgvs8Q3ng/UhqEKIGoBWlSkxPLlB7xpf40nU5Hr5a/7eUAM?=
 =?iso-8859-1?Q?4+WfucnGwzJraXyM/iv6y+XYyNV3knLojNGfzmpjr/0ssrFzdodIO4iIim?=
 =?iso-8859-1?Q?K6XYk+5oTGuojD2a4iJdsm2yHDkNp2bST37fUgE3uwENCcgvhENu60bn5J?=
 =?iso-8859-1?Q?cUPh9Rbpaih0VL/9X+mc676/lGfGV1fc3u?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13c1d3f-c7a8-445a-1198-08dc8f469d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 03:27:42.6414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZRDyWlP1GNzKj2hWcZdtSVJ6OHWAAan7LtRYA4Znb71mTIUmRSNZNh24SLHgZc/R4ZNwQD/jjKKP1K5fuu1uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7702

> If your PCI bridge is functioning properly and if your WiFi adapter is=0A=
> connected and physically enabled (in terms of power and RFKILL) I=0A=
> believe it should be automatically discovered and you should see it in=0A=
> lspci.=0A=
=0A=
I'm sure that wifi@0,0 node is not needed. =0A=
=0A=
> I'm not sure your pcie@0,0 node is needed either.=0A=
=0A=
I think pcie@0,0 node is useful. I have tried to comment it, after that Wi-=
Fi works properly but bluetooth can't work.=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

