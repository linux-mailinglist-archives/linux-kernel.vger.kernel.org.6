Return-Path: <linux-kernel+bounces-535551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C02A47474
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4EB3A2BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C3A1D63CD;
	Thu, 27 Feb 2025 04:27:46 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB091A38E3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630465; cv=fail; b=kFR8WrjJQS67K2yw/NEDQX7nNNqcjx9hMbIUPcCUlj7Q7wxhsoXBZoF8hFTmMsYmAquUL24GwdLSfVTuyCIVpqm7LE0I1tnEdVt0BtvKrdjxsn3kf6U090Mdy0YRTQDAWNRb2uVFBcy0uVTdT4o4jdqyW8aZJzJhEnvaC+nBCGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630465; c=relaxed/simple;
	bh=Lwa0IQliJ8BEq4SCAgogG4k3+h2UD0EMaoYsPZcVxZ0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o/jKeee+5Jgl/yJiL0x6ZLRQlm0zaeEkEhwFCvcDgUsJ5l9T3dufHkUQXGL6/VM5JD+RqDkOQrwV6zX/A+6o5ducTgtF2SrDaHKQX+ffcVaVQ+fS6ybUtre6LwVoh2qxgMSjLrBB7mlRP5otbulUJ3266ubLxlclfVL7E+ydtvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqjnT87fIiPv5bHoL5rPzYNe/aX2iYcioYUyQ48m57ZzAMF4gVeYBJEbZHVD/MURHCpbb3xUNLtFCPGPwdZDahnKeQxhgBBdpr9Kls5NfMHm/kiObR8FYeimO8/ZNqihxOrZdlciiwq3qUmi4so9sLzbTT3+RFpSSq0L+08OjZrllCnJqP1Bx+CoVI/H4SqZKYIgmtPIMuNXbL0FduuPIDkIgJb/E4lnxuydApXd2S20SuLy9yIkA+SHN+8t6MAIe2Fyb8jK6yW7PoDRzJtmP0KaUU0K/KnKNmR3UPjjyuKd7gx3Fqzx6KprE/eCh35S4rez9SylYIlicUsx7bx6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuU7TopDyERisMhKE6D7jEs+WRec+Ri4qO4291jwkOw=;
 b=B3++D47Bb/zu2zsYaIRFJyAzcYi5W7CHLNWh06om8JoLwbR7PGxJiF/LDRMnsawH/iQHN7KtLdxnpyajzLPav/7JLVtoLzwCeI5mADC4Nd7ltfeR7eR/fjHdjlg6R7LrHAiLfns48tAGhQu3SvhrP4bQgm3MioTlcFFraUrSAo7VaZFoeat6IHRKD4EdRAbMZFfbLGWuBqpec8DV0ssjCOtT2drrSk/7MrevcevLobhARnoQ9X6x0DVliJLu210MeWJXaU41MyzSdOh50Cxy7oyc8pNz0/i9bdYC0PYZalP+b2BzlCoPuAhLiETx8VLOThKVMtEBdZwaMHYHIu2rCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::11) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.15; Thu, 27 Feb
 2025 02:53:51 +0000
Received: from ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
 ([fe80::6949:6e77:b17f:c6d0]) by
 ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn ([fe80::6949:6e77:b17f:c6d0%4])
 with mapi id 15.20.8489.014; Thu, 27 Feb 2025 02:53:51 +0000
From: Tingbo Liao <tingbo.liao@starfivetech.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
CC: Tingbo Liao <tingbo.liao@starfivetech.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Fix the __riscv_copy_vec_words_unaligned implementation
Thread-Topic: Fix the __riscv_copy_vec_words_unaligned implementation
Thread-Index: AduIwkod/W+x7D/lR1mCACD0gkE+/A==
Date: Thu, 27 Feb 2025 02:53:51 +0000
Message-ID:
 <ZQ0PR01MB098393466A0CB4722C8D62279BCDA@ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB0983:EE_|ZQ0PR01MB1239:EE_
x-ms-office365-filtering-correlation-id: 208bfd26-625f-4dbc-2e06-08dd56d9f75f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|8096899003|4053099003|38070700018;
x-microsoft-antispam-message-info:
 3i5rtAniRYq0gaefUXzTzIDceKSEJi5EaGwO9QpDYzii6iDtWc/rN3vncdbmH40mv/FQR0QnnCSDSMABteLmrKog+zTjUDUvOcQcXJrSeBefNPBnZ2uQ3VMwaNqhbgHFLJQpUF0sskuqtniT8mZI2HjIaQRqvTFXvdqwiZw7AgqDvoTUZoYk+r2kwh135xpSEqmAJMfGff4q+cZS/4u2Swq62Ry3aATES6CFhKwk/DdivMZFjOpGAngCOlqQG4UGZgbwifqNpgn/NgsHNuSNL0SfZu/dVHiYDgYxO8J2bG0ZanJeJlOk1OA0jlXHTF4YKAvJGnQsXbm0wGjK91DB+OMqHvWg0O/FHbLLnMBi0iMtiFjvOc3QL7j28bVqkMbv5IH3oqzaVu8wEAx5+iWPWEMmkAhbrQwuZCrN5B5bWzzArgwm7Dese86Wc4vbJun/zU+kSTEcUED39fMvzVa/dRdsUH/C4hnNPhv4uqw4OQm9ENGuOo9ozg+FIGqb9NUDONUaZjyC20QDTg7YSNbaWdkoATfiv2YkJzbJ9YPDvv+tBd79QHj6E9sorBiG8ThDkITKbeC76I1/cNopyxlo3a1GPt+Gq3HGpm2FmYGZ7p8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(8096899003)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h+l9gBKOx4HSvau50G1VTDEkH1dbgB+A2pvVuUaSgaqiChzYWeANdcFjO+nH?=
 =?us-ascii?Q?BUpCx54m1wtGhx5XqicgZtoMhnraE5Wjq0AdR10SbWiT2GdShjtsNIVD+Olh?=
 =?us-ascii?Q?9QGRztla9ta9hx4kHZtBecY29HMd/kXjy8x/VF/DSHb5VTdAV5lLvI+rE25r?=
 =?us-ascii?Q?YNEAKRjDGCxBQy3EJ/wyTTwgG9dzPjnTrMhLlf8mewSmU/nNFjg/ATq8Ilvv?=
 =?us-ascii?Q?VcihwJaDv5Gat4diRf6qBO5yW54Gc8UHcY0EzUiAyVA8iY6jR5JlY+t3g5Ec?=
 =?us-ascii?Q?nezpTkOhCSMCBNxy93s0G4VIxVX8wUKbEWBbHaCJM67LoTJqbTVHIoqYXuVG?=
 =?us-ascii?Q?PPwlNAn0uBvZ7iPTPmr9ysxElOK1ARSn8x3iQ5yV6CB1MdJIM9MqDzWjlSXo?=
 =?us-ascii?Q?aAs9XcPJBGemZ0JZRONMsr1GS/WK9BNB6zQWVTYwj15PU37ij6Wosawg6F1N?=
 =?us-ascii?Q?CkdUPE1KG4p6RpBelztiQp1XBa+0Bnq/aA8NoQBRn7Bc0t3aYRqDNTUw+78Y?=
 =?us-ascii?Q?8Xc2kFTewZpuSq/gCI8I0UR+Qi1VlpR3wYuzFRLuo5OsnOMgExWNtDlanyc8?=
 =?us-ascii?Q?SrxcTwkDcwgXHoOdxklhmybOz0Rn3DvlhWZl6Q/r7GQG3WyL89PiZFOVh8Az?=
 =?us-ascii?Q?DEJ7XxLxJSACJHuo0ZuUNLoy4pQqyKC6ialENmvD15MPemLOlpD85M4ScUDz?=
 =?us-ascii?Q?R2SRFa8vMTrD82pIvmJeERwy2Zqf4QpF4k/s1wJJxIV6YwNAhVei6TXTXU2x?=
 =?us-ascii?Q?GTFm8e4yNVW1pcGYqlVa0fx/2Dx6ZrJzalVGXGRCisBtD/r1nFHGZ/6+pXbs?=
 =?us-ascii?Q?QV5Q9S+GxyXzIzKYh/tSf1dEitSg/C9RZwBe0B813Ok6oO6mTMMljFK9PCFl?=
 =?us-ascii?Q?BBsHl9FTbREIWuQLy7Kt5LUrkWFT/KKmSq5lESH2p0wqNm8YUCu2iitEeHjK?=
 =?us-ascii?Q?h2rDHK5FdLW0dubdbUsh5jYyQDswreQHiF8MVLvGDwRsPhsOU7NwTA13ePcT?=
 =?us-ascii?Q?k+inlti3gJuvJy9jlD4QdVfc1i0XUFj0xaMTTlZHc5ipQ3deYjIb96iO8Ie5?=
 =?us-ascii?Q?tIyU7cvienW84c67pFrOnN14DnXAvMtSKKoUWn6QR7Ron6/1dUrXCl/xCGFF?=
 =?us-ascii?Q?RFHCG70/hiBkXi4x2SeEruZE/cXatLEnpHKVspPxj48Rr0m6y+6AboM7HuCm?=
 =?us-ascii?Q?ifva9q7iFYgvoFi2vObFo8PxKXgTWjONUsqiTV3fMKdskcL0K0tc+6YI821F?=
 =?us-ascii?Q?Rfp9yKRLov7k3jKyW5MDnDma+U0bjq0JbPPaIHwmdkD+WwR4val2hu+MfpHW?=
 =?us-ascii?Q?iFu4SjGEsn5ScDNyIisxM6JWwYnv/m0pI84T+4gkBDYGJEP9SCLjzmip7b8H?=
 =?us-ascii?Q?0PrnirD3gPRpOdFxArFMYQY6wW+bxci0/9lPuKtfyKtz+ywmcII8RXdrVJj7?=
 =?us-ascii?Q?5eih1FyPINcjbYI+cZMuJrWFSu5+e7IlIzI4y5YFnMIWsTKSPqipJn8kTrdj?=
 =?us-ascii?Q?cA4bSnHq66ShbLr+i5EYGrvModZ0dUBB9TfWyETcoaD6fCD5259rGj0p0VXI?=
 =?us-ascii?Q?msWGckWZGCC9sdDcF3CShqEJepX3t5//hikX7zU5?=
Content-Type: multipart/mixed;
	boundary="_004_ZQ0PR01MB098393466A0CB4722C8D62279BCDAZQ0PR01MB0983CHNP_"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 208bfd26-625f-4dbc-2e06-08dd56d9f75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 02:53:51.4297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xe585u6bQ372dA3GpDwDJQuwH7Yb1W7uxCqqRMPrcSiLv8KLK72uInlyALctAuSIhr4Smc4QRf/wWifB5rQ5ZNXrg1r7QCgtqhzKpCsLQec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

--_004_ZQ0PR01MB098393466A0CB4722C8D62279BCDAZQ0PR01MB0983CHNP_
Content-Type: multipart/alternative;
	boundary="_000_ZQ0PR01MB098393466A0CB4722C8D62279BCDAZQ0PR01MB0983CHNP_"

--_000_ZQ0PR01MB098393466A0CB4722C8D62279BCDAZQ0PR01MB0983CHNP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All:

  We correct the VEC_S macro definition to fix the implementation of vector=
 words copy in the case of unalignment in RISC-V.

Thanks.

Best Regards,

Tingbo


--_000_ZQ0PR01MB098393466A0CB4722C8D62279BCDAZQ0PR01MB0983CHNP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.5pt;
	mso-ligatures:none;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p style=3D"line-height:200%"><span lang=3D"EN-US" style=3D"font-size:14.0p=
t;line-height:200%;font-family:&quot;Times New Roman&quot;,serif;color:blac=
k">Hi All:</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p style=3D"line-height:200%"><span lang=3D"EN-US" style=3D"font-size:14.0p=
t;line-height:200%;font-family:&quot;Times New Roman&quot;,serif;color:blac=
k">&nbsp; We correct the VEC_S macro definition to fix the implementation o=
f vector words copy in the case of unalignment in RISC-V.<o:p></o:p></span>=
</p>
<p style=3D"line-height:15.75pt"><span lang=3D"EN-US" style=3D"font-size:14=
.0pt;font-family:&quot;Times New Roman&quot;,serif;color:black">Thanks.</sp=
an><span lang=3D"EN-US"><o:p></o:p></span></p>
<p><span lang=3D"EN-US" style=3D"font-size:14.0pt;font-family:&quot;Times N=
ew Roman&quot;,serif;color:black">Best Regards,</span><span lang=3D"EN-US">=
<o:p></o:p></span></p>
<p><span lang=3D"EN-US" style=3D"font-size:14.0pt;font-family:&quot;Times N=
ew Roman&quot;,serif;color:black">Tingbo</span><span lang=3D"EN-US"><o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_ZQ0PR01MB098393466A0CB4722C8D62279BCDAZQ0PR01MB0983CHNP_--

--_004_ZQ0PR01MB098393466A0CB4722C8D62279BCDAZQ0PR01MB0983CHNP_
Content-Type: application/octet-stream;
	name="0001-Fix-the-__riscv_copy_vec_words_unaligned-implementation.patch"
Content-Description:
 0001-Fix-the-__riscv_copy_vec_words_unaligned-implementation.patch
Content-Disposition: attachment;
	filename="0001-Fix-the-__riscv_copy_vec_words_unaligned-implementation.patch";
	size=1099; creation-date="Thu, 27 Feb 2025 02:49:28 GMT";
	modification-date="Thu, 27 Feb 2025 02:53:51 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0NjE4Njg0MzViM2ZiMzQ2Y2YwZTBiNDBhMmFmMDlmMWZjNThkMDA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAidGluZ2JvLmxpYW8iIDx0aW5nYm8ubGlhb0BzdGFyZml2ZXRl
Y2guY29tPgpEYXRlOiBUaHUsIDI3IEZlYiAyMDI1IDA5OjMxOjQ5ICswODAwClN1YmplY3Q6IFtQ
QVRDSF0gRml4IHRoZSBfX3Jpc2N2X2NvcHlfdmVjX3dvcmRzX3VuYWxpZ25lZCBpbXBsZW1lbnRh
dGlvbgoKQ29ycmVjdCB0aGUgVkVDX1MgbWFjcm8gZGVmaW5pdGlvbiB0byBmaXggdGhlIGltcGxl
bWVudGF0aW9uCm9mIHZlY3RvciB3b3JkcyBjb3B5IGluIHRoZSBjYXNlIG9mIHVuYWxpZ25tZW50
IGluIFJJU0MtVi4KClNpZ25lZC1vZmYtYnk6IHRpbmdiby5saWFvIDx0aW5nYm8ubGlhb0BzdGFy
Zml2ZXRlY2guY29tPgotLS0KIGFyY2gvcmlzY3Yva2VybmVsL3ZlYy1jb3B5LXVuYWxpZ25lZC5T
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvdmVjLWNvcHktdW5hbGlnbmVkLlMgYi9hcmNo
L3Jpc2N2L2tlcm5lbC92ZWMtY29weS11bmFsaWduZWQuUwppbmRleCBkMTZmMTlmMWIzYjYuLjdj
ZTRkZTZmNmU2OSAxMDA2NDQKLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvdmVjLWNvcHktdW5hbGln
bmVkLlMKKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvdmVjLWNvcHktdW5hbGlnbmVkLlMKQEAgLTEx
LDcgKzExLDcgQEAKIAogI2RlZmluZSBXT1JEX1NFVyBDT05DQVRFTkFURShlLCBXT1JEX0VFVykK
ICNkZWZpbmUgVkVDX0wgQ09OQ0FURU5BVEUodmxlLCBXT1JEX0VFVykudgotI2RlZmluZSBWRUNf
UyBDT05DQVRFTkFURSh2bGUsIFdPUkRfRUVXKS52CisjZGVmaW5lIFZFQ19TIENPTkNBVEVOQVRF
KHZzZSwgV09SRF9FRVcpLnYKIAogLyogdm9pZCBfX3Jpc2N2X2NvcHlfdmVjX3dvcmRzX3VuYWxp
Z25lZCh2b2lkICosIGNvbnN0IHZvaWQgKiwgc2l6ZV90KSAqLwogLyogUGVyZm9ybXMgYSBtZW1j
cHkgd2l0aG91dCBhbGlnbmluZyBidWZmZXJzLCB1c2luZyB3b3JkIGxvYWRzIGFuZCBzdG9yZXMu
ICovCi0tIAoyLjQ2LjAKCg==

--_004_ZQ0PR01MB098393466A0CB4722C8D62279BCDAZQ0PR01MB0983CHNP_--

