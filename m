Return-Path: <linux-kernel+bounces-356382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021AD996042
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC31282241
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C83717B4FF;
	Wed,  9 Oct 2024 07:03:10 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2139.outbound.protection.outlook.com [40.107.239.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723B154BEE;
	Wed,  9 Oct 2024 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457388; cv=fail; b=IeEzT1zxVAjCZ6Z45TBuNZzz+Yizy5C3AbluSxC5twnCYww2n2lVH4hS4wQqGfxV1RlSStO251AcE6TFv+f+fCQ6IP6ExquU/nurdQLkXJA/jwGX+cb1PeEfr3UTo++PUH62ikJA493HZXiiuRLwMjvwc30RK3/ACB6/REo+v5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457388; c=relaxed/simple;
	bh=Y+sdhFhtgw1a4W/4mVVGkU9Ea5bDTz6mS63Ovj5RPV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYsEoaxyoXKKPGGB5Db67pA+E4NCSLDjlof6JQntY/MPQd1OY+pFzvRvHNUwNhxdrPG8B076EGLPbiqKSqiFrdLs4Yi50cxN4LwTUxuMamIFk+r921NrrH6mmmd6C2YxP49LMFRFKzCgUoAFvgTOeymLO9E8hG1pFEYfYQyGo9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSIEF2aNduWIsy2wIf0g8IgZWyZFoHVRJqOUct5snCYSQVVKctiEZ6DDrW1I8h/zEL8n817c2Qz8tt9I/uYKKdgZTpRPeu971rxXfQAIiumgQdnGsc0fpVNawwLdQXS4JzSqgPROvQld6zcFBCDB7RK+2HLS3sbruT5tp/4HDV6GnfUKzOu+93m1+PqPlciDNKJM5eaEWGVUyBHShfG7jZj0qKPtAMZQKfZala6pX2VXmdwYB497tCWDN2KDD9jqU3p0JEUlgbYWPCgfBKuGo9DriMfbiHg7volmahoLVoznb+9DDYBiNXXQIGmH+oULFznVjrgddfWpTSZWFs2oBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+sdhFhtgw1a4W/4mVVGkU9Ea5bDTz6mS63Ovj5RPV4=;
 b=xuO9U83mdQT92n43OcZtByXkmc9LU2aR+MMjKpnbxq1j8v9hVnMe3vf2L/I5MZmPOAyOlHmZFtxqlFhlE0Zhzi6roZFrwCaWK9uwIcyhI3ZqSCanRblNoxk5Up+ZFVtbumUvA3MvZBt2hQgia/HIuAF5nrWdoSpqV762NYBxeCsxblR4o+XdG1KPmObDhy2VRyaayJTDLs7PAnMCShRb7E5vgzSDiDvhY9iO+76cxMNXsNy6x6Xjra8SwfpnLhqlNq6F0no8eyzYFxBW9n0ILdjlYi730GfOzzSGO+iPVJLTIzpHXE+F1AkwtZg9UzQsP/5GMQUrbz8Oc3f8Iq/xog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2PPFE44924BEA.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::157) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 07:03:01 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 07:03:01 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Topic: [PATCH v5] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Index: AQHa/eIwzwcEDJ69bUWxWwoatqaLUrJ+Nk2E
Date: Wed, 9 Oct 2024 07:03:01 +0000
Message-ID:
 <PN3P287MB182905FC71F2924FDBE2C35A8B7F2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240903091720.443091-1-tarang.raval@siliconsignals.io>
In-Reply-To: <20240903091720.443091-1-tarang.raval@siliconsignals.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|PN2PPFE44924BEA:EE_
x-ms-office365-filtering-correlation-id: c2377451-e48f-4277-807e-08dce83069da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?j7iyEVA9nHCmO/j3DS4f5Km8rtOWTbHU14N8uTBtPzXk7Hj5Enw+fWjTxP?=
 =?iso-8859-1?Q?STqbtLT7Sx9cdXVIXyHnumgFqi2jtHtlyob9d9LagFflOEQLiDOF4Tya0x?=
 =?iso-8859-1?Q?xfdd3auFd6XVdTC/dGT3gLbAeVrt08ky0sfSxUU4hhOS1jSESHdNVDAPWF?=
 =?iso-8859-1?Q?fldhUt6TsGA/TS6LXd1cKarUJTdEhgRIMsNdwl+p2ecQuJmO+RkTt4FkOr?=
 =?iso-8859-1?Q?bxL9Dm5AfClY2qDCI+jh7IG1RdyhzMQKRT8s+mUzYmgdZTkzIp9ynY41VM?=
 =?iso-8859-1?Q?RFd0+zV84QY1ON9hriSa7FqnWMXowTjWm6+t50bj1Nkb/9xLj4Zixe2lK+?=
 =?iso-8859-1?Q?/KwHMFPIGZ8sXCYQdosRXn9wt6kG/i6QSHm9xsytIpbq4mdUw+Ha7ubR7+?=
 =?iso-8859-1?Q?5fKffgmo9tqUHLWaK6Z5BeZa2gRHHyD8xz4HBhc4RH+C15JYe9eoNPvFm6?=
 =?iso-8859-1?Q?B9uqk7bMeaenDn2WLPo3LFIkLszj5Qe7tfCzclzoEZ//0E9HuO6jYvaMCU?=
 =?iso-8859-1?Q?Q646GolUIdMjhdbRUpSJ1PMZS1382pU/S5DwxScxpS78Wh5zOFtFsHVtsY?=
 =?iso-8859-1?Q?Zm4mULY111HLZIsb4SUuWgllm1dOn6QU1JRl1mXuJ8GtGUoIZyMRVudzEC?=
 =?iso-8859-1?Q?KzrZWtQhEkIJMl09M4QXr7Km1v6wtlgIWQL+dUq9XW+xJvy2jAFYZ4AIPV?=
 =?iso-8859-1?Q?SqYR3g6l8eTQG2yOPETwX0Jgujtv7IBXyQcOtGZ+nnOhCOg5bc40yOSL5D?=
 =?iso-8859-1?Q?bLJsQ6IImGElS8ooFzep8wW3mlbJijI+t7LT2EoIcbEDTkg3OfzZvaxBkd?=
 =?iso-8859-1?Q?2uI4aKP2gnUhUM0esvWGCxXNh2KZcedW3XCCiYChUrlDEDvLCMgB3oZxRO?=
 =?iso-8859-1?Q?zMTQWB/mS1vXkhWuqNpWlB0HqiKbfWOt5wfs1c915FsHjPqC36v2ExT3kB?=
 =?iso-8859-1?Q?XOfcB+jpk+1IHrEBgA81RhIsjKFW5VWP+mjvsjZ+NaQh0u3HZPKqTKvyMd?=
 =?iso-8859-1?Q?P15zi7uifsKsdYMggm6L0pim7q/pH68KLouaEVnF0A0pWoquCTPrCmIcH3?=
 =?iso-8859-1?Q?pV67V9sSpGWhrhIvpHxv4GRyz5kSFQ0E4izxWzrBymd7l1vcj+X25DItmW?=
 =?iso-8859-1?Q?pMGJUN+5c9QtMQtIs3S0DM7l82XfiZed8WnnLJWWrkh5FvnleILxrhHqmA?=
 =?iso-8859-1?Q?1VHv6b/1gB6l0dhoGiDYxhDNsp1tx0LuQEAa9IsGFNSCu47SYwgSpsnzWb?=
 =?iso-8859-1?Q?qEVm0jJ9vCR3+5q0Uv/JBijFqleRDaEnE5XbftOBg6n/fTTEvYAViSab+5?=
 =?iso-8859-1?Q?RhBfdU669IwRtcniDI+aETgeiis51DkBIQZ/2GRvYu0u4/+m3S7qoTWQUZ?=
 =?iso-8859-1?Q?n6zxOK3l/aF8Lv5USAeHTgEUjdTH4rKQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yJ98XwNyxwrJAxINXaXpYTGQAJPUP+8MrB0uHJmfqdJ+jVbT3GqvgE6u4Y?=
 =?iso-8859-1?Q?U1AknSkFHXzDV0e0MNAm+MPQaCVlJnH1u2zDlkISL8RTWHAJ1bapMSRu8f?=
 =?iso-8859-1?Q?DFgJVuWvyRroyctjzX1zL8eewdgjxXR4ZRoHJnWPGo9en4dPFz/yqQIX96?=
 =?iso-8859-1?Q?1lMgGHj78AFzI5Sf7gjYoOaOuAdcVGs5oP5oGwvb1303MJFSiCl/QyrVKz?=
 =?iso-8859-1?Q?rhTUHHI4ILZNNTnU5a9GIwC7HvvqxTtVfBsC7W9x2I+06XL5Ctyd7WXQGj?=
 =?iso-8859-1?Q?qQHMaqedT5kvx0s9fCez6wskVgCXlX9cib+CtI5qIY8y4qvh7vIz9YYfrC?=
 =?iso-8859-1?Q?VLtDNaEv5Btfmj8RF1YDrDV8SOet5Tz7CnQsz5z1I/FwmNtRXf/yzpZ78w?=
 =?iso-8859-1?Q?Djyb82tzKEmNqo8My03h4TVZuwcz7HwZwEdILw05mgth22Teqk6+0C8Rmg?=
 =?iso-8859-1?Q?ZIlS7LvKOlLAjg0b/Gjxt038a+y9hMGh5zZ7h0u+zAhZh2gaAYzt1frmGZ?=
 =?iso-8859-1?Q?X0faoQ5JzxIxWjHvXChY02xcqMzzrjfrngHCZ4M30SYwtu+7jpn1IfZdp1?=
 =?iso-8859-1?Q?OZTgSQtqZEAY2QesRTFRwMjN8CvrGngaZmiO/N4h0yFe8oi440K+vD/GWg?=
 =?iso-8859-1?Q?e7dOfC5fvWHpO6X3EjBPa83n9ZluXJ0wstS8PbCy3ZHwpejMXtqbqndUSL?=
 =?iso-8859-1?Q?0PE1k3s3k1S8N+96Yd4j6udVgm2u/OTNIAwb0k9grs+phPjmf5yUxXBl6q?=
 =?iso-8859-1?Q?S0aEJNJDdLF7UhV3NV/MkY0EVEBITPhRlK6nI430wgH+aK3hkR1rlutw7c?=
 =?iso-8859-1?Q?EIUNR23Mf04mf1Bf3efFssEo1Lm9tjcwX79HmbK9um220H9A3sLcp9iYsX?=
 =?iso-8859-1?Q?dMi5Z/h4MImg7ZK6tT/fE+2Hubs0yc8K5i/R1FvhKAH7XMsFt0hH0fn+pN?=
 =?iso-8859-1?Q?RWbWTAry4nwfhiTGEmAqZts6iiBePhaqXgeifrA3WiGpfrA+d14RhCLjMj?=
 =?iso-8859-1?Q?4A/6prhIibPmD2t7vLZJXbmj+j6lqVaXPa4FlDGRJbZWKc8Zxtf9p71+ay?=
 =?iso-8859-1?Q?R7ZJO/IlTUy2qqLKVy+vN232NqG1yaYpYtBHcmnb9CYEGG+yk9ywsp+cG/?=
 =?iso-8859-1?Q?UQ3FjZqSc8HL17YdlYtTPW6bi8ayIKR91CJx4VRbZGuHfQ3DQXgrIgZTtR?=
 =?iso-8859-1?Q?sOOhRlszgSxMZPyeC3OfjxmMth4/Vw2UrNLeZ0nk3RR7ObvnW6MTol0nF6?=
 =?iso-8859-1?Q?ucLQQ2zsJriMh76CIfsvgZ4GIdmTGWwAKvPUiXY2hl+/kaW7RiWPeSt5AV?=
 =?iso-8859-1?Q?C3RMJPHh6qXIRAIBEWrfW0sHAD2qBh7noUmDOMMAKn8X+Y77WM/r6Cv2E0?=
 =?iso-8859-1?Q?rY5PMofsHekCW1choHo2BNkKKueLlTv2U+jk3OkLERvrus4AVC65gkPuh8?=
 =?iso-8859-1?Q?UJW0xkM/MDGBEmkpz4d9FAoaZrmj9nmq0W5vdr7bg+LHRQLISWbLftcTsg?=
 =?iso-8859-1?Q?BlMuThHKEGfJiXOv+WL6Fi8sc4ciGRKC6X6hAAF2aCQSY4L94Zbc9XThZx?=
 =?iso-8859-1?Q?Ze/F6iKHO1NgSfICZJf0lT3CXX0/3QROBlv/uEFDgyGau5B0kLglQiSqu9?=
 =?iso-8859-1?Q?MeGIfL0WIFqWrPLarDMh5CsRlOuH7R8Pj1orKz6eF3oiObScg96p7XFQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2377451-e48f-4277-807e-08dce83069da
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 07:03:01.1190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOPtL5O6sFyiFtvRjfbR+RoD/lzI0YWtncP79V6CpX0IA+KIT1HjejWyXFHGk0aoPNTdbd4vXgCWbhZPsKlMrLoTccWfY+VemqOJakkfDHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFE44924BEA

Hi Shawn,=0A=
=0A=
Just a gentle ping...=0A=
=0A=
________________________________________=0A=
From:=A0Tarang Raval=0A=
Sent:=A0Tuesday, September 3, 2024 2:48 PM=0A=
To:=A0shawnguo@kernel.org <shawnguo@kernel.org>=0A=
Cc:=A0Tarang Raval <tarang.raval@siliconsignals.io>; Rob Herring <robh@kern=
el.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@k=
ernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team =
<kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; devicetree@vge=
r.kernel.org <devicetree@vger.kernel.org>; imx@lists.linux.dev <imx@lists.l=
inux.dev>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.inf=
radead.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0[PATCH v5] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals S=
upport=0A=
=A0=0A=
Add following peripherals support for the Emtop i.MX8M Mini Baseboard=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 * Wi-Fi=0A=
=A0=A0=A0=A0=A0=A0=A0 * Audio=0A=
=A0=A0=A0=A0=A0=A0=A0 * SD card=0A=
=A0=A0=A0=A0=A0=A0=A0 * RTC=0A=
=A0=A0=A0=A0=A0=A0=A0 * CAN bus=0A=
=A0=A0=A0=A0=A0=A0=A0 * USB OTG=0A=
=0A=
Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>=0A=
---=0A=
=0A=
Changes in v2:=0A=
=0A=
1. Updated the node name and pinctrl name.=0A=
2. Removed the 'regulators' container.=0A=
3. Removed a stray blank line.=0A=
4. Removed non-existent properties.=0A=
5. Removed unused node and pinctrl:=0A=
=A0=A0 -modem-reset=0A=
=A0=A0 -pinctrl_uart1=0A=
6. Defined the CAN transceiver reset GPIO separately.=0A=
=0A=
Change in v3:=0A=
=0A=
1. Removed 'can-connector'.=0A=
2. Use USB connector instead of extcon_usb.=0A=
3. Changed id-gpio to id-gpios.=0A=
4. Use Level trigger IRQ in the CAN node.=0A=
5. Corrected the compatible property of RTC.=0A=
6. Added blank lines to separate the pinctrl groups.=0A=
=0A=
Changes in v4:=0A=
=0A=
1. Sorted I2C device nodes by slave address.=0A=
2. Moved properties above the "status" property in the Wi-Fi node.=0A=
=0A=
Change in v5:=0A=
=0A=
1. I mistakenly removed <pinctrl-canbus>; it has now been re-added.=0A=
2. Added Author name=0A=
---=0A=
=A0.../dts/freescale/imx8mm-emtop-baseboard.dts=A0 | 335 ++++++++++++++++++=
=0A=
=A01 file changed, 335 insertions(+)=0A=
=0A=
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts=0A=
index 7d2cb74c64ee..90e638b8e92a 100644=0A=
--- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts=0A=
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts=0A=
@@ -1,6 +1,9 @@=0A=
=A0// SPDX-License-Identifier: (GPL-2.0+ OR MIT)=0A=
=A0/*=0A=
=A0 * Copyright 2023 Emtop Embedded Solutions=0A=
+ *=0A=
+ * Author: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>=0A=
+ * Author: Tarang Raval <tarang.raval@siliconsignals.io>=0A=
=A0 */=0A=
=A0=0A=
=A0/dts-v1/;=0A=
@@ -11,6 +14,113 @@ / {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 model =3D "Emtop Embedded Solutions i.MX8M Mini Ba=
seboard V1";=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "ees,imx8mm-emtop-baseboard", "ees,=
imx8mm-emtop-som",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "fsl,imx8mm";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 connector {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "usb-c-connector=
";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 label =3D "USB-C";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_usb_otg=
>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 id-gpios =3D <&gpio1 10 GPIO_AC=
TIVE_HIGH>;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 port {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 high_sp=
eed_ep: endpoint {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 remote-endpoint =3D <&usb_hs_ep>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 leds {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "gpio-leds";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_gpio_le=
d>;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 led-1 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 label =
=3D "buzzer";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpios =
=3D <&gpio4 29 GPIO_ACTIVE_HIGH>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default=
-state =3D "off";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 osc_can: clock-osc-can {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "fixed-clock";=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #clock-cells =3D <0>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clock-frequency =3D <16000000>;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clock-output-names =3D "osc-can=
";=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 reg_audio: regulator-audio {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "regulator-fixed=
";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "wm8904_supp=
ly";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <18=
00000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <18=
00000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 reg_wifi_vmmc: regulator-wifi-vmmc {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "regulator-fixed=
";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "vmmc";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <33=
00000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <33=
00000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpio =3D <&gpio2 10 GPIO_ACTIVE=
_HIGH>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable-active-high;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 startup-delay-us =3D <100>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 off-on-delay-us =3D <20000>;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 sound-wm8904 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "simple-audio-ca=
rd";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 simple-audio-card,bitclock-mast=
er =3D <&dailink_master>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 simple-audio-card,format =3D "i=
2s";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 simple-audio-card,frame-master =
=3D <&dailink_master>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 simple-audio-card,name =3D "wm8=
904-audio";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 simple-audio-card,mclk-fs =3D <=
256>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 simple-audio-card,routing =3D=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Headph=
one Jack", "HPOUTL",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Headph=
one Jack", "HPOUTR",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "IN2L",=
 "Line In Jack",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "IN2R",=
 "Line In Jack",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Headph=
one Jack", "MICBIAS",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "IN1L",=
 "Headphone Jack";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 simple-audio-card,widgets =3D=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Microp=
hone","Headphone Jack",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Headph=
one", "Headphone Jack",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Line",=
 "Line In Jack";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dailink_master: simple-audio-ca=
rd,codec {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sound-d=
ai =3D <&wm8904>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 simple-audio-card,cpu {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sound-d=
ai =3D <&sai3>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 sound-spdif {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "fsl,imx-audio-s=
pdif";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 model =3D "imx-spdif";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spdif-controller =3D <&spdif1>;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spdif-out;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spdif-in;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+};=0A=
+=0A=
+/* CAN BUS */=0A=
+&ecspi2 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_ecspi2>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0 can: can@0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "microchip,mc=
p2515";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_canb=
us>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clocks =3D <&osc_can>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-parent =3D <&gpio1=
>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupts =3D <14 IRQ_TYPE_=
LEVEL_HIGH>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spi-max-frequency =3D <10000=
000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 };=0A=
=A0};=0A=
=A0=0A=
=A0&fec1 {=0A=
@@ -40,7 +150,135 @@ vddio: vddio-regulator {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
=A0};=0A=
=A0=0A=
+&i2c3 {=0A=
+=A0=A0=A0=A0=A0=A0 clock-frequency =3D <100000>;=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_i2c3>;=0A=
+=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 wm8904: audio-codec@1a {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "wlf,wm8904";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x1a>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #sound-dai-cells =3D <0>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clocks =3D <&clk IMX8MM_CLK_SAI=
3_ROOT>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clock-names =3D "mclk";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DCVDD-supply =3D <&reg_audio>;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DBVDD-supply =3D <&reg_audio>;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AVDD-supply =3D <&reg_audio>;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPVDD-supply =3D <&reg_audio>;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MICVDD-supply =3D <&reg_audio>;=
=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 rtc@32 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "epson,rx8025";=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x32>;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+};=0A=
+=0A=
+/* AUDIO */=0A=
+&sai3 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_sai3>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 assigned-clocks =3D <&clk IMX8MM_CLK_SAI3>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 assigned-clock-parents =3D <&clk IMX8MM_AUDIO_PLL1_O=
UT>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 assigned-clock-rates =3D <24576000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+};=0A=
+=0A=
+&spdif1 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_spdif1>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 assigned-clocks =3D <&clk IMX8MM_CLK_SPDIF1>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 assigned-clock-parents =3D <&clk IMX8MM_AUDIO_PLL1_O=
UT>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 assigned-clock-rates =3D <24576000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 clocks =3D <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM=
_CLK_24M>,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&clk IMX8MM_CLK_SPDIF1>, <&=
clk IMX8MM_CLK_DUMMY>,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&clk IMX8MM_CLK_DUMMY>, <&c=
lk IMX8MM_CLK_DUMMY>,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&clk IMX8MM_CLK_AUDIO_AHB>,=
 <&clk IMX8MM_CLK_DUMMY>,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&clk IMX8MM_CLK_DUMMY>, <&c=
lk IMX8MM_CLK_DUMMY>,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <&clk IMX8MM_AUDIO_PLL1_OUT>=
, <&clk IMX8MM_AUDIO_PLL2_OUT>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 clock-names =3D "core", "rxtx0", "rxtx1", "rxtx2", "=
rxtx3",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "rxtx4", "rxtx5", "rxtx6", "=
rxtx7", "spba", "pll8k", "pll11k";=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+};=0A=
+=0A=
+/* USBOTG */=0A=
+&usbotg1 {=0A=
+=A0=A0=A0=A0=A0=A0 dr_mode =3D "otg";=0A=
+=A0=A0=A0=A0=A0=A0 usb-role-switch;=0A=
+=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 port {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb_hs_ep: endpoint {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 remote-=
endpoint =3D <&high_speed_ep>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+};=0A=
+=0A=
+&usbotg2 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 dr_mode =3D "host";=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+};=0A=
+=0A=
+/* Wifi */=0A=
+&usdhc1 {=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default", "state_100mhz", "state_200=
mhz";=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>=
;=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc=
1_gpio>;=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc=
1_gpio>;=0A=
+=A0=A0=A0=A0=A0=A0 bus-width =3D <4>;=0A=
+=A0=A0=A0=A0=A0=A0 vmmc-supply =3D <&reg_wifi_vmmc>;=0A=
+=A0=A0=A0=A0=A0=A0 cap-power-off-card;=0A=
+=A0=A0=A0=A0=A0=A0 keep-power-in-suspend;=0A=
+=A0=A0=A0=A0=A0=A0 non-removable;=0A=
+=A0=A0=A0=A0=A0=A0 #address-cells =3D <1>;=0A=
+=A0=A0=A0=A0=A0=A0 #size-cells =3D <0>;=0A=
+=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 wifi: wifi@1 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "brcm,bcm4329-fm=
ac";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <1>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-parent =3D <&gpio2>;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupts =3D <9 IRQ_TYPE_LEVE=
L_LOW>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-names =3D "host-wake"=
;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+};=0A=
+=0A=
+/* SD-card */=0A=
+&usdhc2 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_usdhc2>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 cd-gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 bus-width =3D <4>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+};=0A=
+=0A=
=A0&iomuxc {=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_canbus: canbusgrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_GPIO1_IO14_GPIO1_IO14=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x14=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_ecspi2: ecspi2grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ECSPI2_SS0_ECSPI2_SS0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x82=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ECSPI2_MOSI_ECSPI2_MOSI=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x82=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ECSPI2_MISO_ECSPI2_MISO=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x82=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ECSPI2_SCLK_ECSPI2_SCLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x82=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_usb_otg: usbotggrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_GPIO1_IO10_GPIO1_IO10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x140=A0=
=A0 /* otg_id */=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_GPIO1_IO12_GPIO1_IO12=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x19=A0=
=A0=A0 /* otg_vbus */=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl_fec1: fec1grp {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX=
8MM_IOMUXC_ENET_MDC_ENET1_MDC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0x3=0A=
@@ -60,4 +298,101 @@ MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL=A0=A0=A0=
=A0 0x1f=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX=
8MM_IOMUXC_SAI2_RXC_GPIO4_IO22=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0x19=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_i2c3: i2c3grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_I2C3_SCL_I2C3_SCL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
0x400001c3=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_I2C3_SDA_I2C3_SDA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
0x400001c3=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_sai3: sai3grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SAI3_TXFS_SAI3_TX_SYNC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0xd6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SAI3_TXC_SAI3_TX_BCLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0xd6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SAI3_MCLK_SAI3_MCLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0xd6=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SAI3_TXD_SAI3_TX_DATA0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0xd6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SAI3_RXD_SAI3_RX_DATA0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0xd6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_spdif1: spdif1grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SPDIF_TX_SPDIF1_OUT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0xd6=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_usdhc1: usdhc1grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_CLK_USDHC1_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x=
190=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_CMD_USDHC1_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x=
1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA0_USDHC1_DATA0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA1_USDHC1_DATA1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA2_USDHC1_DATA2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA3_USDHC1_DATA3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp{=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_CLK_USDHC1_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x194=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_CMD_USDHC1_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA0_USDHC1_DATA0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA1_USDHC1_DATA1=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA2_USDHC1_DATA2=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA3_USDHC1_DATA3=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_CLK_USDHC1_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x196=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_CMD_USDHC1_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA0_USDHC1_DATA0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA1_USDHC1_DATA1=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA2_USDHC1_DATA2=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA3_USDHC1_DATA3=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_usdhc1_gpio: usdhc1-gpiogrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_RESET_B_GPIO2_IO10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x41=A0=A0=
=A0 /* wl_reg_on */=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD1_DATA7_GPIO2_IO9=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x41=
=A0=A0=A0 /* wl_host_wake */=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K=A0=A0=A0=A0=A0 0x141=A0=A0 /* LP0: 32KH=
z */=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_usdhc2: usdhc2grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_CLK_USDHC2_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x190=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_CMD_USDHC2_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA0_USDHC2_DATA0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA1_USDHC2_DATA1=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA2_USDHC2_DATA2=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA3_USDHC2_DATA3=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_CLK_USDHC2_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x194=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_CMD_USDHC2_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA0_USDHC2_DATA0=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA1_USDHC2_DATA1=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA2_USDHC2_DATA2=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA3_USDHC2_DATA3=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_CLK_USDHC2_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x196=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_CMD_USDHC2_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA0_USDHC2_DATA0=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA1_USDHC2_DATA1=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA2_USDHC2_DATA2=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SD2_DATA3_USDHC2_DATA3=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
=A0};=0A=
--=0A=
2.34.1=0A=

