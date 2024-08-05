Return-Path: <linux-kernel+bounces-274511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D428947928
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25DF1F220C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F21547CF;
	Mon,  5 Aug 2024 10:13:00 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2097.outbound.protection.outlook.com [40.107.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E739481C0;
	Mon,  5 Aug 2024 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852779; cv=fail; b=Ts94/OXMyuoB26yCougB0uDNKozhTcyoLwvrFwoQRKko+WIWNghLAcNIgdC2xghVsT7BT9qlry/GHp6hIjq25MEtRUF2brWhm0Ua19hfa6c3d6UbQzYsGwz3cTNmFFZuEZWSrJ6oHukhp92DaJt5WtHHvF8N5YnwjBej5hUoN2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852779; c=relaxed/simple;
	bh=dD0WL0W4/+H1mBToZMEDpen5wtF6gHuVZeYD7ayGCEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=COiujxFAPL2Opyof5vdl9BV5DRtJcfJQSKiF7mSdIUsu+BBYZVLLlSV6M+DMgOxvjonNanf2nnnf7pxP4ZUo1apX279/XcMbA5r6aX9h1am5eyQm7i+LGzRrLX80o4WwQY2TMd4qffQrraKtcE/83agQqyriZfRkL31b07H1qUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laavLBrcKm5QFQJ/FYVfhbpdWAqxpcUzDSlQIVyaFuOWey5jtXpmmul855FA1phI84vPtWP98auGq+Mh6ZSU9LKtImw9haWELrrVoBFXL2o+/jkI5Pf/GlVjH0WquMRfw/JLDL3pKMeNudWmgJUyitjiqoR8+Q0zGmTyfh5p7pa/r6DdXDkE0JmX/Vk6a17gtMXVbVoscRwdlVZWli5uCXjtMDVUObZG1jWuivPmxg9hOyeJ1O0QKi1p4fBXpjqoPPoCS8FpQxnNJfenR2Xq5NnDtaxL3vFTrk3gS6o68MFibF0eavTJiLDx0Nel+7ZRqZa+2Bjj7bLlC+9yosjIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dD0WL0W4/+H1mBToZMEDpen5wtF6gHuVZeYD7ayGCEY=;
 b=X5r4qGKEYG2XC4i+fKESGdgB8IiUjW+gcadD9pA3RLRZX7SgaNneEoUqCycd6/o4xZelIYMq+HE1bsXl2UPEwMWjn7IHYFJDeXTv2RJKlWERsKuVzNjwhf159obKgjBe/2gkip23mOfGHd/L1k51LfxtPwVklckhNP18qGJr6IxI+CcJnaHz9+GpXXdMErgu8YyxI1vSPhvlDwcVA78K9lKQ9AAIe0Cr4T8plKNhL3qKcvcgcgmlFUvYuVFoVmSmIW4uTfT4JO04yDKD/h9KzJLJjKJDY7m99eSJ3feJ27bLr7ObQDUIwUjdaUEMvNeFglHTMQSi6v72aArYjS2uUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN0P287MB0198.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 10:12:53 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 10:12:53 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Ethernet
 Support
Thread-Topic: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Ethernet
 Support
Thread-Index: AQHa3o3H1+ScWhvARkGVPfAPDdG7LrIYgdtl
Date: Mon, 5 Aug 2024 10:12:52 +0000
Message-ID:
 <PN3P287MB182947A91A8E381988B6F6198BBE2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240725122522.5030-1-tarang.raval@siliconsignals.io>
In-Reply-To: <20240725122522.5030-1-tarang.raval@siliconsignals.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|PN0P287MB0198:EE_
x-ms-office365-filtering-correlation-id: bde0c7be-fcfe-4c4f-a616-08dcb5372b13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?35imuW+/fQDblUAMMFRp4gp3lcJ2sIX/v+NKkQGksV02O89/4o78WEzXzJ?=
 =?iso-8859-1?Q?nXTCYDxLHU3ng9nACYNvgna7x8XO27UF04gsbHudxOmoESQTlvgqzRqYxi?=
 =?iso-8859-1?Q?JyhEyAKz7a90VjbZj58U4mWWwXs2aUy3xSezjRorCksPNCSlgpqOSwTdoS?=
 =?iso-8859-1?Q?FfcPtHVgSRuJ5IEuhI8fH2xz4KPtPT1TAl20G4naNZqjyMolPYqj36A/Zt?=
 =?iso-8859-1?Q?HENhIrZNwXY6/S36kzbOf94jUkqZNIpCuRrJ/AlNTy5+tFFyZdpkq1qPQY?=
 =?iso-8859-1?Q?TKeARFpghj5HFxc1J9bHR86WHxV5kIqfvaJWUpkcXr0zolE7FftkEcVegG?=
 =?iso-8859-1?Q?smuwapUIk3XKy/Dboj3YyIIU5vCYVwZTKw8kKxbilbFXFvF6U4n/QtDIjW?=
 =?iso-8859-1?Q?TJ2B8MbKWYA/kasMPxtKMKeVCA8r9/rEpjX0+hloI/jJXbc8eXRaWsHS3V?=
 =?iso-8859-1?Q?5JzrZtxBatcg5wZiB1vo1WJr56kRk56aOR5wRDbRNy10n5zDLh1DkPKtmd?=
 =?iso-8859-1?Q?PM37I8yN/6hnKCBv0XsgnsCi6a1krevux53vpPzZPndwK2Bx1ky/KPgQOk?=
 =?iso-8859-1?Q?bwNOqWW/buhV8JdjlAFLg4Skxc7EKkY5F0Jp51jgQ3il6V//S1OEZo4E3O?=
 =?iso-8859-1?Q?vjdEXCNC9MbfQZ9oSzYIyPotqZqsXWhGj/YOSUTSUXbE8crV2MJhqoOtrb?=
 =?iso-8859-1?Q?+vhNKIh/YgL4jxM4e+BqfYj+xO/jEvEphYa1ts4rEc4goeuis5xmif3RNH?=
 =?iso-8859-1?Q?BCYBwCYgCMsFp9hpxf1XcFhUDPJH2P6jycGJym12dXbMgf0HccA2AKPg4s?=
 =?iso-8859-1?Q?SyUl8OjjMuJi0FGbjVgKQKYRe8SRws79bgjfM5NDVYLHxEuap7c24csR71?=
 =?iso-8859-1?Q?hL1ET+PSdtWnaT3EM6tGXvhquI3pK35gbZ4nW3rE8/XcKvmOhxrbpJzteJ?=
 =?iso-8859-1?Q?vFI62YVzYqdQU0ASN7jVOgLzawXO8Xs+hh5v7+Gq142aDNFjPiy+hlYIFz?=
 =?iso-8859-1?Q?VGRedaHNuDWd9TSC7bj/JpotYTy1Yw8jfsE0tTnCMJ710BtiNXFP7HgHAe?=
 =?iso-8859-1?Q?1W34Ml+iIgn2PWQHjWPVlzOIP0CavXrNTifNMxPP2rhlGkVqMgdyDWBgwY?=
 =?iso-8859-1?Q?5a/iSzhtHJmW4pMrekdB/tMMYdGP9663QziUm5ipgm5QCyg2xXJbvcSBVd?=
 =?iso-8859-1?Q?f8mDxbRVBN06WAYd2RFl5gjp1WqPpucLLrvkJwwXeP7qAbxllfNfSTo+wi?=
 =?iso-8859-1?Q?xaZfui85HFa+MziQO5+ENX101igI5sxdZ6n55ARKrfloBDr4xOiohtj94C?=
 =?iso-8859-1?Q?KhQqDQnULwE92VHjH0huKN0L11iLD36/N8ppsA2LgBwdWZm19QHiQDe8fq?=
 =?iso-8859-1?Q?aUw3mqChrCc38GN1VdTzg5lYcBOkfkFxb19ZqV8QuKYK0j4BfSAjIaLf20?=
 =?iso-8859-1?Q?tD/EM3xd4sglXIx3fQrtdKQHS+U1RjkPlmvf7w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2+kejFrBl6AnADyOHV0QBbEMB1y11PPd+wcJY9wHzUEponTPU72MRvX8Sb?=
 =?iso-8859-1?Q?PYwaaaTRIoXkaG8EFmb4Uok+i21Mhi0kwgF08ChlJAloifFQlGGv0/QLBK?=
 =?iso-8859-1?Q?HejEsLErOUg4XkgysheFMKYf2jOcpdpefI+YQl+qSVi2rQ8dYM3u7a0O9o?=
 =?iso-8859-1?Q?9uTx8duIUYxdKpGhf78fy3MRBI3B5xzMiZmd852Y3p4C373Cv4AmDFovdY?=
 =?iso-8859-1?Q?Yb5NszTA6h8EiSmmz8zD9KQKInXUIbhhlH75xPcdeXJWaIyCZCSd39LT5C?=
 =?iso-8859-1?Q?KlM8E2Rnt9OTLp3SaTKZfHMgkLQq38sgX1uXmRsf98LLghDN12lQp5xYIG?=
 =?iso-8859-1?Q?DuFOg1fxeYojLOFv8Rugpefm4RF2ATq2cxWJouEq6h9vfImSn3575KJR1S?=
 =?iso-8859-1?Q?Gj05jYi4ETocpaWuqW4pj2eO9yZy7QpRdwvwL7e/N8bYOxroY2bJuT6lwp?=
 =?iso-8859-1?Q?GYB0aekGGQU2PGoYcQFmT1jYGHBacumItJjS2NSUPCo+DhQ6MUgB4SaLUS?=
 =?iso-8859-1?Q?iyx8hOcZQAeLTM68hKLJyuYKiVb4m22Ru5B/D0vnTVqne71VyZEt3TSFVn?=
 =?iso-8859-1?Q?iFEEIT8iAvKUzuzmCKPu1SDy5FMDpRuo1dyve1a6AvU7pk43kKrtul7qYF?=
 =?iso-8859-1?Q?qbPE4pBhxNYVLZzVaF3uIEKw64XuvUry85r8xv/ER/lEWmJseu/vxBJ2bG?=
 =?iso-8859-1?Q?7pXrcK4QoXPCocAAFl5mxg0jQmr4jFqAPvD0mGnUXOMCP2muVgucl4ou0J?=
 =?iso-8859-1?Q?VvWjiiPpdlPaEMbCSneC7A267WduFfTM4vdncp8zgUbfK1sxEPSXBsUvXQ?=
 =?iso-8859-1?Q?AdvbomvQM2BeVbJIRTiztAS0mVfcGNt2TGIeBG1jIHyC4vtuPWpYnMOLX/?=
 =?iso-8859-1?Q?nybfJSmrPjwN7YEGL45h2wGFOibU8LZ7IjwA+c79neRIZwWeUahpQEOrP/?=
 =?iso-8859-1?Q?Uu1NAwOzwpMycxHs1FD/GXDPcIi1i+NUnqUzhh9Qh6+N7zXJ+IHOnltvEg?=
 =?iso-8859-1?Q?b6L035uIsQn+kJNrz6t0mCiOe6wum4weI5spyDeB8o/qHblf184zFvwd/y?=
 =?iso-8859-1?Q?qpVITkQ7dKsSrF8Z+NdP6u5pmXogfBrBAJwrWDJNI6SYK6NG+KK36Q4eZS?=
 =?iso-8859-1?Q?zIViiD4oNyIH1rZOE47oumpMelApOx0zTHo9LAgJzLoFYR5SV5cC8hSCy5?=
 =?iso-8859-1?Q?Wu39XEvXSJgdX5WP6F4M1CB5U3nXvL4KIsQj5cSGWfJH0NaIz1kNkhZ+N4?=
 =?iso-8859-1?Q?8PmXE/5jgaGnmHmTKgBOavxW7onUkkf7oPFF9U3U/Cw2XXLENcPCz5FmDP?=
 =?iso-8859-1?Q?/Cb1APP33zHCRaFaXV4rYcPRT/GqQPHUTbYn6mAa4oOuuk3qOQUpyAMK/5?=
 =?iso-8859-1?Q?oNOVjYmT8dRTXl4yxTrTy1TI/MzE5Vme1U7tga1dxZz0WIl/eEa9Ug4Fwn?=
 =?iso-8859-1?Q?1k+oek6FTVYPG2sr5yYndk/RQmrqngyfg+6XWxcTtM2Qc8qwWpJIcqhxyd?=
 =?iso-8859-1?Q?LcdjdtZpwrgJpxTvhLkgQdCniGadzhPkhKhZdbLKlk/wGJ8vm9+TpcvnlA?=
 =?iso-8859-1?Q?5waHWOZoDTQCMXuQnZGC0xzpJFC6T0UvsgG4lJeu9XjmZD+JFMRK4AwYgW?=
 =?iso-8859-1?Q?J9DtGhN7d8DK8+37q7ksmLcEkuB/RrDZ6ineMvbZzpT/zcbvORJqlWAw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bde0c7be-fcfe-4c4f-a616-08dcb5372b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 10:12:52.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulbHUF/upwLwqhdJwIfd3v3v0g8474zogNaE8Db9xsE8XSoHy6s+pU6Z7hvhjmiPB7GZ7RJEcWjBxwxmSY6/Ff1QoFRyWOmKiYkUeFixzvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0198

As per your comments on v2 patch I have shared an updated version of the pa=
tch (v3-0001-arm64-dts-imx8mm-emtop-baseboard-Add-Ethernet-Sup.patch) with =
the recommended corrections.=0A=
is there any updates on this patch?=0A=
=0A=
Best regards, =0A=
Tarang =0A=
=0A=
________________________________________=0A=
From:=A0Tarang Raval=0A=
Sent:=A0Thursday, July 25, 2024 5:55 PM=0A=
To:=A0krzk+dt@kernel.org <krzk+dt@kernel.org>; shawnguo@kernel.org <shawngu=
o@kernel.org>; festevam@gmail.com <festevam@gmail.com>=0A=
Cc:=A0Tarang Raval <tarang.raval@siliconsignals.io>; Rob Herring <robh@kern=
el.org>; Conor Dooley <conor+dt@kernel.org>; Sascha Hauer <s.hauer@pengutro=
nix.de>; Pengutronix Kernel Team <kernel@pengutronix.de>; devicetree@vger.k=
ernel.org <devicetree@vger.kernel.org>; imx@lists.linux.dev <imx@lists.linu=
x.dev>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infrad=
ead.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0[PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Ethernet Supp=
ort=0A=
=A0=0A=
Add ethernet support for emtop imx8mm basboard=0A=
=0A=
Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>=0A=
---=0A=
Change in V3=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 1. Add appropriate commit=0A=
=A0=A0=A0=A0=A0=A0=A0 2. Add Changelog at correct place=0A=
=0A=
Change in V2=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 1. Add Board name into subject=0A=
=A0=A0=A0=A0=A0=A0=A0 2. Remove below properties=0A=
=A0=A0=A0=A0=A0=A0=A0 - at803x,eee-disabled;=0A=
=A0=A0=A0=A0=A0=A0=A0 - at803x,vddio-1p8v;=0A=
---=0A=
=A0.../dts/freescale/imx8mm-emtop-baseboard.dts=A0 | 48 +++++++++++++++++++=
=0A=
=A01 file changed, 48 insertions(+)=0A=
=0A=
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts=0A=
index 1c4e4d175989..7d2cb74c64ee 100644=0A=
--- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts=0A=
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts=0A=
@@ -11,5 +11,53 @@ / {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 model =3D "Emtop Embedded Solutions i.MX8M Mini Ba=
seboard V1";=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "ees,imx8mm-emtop-baseboard", "ees,=
imx8mm-emtop-som",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "fsl,imx8mm";=0A=
+};=0A=
+=0A=
+&fec1 {=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_fec1>;=0A=
+=A0=A0=A0=A0=A0=A0 phy-mode =3D "rgmii-id";=0A=
+=A0=A0=A0=A0=A0=A0 phy-handle =3D <&ethphy0>;=0A=
+=A0=A0=A0=A0=A0=A0 fsl,magic-packet;=0A=
+=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 mdio {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D <1>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D <0>;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ethphy0: ethernet-phy@4 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compati=
ble =3D "ethernet-phy-ieee802.3-c22";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D=
 <4>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reset-g=
pios =3D <&gpio4 22 GPIO_ACTIVE_LOW>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reset-a=
ssert-us =3D <10000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vddio-s=
upply =3D <&vddio>;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vddio: =
vddio-regulator {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <1800000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <1800000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+};=0A=
=A0=0A=
+&iomuxc {=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_fec1: fec1grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_MDC_ENET1_MDC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x=
3=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_MDIO_ENET1_MDIO=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x3=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_TD3_ENET1_RGMII_TD3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1f=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_TD2_ENET1_RGMII_TD2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1f=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_TD1_ENET1_RGMII_TD1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1f=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_TD0_ENET1_RGMII_TD0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1f=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_RD3_ENET1_RGMII_RD3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x91=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_RD2_ENET1_RGMII_RD2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x91=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_RD1_ENET1_RGMII_RD1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x91=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_RD0_ENET1_RGMII_RD0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x91=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_TXC_ENET1_RGMII_TXC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1f=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_RXC_ENET1_RGMII_RXC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x91=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL=A0=A0=A0=A0 0x91=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL=A0=A0=A0=A0 0x1f=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MM_I=
OMUXC_SAI2_RXC_GPIO4_IO22=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x19=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
=A0};=0A=
--=0A=
2.34.1=0A=

