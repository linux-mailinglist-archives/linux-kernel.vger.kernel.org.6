Return-Path: <linux-kernel+bounces-217204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7578190ACD2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D27A285BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC08194A7D;
	Mon, 17 Jun 2024 11:23:03 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A801946BF;
	Mon, 17 Jun 2024 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623382; cv=fail; b=aLaiOg5bFBG/TUAxD8K23+IqmoxKC9V/+aNCQ3ayrqEbZHMXhgWVOO03RMCfXeh12TOZFyHEhQeR+fff1LxigFW3QpbUOjSi6uMd8mThECR27zyqsxZt+lgsUs/XBCXmZ0YzPrGeJEXzO9cwFLcCef1d4emxdTDOp3ZZT5Y9iCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623382; c=relaxed/simple;
	bh=L/yMYKkmBasibPE64MnEXw8YQGZAVB+XJT930R96eH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dn+sMy/wxGHayzh8L1CJo2rx9iU4AplvYocQxoaG+tIjf1kYDf2pYIv0CVn7BvCKZaiyVegcbAeWnznliQUo15uUYNaICu8ebKaJCq5N1js6BLvkwdH++zUiuswMGxbuqY7AZzqgohOGFLedr7l21RKUzySxMJqvZMUioyJcWcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHJD7DWPAGu2w29kDXKmj5NDrnND4bnEOr//wGsUiNWUnuQZpzFxnD/B1gzpcrSZ2NhH7kW/Q9Ky57pPMtVfd/8Izjm0pzF3Wz1TSaUVDfRRdixIyOZ4IGvUUCYFeZqwb+iQObRBLln8g+b1jF5LIJyGkiPeGb4TKH1KCE+ITX8hOqI6duESD8qe+ePTFWClWPSxhj95RlK0tmGoZxNzAq+7Z3IhJPve5XH6bO5HYgooqk93GW5ReqgCZTgQLm+UiqVqyH+x9GB5BhvgHS2Vp3Oobz76s57aF2a2OUnduZImHYzYk3AsvVZG1MkB5xFjgFzEp3oiPAXV6NcGUVjl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/yMYKkmBasibPE64MnEXw8YQGZAVB+XJT930R96eH4=;
 b=TmjSzcWFFQPfqoK5LP20DK0B5IDw+a/N/D0r2bcZ4BklpwCBUiCaX+DP7O3XqJd8i3TvzJnoWdCJvXRAEwf9hwmkyKP243CQWHiXkeVDvpyYeNvPkB1DxkJ5FbVvXaKOhm/WbFZ/X/yytiWZqJv+2xNAhL8cp1Rq8Pigu8wBnKqaKmGfl9tSmRHOiNR1HGDTycoLBGHiP2Hd0H6K/iIoHD041wwTJGFjIjWy8FJxISUJ8NhFrAJF8KocHNLjo5oJBfpvh1oexTy/7qTcuReWWazBetMdyAlYZpsFr97Uh044CwMp4XKk2gYKjpZAc/bpLRsm878ZNCBmYIH4wV/+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7937.apcprd03.prod.outlook.com (2603:1096:820:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 17 Jun
 2024 11:22:57 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 11:22:57 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Alexey Charkov <alchark@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>
CC: Nick Xie <nick@khadas.com>, "efectn@protonmail.com"
	<efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>,
	"dsimic@manjaro.org" <dsimic@manjaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Add bluetooth rfkill to
 Khadas Edge2
Thread-Topic: [PATCH v2 2/5] arm64: dts: rockchip: Add bluetooth rfkill to
 Khadas Edge2
Thread-Index: AQHawIWSGno1qGDO5k+YxfPMD0x/C7HLrc+AgAAGRQWAAArwAIAACnfW
Date: Mon, 17 Jun 2024 11:22:57 +0000
Message-ID:
 <TYZPR03MB7001732D8E2F0921BA82B7BC80CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-3-jacobe.zang@wesion.com>
 <f147be11-fc35-44c2-88e8-7421fee47ace@letovo.ru>
 <TYZPR03MB70017A6280F060A6F4A1DD9880CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <a25472f5-3e88-408c-a033-5e338dce6340@gmail.com>
In-Reply-To: <a25472f5-3e88-408c-a033-5e338dce6340@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|KL1PR03MB7937:EE_
x-ms-office365-filtering-correlation-id: db6b8349-f78f-4c59-1f08-08dc8ebfd6e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|1800799021|7416011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QxD1fZDennjY75yTWx8FJ8Dpj1pbyaiQz6LgjJWCLW6KXeq6fd+OTHwXlq?=
 =?iso-8859-1?Q?J+Yx3InoKDDMsmwtjyRsBxppiosxp7cwuhuBf/25iDP+u9iKe/LQEj+UVX?=
 =?iso-8859-1?Q?/w0ArK/BKv3D6175ItdHjHPDALsw7jT8En3ZmNTnnaNM3n+nAhnrYxHgS7?=
 =?iso-8859-1?Q?xeeHmpVWA078lCA+zSTqx24odvlNMbR3/cHZETw+Axw04BaxtZK3ecDxKD?=
 =?iso-8859-1?Q?dYVEv3czceaQlX5gNk1DKPFVRZl3XGGVxxkat7Gcp8ew9Ng6EfQXyTcHi/?=
 =?iso-8859-1?Q?SAWrWKk8cPcpJHzWe8IOO6uS65p2uTWmsJOpNsQEfB6qV59a7ON+ss5ItW?=
 =?iso-8859-1?Q?XNQyIHYBlP0npt2EdftsQrVRY3oQ8pSIqDv9NwpbPg/LCQPlFyitS7Xa75?=
 =?iso-8859-1?Q?PxBfBKeDtDOG7tFQFquhoCi1e/FjPndNEpnVKAvQGu/wVM45cBO6YRl9mW?=
 =?iso-8859-1?Q?OT9eoMtJjMi32yt6Gl3Zdp8ng+BTC5xeQmnk7M1wsq2Rm3nrbeHslCMUIm?=
 =?iso-8859-1?Q?xoBOeR3VIephkuPuiBaEYHR3c2kVVq0KteI7Y57C+qKxxxNPMOlVoqN2q8?=
 =?iso-8859-1?Q?f7UHS36S4L6QaEf/g8YB6rbpdzr97jTOcUtSv4jCO6BTgqndcdFAgIuX/U?=
 =?iso-8859-1?Q?Oo0k4LXpSqyiulT06Qgj5nE8N6+u+CWwRzxSUwFEtwYYrb6aEdzEAlvH3D?=
 =?iso-8859-1?Q?KXf9yIDzrgN2oKTyuy0ahdfDmiSCh54/SybI5mbV7OteK750Rdullh+25s?=
 =?iso-8859-1?Q?xgkND1t184p6m3G2/TraUasvcPiC6ypzOMDowktQRwPbWJe+pN/KSig1n+?=
 =?iso-8859-1?Q?DCZfx7CWvO000D4FQF+A+9hDuHDYjQbnbxLQDeMO7IYWTXHmxg1Q6NBNpc?=
 =?iso-8859-1?Q?6fsK5huxYpocRC3FEWsjUMJ6HoUZGSI4sZtd0d4e3TppG0fAOIIu27sX43?=
 =?iso-8859-1?Q?WwgiRbVSiaz3GRKWFDDtLuMhiiVo1miR04yj1YRc/EdIDMkK+rprHKSWMJ?=
 =?iso-8859-1?Q?qKF9eBpgDpaS2NO5A3Aw9iMtQVcjB3WaE4hxcE/TGQgBLTQFMKhuHv5I3d?=
 =?iso-8859-1?Q?faZAeRMT/SJSEh2hiAZQ2luyVbmxOTvlRTZaJgo5EZLMYevWdQ+ok+FWVO?=
 =?iso-8859-1?Q?uxFT0cCqRHEmusxPKxMqbHbOFkY4sEw1k+vaHgexmwwBkP8Dn4ISf/nPky?=
 =?iso-8859-1?Q?ln8POXm6nSkLpL1VhGmtmL/rQa6SbBsYUfH9pEwnTVmPNHjIKICCuyg8SC?=
 =?iso-8859-1?Q?/6Qyz0HO1sgrGz46zAoBe/lUsrJyVUtK61MDk/CaNehDU5BF4Y0K4kGc7K?=
 =?iso-8859-1?Q?DWrgK5glPq+z9zzZQOhIzPGRcu5yzVNMqUvcgn+iab2SQQxcsswh9T7wLS?=
 =?iso-8859-1?Q?7L5y9Av08VxZSKxByDHffru/bbTXmR6+vneA6dOG4T8WtRZUIm7gk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(7416011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CTYbmoslli15f89SNUruOwfnEdFOUDUrC5Yiz7QGwgMjSz/dLd3r27MJEv?=
 =?iso-8859-1?Q?6yU1oxB8YlsFX4LwInWvr7ndNoncbSfaI8n7+1kfe2In+Bv+37f4kRSwcj?=
 =?iso-8859-1?Q?61TVr/9hNR83InQKlEPUFTNz+ODjA4rLyI/FFT478DS/O3rgcbN5A6Ws/m?=
 =?iso-8859-1?Q?eyse/1Dy1Ndg1ksJHxRE8/i0vBUDRALQwVKLWoQwRT3U763Gl4FhWi3xz/?=
 =?iso-8859-1?Q?9fA1nKgkxmkftNhFeqcCYQJEQlZCkUwJy7BJgA1gNcCXVNueTXzixiV3p+?=
 =?iso-8859-1?Q?r8zKyYyT2Ri7R8Dp2ElKVOZYwQQeOn1p1Agne2K6r1JbP4eehIm3IN2rPk?=
 =?iso-8859-1?Q?VZ/p0RSvMbF5fvns3HxQumdYsFgqWmdWm/O1j2qlSOLHS6gu9eRGJ7cVP2?=
 =?iso-8859-1?Q?VIau0GoGhZ8Jq4PrrC30RQtfH1cmH5EubC5TzFlq1rvZPRc7isQXl5qEXy?=
 =?iso-8859-1?Q?i4DjGY3rlaEvV5CmlTkgtMDy6WJ2kYwEBiWPUU0TS7woPyhSlOqnXkREce?=
 =?iso-8859-1?Q?kib9MgWW9ULDBGdKsRcwL0n06yMqNq6IX138XPYQVmxMyZJKUpyDA604hv?=
 =?iso-8859-1?Q?swzqJ9Apc5odgEp81X4tbdeohdyGg+W3OhBxZiurAEhSh4FnjwAiKwJ3dW?=
 =?iso-8859-1?Q?G0151w4zqqrekN/izofKnfaEPMeB1jdYJ9JfPc0slRS7moO7/MWI+PZgs3?=
 =?iso-8859-1?Q?ds/5/2OzQ2t/JREJB8tOa0dWpz9dUWBHMwFWj/kSpscqRW45JAG475leOQ?=
 =?iso-8859-1?Q?eE/4f7cxOnW6tUTpX+TrcMwCX0Kz2zFTfLAL8ipOnicxVOKjiLiyX3V9I4?=
 =?iso-8859-1?Q?K2nMUrj/57Mknu21PhfHpPLlzykc6+ygzYe8nGb4bTRSTXemXEmrclrOqI?=
 =?iso-8859-1?Q?5P0eUXx4Ll1TyEUWNcXMktJo/hZjV7dJJf+K2P0HvGFV3zHCb1XEqyfI0c?=
 =?iso-8859-1?Q?+w2eR9PFlfnF27IvgLtlascryziMeE4Kz2r5ByZ2fjy54oXhUS4vLSfSY2?=
 =?iso-8859-1?Q?wS2evy77MfvcIrniTgvPa7vs4Xpd7j3xLem1WZJ5IPlZXweU47jUV4EcKF?=
 =?iso-8859-1?Q?ZMgkuAD1dna19nU7cecGpP+mbnwpxibOcSO6UJXFr6GGaM1R35/ExDB5Jk?=
 =?iso-8859-1?Q?ouAxWlgXDmuV4QMU8GwG9c8UdboYpxZBpja26gJe5e6uAkNolH7/2QQDdr?=
 =?iso-8859-1?Q?UevTGQ89E+aC3lxv2Kw+U1j1clBN6UENkJcAGNbCSCIvMjEe6j6iMA9J+o?=
 =?iso-8859-1?Q?e4yR1E9cKsrfUvrKb3JvAp6VrTS//MnFXTzKptYSVv9GmDuEfQ44/dAjg7?=
 =?iso-8859-1?Q?19RBgJdzvUa08BLJnL8pgN1+HaWqhMiNGirfThg2c4qG+6RP+/uc+gNL/q?=
 =?iso-8859-1?Q?C5AUcBjn1jRBXFnDJmK8Q8CKFVQX7MQyOqQkqGOzQPB+k/nQkQh0Kc8a2d?=
 =?iso-8859-1?Q?QFacsFyw4ljZtxAW8LkiSfHBOF9jQelevtiTAzH1ChiyBO/nBj2A3pIH+l?=
 =?iso-8859-1?Q?1eQ8D0UtNFgwiwHAfo4gASwq755v84UlkswLIMU3W2vtiCER/kaKgXWjZN?=
 =?iso-8859-1?Q?CR9jLobEf8iN5ELJP/utnfmWjLSFdJcCOuJPWE85g+GgUjgAH6fAFgVJTy?=
 =?iso-8859-1?Q?SeMLfyYvwPv7M4NvHWMi7h6uHgLzca6GMR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db6b8349-f78f-4c59-1f08-08dc8ebfd6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 11:22:57.5228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JqSU6mJkF73BEcPkzw9yp4fD2DJCf18BwmvwBmCyOka8cPEM8Fp/GU70pj7J9THN5yrUeVsnFlEwNigDbyGyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7937

> If you already control this GPIO from elsewhere (such as from the=0A=
> bluetooth driver), then perhaps you don't need to define a separate=0A=
> rfkill device at all.=0A=
=0A=
Yes, I missed the error log before. The rfkill driver didn't probe successf=
ully. I will remove this rfkill node and reserve bluetooth node next time.=
=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

