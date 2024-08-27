Return-Path: <linux-kernel+bounces-303166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECE496084C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E745F1F23A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B219F471;
	Tue, 27 Aug 2024 11:16:11 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2103.outbound.protection.outlook.com [40.107.239.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA41714A8;
	Tue, 27 Aug 2024 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757369; cv=fail; b=pNy5aaj2/Y2Dtgzvc7FN0/7GZk9alsX8Bq5akZ5t4DbEHqUpWIuGKqydPyLCIxL9lu16DUy86DzkyF2FuyfdhxsmIoPdc5LA2ZsKp+N5kA2lmpFuFfceGeU0aS8EF4+al9oe98bL9IeAJbTuYKdee5e06kK4FzvXiD3YDrDkpHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757369; c=relaxed/simple;
	bh=gkzATj1/enrIDbXwOvS2jvKELFpe1p4wB4/OmaOqHTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a3aCQtTbT6MdwA6DCaNrYfTcdMDZkad797taSA/oi/5n9EMexZNDfnA5Zumolis2rDjS1ngfK4Vx1dQu1pKx2RBRknrq2Lt+pAqbq6Bpey7msenUvwnrxcTs0Ycf/fxG2MLsrBTekQjSFXXCestBGOOZoPn3MVuPPCBYshuYN60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfslPsuB/skuTyW3JfuMMer7r57F6OjgH9Zlh/uLF00I15hZg/f64LsPy02NQpTJ3pBqBMqYiX+7PysAIwJNvDpue292Oak8gl9X6juu5iQ66r1vrwYEweQEjjv5gDRAFDHl96kdGIBEO6MvUYhk5e+4Hg3y5jvcs56pRN2Fxtn9yxoaY5P4sSC0vBUT42pVRK5TdoVGBzzRXZkpU16zRr8KUiSM3yPIY+5Wx2jR/PTaVgeBLn4JqcPCJmHG3LyNtMDTHucSmRGq1akTXFYAfKgG8Fq1FVcMDi25k9RPNJzS/u4PmMsePZpnhKanQ9HBh3dtOOoqEqLIzcR2UGSyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkzATj1/enrIDbXwOvS2jvKELFpe1p4wB4/OmaOqHTo=;
 b=Fm0JMoamAxsaVClfbbpVW5rnFX3FCBQxT5ASWZ0CQkUQDGxRNon2kII8lr+mPthxCfzvp0fQk8YGf/cBIOmK+wV0l4tbJiOD7+y5AWpZC2eGUyd8GZiGAAwzo2UjmodmSLSjMwiQiQwfqri6xGeUK/RK48mAAdsQ7Othr8o+0mgtuJ66VpVMNb7TTevmJQLbVdZ30Qae6wBUDepjVTGJddZjcKJNKU1qyKvGxr6p2Ayx7irCzDp0jHhKk3GnjM7F7DK3xwS1lsVhGRcvt2s68TtyCssC41+S3AzkivWJfhfoN0LTwKZk/aiTljZ1w8aEgOOW7V45G6O8aWh47Jzmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2P287MB0479.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:16:02 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:16:02 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Topic: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Index: AQHa9VRUHO5mIgJDEES+QtfARtJnGLI0x5OAgAYyo1M=
Date: Tue, 27 Aug 2024 11:16:02 +0000
Message-ID:
 <PN3P287MB1829E68257FC17F8ADA725028B942@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240823120158.19294-1-tarang.raval@siliconsignals.io>
 <20240823-demonic-jolly-chital-fb4d61-mkl@pengutronix.de>
In-Reply-To: <20240823-demonic-jolly-chital-fb4d61-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|PN2P287MB0479:EE_
x-ms-office365-filtering-correlation-id: 121939b0-318f-4a92-69c5-08dcc689a2d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XXLpP8ln12q9g2bvPVDGikdjsoc5Qbo1/HFmH48R2Tgff8+a4jH1yjLdyH?=
 =?iso-8859-1?Q?BJ123yMFdfcuNpU6zZP8cRv3d0hl1oWfxLZQn3OUcveCtrcxfjRv3Au/nm?=
 =?iso-8859-1?Q?SMiUNuphWHygm7JmwqKuXSWNya07Uzgu2x1oCqL7NKqkIqIMTaQH7GItor?=
 =?iso-8859-1?Q?RCX0hLBqfnmA50SnvlokgH0g874nLdTFDPy7iLsF5lw32RsLDGMILuSoRQ?=
 =?iso-8859-1?Q?Qe12ytLgP7/NqLKWbkSfz/GjKIBIweDmNN/sbozB2CZ0YsCj5hiLkaS8C+?=
 =?iso-8859-1?Q?AN09iZ6BO2i/8VnqLV8bJ0+0ElbvDWbDw++MwH9dBf1sweCi/bawZdZsGn?=
 =?iso-8859-1?Q?IOfsRts1hLxumo8JAqJwTKbeMUDSvU1ZYMHeGxe3TYYQKYvpAfETPDljzT?=
 =?iso-8859-1?Q?GrozP1H/7c/OVTH8sqOtK5zquoMmOhGzOkJHSgSW+gxIgGFn4en3BGZtII?=
 =?iso-8859-1?Q?WQ6A9nT+ujyJG8MgZP0aHSyTuzaox4JbJOXfXzM+eHVit2yKK5KrBY6iFf?=
 =?iso-8859-1?Q?UjohHPaFfo+xnYanBzTijQ9lW5xL/1Kotp9jqghsX5pnORPoA4FM3S1qWv?=
 =?iso-8859-1?Q?FjYizSSCaX3o/H+zTXVhsPadAhBsBVEMjzbM/0LO29kA8QX5lleA/+yzWs?=
 =?iso-8859-1?Q?viEP2RkfgasaR+2045yMzMUlozqyRvBPwuyWdQUii5caCCsb6dcSrAQ7jy?=
 =?iso-8859-1?Q?QM3yQ5wnpydTKcychskKcr5ycA3+c61PYQHzJTTOSN+6HOXXSp7SbX7LCo?=
 =?iso-8859-1?Q?b14ozKTtFHkKluFvWRRkJZYuX6GKy3ZTSb3DzUcjI/I570RL/W23BUY1Qx?=
 =?iso-8859-1?Q?L5v+e7dWjBRvDtBrtZ2rkAnzX7mGF0EQaFB0HktkwFesAITxFqXEBUZGYO?=
 =?iso-8859-1?Q?DcsQRErAZRRTU/JrhBoDIiRL+S/sd5H5UBCHbFZnld8kbv5lWWwnMg6ezq?=
 =?iso-8859-1?Q?mqbwP/qyXkaC+Jo9gBvqcQX85btAp2S9dvEYXG2cPKU3scoS9S8ksNyAV/?=
 =?iso-8859-1?Q?jA1Fq9xNEHPA0f3pOeTyz5o/xXuxXW2+47dgFcEMtIHM1geOInTZBNvYtK?=
 =?iso-8859-1?Q?zl0E+3rgT6SFpS8vP4KjXiiwlVbR+AcqNBk+b6FkqgmIXE4EPmjlq1CPR/?=
 =?iso-8859-1?Q?rrcmg/ZROKDRRCM2JY7mxWUmb1hnQr1BPKs+igS95Ro7jry3eleLRKq7B1?=
 =?iso-8859-1?Q?AmG3obu39lWlXqh+st9LgkI5bfcrnFpn/R/ehSnYVaOGMEIiOAxv5jqvC6?=
 =?iso-8859-1?Q?qtwAMahfRhyAHbPgiwvnT785dzbG+yZbdfQQ+scy+OtaWptNhH4ol07wuG?=
 =?iso-8859-1?Q?YB4mMji5ms/dNS1scmYre+1JKCpGbre7866t7ANSFa0Uo4+m54OjXAiCuX?=
 =?iso-8859-1?Q?SGkBzvhshPWejYpbkcX4mH4bpqGpeTIrWiR3kT2aKhJyna0DGCdGJZcRSm?=
 =?iso-8859-1?Q?upzZLR4mvBeTtgPmbztWNWCM0QxYtoN2ZK/vqA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4lPr10HahgUBV/7oQkZ39/UUd+ID87TT8CtXxicO9jk2mLx5kJfkTPS8J7?=
 =?iso-8859-1?Q?112HmOu4Q0ddjrZf5O+JNf+lM2EvK2MDetiZpSrcDVy9IeZ/vlLsIPFeT1?=
 =?iso-8859-1?Q?MS7H8/8VCkhAG9uV9cEpNSRK2qQlnqHTp44x5Piv2btTz80q9goaEUtvP3?=
 =?iso-8859-1?Q?wI7A/mc/pExQKIwsU4bdHIUC1gB0OJwM83VrIFqOOJKQSyRpl7oEiOhDhj?=
 =?iso-8859-1?Q?KYsXRfCzlxt1yky9YDxFW3Vp7OnQ2G/w3mG361buPw3yfG8fLLDGXv6RLo?=
 =?iso-8859-1?Q?DxwKc93MTrtXKPLiPFPXLHVPinI2AqtsSgVhus8o8mKiHY4qfBb+43FBWj?=
 =?iso-8859-1?Q?Lw49oYTQUQfCLbMZAUrNUID+Jp6OEmlWeMSbM71LQL3N/d8mPYSCIgx9VR?=
 =?iso-8859-1?Q?xXV2dccb3TBGuFpXwJ38HJQz5vZROt9eSdGgqSFdrFU6XWWLJmeEGqIRAf?=
 =?iso-8859-1?Q?NhkHWh1xYIsojbIV7foqX5zKmkzI1A5lkk8VZBFe+Rq5TD74qcs4V9N1IH?=
 =?iso-8859-1?Q?uWtFr/qN+IT7L3utLWZe8hWlsWsQYoS6lakNibE98/HrD68j9zaLvmpMvo?=
 =?iso-8859-1?Q?Amixfqf6QxOk4sRKLUBA9yMApoSgAstW3qxR0nVRO2TAfcwTDcQN64UQDf?=
 =?iso-8859-1?Q?uT7sQypxdB44LOeoPZXX8qgkRkHOMBdObGVzfph1WVH1YnQwo/YrP4tAB1?=
 =?iso-8859-1?Q?PFVuOFl2B/cd/dRd5HpXUvkDtVkO3B+u8nnqlpfZm8+PLdLL+May04TPL9?=
 =?iso-8859-1?Q?GuGbDsA4CgrT57DTJY+KXl7HZZZFcdp6jvSyEEjMBBaSsQ9pEcgZ881Qg0?=
 =?iso-8859-1?Q?o/nf1UDzZWPRAYVOer1ZJ562uzar5kWOWpe9/0EqSO2BIXz0zNLK48wvZl?=
 =?iso-8859-1?Q?11WY+2EidcRzah+1KQuYrIyyuPOR+ijpDptcNWrwG/acFE+bFBqYT0O+yf?=
 =?iso-8859-1?Q?kF9ZtyrHyvF23/0ku0Go0DuPrbg70pTZcAkHk0mep4MIIBijh68y+4Pokn?=
 =?iso-8859-1?Q?OCZynBvzQk7JR5o0uGtvmVsq6hM21cAGnzVzrcyNIdR1DeBnvHZXLLuZY7?=
 =?iso-8859-1?Q?QjvKqJrefbb3CnMEIWt0gNdUVlJ/3tSJnByn0L1IfghzvdebfKpkPXdeHF?=
 =?iso-8859-1?Q?pG+9T+28tlN8BXjAiRElo4fvi/E6PTsk4IM3WzybTEJYPeOsyATbt4UVOf?=
 =?iso-8859-1?Q?cn44cR5TyIveKVFuRxNESchnW7pZYqZpPyjbXNugx75fyK/pi6m8LGt7nk?=
 =?iso-8859-1?Q?1okabbIe9gRz0dCWWTk3j/+w+9MXHgLdXccVOW8UgcipiClqiU6LQAoJXr?=
 =?iso-8859-1?Q?VVXJYLLrQXc7jJF5uuoAGcqPeYlyXvCkTKdBBkm3Ani2Dya8lLimPd/HP8?=
 =?iso-8859-1?Q?xIblPBuqciItA6YjTHfipHCW8uOw/TFplOSyjYzLmEzGbcQpYu/B73tvEw?=
 =?iso-8859-1?Q?zuCzFxc2hyAXDeLHGGitV5j+DSTd+cEf3q/nCeDZFRANFf32ui8BqO5W3W?=
 =?iso-8859-1?Q?qCDgrmyTxuhQrrxYa4ifN86czKqOTZphndhXTq28fyRrU0nFny9fAVZaJe?=
 =?iso-8859-1?Q?AUfftT6JX0kS/C/SoUP1SdlDEcWRLF9HLmkT8AC98aNxmvRayNtcWDUvEz?=
 =?iso-8859-1?Q?i/S1br1Fm7ooMn/5BKuabv6N6TxottOV2GSpZKYpfExX0S14dIGwgj4w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 121939b0-318f-4a92-69c5-08dcc689a2d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 11:16:02.3985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsRYNIvLlxL4XsRF1Yoi9mM24HJkjyiHpBHAXjSZfFfG/KVWppxeRKenPiqjsqMxDEEA+IH7bT7jp/v7Ij0D4DV0+vUkHilj5Awj/t5RomI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0479

Hi Marc,=0A=
=0A=
Yes, I have tested it, and you can see the logs below.=0A=
=0A=
After running=A0 ifconfig can0 up, the bus is operational.=0A=
=0A=
[=A0=A0=A0 0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034=
]=0A=
[=A0=A0=A0 0.000000] Linux version 6.10.0-dirty (falcon@falcon) (aarch64-po=
ky-linux-gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.36.1.20210209) #8 SMP PR=
E4=0A=
[=A0=A0=A0 0.000000] KASLR disabled due to lack of seed=0A=
[=A0=A0=A0 0.000000] Machine model: Emtop Embedded Solutions i.MX8M Mini Ba=
seboard V1=0A=
[=A0=A0=A0 0.000000] efi: UEFI not found.=0A=
[=A0=A0=A0 0.000000] OF: reserved mem: 0x00000000be000000..0x00000000bfbfff=
ff (28672 KiB) nomap non-reusable optee_core@0xbe000000=0A=
[=A0=A0=A0 0.000000] OF: reserved mem: 0x00000000bfc00000..0x00000000bfffff=
ff (4096 KiB) nomap non-reusable optee_shm@0xbfc00000=0A=
[=A0=A0=A0 0.000000] NUMA: No NUMA configuration found=0A=
[=A0=A0=A0 0.000000] NUMA: Faking a node at [mem 0x0000000040000000-0x00000=
000bdffffff]=0A=
[=A0=A0=A0 0.000000] NUMA: NODE_DATA [mem 0xbdbe39c0-0xbdbe5fff]=0A=
[=A0=A0=A0 0.000000] Zone ranges:=0A=
[=A0=A0=A0 0.000000]=A0=A0 DMA=A0=A0=A0=A0=A0 [mem 0x0000000040000000-0x000=
00000bdffffff]=0A=
[=A0=A0=A0 0.000000]=A0=A0 DMA32=A0=A0=A0 empty=0A=
[=A0=A0=A0 0.000000]=A0=A0 Normal=A0=A0 empty=0A=
[=A0=A0=A0 0.000000] Movable zone start for each node=0A=
[=A0=A0=A0 0.000000] Early memory node ranges=0A=
[=A0=A0=A0 0.000000]=A0=A0 node=A0=A0 0: [mem 0x0000000040000000-0x00000000=
bdffffff]=0A=
[=A0=A0=A0 0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x0000000=
0bdffffff]=0A=
[=A0=A0=A0 0.000000] On node 0, zone DMA: 8192 pages in unavailable ranges=
=0A=
[=A0=A0=A0 0.000000] cma: Reserved 32 MiB at 0x00000000b9a00000 on node -1=
=0A=
[=A0=A0=A0 0.000000] psci: probing for conduit method from DT.=0A=
[=A0=A0=A0 0.000000] psci: PSCIv1.1 detected in firmware.=0A=
[=A0=A0=A0 0.000000] psci: Using standard PSCI v0.2 function IDs=0A=
[=A0=A0=A0 0.000000] psci: Trusted OS migration not required=0A=
[=A0=A0=A0 0.000000] psci: SMC Calling Convention v1.1=0A=
[=A0=A0=A0 0.000000] percpu: Embedded 24 pages/cpu s59880 r8192 d30232 u983=
04=0A=
[=A0=A0=A0 0.000000] pcpu-alloc: s59880 r8192 d30232 u98304 alloc=3D24*4096=
=0A=
[=A0=A0=A0 0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3=0A=
[=A0=A0=A0 0.000000] Detected VIPT I-cache on CPU0=0A=
[=A0=A0=A0 0.000000] CPU features: detected: GIC system register CPU interf=
ace=0A=
[=A0=A0=A0 0.000000] CPU features: detected: ARM erratum 845719=0A=
[=A0=A0=A0 0.000000] alternatives: applying boot alternatives=0A=
[=A0=A0=A0 0.000000] Kernel command line: console=3Dttymxc1,115200 root=3D/=
dev/mmcblk2p2 rootwait rw audit=3D0=0A=
[=A0=A0=A0 0.000000] audit: disabled (until reboot)=0A=
[=A0=A0=A0 0.000000] Dentry cache hash table entries: 262144 (order: 9, 209=
7152 bytes, linear)=0A=
[=A0=A0=A0 0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048=
576 bytes, linear)=0A=
[=A0=A0=A0 0.000000] Fallback order for Node 0: 0=0A=
[=A0=A0=A0 0.000000] Built 1 zonelists, mobility grouping on.=A0 Total page=
s: 516096=0A=
[=A0=A0=A0 0.000000] Policy zone: DMA=0A=
[=A0=A0=A0 0.000000] mem auto-init: stack:off, heap alloc:off, heap free:of=
f=0A=
[=A0=A0=A0 0.000000] software IO TLB: SWIOTLB bounce buffer size adjusted t=
o 1MB=0A=
[=A0=A0=A0 0.000000] software IO TLB: area num 4.=0A=
[=A0=A0=A0 0.000000] software IO TLB: mapped [mem 0x00000000b9500000-0x0000=
0000b9700000] (2MB)=0A=
[=A0=A0=A0 0.000000] Memory: 1941312K/2064384K available (18432K kernel cod=
e, 4936K rwdata, 12096K rodata, 10368K init, 761K bss, 90304K reserved, 327=
6)=0A=
[=A0=A0=A0 0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=
=3D4, Nodes=3D1=0A=
[=A0=A0=A0 0.000000] rcu: Preemptible hierarchical RCU implementation.=0A=
[=A0=A0=A0 0.000000] rcu:=A0=A0=A0=A0 RCU event tracing is enabled.=0A=
[=A0=A0=A0 0.000000] rcu:=A0=A0=A0=A0 RCU restricting CPUs from NR_CPUS=3D5=
12 to nr_cpu_ids=3D4.=0A=
[=A0=A0=A0 0.000000]=A0 Trampoline variant of Tasks RCU enabled.=0A=
[=A0=A0=A0 0.000000]=A0 Tracing variant of Tasks RCU enabled.=0A=
[=A0=A0=A0 0.000000] rcu: RCU calculated value of scheduler-enlistment dela=
y is 25 jiffies.=0A=
[=A0=A0=A0 0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_c=
pu_ids=3D4=0A=
[=A0=A0=A0 0.000000] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb=
_adjust=3D1.=0A=
[=A0=A0=A0 0.000000] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_t=
ask_cb_adjust=3D1.=0A=
[=A0=A0=A0 0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0=0A=
[=A0=A0=A0 0.000000] GICv3: GIC: Using split EOI/Deactivate mode=0A=
[=A0=A0=A0 0.000000] GICv3: 128 SPIs implemented=0A=
[=A0=A0=A0 0.000000] GICv3: 0 Extended SPIs implemented=0A=
[=A0=A0=A0 0.000000] Root IRQ handler: gic_handle_irq=0A=
[=A0=A0=A0 0.000000] GICv3: GICv3 features: 16 PPIs=0A=
[=A0=A0=A0 0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000=
38880000=0A=
[=A0=A0=A0 0.000000] ITS: No ITS available, not enabling LPIs=0A=
[=A0=A0=A0 0.000000] rcu: srcu_init: Setting srcu_struct sizes based on con=
tention.=0A=
[=A0=A0=A0 0.000000] arch_timer: cp15 timer(s) running at 8.00MHz (phys).=
=0A=
[=A0=A0=A0 0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff =
max_cycles: 0x1d854df40, max_idle_ns: 440795202120 ns=0A=
[=A0=A0=A0 0.000000] sched_clock: 56 bits at 8MHz, resolution 125ns, wraps =
every 2199023255500ns=0A=
[=A0=A0=A0 0.001259] Console: colour dummy device 80x25=0A=
[=A0=A0=A0 0.001329] Calibrating delay loop (skipped), value calculated usi=
ng timer frequency.. 16.00 BogoMIPS (lpj=3D32000)=0A=
[=A0=A0=A0 0.001340] pid_max: default: 32768 minimum: 301=0A=
[=A0=A0=A0 0.001407] LSM: initializing lsm=3Dcapability=0A=
[=A0=A0=A0 0.001487] Mount-cache hash table entries: 4096 (order: 3, 32768 =
bytes, linear)=0A=
[=A0=A0=A0 0.001500] Mountpoint-cache hash table entries: 4096 (order: 3, 3=
2768 bytes, linear)=0A=
[=A0=A0=A0 0.003270] rcu: Hierarchical SRCU implementation.=0A=
[=A0=A0=A0 0.003280] rcu:=A0=A0=A0=A0 Max phase no-delay instances is 1000.=
=0A=
[=A0=A0=A0 0.005746] EFI services will not be available.=0A=
[=A0=A0=A0 0.005943] smp: Bringing up secondary CPUs ...=0A=
[=A0=A0=A0 0.006381] Detected VIPT I-cache on CPU1=0A=
[=A0=A0=A0 0.006448] GICv3: CPU1: found redistributor 1 region 0:0x00000000=
388a0000=0A=
[=A0=A0=A0 0.006485] CPU1: Booted secondary processor 0x0000000001 [0x410fd=
034]=0A=
[=A0=A0=A0 0.007018] Detected VIPT I-cache on CPU2=0A=
[=A0=A0=A0 0.007068] GICv3: CPU2: found redistributor 2 region 0:0x00000000=
388c0000=0A=
[=A0=A0=A0 0.007093] CPU2: Booted secondary processor 0x0000000002 [0x410fd=
034]=0A=
[=A0=A0=A0 0.007565] Detected VIPT I-cache on CPU3=0A=
[=A0=A0=A0 0.007612] GICv3: CPU3: found redistributor 3 region 0:0x00000000=
388e0000=0A=
[=A0=A0=A0 0.007636] CPU3: Booted secondary processor 0x0000000003 [0x410fd=
034]=0A=
[=A0=A0=A0 0.007731] smp: Brought up 1 node, 4 CPUs=0A=
[=A0=A0=A0 0.007738] SMP: Total of 4 processors activated.=0A=
[=A0=A0=A0 0.007742] CPU: All CPU(s) started at EL2=0A=
[=A0=A0=A0 0.007761] CPU features: detected: 32-bit EL0 Support=0A=
[=A0=A0=A0 0.007764] CPU features: detected: 32-bit EL1 Support=0A=
[=A0=A0=A0 0.007769] CPU features: detected: CRC32 instructions=0A=
[=A0=A0=A0 0.007806] alternatives: applying system-wide alternatives=0A=
[=A0=A0=A0 0.009753] devtmpfs: initialized=0A=
[=A0=A0=A0 0.016564] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xf=
fffffff, max_idle_ns: 7645041785100000 ns=0A=
[=A0=A0=A0 0.016589] futex hash table entries: 1024 (order: 4, 65536 bytes,=
 linear)=0A=
[=A0=A0=A0 0.017481] 21072 pages in range for non-PLT usage=0A=
[=A0=A0=A0 0.017495] 512592 pages in range for PLT usage=0A=
[=A0=A0=A0 0.017704] pinctrl core: initialized pinctrl subsystem=0A=
[=A0=A0=A0 0.019984] DMI not present or invalid.=0A=
[=A0=A0=A0 0.022491] NET: Registered PF_NETLINK/PF_ROUTE protocol family=0A=
[=A0=A0=A0 0.023668] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic a=
llocations=0A=
[=A0=A0=A0 0.024340] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for =
atomic allocations=0A=
[=A0=A0=A0 0.025196] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool fo=
r atomic allocations=0A=
[=A0=A0=A0 0.026938] thermal_sys: Registered thermal governor 'step_wise'=
=0A=
[=A0=A0=A0 0.026944] thermal_sys: Registered thermal governor 'power_alloca=
tor'=0A=
[=A0=A0=A0 0.027031] cpuidle: using governor menu=0A=
[=A0=A0=A0 0.027259] hw-breakpoint: found 6 breakpoint and 4 watchpoint reg=
isters.=0A=
[=A0=A0=A0 0.027348] ASID allocator initialised with 65536 entries=0A=
[=A0=A0=A0 0.029691] Serial: AMBA PL011 UART driver=0A=
[=A0=A0=A0 0.035145] platform soc@0: Fixed dependency cycle(s) with /soc@0/=
bus@30000000/efuse@30350000/unique-id@4=0A=
[=A0=A0=A0 0.040657] imx8mm-pinctrl 30330000.pinctrl: initialized IMX pinct=
rl driver=0A=
[=A0=A0=A0 0.041461] platform 30350000.efuse: Fixed dependency cycle(s) wit=
h /soc@0/bus@30000000/clock-controller@30380000=0A=
[=A0=A0=A0 0.043104] platform 30350000.efuse: Fixed dependency cycle(s) wit=
h /soc@0/bus@30000000/clock-controller@30380000=0A=
[=A0=A0=A0 0.043794] platform 30380000.clock-controller: Fixed dependency c=
ycle(s) with /soc@0/interrupt-controller@38800000=0A=
[=A0=A0=A0 0.057376] platform 32e40000.usb: Fixed dependency cycle(s) with =
/connector=0A=
[=A0=A0=A0 0.057451] platform connector: Fixed dependency cycle(s) with /so=
c@0/bus@32c00000/usb@32e40000=0A=
[=A0=A0=A0 0.059749] HugeTLB: registered 1.00 GiB page size, pre-allocated =
0 pages=0A=
[=A0=A0=A0 0.059761] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB pag=
e=0A=
[=A0=A0=A0 0.059767] HugeTLB: registered 32.0 MiB page size, pre-allocated =
0 pages=0A=
[=A0=A0=A0 0.059772] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB pag=
e=0A=
[=A0=A0=A0 0.059776] HugeTLB: registered 2.00 MiB page size, pre-allocated =
0 pages=0A=
[=A0=A0=A0 0.059780] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB pag=
e=0A=
[=A0=A0=A0 0.059786] HugeTLB: registered 64.0 KiB page size, pre-allocated =
0 pages=0A=
[=A0=A0=A0 0.059790] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB pag=
e=0A=
[=A0=A0=A0 0.060200] Demotion targets for Node 0: null=0A=
[=A0=A0=A0 0.061621] ACPI: Interpreter disabled.=0A=
[=A0=A0=A0 0.064491] iommu: Default domain type: Translated=0A=
[=A0=A0=A0 0.064500] iommu: DMA domain TLB invalidation policy: strict mode=
=0A=
[=A0=A0=A0 0.064825] SCSI subsystem initialized=0A=
[=A0=A0=A0 0.064934] libata version 3.00 loaded.=0A=
[=A0=A0=A0 0.065157] usbcore: registered new interface driver usbfs=0A=
[=A0=A0=A0 0.065187] usbcore: registered new interface driver hub=0A=
[=A0=A0=A0 0.065213] usbcore: registered new device driver usb=0A=
[=A0=A0=A0 0.066511] pps_core: LinuxPPS API ver. 1 registered=0A=
[=A0=A0=A0 0.066517] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Ro=
dolfo Giometti <giometti@linux.it>=0A=
[=A0=A0=A0 0.066529] PTP clock support registered=0A=
[=A0=A0=A0 0.066676] EDAC MC: Ver: 3.0.0=0A=
[=A0=A0=A0 0.067122] scmi_core: SCMI protocol bus registered=0A=
[=A0=A0=A0 0.068216] FPGA manager framework=0A=
[=A0=A0=A0 0.068314] Advanced Linux Sound Architecture Driver Initialized.=
=0A=
[=A0=A0=A0 0.069541] vgaarb: loaded=0A=
[=A0=A0=A0 0.069930] clocksource: Switched to clocksource arch_sys_counter=
=0A=
[=A0=A0=A0 0.070138] VFS: Disk quotas dquot_6.6.0=0A=
[=A0=A0=A0 0.070156] VFS: Dquot-cache hash table entries: 512 (order 0, 409=
6 bytes)=0A=
[=A0=A0=A0 0.070379] pnp: PnP ACPI: disabled=0A=
[=A0=A0=A0 0.076745] NET: Registered PF_INET protocol family=0A=
[=A0=A0=A0 0.076885] IP idents hash table entries: 32768 (order: 6, 262144 =
bytes, linear)=0A=
[=A0=A0=A0 0.078410] tcp_listen_portaddr_hash hash table entries: 1024 (ord=
er: 2, 16384 bytes, linear)=0A=
[=A0=A0=A0 0.078436] Table-perturb hash table entries: 65536 (order: 6, 262=
144 bytes, linear)=0A=
[=A0=A0=A0 0.078449] TCP established hash table entries: 16384 (order: 5, 1=
31072 bytes, linear)=0A=
[=A0=A0=A0 0.078597] TCP bind hash table entries: 16384 (order: 7, 524288 b=
ytes, linear)=0A=
[=A0=A0=A0 0.078997] TCP: Hash tables configured (established 16384 bind 16=
384)=0A=
[=A0=A0=A0 0.079088] UDP hash table entries: 1024 (order: 3, 32768 bytes, l=
inear)=0A=
[=A0=A0=A0 0.079133] UDP-Lite hash table entries: 1024 (order: 3, 32768 byt=
es, linear)=0A=
[=A0=A0=A0 0.079283] NET: Registered PF_UNIX/PF_LOCAL protocol family=0A=
[=A0=A0=A0 0.079646] RPC: Registered named UNIX socket transport module.=0A=
[=A0=A0=A0 0.079651] RPC: Registered udp transport module.=0A=
[=A0=A0=A0 0.079654] RPC: Registered tcp transport module.=0A=
[=A0=A0=A0 0.079657] RPC: Registered tcp-with-tls transport module.=0A=
[=A0=A0=A0 0.079660] RPC: Registered tcp NFSv4.1 backchannel transport modu=
le.=0A=
[=A0=A0=A0 0.080810] PCI: CLS 0 bytes, default 64=0A=
[=A0=A0=A0 0.084150] kvm [1]: nv: 477 coarse grained trap handlers=0A=
[=A0=A0=A0 0.084469] kvm [1]: IPA Size Limit: 40 bits=0A=
[=A0=A0=A0 0.087081] kvm [1]: GICv3: no GICV resource entry=0A=
[=A0=A0=A0 0.087086] kvm [1]: disabling GICv2 emulation=0A=
[=A0=A0=A0 0.087101] kvm [1]: GIC system register CPU interface enabled=0A=
[=A0=A0=A0 0.087128] kvm [1]: vgic interrupt IRQ9=0A=
[=A0=A0=A0 0.087148] kvm [1]: Hyp nVHE mode initialized successfully=0A=
[=A0=A0=A0 0.088405] Initialise system trusted keyrings=0A=
[=A0=A0=A0 0.088572] workingset: timestamp_bits=3D42 max_order=3D19 bucket_=
order=3D0=0A=
[=A0=A0=A0 0.088839] squashfs: version 4.0 (2009/01/31) Phillip Lougher=0A=
[=A0=A0=A0 0.089052] NFS: Registering the id_resolver key type=0A=
[=A0=A0=A0 0.089071] Key type id_resolver registered=0A=
[=A0=A0=A0 0.089075] Key type id_legacy registered=0A=
[=A0=A0=A0 0.089093] nfs4filelayout_init: NFSv4 File Layout Driver Register=
ing...=0A=
[=A0=A0=A0 0.089098] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver =
Registering...=0A=
[=A0=A0=A0 0.089212] 9p: Installing v9fs 9p2000 file system support=0A=
[=A0=A0=A0 0.141859] Key type asymmetric registered=0A=
[=A0=A0=A0 0.141867] Asymmetric key parser 'x509' registered=0A=
[=A0=A0=A0 0.141916] Block layer SCSI generic (bsg) driver version 0.4 load=
ed (major 245)=0A=
[=A0=A0=A0 0.141931] io scheduler mq-deadline registered=0A=
[=A0=A0=A0 0.141936] io scheduler kyber registered=0A=
[=A0=A0=A0 0.141964] io scheduler bfq registered=0A=
[=A0=A0=A0 0.188177] imx-sdma 302c0000.dma-controller: Direct firmware load=
 for imx/sdma/sdma-imx7d.bin failed with error -2=0A=
[=A0=A0=A0 0.188199] imx-sdma 302c0000.dma-controller: external firmware no=
t found, using ROM firmware=0A=
[=A0=A0=A0 0.191398] imx-sdma 302b0000.dma-controller: Direct firmware load=
 for imx/sdma/sdma-imx7d.bin failed with error -2=0A=
[=A0=A0=A0 0.191423] imx-sdma 302b0000.dma-controller: external firmware no=
t found, using ROM firmware=0A=
[=A0=A0=A0 0.194024] imx-sdma 30bd0000.dma-controller: Direct firmware load=
 for imx/sdma/sdma-imx7d.bin failed with error -2=0A=
[=A0=A0=A0 0.194043] imx-sdma 30bd0000.dma-controller: external firmware no=
t found, using ROM firmware=0A=
[=A0=A0=A0 0.195842] SoC: i.MX8MM revision 1.0=0A=
[=A0=A0=A0 0.229395] Serial: 8250/16550 driver, 4 ports, IRQ sharing enable=
d=0A=
[=A0=A0=A0 0.233994] 30890000.serial: ttymxc1 at MMIO 0x30890000 (irq =3D 1=
8, base_baud =3D 1500000) is a IMX=0A=
[=A0=A0=A0 0.234041] printk: legacy console [ttymxc1] enabled=0A=
[=A0=A0=A0 1.373900] msm_serial: driver initialized=0A=
[=A0=A0=A0 1.378539] SuperH (H)SCI(F) driver initialized=0A=
[=A0=A0=A0 1.383371] STM32 USART driver initialized=0A=
[=A0=A0=A0 1.395897] loop: module loaded=0A=
[=A0=A0=A0 1.400551] megasas: 07.727.03.00-rc1=0A=
[=A0=A0=A0 1.413135] tun: Universal TUN/TAP device driver, 1.6=0A=
[=A0=A0=A0 1.419603] thunder_xcv, ver 1.0=0A=
[=A0=A0=A0 1.422883] thunder_bgx, ver 1.0=0A=
[=A0=A0=A0 1.426140] nicpf, ver 1.0=0A=
[=A0=A0=A0 1.430708] hns3: Hisilicon Ethernet Network Driver for Hip08 Fami=
ly - version=0A=
[=A0=A0=A0 1.437948] hns3: Copyright (c) 2017 Huawei Corporation.=0A=
[=A0=A0=A0 1.443319] hclge is initializing=0A=
[=A0=A0=A0 1.446680] e1000: Intel(R) PRO/1000 Network Driver=0A=
[=A0=A0=A0 1.451565] e1000: Copyright (c) 1999-2006 Intel Corporation.=0A=
[=A0=A0=A0 1.457339] e1000e: Intel(R) PRO/1000 Network Driver=0A=
[=A0=A0=A0 1.462310] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.=0A=
[=A0=A0=A0 1.468260] igb: Intel(R) Gigabit Ethernet Network Driver=0A=
[=A0=A0=A0 1.473666] igb: Copyright (c) 2007-2014 Intel Corporation.=0A=
[=A0=A0=A0 1.479270] igbvf: Intel(R) Gigabit Virtual Function Network Drive=
r=0A=
[=A0=A0=A0 1.485545] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.=0A=
[=A0=A0=A0 1.491929] sky2: driver version 1.30=0A=
[=A0=A0=A0 1.497599] VFIO - User Level meta-driver version: 0.3=0A=
[=A0=A0=A0 1.507024] usbcore: registered new interface driver usb-storage=
=0A=
[=A0=A0=A0 1.517572] i2c_dev: i2c /dev entries driver=0A=
[=A0=A0=A0 1.533792] sdhci: Secure Digital Host Controller Interface driver=
=0A=
[=A0=A0=A0 1.540017] sdhci: Copyright(c) Pierre Ossman=0A=
[=A0=A0=A0 1.545624] Synopsys Designware Multimedia Card Interface Driver=
=0A=
[=A0=A0=A0 1.553116] sdhci-pltfm: SDHCI platform and OF driver helper=0A=
[=A0=A0=A0 1.563449] ledtrig-cpu: registered to indicate activity on CPUs=
=0A=
[=A0=A0=A0 1.571934] usbcore: registered new interface driver usbhid=0A=
[=A0=A0=A0 1.577534] usbhid: USB HID core driver=0A=
[=A0=A0=A0 1.587453] hw perfevents: enabled with armv8_cortex_a53 PMU drive=
r, 7 counters available=0A=
[=A0=A0=A0 1.594252] mmc2: SDHCI controller on 30b60000.mmc [30b60000.mmc] =
using ADMA=0A=
[=A0=A0=A0 1.598025] platform soc@0: Fixed dependency cycle(s) with /soc@0/=
bus@30000000/efuse@30350000=0A=
[=A0=A0=A0 1.613810] optee: probing for conduit method.=0A=
[=A0=A0=A0 1.618301] optee: revision 3.10 (b3914e54)=0A=
[=A0=A0=A0 1.618595] optee: dynamic shared memory is enabled=0A=
[=A0=A0=A0 1.628000] optee: initialized driver=0A=
[=A0=A0=A0 1.645008] fsl-spdif-dai 30090000.spdif: failed to get RX Sample =
Rate kcontrol=0A=
[=A0=A0=A0 1.655213] mmc2: new HS400 Enhanced strobe MMC card at address 00=
01=0A=
[=A0=A0=A0 1.656692] NET: Registered PF_LLC protocol family=0A=
[=A0=A0=A0 1.663035] mmcblk2: mmc2:0001 TB2916 14.6 GiB=0A=
[=A0=A0=A0 1.666596] NET: Registered PF_INET6 protocol family=0A=
[=A0=A0=A0 1.672502]=A0 mmcblk2: p1 p2=0A=
[=A0=A0=A0 1.676934] Segment Routing with IPv6=0A=
[=A0=A0=A0 1.680361] mmcblk2boot0: mmc2:0001 TB2916 4.00 MiB=0A=
[=A0=A0=A0 1.682364] In-situ OAM (IOAM) with IPv6=0A=
[=A0=A0=A0 1.688961] mmcblk2boot1: mmc2:0001 TB2916 4.00 MiB=0A=
[=A0=A0=A0 1.691214] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver=0A=
[=A0=A0=A0 1.698289] mmcblk2rpmb: mmc2:0001 TB2916 4.00 MiB, chardev (234:0=
)=0A=
[=A0=A0=A0 1.702407] NET: Registered PF_PACKET protocol family=0A=
[=A0=A0=A0 1.713351] 9pnet: Installing 9P2000 support=0A=
[=A0=A0=A0 1.717679] Key type dns_resolver registered=0A=
[=A0=A0=A0 1.732850] Timer migration: 1 hierarchy levels; 8 children per gr=
oup; 1 crossnode level=0A=
[=A0=A0=A0 1.741727] registered taskstats version 1=0A=
[=A0=A0=A0 1.746063] Loading compiled-in X.509 certificates=0A=
[=A0=A0=A0 1.759882] Demotion targets for Node 0: null=0A=
[=A0=A0=A0 1.776979] gpio gpiochip0: Static allocation of GPIO base is depr=
ecated, use dynamic allocation.=0A=
[=A0=A0=A0 1.787670] gpio gpiochip1: Static allocation of GPIO base is depr=
ecated, use dynamic allocation.=0A=
[=A0=A0=A0 1.798264] gpio gpiochip2: Static allocation of GPIO base is depr=
ecated, use dynamic allocation.=0A=
[=A0=A0=A0 1.809157] gpio gpiochip3: Static allocation of GPIO base is depr=
ecated, use dynamic allocation.=0A=
[=A0=A0=A0 1.820089] gpio gpiochip4: Static allocation of GPIO base is depr=
ecated, use dynamic allocation.=0A=
[=A0=A0=A0 1.833312] usb_phy_generic usbphynop1: dummy supplies not allowed=
 for exclusive requests (id=3Dvbus)=0A=
[=A0=A0=A0 1.842919] usb_phy_generic usbphynop2: dummy supplies not allowed=
 for exclusive requests (id=3Dvbus)=0A=
[=A0=A0=A0 1.853760] i2c i2c-0: IMX I2C adapter registered=0A=
[=A0=A0=A0 1.854275] nxp-pca9450 0-0025: Read device id error=0A=
[=A0=A0=A0 1.863722] rtc-ds1307 2-0032: power-on detected=0A=
[=A0=A0=A0 1.869510] rtc-ds1307 2-0032: voltage drop detected=0A=
[=A0=A0=A0 1.880478] rtc-ds1307 2-0032: registered as rtc0=0A=
[=A0=A0=A0 1.891345] rtc-ds1307 2-0032: setting system clock to 2024-08-27T=
10:45:39 UTC (1724755539)=0A=
[=A0=A0=A0 1.905522] wm8904 2-001a: revision A=0A=
[=A0=A0=A0 1.941639] i2c i2c-2: IMX I2C adapter registered=0A=
[=A0=A0=A0 1.948543] i2c i2c-3: IMX I2C adapter registered=0A=
[=A0=A0=A0 1.958070] pps pps0: new PPS source ptp0=0A=
[=A0=A0=A0 1.965416] fec 30be0000.ethernet: Invalid MAC address: 00:00:00:0=
0:00:00=0A=
[=A0=A0=A0 1.972260] fec 30be0000.ethernet: Using random MAC address: 8a:e8=
:90:b7:d4:2f=0A=
[=A0=A0=A0 1.980747] mdio_bus 30be0000.ethernet-1: MDIO device at address 4=
 is missing.=0A=
[=A0=A0=A0 1.988642] fec 30be0000.ethernet eth0: registered PHC device 0=0A=
[=A0=A0=A0 1.996998] imx_usb 32e40000.usb: No over current polarity defined=
=0A=
[=A0=A0=A0 2.010485] imx_usb 32e50000.usb: No over current polarity defined=
=0A=
[=A0=A0=A0 2.020233] ci_hdrc ci_hdrc.1: EHCI Host Controller=0A=
[=A0=A0=A0 2.025145] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bu=
s number 1=0A=
[=A0=A0=A0 2.045936] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00=0A=
[=A0=A0=A0 2.052273] hub 1-0:1.0: USB hub found=0A=
[=A0=A0=A0 2.056057] hub 1-0:1.0: 1 port detected=0A=
[=A0=A0=A0 2.069501] sdhci-esdhc-imx 30b50000.mmc: Got CD GPIO=0A=
[=A0=A0=A0 2.069855] cfg80211: Loading compiled-in X.509 certificates for r=
egulatory database=0A=
[=A0=A0=A0 2.083606] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'=0A=
[=A0=A0=A0 2.090069] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7=
248db18c600'=0A=
[=A0=A0=A0 2.097377] platform regulatory.0: Direct firmware load for regula=
tory.db failed with error -2=0A=
[=A0=A0=A0 2.097945] mmc0: SDHCI controller on 30b40000.mmc [30b40000.mmc] =
using ADMA=0A=
[=A0=A0=A0 2.098010] clk: Disabling unused clocks=0A=
[=A0=A0=A0 2.101709] PM: genpd: Disabling unused power domains=0A=
[=A0=A0=A0 2.101778] ALSA device list:=0A=
[=A0=A0=A0 2.101782]=A0=A0 #0: imx-spdif=0A=
[=A0=A0=A0 2.106025] cfg80211: failed to load regulatory.db=0A=
[=A0=A0=A0 2.106448] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] =
using ADMA=0A=
[=A0=A0=A0 2.266355] EXT4-fs (mmcblk2p2): warning: mounting fs with errors,=
 running e2fsck is recommended=0A=
[=A0=A0=A0 2.277093] EXT4-fs (mmcblk2p2): recovery complete=0A=
[=A0=A0=A0 2.283024] EXT4-fs (mmcblk2p2): mounted filesystem 20364220-6e5e-=
45c8-bf64-7551b37d8c8d r/w with ordered data mode. Quota mode: none.=0A=
[=A0=A0=A0 2.287078] mmc0: new ultra high speed SDR104 SDIO card at address=
 0001=0A=
[=A0=A0=A0 2.295187] VFS: Mounted root (ext4 filesystem) on device 179:2.=
=0A=
[=A0=A0=A0 2.308798] devtmpfs: mounted=0A=
[=A0=A0=A0 2.309735] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4=
3455-sdio for chip BCM4345/6=0A=
[=A0=A0=A0 2.314563] Freeing unused kernel memory: 10368K=0A=
[=A0=A0=A0 2.320440] usb 1-1: new high-speed USB device number 2 using ci_h=
drc=0A=
[=A0=A0=A0 2.325119] Run /sbin/init as init process=0A=
[=A0=A0=A0 2.335547] brcmfmac mmc0:0001:1: Direct firmware load for brcm/br=
cmfmac43455-sdio.ees,imx8mm-emtop-baseboard.bin failed with error -2=0A=
[=A0=A0=A0 2.335575]=A0=A0 with arguments:=0A=
[=A0=A0=A0 2.347655]=A0=A0=A0=A0 /sbin/init=0A=
[=A0=A0=A0 2.347659]=A0=A0 with environment:=0A=
[=A0=A0=A0 2.347662]=A0=A0=A0=A0 HOME=3D/=0A=
[=A0=A0=A0 2.347665]=A0=A0=A0=A0 TERM=3Dlinux=0A=
[=A0=A0=A0 2.467553] systemd[1]: systemd 243.2+ running in system mode. (+P=
AM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -GC=
R)=0A=
[=A0=A0=A0 2.487372] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob av=
ailable (err=3D-2)=0A=
[=A0=A0=A0 2.489677] systemd[1]: Detected architecture arm64.=0A=
[=A0=A0=A0 2.497370] hub 1-1:1.0: USB hub found=0A=
[=A0=A0=A0 2.505499] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 w=
l0: Mar=A0 3 2019 19:47:25 version 7.45.184 (r712131 CY) FWID 01-b363c0a0=
=0A=
[=A0=A0=A0 2.517873] hub 1-1:1.0: 4 ports detected=0A=
[=A0=A0=A0 2.578353] systemd[1]: Set hostname to <imx8mmddr4evk>.=0A=
[=A0=A0=A0 2.720063] EXT4-fs error (device mmcblk2p2): ext4_validate_block_=
bitmap:423: comm ext4lazyinit: bg 34: bad block bitmap checksum=0A=
[=A0=A0=A0 2.787503] systemd[1]: /lib/systemd/system/dbus.socket:5: ListenS=
tream=3D references a path below legacy directory /var/run/, updating /var/=
run.=0A=
[=A0=A0=A0 2.815727] systemd[1]: /lib/systemd/system/syslogd.service:8: PID=
File=3D references a path below legacy directory /var/run/, updating /var/r=
un/.=0A=
[=A0=A0=A0 2.845890] systemd[1]: /lib/systemd/system/rpcbind.socket:5: List=
enStream=3D references a path below legacy directory /var/run/, updating /v=
ar/.=0A=
[=A0=A0=A0 2.869152] systemd[1]: /lib/systemd/system/klogd.service:8: PIDFi=
le=3D references a path below legacy directory /var/run/, updating /var/run=
/kl.=0A=
[=A0=A0=A0 5.989945] random: crng init done=0A=
[=A0=A0=A0 5.995822] systemd[1]: Created slice system-getty.slice.=0A=
[=A0=A0=A0 6.019025] systemd[1]: Created slice system-serial\x2dgetty.slice=
.=0A=
[=A0=A0=A0 6.042942] systemd[1]: Created slice User and Session Slice.=0A=
[=A0=A0=A0 6.514702] EXT4-fs (mmcblk2p2): re-mounted 20364220-6e5e-45c8-bf6=
4-7551b37d8c8d r/w. Quota mode: none.=0A=
[=A0=A0=A0 6.762206] systemd-journald[118]: Received client request to flus=
h runtime journal.=0A=
[=A0=A0=A0 7.441591] imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 2 mkt s=
egment 2 supported-hw 0x4 0x4=0A=
[=A0=A0=A0 7.533512] Error: Driver 'imx-sdma' is already registered, aborti=
ng...=0A=
[=A0=A0=A0 7.638002] snvs_rtc 30370000.snvs:snvs-rtc-lp: registered as rtc1=
=0A=
[=A0=A0=A0 7.652039] Error: Driver 'imx-sdma' is already registered, aborti=
ng...=0A=
[=A0=A0=A0 7.731186] imx8m-ddrc-devfreq 3d400000.memory-controller: failed =
to get OPP table=0A=
[=A0=A0=A0 7.744440] mc: Linux media interface: v0.10=0A=
[=A0=A0=A0 7.778371] debugfs: File 'Headphone Jack' in directory 'dapm' alr=
eady present!=0A=
[=A0=A0=A0 7.843477] videodev: Linux video capture interface: v2.00=0A=
[=A0=A0=A0 7.968037] etnaviv etnaviv: bound 38000000.gpu (ops gpu_ops [etna=
viv])=0A=
[=A0=A0=A0 7.991117] hantro-vpu 38300000.video-codec: registered nxp,imx8mm=
-vpu-g1-dec as /dev/video0=0A=
[=A0=A0=A0 7.994918] etnaviv etnaviv: bound 38008000.gpu (ops gpu_ops [etna=
viv])=0A=
[=A0=A0=A0 8.006631] etnaviv-gpu 38000000.gpu: model: GC600, revision: 4653=
=0A=
[=A0=A0=A0 8.022053] etnaviv-gpu 38000000.gpu: Need to move linear window o=
n MC1.0, disabling TS=0A=
[=A0=A0=A0 8.024688] bluetooth: Unknown symbol crypto_ecdh_key_len (err -2)=
=0A=
[=A0=A0=A0 8.032308] hantro-vpu 38310000.video-codec: registered nxp,imx8mq=
-vpu-g2-dec as /dev/video1=0A=
[=A0=A0=A0 8.036846] bluetooth: Unknown symbol crypto_ecdh_encode_key (err =
-2)=0A=
[=A0=A0=A0 8.036917] etnaviv-gpu 38008000.gpu: model: GC520, revision: 5341=
=0A=
[=A0=A0=A0 8.046269] [drm] Initialized etnaviv 1.4.0 20151214 for etnaviv o=
n minor 0=0A=
[=A0=A0=A0 8.244785] usbcore: registered new device driver onboard-usb-dev=
=0A=
[=A0=A0=A0 8.445671] hub 1-1:1.0: USB hub found=0A=
[=A0=A0=A0 8.462368] CAN device driver interface=0A=
[=A0=A0=A0 8.473204] hub 1-1:1.0: 4 ports detected=0A=
[=A0=A0=A0 8.527105] hub 1-1:1.0: USB hub found=0A=
[=A0=A0=A0 8.542004] hub 1-1:1.0: 4 ports detected=0A=
[=A0=A0=A0 8.562833] mcp251x spi1.0 can0: MCP2515 successfully initialized.=
=0A=
[=A0=A0=A0 8.639860] fec 30be0000.ethernet eth0: Unable to connect to phy=
=0A=
[=A0=A0=A0 8.708452] fec 30be0000.ethernet eth0: Unable to connect to phy=
=0A=
=0A=
Regards,=0A=
Tarang=0A=
=0A=
________________________________________=0A=
From:=A0Marc Kleine-Budde <mkl@pengutronix.de>=0A=
Sent:=A0Friday, August 23, 2024 6:06 PM=0A=
To:=A0Tarang Raval <tarang.raval@siliconsignals.io>=0A=
Cc:=A0shawnguo@kernel.org <shawnguo@kernel.org>; krzk+dt@kernel.org <krzk+d=
t@kernel.org>; festevam@gmail.com <festevam@gmail.com>; Rob Herring <robh@k=
ernel.org>; Conor Dooley <conor+dt@kernel.org>; devicetree@vger.kernel.org =
<devicetree@vger.kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; linux-=
kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Pengutronix Kernel T=
eam <kernel@pengutronix.de>; imx@lists.linux.dev <imx@lists.linux.dev>; lin=
ux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead.org>=0A=
Subject:=A0Re: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Periphera=
ls Support=0A=
=A0=0A=
CAUTION: This email originated from outside the organization. Do not click =
links or open attachments unless you recognize the sender and know the cont=
ent is safe.=

