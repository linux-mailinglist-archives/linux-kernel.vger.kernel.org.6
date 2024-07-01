Return-Path: <linux-kernel+bounces-236058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367291DCF6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C82DB2479F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAB113B597;
	Mon,  1 Jul 2024 10:45:31 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096912C52E;
	Mon,  1 Jul 2024 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830730; cv=fail; b=nfjo72aCdvLbMD8nZ87pAHcEgSsLackjh37V/0GBBEOopLcz1wYBpzeaRt5WjVkoLDnvdtfHrF0E5UU820KNBGylgek1kZnc1uER8HcIf37OAAZs6E4Ci+0vuUH7rEKTCGpOb5Q1HBViwt3WOF4tXQxMEWzVo9+/QeySMRsbXfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830730; c=relaxed/simple;
	bh=dO59LVyFoq9F7uIrwRjFkBZRaNbX4SzAUkLLfR41XKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CPf8X02q1vc0jVVg48oAD3kkDPht4n8KWcWKGoGxqNPpty/iNs01LvcEBMzHzka/kF71HT16VgIXF642RSc/w+ZYXM4eECwa3jCdMR/yDWAnccTNA7AY1VAEERd83HMCRRXK+/jWFPLMtaIy7KHYlJuudNm2U8fYeF+tJP0MnUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlV72AwgKcCzVgv8w2WmY8V86NQIJXPQgYEk9c0ecuaRCpwv/YUFlMcZvD804kl866ORwUY3+dS1BdXGJdU1YcUCL53HSawjLKKz+JgRgzVPo5F419PjeUS/T8a/T0NnDCbe5cH0vWVlxa7r6Uk8TbTDDsTYUOq/LYxB65Bgo7Xiy9Oxo7/dGFF068Jh92737OAP7Mso5GJDGc3Ud55ubfWDzA3dYzuJ1X4bzdcqYes3wNDAivDJJm7mpz6DQTRJAhVxuRimIanOoZ7DYyZCOOwN016ZoBMM+8Fk61FsDBi2gLV99kSL5Hg4vTX+H9+t5II04B/Tg87X5j8kh4LDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fpz9VwyVTaofpuBmUrXsl6XcCbmQlFKIRCLGA5iJ44=;
 b=DdI12TnXG7y+aM2jmUtQzuHdT5i8VMsTUhqEtTtNHpq5c2u4upQBwSsBXdyXmlyY/Txg8df3jWB2ioQgC86XA3FtGa4SMkIoZXYkw2Uw1H4jRGC5uSjAXd3z8hG+eajllkJgbTOQRQ5mZTEX5MEgytDeN021VQweOTA2nYlhBHdPHtQyAa9SQ2LA6RtQkBp1ofV48DBq6wjZADyKj6SlNX2f1O1psxw2MZi61x0uZvzjV/V0CbYzBL8yotrxsf5dLSybVDO3jYeAVbpfQCO8gF0d3SpyzdZ//uJSWlRFpSMtDcCEX528rLyd5yhPevuHNib3TxGOIMGVCMHeSrX9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0814.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 10:45:15 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7719.028; Mon, 1 Jul 2024 10:45:15 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Rob Herring
	<robh+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: dts: starfive: add pcie1 on the star64
Thread-Topic: [PATCH] riscv: dts: starfive: add pcie1 on the star64
Thread-Index: AQHayAObtie3lKGpSUu9x20651p+HrHht3rA
Date: Mon, 1 Jul 2024 10:45:15 +0000
Message-ID:
 <SHXPR01MB086332671CEBE2D0A21ED695E6D32@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240626-traverse-excitable-a1d9be38a9da@spud>
In-Reply-To: <20240626-traverse-excitable-a1d9be38a9da@spud>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0814:EE_
x-ms-office365-filtering-correlation-id: c70de35f-5a38-406c-b2db-08dc99bae482
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|38070700018;
x-microsoft-antispam-message-info:
 e+uSDgvOzdK0V2HVD3hDDlXPpriRnQoHRCXvgyRM1LlyJadCfYpHhM2JX3OTJ4OiqAVAsM+/12dEqt7FUghN9+Tx8eeJu8MAV3AXHsO5kQg24Qs4erP2pZHwUwJWaMdFjLRBljxmTLl6M+PkQor8IwZUHjaGCciuElC9wAFwTRgz6cKJAueiRadFo9tyB7k7MiFKwXp2NW3kOZ0GmOcefhovOaHmmRwhcMCPr4QSQ0sHVpTWuXMgxHijkvTnDJua/er64DKtlfUXV0MRwasuwy4s23tQyzDTwzNmBP+AaFyv0gbyLCRmGB8Ryv+zh4RbBYp2h4L0jaOJXpXL3EencE5ry3HObkUoKaeS37lmDNGpf6IE4vJjeP3OwTLWLPSngUpLciwfkSVbsX+cYUBQULwh4B9cUirhY5W+8Kv6bAVuuiCeLyvQcgvxJMNEVB/0iejZidtZNrIMl2z6FDg9+ORCsaiOfmyqQbNBxYbOMLcTlCWQvoTkqclm5cXKi5RDUkPZCnYK5qDGfqBXTVmc/l5DCedJ1KDRFy4YUzwcZQ4ZyjuNUXD/yMuZI6ckdOYVq8txDGVp5MK/nnxJjkw+MHMs0sQ8AbIQZJ/mRiZHeB522/rFT7oZJTEQp8HkqFLR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lnnKcDHnltCDzH0pxRKkqt25TnKqxw4l167wqqN2fxgbHxzHNIbsi8b8PGNJ?=
 =?us-ascii?Q?hdzkcyTzH9/vOqTBYZANUyRrrSu6J1vDG0i0cxYyKFepYKciglqzEYRTA0Wo?=
 =?us-ascii?Q?4NnJYwi05icDBvnNV3g1qQ9OC4BnrHYZ9ArJulcikagwbH1fUnTtwMpnKPPa?=
 =?us-ascii?Q?96WV8sWCPysTXU7Ll823vKtg5+HTSxeq6g4jnRMDgZiuGDrfaP9v5kC8qNro?=
 =?us-ascii?Q?pvlZzdMFik3JIBuTM735aoOQZjQdQPWJFEbAKmr3G349ZdjYwss/BPHB9WWH?=
 =?us-ascii?Q?t8f8qm1JGoGp+kN2Gu3a2ze+FAeQalMPE0+X7J5m4YlWerU2baLBI0m1DlaL?=
 =?us-ascii?Q?v5QXUfnvXRrm8tLgorCJz4VMygeKyv4zlgn7+Z//Z8nlD1UV0RMS++Ag2tAq?=
 =?us-ascii?Q?I8Wsg21WG04TyY4pJDoG0pq3unYm+lb6rZHBtFZ06W98d76eXHcE0pPs9GbL?=
 =?us-ascii?Q?khcZVI8/x7105LjkaFrCRmnL3qBt2nc3w/CMtoyBLdJJ4WfCdk3BO8kZFOMx?=
 =?us-ascii?Q?2EkNwj0iDf1POoaa9FfPizBOVLtwNdeb6Yhec0kJRUbcLGAmgMQsU0ocN8LZ?=
 =?us-ascii?Q?PypVCFnC6FgOV6d16ZZCA5coaZ3Wet5vEkUnpZzFfVxSxrl43D8c5BDGesgO?=
 =?us-ascii?Q?wiKiItH9+/3Q368prSOyRN4ZNFDJ5daebg41xVWbqKTtA+TTBCOTaOVNnGIN?=
 =?us-ascii?Q?fPWKj/Uurid/mj7waDLkvjF7rMDsnZjNSPPSg2am20DPADlFMT247p1VL9Hh?=
 =?us-ascii?Q?gvPifl5LnzPrrnr3sV6ioNl9W2H+ZsF6I24sTY+wFUzZGbosPJIQdFdHstfv?=
 =?us-ascii?Q?nE1NXKu+/dBOoyIJ9Iv+HIbBRZq656W3PbsUqtOULc2SPztoQXk0iofay9q8?=
 =?us-ascii?Q?z9EWn3ue2O6u7UdK6ComoTI+6Cq0PyZYX+xm7ii678ftcan2WA9Mo0VB73qg?=
 =?us-ascii?Q?Mbwo5OUB9ZNHdWS0niMKMYasYtPuCm2Nt/mahorJV2at6FgcihlBVx+WeYT6?=
 =?us-ascii?Q?XStd4JLTaFwAMrwxO+KdvSnt7LgnNa1lk3gfwhEoizmGOv1Ei/cjP+lggcQw?=
 =?us-ascii?Q?2SIC7hvJhxatdobTioQ6tAuajx3MHZSpcewfB8mJewTuEFhOWah94shHepYj?=
 =?us-ascii?Q?ZTEFYg3W+DBglSauITUoGx3GpbSL/1iHzm8J7AYkL99djanww0TLf/lhp70t?=
 =?us-ascii?Q?PNVyJqHAKHm+nz9fXLS1xEMwc1DPEnFfV1lg5ww1kqq/FLCbXCdiGQolNbc4?=
 =?us-ascii?Q?/diI9Fw0JBI/dwUt0LH4mRRB4Uj5hOBwYAtgSCuFZeSRqeeZUXdVI4TT+dnS?=
 =?us-ascii?Q?lPSw69j3ttI/ef6JUe7qQcB34ULl/nBcjjvOeJ2IcrTqz2hQcejC+Fq2ESgr?=
 =?us-ascii?Q?kPQbwjnIXakIT1v4K+qJgVLk3acLCit2g3IFOjdp5jvIjitozWKDOH6Q4Gc6?=
 =?us-ascii?Q?kVdXWul5g240qa6b9ysJRoM4Kc9nYHxQTiPVRcFSDu2m6e4YnvSkD0I9VIml?=
 =?us-ascii?Q?1xtNvNVzIzEcLh+xzWHnCQmV8dRzOqgMgt69WlVHxZ7TnbGoCHoruGPfDBfE?=
 =?us-ascii?Q?5ZjXz9GgAoQmwpb+2HQQSxGsoc8NP8FVpPnEXcxX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c70de35f-5a38-406c-b2db-08dc99bae482
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 10:45:15.6303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7v3b1oiemt8kdCqd05GkVLDwrARvmZ4SxFYIFMf4lEbfEmXF55+IxTxtboECuHdfID2CXP2LVv5dwOxEKr5X0j0bMO6DwaWiA5V2fP/dlQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0814



>=20
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> It was reported to me that the star64 actually /does/ have an exposed PCI=
e port,
> despite the commit message there. In my original conversation with Minda,
> they said that pcie1 was available there and pcie0 was not, but the v2 pa=
tch
> didn't actually add pcie1 on the star64.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I think I'll just squash this in and fixup the commit message, since the =
patch is still
> at the top of my branch.
>=20
> CC: Minda Chen <minda.chen@starfivetech.com>
> CC: Conor Dooley <conor@kernel.org>
> CC: Rob Herring <robh+dt@kernel.org>,
> CC: Emil Renner Berthing <emil.renner.berthing@canonical.com
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> index 2d41f18e0359..b720cdd15ed6 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> @@ -39,6 +39,10 @@ phy1: ethernet-phy@1 {
>  	};
>  };
>=20
> +&pcie1 {
> +	status =3D "okay";
> +};
> +
>  &phy0 {
>  	rx-internal-delay-ps =3D <1900>;
>  	tx-internal-delay-ps =3D <1500>;
> --
> 2.43.0

Hi Conor

The jh7110-pine64-star64.dts is in linux-next tree. I have not noticed it b=
efore.
Should I squash this to my patch? Can my dts patch be accepted in kernel 6.=
11? Thanks
(The same with Starfive PCIe patch set in linux-next, which will be merge i=
n 6.11, right?)


