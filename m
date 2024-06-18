Return-Path: <linux-kernel+bounces-218562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F2790C1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5942F1F22660
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8619AD9E;
	Tue, 18 Jun 2024 02:46:36 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516E179AE;
	Tue, 18 Jun 2024 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718678796; cv=fail; b=L1imzjTB9geedCYcC+RpKjTCeH7xglA4acNtYzhnaWCPcvTg/yJiDu6qVlIOO9t0CnIcqwaBlGM3BF3MFAro8X3zK3VEio5UkeMFsudAZQP0KBtWonahZ2w7haONB+FVKVE1zqXIf2v6FC2w9QNoSmydgMPOoTogTvrmLuT7huA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718678796; c=relaxed/simple;
	bh=S1p71wQ6DKFkcffIuWc3bwQxls93mmWhft1NovVF5qM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k4MVu/W6+EYLXF9nfgaIIO+dmiqKLm3tJk9kPIRJXaamml0eAwyS/l4mNRK7qs0CjVos/Y5lqsdXLf/cj+3hbjJxS65js7AmYRq7mzuNd0hOprU2L16jbrAEqysvADp8ucu2ygT0wv13weDIY7FuZzEltRd8vS1lGrb5Q1Kaogs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEoa6OSfBgBGNl7/LYcZivdoOBHMolHEvUF9ALbQV7YevKDudkyBNzSUX43XTMxFmKhZE+biUT4ayMxOplFBllW5SL5OcTZFB4hcx2eBFo4uF+phtAwB4KBRcTLx5je0Gy/zUeurrjThiDQUHZLiKPsvSLts73sp4XQeh7RqxGW5sSnn3hddsOiaZoqOXsURT+C35JkvIyBUwlhYUju63e7gIFBtQETMK8Av2CtHgXQ+j3ne/zmrd9yswUzOlKdgWD5e8t3lJtA2+AO3OcpS6zLGUGsLTe+Trw62ahFCKXLz2Bbp2QLTJ6Wujs0qTsOK1z3vJ9E2gKUX8sZA++J7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1p71wQ6DKFkcffIuWc3bwQxls93mmWhft1NovVF5qM=;
 b=CcX0llbuXweyx66vO3SGHZEatRVj35fWhMO5W1q81oSlgIRil+w8wcBmz2KCUnV2RprUmJrP5J+ew2g7cqPBFq0KFW2ZT489n9BUoCNMirxM1dOlaR9PGSpk0+EZ/zVWQO2gd0Vhmea2I3IHiPkVx1vsjdanvNGNb27RwLItWbvePjGiS17q0MoX3bXoGRMEigFMjUCgoqfjSFW8TWGZWBjlr1V89ic5pbC8ZAxhPTWxUdnf5K6MzAi8JS8qC17fofuF80ddRRwOxHmqFFn+8Negq7RDr1cO3e+E59A3Uk9E322diSGbDDOrdmoPLhcUd3ES61uxL8/jqDJ5bWm8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8287.apcprd03.prod.outlook.com (2603:1096:820:10f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:46:31 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Tue, 18 Jun 2024
 02:46:31 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: =?iso-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Nick Xie <nick@khadas.com>, "efectn@protonmail.com"
	<efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>,
	"dsimic@manjaro.org" <dsimic@manjaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] arm64: dts: rockchip: Add HDMI & VOP2 to Khadas
 Edge 2
Thread-Topic: [PATCH v2 3/5] arm64: dts: rockchip: Add HDMI & VOP2 to Khadas
 Edge 2
Thread-Index: AQHawIWTOKEi5OAZqkeNQSj3WmLAerHMaI2AgABmr9o=
Date: Tue, 18 Jun 2024 02:46:30 +0000
Message-ID:
 <TYZPR03MB7001E6413C47535F2CF7102380CE2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-4-jacobe.zang@wesion.com> <28646794.czjnFlTdjD@diego>
In-Reply-To: <28646794.czjnFlTdjD@diego>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|KL1PR03MB8287:EE_
x-ms-office365-filtering-correlation-id: 25c10ae4-6ea9-4904-d9e7-08dc8f40dbe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|1800799021|376011|7416011|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KOgLVEJIj44rgNWDpecT7kn6wvojKdWWE3D44dq4FWfKWnjeRgMsfksZKG?=
 =?iso-8859-1?Q?k66knZiK6VzR5ZWp+nu9dH/dcmNC/qAJwXE2NaPgNw+a5D33WjkssbAq3e?=
 =?iso-8859-1?Q?ugQ52Kl7t20uP2DM5dU4e79fI5216GERK0jeYJYb6M9l+kUt7kIZvEk0od?=
 =?iso-8859-1?Q?cPf+ecNqfUI1DdbIjAQazrIxB8Vk+EqlUR9juHYOowJqJH+YROr3rGa6EU?=
 =?iso-8859-1?Q?zuHgn0UdZzbGXh/7g6yXDc9pMqmbg4GkSDg15CsoGKnkjeJXKF8t7pMoSq?=
 =?iso-8859-1?Q?Hgi2fyTSu7AfE8thJUaoCc2YUHKPbW/5iUpFvY7FLMUcRpZoTdJ3N9wjhV?=
 =?iso-8859-1?Q?BZL65T9KqL9SEnVRNuh/gwmrQ1fgJ+ymsDzlLoRABU6+p+50TqgWE67Ec4?=
 =?iso-8859-1?Q?pGGdPGABFg+3sImtOxAbQ/238JhqtlSxs7Co02f6wHjy9YMArO87Vojhaa?=
 =?iso-8859-1?Q?kjG5y3sy7lYcMVxD5+qBjQmmvx0cMOkuIQibf3t4BMnvnKFFzSwXuJ1kIm?=
 =?iso-8859-1?Q?DIqGNY0fInKFCH7BMKiDSpFkrXTULEaDN9UnNxbritOKdD6Gf8ojOITAiN?=
 =?iso-8859-1?Q?IZU5SpY8pDk4nt9b3fDK4a/fBrtWuiC9f9PxzxY0gauwy41wAos7dmAEp6?=
 =?iso-8859-1?Q?3GQrWFhwD2obrDQ3m1kofbLXPCb2ysu1S3BaVssD+72a9I5SgxyW9XdNuS?=
 =?iso-8859-1?Q?k7fhsnYiv4F4RpKIqZCnfWeIfV61ClYoI97GWEJ4ResU7F0wm8Oo3nLAMg?=
 =?iso-8859-1?Q?4AfXPbmZUG4KLaRaezp2oiCo2fQVQla0irf3W1Hs/rCNSd38+O/NhHJdjM?=
 =?iso-8859-1?Q?RCu+tWhShpL/0Dh5cL5VkuvgED/fThVulIUsmY2Xb8EhyRzWEj34Z3Iz8i?=
 =?iso-8859-1?Q?CbqhSdSkKyXuHp9NzWTyaFVKrBvVkNKp+H+UarZ7uiPqpI9eyJneDKrPuU?=
 =?iso-8859-1?Q?y6Yylk5Uu7rShqZ5tqq2ykGgPB1O0rYOeHARPgH+1Yu5+zGQBAd98WxGM9?=
 =?iso-8859-1?Q?Wvwl76qP0834snsRUjT9sxP2HLauiO7CAVhM2Hm4Le/5m4hHoWSIp4Cqf6?=
 =?iso-8859-1?Q?xEBXbIw1DiJKoun8GJyWtaQ+gCcqahX2qTg5tHMSb41Umz5lzXUHqeEZ7V?=
 =?iso-8859-1?Q?Dm5VROP4+xjc/MQNZbdyTGpIP5L2l+wgf+PuQnjQgnmos3AB74PkBimak3?=
 =?iso-8859-1?Q?Y5/2omLu8Xm+HMZcaZZeDyB/0rkRuJgBNAtPpV5wda851ITL/8wSPh1klD?=
 =?iso-8859-1?Q?OrAug4vO2MjizzK+azr5j9nKhs5D+6wkazASHBi4gkHfd5b1sLcXsMW6Lg?=
 =?iso-8859-1?Q?3qQ4ZM4lL3I9V6PP8ADuilxEctfRCO4MfvF0DgLbx43JBwCyQSo/Gzpit/?=
 =?iso-8859-1?Q?tkDVBpPybmeF7qJo3+4MPuy4l2TxE9q12bR9+qDO31WU5pRnkkF9w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(7416011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?79ZWrvYBv3aw16E17Be8UnMJkUFFN0HUfItrsY6HtDiQLPjUdKi4a8IRx7?=
 =?iso-8859-1?Q?Rltdx+dU6nohdGjix/ZAY+oa3LkFofLXuhLkbGyPg90kODNmQvKipxiAit?=
 =?iso-8859-1?Q?GqhrtocKV+zE7zK7uqUN3ILZAADn/Ab3DkPRuZ5W2hNZFMfmQSPzxFYmqc?=
 =?iso-8859-1?Q?/J8I2BUjLfajjWjNDgy/HNF39b2aVjPdjvCzBggRPd0AUBFM3SjzizpAJo?=
 =?iso-8859-1?Q?fITNAVCwT2Uz+2kpm2SaRu5EQwBDON68Xqpx1H4HDVNfi7pfSadi0FgID1?=
 =?iso-8859-1?Q?uLkns/CGnfUqhPoONr1W0saTTnncEvzzxLsZuhVBnlJkxEbU/V3+ISK+RE?=
 =?iso-8859-1?Q?G7EqFRmr037c5p5Oqlp0maNllKk42pg4wYabFJGe2RHpwZpRERl4tA65VN?=
 =?iso-8859-1?Q?0UvTOh3CRW6LNIZLNb05WeihYdltc5siREr3D/yS70TSCoeEV4LWWMcjwA?=
 =?iso-8859-1?Q?GraxZb2I483vez9VKYpXIi6K+gbctpB3aMmk3YA9fz3aXkbmhJshMwTgRv?=
 =?iso-8859-1?Q?gFBlyY5uune/IIpEqw0YL5p+MYvvWu+in9qTmOvRW4WP4acc742jWflDFn?=
 =?iso-8859-1?Q?Vk+nJrofEDN96atBwniDnlKHgyWrdh708O42XWBncaZfIGOXjWc5REavWk?=
 =?iso-8859-1?Q?JZN5lxoMZ4yjz1jnamjJ2FHUjiS53G+UexE5f22f4+ykchBMfNn5Y2rQVQ?=
 =?iso-8859-1?Q?jXXR3tOQk38Cn2xHOh1+yhj9HGxEzoh6f55kNHeOJ+VFjpPW2hlBK5NlNK?=
 =?iso-8859-1?Q?lxo8/ppJAf30ESbNGowe9EWObs+3z4On+vPkOTKvX6NYL0jqQ44QTDex40?=
 =?iso-8859-1?Q?CxNRh01ZqODrCeN8r7x7/dL1dZXLXe0WUYCdwHb6VfQfRm8QpRQR6mbUTm?=
 =?iso-8859-1?Q?CDg7tBAoFXMHwZG7kJBeNQACGAMXeNhfLfXQaa63RxRYLM7Lykv4JTGwem?=
 =?iso-8859-1?Q?SEiqLEMdA4SM6smx1+VWLjML1EBTHoe9fLctOMkXttRfSwP+vluxNA8nz/?=
 =?iso-8859-1?Q?UVhCMMz+Dq1LGouIpIPmi6mpXYLxuYc+xOEyPpqvtZRXMMocRProb0usId?=
 =?iso-8859-1?Q?DoGayy5iEaUcmDKVRobhQkO85lplNP/9LuaFs8BFbEXuZA2LwA0WYPFM3m?=
 =?iso-8859-1?Q?uyN3a7q4afPyHkIRkoSKX/UYVoXZFPinwULFO5vsO6yJHVujBIpf5gcrYR?=
 =?iso-8859-1?Q?a8Js2LG/YcKZi+KjSl3hAaND/4NiKgU6ocCLB7XaLFrjvexgoqqtZd299o?=
 =?iso-8859-1?Q?1KFvFbCQXlHvZsRugFBTQdk7nfgfggDIEeG68XxDZGn3P/+4QEOqipbRa7?=
 =?iso-8859-1?Q?XSjxUXFtd/lQyksZ4SsXBEHz5ijNiK9ojLafqcn/nbM8ynGqkrpdbtG667?=
 =?iso-8859-1?Q?XFohNSqsJ5VNjzk9PjBuaMEcP/2Q3deIqHRjK4aGzsCDcY4V+YwX0xAy5t?=
 =?iso-8859-1?Q?rS2sMDEfXSQi8p6ooLdeVMR0HmkolaJNP/xxgZFzTNelt2VXJh5fQLWq+1?=
 =?iso-8859-1?Q?B656ihqxbnW6HFXv8vzsGn4MBZDR9Y+4b1exWiDaSkRfDB5p1GDYMxwdeG?=
 =?iso-8859-1?Q?X4WIIyDbRqSCMsue4Kutm1WvBOnYWt8r0fTiTXrT+5n3MbkMCF3xigeAsI?=
 =?iso-8859-1?Q?dTgAK6A2MXrcRuidlx9/I4J4xaDoXT38kP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c10ae4-6ea9-4904-d9e7-08dc8f40dbe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 02:46:30.9871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwrhCI623/KE89JmGypm2JOakgljtV9NHbAHHRq3QdX3nIFGopSHy1cw/Za0rpkunYOHUmOjEIkVkba1LYIUpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8287

Hi Heiko,=0A=
=0A=
> The rk3588's hdmi controller was just posted in a v1 and from=0A=
> comments received it looks like it'll still take a bit of time before=0A=
> that is ready to land.=0A=
=0A=
All right. I will recommit after the posted patch was merged by mainline. B=
y the way, could you provide information on the specific patch or share a l=
ink to it?=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

