Return-Path: <linux-kernel+bounces-280824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5E94CFB2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66931F2396D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F403A192B82;
	Fri,  9 Aug 2024 12:00:25 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2133.outbound.protection.outlook.com [40.107.239.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5212C7FD;
	Fri,  9 Aug 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204825; cv=fail; b=GyPzbD8xffe316DR1gG3Wiyt5LYG2Fu3yHfuHGhtefU+SbZRpZXBdVD7hbXplCm+UNBjNnPURP++sN8+FWMwFysRliM4hsvZsKU2kgKi1GJxQol/2kyouxXI8MW6NvUtChUSvx5IK2C0Q2i9qePNGccewYZxJCHaxhkrhdl76ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204825; c=relaxed/simple;
	bh=BAdey6/TSBAUwlYEzxobn9KbxOdkUhxR57Fu9qgttUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rN+e2L6QWBvgsrFf1PCFGl9Q+gEWzLeJtzv9bBZQ0mvdJeEC1PUPIwoTddo+fvAmfxmGLJrMeMmPCJqmSK3PiVGOlbfjwB8buTDcGiYxv2DUKgD1koT/I5PF9ZhXpEGmOIC3L12OCct8UcaUnQoySti3dZTdi8QwTIvFLQk5u4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwqlZoLyuUtwzvnWmt043+ebblmOg32D5jNJDb4Up630aMHNC6OLIhcFe+1cqc7F8WjMhr1cbnwnAYPnSMUUUUPOd8y78WZYhajKEDiYhHQuB1+hpnjdBZf6fQhgOFss/jYeYckOhi832dU3NbeOlXOgWkhrI+1k4NObYXqK8M/CHrUSgQytERikGlwi10eiKHiUA+M+gVk/xn4emVRfe2ubYfsN/r1RezyM7ndJNWmKA5ApB+HG0GievBqqQeCMxxlCMpuE2Ag5/LbfAkQL1xJo5mfmLqZ3+a302+Qj33Zb9xiMCBqalRoiq9Z9Z0rdpjVrcAVSKoWeNitMRylAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAdey6/TSBAUwlYEzxobn9KbxOdkUhxR57Fu9qgttUo=;
 b=FCZVZqo6cfoBMJVpY1rzHZ0UDxF5sYGxtEejJOPFBB38iP8R7uuHuKddq9V061HRgbCAiCOTPDFgdZ8vmCe+NqAuIYIWVhMnN/v0xDrWO01PnFxFFWLPSLY01/wbPIFalYNQFQi9jdo/PdsbswxMNHAO9AdVAbEhm0buNfn/hBmJc5nsFr3aRmv0kEi4GuCUywCT501RZd7WvEDY7CQQ2UttkNgOBQ+w77vk9WOw3P4wZPCFAoB16DY1mYCkzHM5lEA44og/0Aey2MhStJegc9UH44Mimq/Blb7tkmIGNTF2imztPzZl3fX+nSkAeM75caOSXSury1ENZjQf0hwMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN0P287MB1237.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:185::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 12:00:18 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 12:00:18 +0000
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
Thread-Index: AQHa3o3H1+ScWhvARkGVPfAPDdG7LrIYgdtlgAZlMPw=
Date: Fri, 9 Aug 2024 12:00:18 +0000
Message-ID:
 <PN3P287MB18290445549AD47E4BA5A45E8BBA2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240725122522.5030-1-tarang.raval@siliconsignals.io>
 <PN3P287MB182947A91A8E381988B6F6198BBE2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3P287MB182947A91A8E381988B6F6198BBE2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|PN0P287MB1237:EE_
x-ms-office365-filtering-correlation-id: 69feec62-9682-4ffa-030c-08dcb86ad6a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5vu2zepwoMatORWYR0k6XlnkmeIX5lUWI9uvdrLnmi1rmhGURygHtUY8qX?=
 =?iso-8859-1?Q?HYs2B11gSxmn2FRLk/5lb+t5IIzsPWSu/Dt58oH7C3ZbLZzJTLaw+pgnhd?=
 =?iso-8859-1?Q?mxSFdhcRhD7U9EcbmmTAiyXZUHiMUIQ4VK1OiSi4i6V4RHg5tKwXI7z2RR?=
 =?iso-8859-1?Q?CJwVs5bJ2ghvl4fkDGQhASQwfy4CXZMJUDHu4boamNF6XRAs3cWNVp3nER?=
 =?iso-8859-1?Q?MqdyOaq5PE62gZ2rWczNflsAsCXHEefoicrnhEFSaQXszN54i87sAzyn1y?=
 =?iso-8859-1?Q?3i9gIm5syb48+2P/j6gbX6NvRazslMwYFTbSo5ogcD4xoL9bH8kNEv8gOi?=
 =?iso-8859-1?Q?dw/ElKf7z9/N85AeaBw3PZAujaNwMPwFteZ5TXUvVrZl/O4I98eiU11u+W?=
 =?iso-8859-1?Q?A4I0DKlHbH8RpQDMANQbibU0kSUvomHilB8t4WfEyaZcOgiosVu3G5F3tR?=
 =?iso-8859-1?Q?x+Dm/uz7asAEuoFWtFPdjlBhHg+ikjQKdlZsVg6/kM/gF1z8/3m/hjbzsb?=
 =?iso-8859-1?Q?lvDI62DfNUPXQ4CM1VdffFvpfpyt3ksQPyV8P7Dh8lhJ/4ALvM3AadTy8D?=
 =?iso-8859-1?Q?9tv/1gV6owalFRQBvdcV56gxfC1kHFspfdrXSqBx0NjzxfStQvWb1rsda8?=
 =?iso-8859-1?Q?IBZ2Y9ogQtj+LwLEsOhIZ/B2za6CWfmnafq8DmfvJ0284Pe773/qjC5fiH?=
 =?iso-8859-1?Q?bHU13M4EOReAlYJ26NwYZrI5kazCL0mlP0Tp8OoRZoZfnsY+Ln6WlGohz1?=
 =?iso-8859-1?Q?7AbCGpUiOVjiE9D6Bj0ZV8jE+/sVuRkAvy0Jv2UJ9/m+vXKgMsusRSnZOU?=
 =?iso-8859-1?Q?XAr5LfEn0ZkPwSXUY/PExuxuis+RGjWbmDVG37gJYhmRh8zt9G6kDCi5WJ?=
 =?iso-8859-1?Q?viu/yiK27+nIOTg1VxmVczjKLuF1slEo/rmse2ej+5NyQ6wEy7vqL4b6oc?=
 =?iso-8859-1?Q?Nbi4RqSDvmPKXlTvbANqykBZkRMB3ZQ7gaJFAAYhed6QZxaFtGZzGXZ+l/?=
 =?iso-8859-1?Q?OXvAPnW47mEMXTWgwrghzHb31EzFCMHV93Xd8SMQB4w/PEGl9XG97SU+VZ?=
 =?iso-8859-1?Q?2tZ0n+ZY7QVCASxU6OIQj7jrDHTB3HaRCWjFdn9vc7a/vNrQg8IfMBW4DW?=
 =?iso-8859-1?Q?o7KgU4fDKybJc3+6aLFMv4YtkplK+rHwwJZOEf8XmbPj/pew77jyDDZxbJ?=
 =?iso-8859-1?Q?njKXpuXsfwdlAHS+ClaJaP5ApXREUoqeCsInxlt9SnwCOCaqvF38yusKsZ?=
 =?iso-8859-1?Q?1+wzTQtd/zieaEnb+Y4G3G6NmN9qS4Rm1f1YP3YcmmjGaxx3xhMIU3WgPs?=
 =?iso-8859-1?Q?p/9D9HCxZ/Yri+gt45EMr4pr1NmRwUiHaURFHyWvzc0Cd8CwvH55+IPuXX?=
 =?iso-8859-1?Q?b0HJmtqr3yjvNb+6aIF7/mLpe71nHCk8p+LhVt4GVAcZ49oU4xfRy92wYj?=
 =?iso-8859-1?Q?HTpZ9A5HCSWqKNlh2v8xJnYaZLxx1GyStA5o8g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JtBirLC7EHQ8jG8Q5C7r/uamLVxTXyNHVEs5YMRAS2lIo8yFbDYeUi66ru?=
 =?iso-8859-1?Q?aOZEAGr73/99zYQhWX1klXMUHXR7j0nAwFUIvZI1nmbCZyeVxTpA4tySm+?=
 =?iso-8859-1?Q?P/hoSwY7d37SciQWeAP3UdkJB/FieGXO91Yu1zQb+hI6daoHUPTVvEIWbk?=
 =?iso-8859-1?Q?I55j0kvBt7CXIkIHV70cVyklBHMsUOgGb4CuHqkcwwy5VIHGx8Mu0CYfXt?=
 =?iso-8859-1?Q?6euKoZ4DcHhsIa9hxdfA6Q/+Dv3SRGOP9QS9MNNigSuegAdTSsW4vbqrlK?=
 =?iso-8859-1?Q?in1FzE1PSYhaG4kA5KE0noBU/iOIH87el7c7LeZblK7jnmnciVwACLcRB4?=
 =?iso-8859-1?Q?uAtDGEmoLLYWBRI7TAOShOIV9cRaxH00iS1+gyyFm5O1E7CWBAkGtlnE4m?=
 =?iso-8859-1?Q?ZeSLsIZrTPr30zjL/bnTNSJBok1lo8QqGxxRXjICX4Z8/4/VAk5h9lONbj?=
 =?iso-8859-1?Q?8+6/ovCR/jBC1zwFXB8Sl2aFSTnkuN4T/4cwqCgMjfSo40S0V0UJxCKrV0?=
 =?iso-8859-1?Q?CzQu8xijsCv5mbjTraalJ12RQJjWIR9jS/dHlDwZzd/YCO5c8iYSb9dlsG?=
 =?iso-8859-1?Q?AY9fOIHDUZJXpjWXrIbuxXafirM+RN/KhssRKKBWZIeK9phsQeu86Bsge5?=
 =?iso-8859-1?Q?857QBmUofEuVRmvy6riJdG7SF8J4jFS3LPL3hbykOo95WohUFHfiLurUKG?=
 =?iso-8859-1?Q?SlUjehj9l+RrRWYOABou8JYrh4I9Ypy4/LZyi5bR7dc3a/Ec8svY/L5ljv?=
 =?iso-8859-1?Q?j8amO3KFQ/a4kJS4LAzAFEW/66P7PovjWS4V8MU3bprzqoRzpCS/g/BFUY?=
 =?iso-8859-1?Q?Uv4rIfz2kF3dyS+yYJYXHCvri/vtw8L4d3MWonRC6C8Rv215QgbxuwbyJk?=
 =?iso-8859-1?Q?oURQAGaviKGC7X69Tn4W9eWhjkp3ZnXEMJtQHJj716+LeNuA13ypxy+kNU?=
 =?iso-8859-1?Q?IUgLnoR4d9EeINITH1suPWrb1hJcdnr4W11vhoE+MKYVVPYn0Ne7GI6Y58?=
 =?iso-8859-1?Q?xttuYwxnwQw8Ur66xOpD1Bvo3ACZaycwBMbUVJsroFkZKWHwXtqag+zmwI?=
 =?iso-8859-1?Q?Phs4JNNHbh6c7eUna8fWeAvPoQMoyDYhfAzZGy7RDAmPbdA7Rf0o4qpogk?=
 =?iso-8859-1?Q?7fQxW/9LXYRjYz8/LHICQ6z1dFPxGdtJUePA59IB+ixsyUFw+A6WgXtc8q?=
 =?iso-8859-1?Q?z8TRikMtiA0OcFoStcNFXaCu0zYwEkQlUAgAeyN07kQnYXZbR7dWB94ko+?=
 =?iso-8859-1?Q?YR9JcOeRjT/Rw6FBMU+AB0hYKfkVJ6rRFQ4UAgX7gl6Go4CbBoAnEbRJbO?=
 =?iso-8859-1?Q?HL4fWl4tOdMI1beczR1UadiOgsrgPaibg/ZkOolx0YSQQxu2qCCEFcauN2?=
 =?iso-8859-1?Q?EJfa2tZDcCV23+5DYrytyEMQkX1EyfuefEq/enm6CTgL4w2JVVK5yKWsLS?=
 =?iso-8859-1?Q?0FL4CL0uBURpZ2LXb83Xh4Wle5/2ZOYogHncI6/SMEOZ5FmbiF7eGfFZkp?=
 =?iso-8859-1?Q?pJIfQr0sca7XumaeANz28MdXM82/bKQeN3bsXzVbadiznfV6Pq+/8FTitj?=
 =?iso-8859-1?Q?/2go2Pu7VuUNXymewOq33G9YPEsxYS1lyvpGyHHJUslpjnR2mrmgGTu4Gs?=
 =?iso-8859-1?Q?LBNgfcRkXPQp5Ce4Sd/GCmLs8zigrLQ92v1njfHE4zgpxKjHNxCIp34g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 69feec62-9682-4ffa-030c-08dcb86ad6a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 12:00:18.6404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XREeHJ8hJxuaVKta59sxb/5akw9trVs6up8cpO5iX8GQDOsC8A6GhnX+YXDSNMVXMa0FlwVK2cIhNwaH2DPohf3pc6CMgpnj5JZ7PEsrXAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1237

I wanted to kindly follow up on the status of my patch submission. Please l=
et me know if there are any updates.=0A=
=0A=
Best regards,=0A=
Tarang=0A=
________________________________________=0A=
From:=A0Tarang Raval <tarang.raval@siliconsignals.io>=0A=
Sent:=A0Monday, August 5, 2024 3:42 PM=0A=
To:=A0krzk+dt@kernel.org <krzk+dt@kernel.org>; shawnguo@kernel.org <shawngu=
o@kernel.org>; festevam@gmail.com <festevam@gmail.com>=0A=
Cc:=A0Rob Herring <robh@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Sa=
scha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team <kernel@pengut=
ronix.de>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; imx@lis=
ts.linux.dev <imx@lists.linux.dev>; linux-arm-kernel@lists.infradead.org <l=
inux-arm-kernel@lists.infradead.org>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Ethernet =
Support=0A=
=A0=0A=
As per your comments on v2 patch I have shared an updated version of the pa=
tch (v3-0001-arm64-dts-imx8mm-emtop-baseboard-Add-Ethernet-Sup.patch) with =
the recommended corrections.=0A=
is there any updates on this patch?=0A=
=0A=
Best regards,=0A=
Tarang=0A=
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
2.34.1=

