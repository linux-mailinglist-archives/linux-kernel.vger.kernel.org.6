Return-Path: <linux-kernel+bounces-404277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1939C41C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E933284CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1577D13B5B3;
	Mon, 11 Nov 2024 15:25:25 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2093.outbound.protection.outlook.com [40.107.222.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EEC53389
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338724; cv=fail; b=FlQwvTYLYhkNfkX1yz0RKZOxTj15cGc6cq3xGpSgbAU6KW8F6Cj9s9WE92uhvzk6Za6Lu/0GrgOr+ckQnKlQRRaGikHMq9PeCxj3FeMvNhst940ur3Q2RPNARzoli8yjr4sVUMfoPemVlugOHDVcjDn22y2Dkzqx1Kuw/udi8TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338724; c=relaxed/simple;
	bh=kTtont8KABRlRWH72/4BYpNbp+uRbCclFcVujlw32yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CCjccC89T2M50Hf6eXkQ68o4JC6xZMRluoqMUOtqTYRgfvklsGmh9yCvp9IxybGhCsFVYsqmTOPZLwFOirBMR0OSRcGp+7eTPMGul4qAtS+gpxL0O6t0Pj+G58IZhQqhwvvw1AANt15Bc36mPjMDpHJbpYtFuaY3+xGlsKunXMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GD4jHzzV/UmMuoof1EP+p8T5gMFvWMGzawBW7djl7z1MCzggQE+JQhfxz/Hw93f+k+BuWuQ/N7vzdqKDJMFp/fdokacUVieHCxA3W0vBGn/FW/pMshur0/JzjplY6AaYhdTZ5C3t3E2Ie7QN6tAWnNed4Qf2d4EvXSfQe7pfR7/OXTEJHhjUuFCzTgx8Mr9hBgbV3E2cc/gaSoW8ODnDXZWm2myS6qHTkYKUk+vDmrapdoPKkA0OxNoo8aFgKQo/L977Dqk1m06sN4lyKqZhwlm0DHgBa40s9eQaOM45BpmpgHGhX6AFuo2CmCECapvObyb7R6S1k+I9mkeqF7qqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTtont8KABRlRWH72/4BYpNbp+uRbCclFcVujlw32yk=;
 b=H+2f2emm0hCeSYCb4AnGM5wk2iM1zeu0nVaD72YMepRFHFYrNfBDCileIkIUnOuohDTmdW8+JHBxgVEIYvdviJwrBjwvJ+PsFDGVBv3ipcs4WzQ6zWXlS/n0i5qDPc2R5y/4tMxem6DCLvbneY26NhXoPYPecx8WyqSPwrdUJJzXwqDlyNXD5YfaFXeJ8hBPUrmjGzBROH7h0ip1u3lmzzaR9eW60jzAZBNtyEomBpJGtqW3FLHSVNta1IDSSIlH3f15Bo2a7w7j886MO6prjERfl/lLdJDw2h7DIv4G3Wr0fqNt2NbczqP/Igx1/2sCMYhvT2NirJwkTl827EK4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB1343.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 15:25:18 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 15:25:18 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Mark Brown <broonie@kernel.org>
CC: "will@kernel.org" <will@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Oliver Upton <oliver.upton@linux.dev>, Marc
 Zyngier <maz@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Joey Gouly <joey.gouly@arm.com>, Ryan Roberts
	<ryan.roberts@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Tarang Raval <tarang.raval@siliconsignals.io>
Subject: Re: [PATCH] arm64: Refactor conditional logic
Thread-Topic: [PATCH] arm64: Refactor conditional logic
Thread-Index: AQHbNEUhfUua9TGhXUuHxRV9W2oRIrKyLkkAgAAC0L8=
Date: Mon, 11 Nov 2024 15:25:18 +0000
Message-ID:
 <PN0P287MB2843B5DAB4BF01A06C5F3DF4FF582@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241111142204.67751-1-hardevsinh.palaniya@siliconsignals.io>
 <ZzIdrLFldf_L3X_V@finisterre.sirena.org.uk>
In-Reply-To: <ZzIdrLFldf_L3X_V@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|PN2P287MB1343:EE_
x-ms-office365-filtering-correlation-id: c291ee02-8056-47d3-abdf-08dd02650cc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0Kg9v0xO5v+stX9ASMRQTr7CR8QfSd1rlYqaw+0MXGHrbnhvs6I5sFmibL?=
 =?iso-8859-1?Q?NGr01leoQNDaU8H7tzG/j8FBQ7rrzNlh63AZLj9NBnkRfgyZ6wJUOp53b4?=
 =?iso-8859-1?Q?RVPFpcmwEa3OdceskRbnLcjqHDmJ6U/cugpcEeAbgwgJAxJwtbiHDMkdhh?=
 =?iso-8859-1?Q?EpIYriGcZrJIkU1ZzEh0IVWXECk8mug1pfIfQnbU079dU8nWiwXcqfsGIq?=
 =?iso-8859-1?Q?ROpknPBG2Wn0VmMFXGQSwjdNY6xAhFmCQefa0Qo5+CrUO3bKuXs/SBq4Vm?=
 =?iso-8859-1?Q?StPS0IscuIqvZuwjRKxMD5Y1id6VxdK6dhY8gegMFm/1r9CAZ3nci33OtY?=
 =?iso-8859-1?Q?smHGiYwqrvZqhOV5gqH/eVgwWeQ9MymDsuxfxGh6IbMm10/1SIjdvx2O9x?=
 =?iso-8859-1?Q?7VsVz7Qi6GZIU+84anHMswAziIgLIAETMja2JgxW6GKeqZPWAoubOClzxP?=
 =?iso-8859-1?Q?3XEM0rxfydJFBdWQnQrrsvN4AtNWA10UTTn6FyqzNIY9ibrqjve1mKZMj+?=
 =?iso-8859-1?Q?WFryb7bLLoJVjS4I2WNAwDaRaDC0IYegmW1anujAODv9JHcQLSzuf4P3X8?=
 =?iso-8859-1?Q?sw3PnH7IYAj84iRPehfnlLaRzGw52rEqopKu6XiOuSyyEb0Oamwe7Rln27?=
 =?iso-8859-1?Q?3P+Rg5GMDDwSEYKz4oQt+nqI8hFfsX8PHm+7eMMv3vjABUICLc5CrqZ7jr?=
 =?iso-8859-1?Q?Ozy2sdf8aNfcWDzisAzhWgAfSosXLHK+dP7JJ8LjRQ7nnVRZUcVYwDSqi+?=
 =?iso-8859-1?Q?SMPJKadrITKLrO2IN82MSlq5a1RdqErAjY5Vw4W75xkpctxfgnV5ORnw0Q?=
 =?iso-8859-1?Q?il6uoYu0Q6VNZZCln+R9XXdkwjIcSYAvjV/g0NPQbkAM330kSCNIIoX+gB?=
 =?iso-8859-1?Q?j5QGX4pvKyTdSiq7aOkAjtYAg99BXJLDerD89kP8AZQnol91YuEIv0Fyzs?=
 =?iso-8859-1?Q?z65ljQot4WXSCyzl5LSo3a0YQvB/K2khxnQMNUyXepFBZ66IejCil1qTZ8?=
 =?iso-8859-1?Q?ZAS9L9AjNstxVe4XYCK6XnoJqcyJtUuOxzP+dLoqqwqS1HrqzX7/D0lCAX?=
 =?iso-8859-1?Q?dpSNTmRvx8d2lygKDoqfK/kOts+fz+VWn0fcTObs7/GPBHdx9bjMyBE1j1?=
 =?iso-8859-1?Q?crWCM6URmmiNROJqgDFkQMsgZ9bDw1ds0GHnoFk3GswkZ2FtWaNN64i4d+?=
 =?iso-8859-1?Q?FTigWtIEUVSLwAGGEHlq4iYqaV/8eaoJ5IcnYqIIFwTNbBPHIT93RAnj56?=
 =?iso-8859-1?Q?I49r+Yw/DYTth4alt/G9F3kikjeNLr85OLBmUvJE6p4CeDxEjGJb6uJe+l?=
 =?iso-8859-1?Q?+UWpLxXQDN937Wgr+YpbGAdfWrJjTMtUl9LYwUfOfXV2YhxE2Kd8L4i5YM?=
 =?iso-8859-1?Q?X2kKVfqI7j4HkI7B7NwXpXEp0uhePCs1mW+rsXOahOI9NMIAKfGoI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5NevRAusrll/0eHeIny+N6eUbsqksYh9xGtc9dQm31sjtnfdUlUQKx7JcR?=
 =?iso-8859-1?Q?106XuTpOx1oK1o08sSc6gaWcQjL/vcuShSQVpZv5pvlaqiKozBtSAkTWNR?=
 =?iso-8859-1?Q?XvOUn5AdPc5pJ/dKe0o8QoKonFSXdNmiHifC8SG3JRgAckh0K2ID/CvYP0?=
 =?iso-8859-1?Q?ZwFQq5gVUJCuG2J7tabdRamCZKUvJ8Z+s42njXBZhs08Hiwhv7W35mrfyp?=
 =?iso-8859-1?Q?qOxRrd3xVXUZzSsOBcCJObhEBKEeUuyy8+VZBwXddukUP6uYXIcagyqVgF?=
 =?iso-8859-1?Q?ujClrEcXW5XI56q1cR5VzGZ6usz3qxyTSCIHQI7Nn3XnddqogylYGR3J5V?=
 =?iso-8859-1?Q?UE3hGQjQKG0kVPKWuqpgT1X9fm6gRusNf6ULooSPsDchHqIdmtWcQHgtnj?=
 =?iso-8859-1?Q?dE2I2iKl0aLz/l5GL7OxkOWLYrX/QPvVVSLdyWpuqMgQ1lGoTqg7vW3A9T?=
 =?iso-8859-1?Q?P9Ip3PVPEBLm1EcraGG5AyvYf4JJWp230IpcH5mNaMx/sMM/IUJbtjRAxs?=
 =?iso-8859-1?Q?uhLtG3o00H4bFhBxJmdxNDo5pAwbwi3d2eQwaX0aD/+M4Kzq4Ufnc+oCD8?=
 =?iso-8859-1?Q?o6zFTDzIPLqZ02oG+iqYgsCdYqJ/JmvvONOFW16xNHgJ9foNWbBVa4MHBC?=
 =?iso-8859-1?Q?QzZiPgmyguFuIl+spNZTDli272Dr90JpvYE4+midOZwIZlM3GaSFSkU+xp?=
 =?iso-8859-1?Q?ehuQFZnKJ7Va8htPD3doFAwA6VoVwQD4wGoTmuk54wTU8rWXNYrLzr4ntW?=
 =?iso-8859-1?Q?rnJK+kSJ6vYgBqnJ8/YUSphbw1XlBcetkE3WAY3luvDRRg3xhG8Zg5WG1R?=
 =?iso-8859-1?Q?U1qpkwLsOC3yz8gDIGu9j7G81r/Mhm7B84Zhb4G+gYC9vAqemsGxKn3Xxq?=
 =?iso-8859-1?Q?rJ5t5Ial8w3ihVlAL2k4iQ7AQECMwdq/2ChE/p/ewPm5B4zS4gyziVXkyt?=
 =?iso-8859-1?Q?ggfht2r2qD5mzwWujbu71n4Olztod2+HcLxIRcCz4zxdkSVkYFG4e0M2Wl?=
 =?iso-8859-1?Q?Hr6yNojY5E4IwV2OGFhb92eJCOmo0iQxbI4vJuz6x9r5EyIpEBWchH4IAV?=
 =?iso-8859-1?Q?dQ1ZWFSCwCKzEmiBSytM/4IDWoN2LB+rgLPcMgr0lm6+tC8AZkU40le+aZ?=
 =?iso-8859-1?Q?+G6hhx0XFtx/00MrycVBeRxfBjeLFTmwaSflGJGIsxUf2H2Tolub3iAkoP?=
 =?iso-8859-1?Q?nldya5RGoCerI5ddNM0q7biI4Q0LcldcKVYxQY1ik6lm//1+B2VGzg9Gc5?=
 =?iso-8859-1?Q?si59eqwtQSSwR2xnxTfT3vQao/j+P2Pq7z+wOfIiP17hhhTrNGc7w075wk?=
 =?iso-8859-1?Q?NHCnoE5lo8Dy8zqyZ7vJlbyyqHbWxeDRP0meq1Xo1DHRpOyKGtZcOSqNHE?=
 =?iso-8859-1?Q?NG+1947VeFsSUjU2xztG/gAuQCnDLNPCkgbGrwr7w7AL+rddAo5g5il8ge?=
 =?iso-8859-1?Q?QxJ1kTILMIsOjpgw7yPUWaVst7dFzD01SKbAbUmNwuOFGngzY+hRBYKKtE?=
 =?iso-8859-1?Q?pRiRcceHXHJuid7aJixwSkU5belcvC+Xj1ijWeRCDv/mi+ed4E+rII40lT?=
 =?iso-8859-1?Q?evUhs2+4jRvOmmF6Decx7tjq1X2nT3myR4Om5/+T/nFKpc9Ps2jRDBqjTS?=
 =?iso-8859-1?Q?HGW0I7qw/J/xiwprqDi/COlJpHFPQzLXy9UQ7SCNE1sDbnmiO+4iFb63/n?=
 =?iso-8859-1?Q?YZQs48TC78GUB7m7BKs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c291ee02-8056-47d3-abdf-08dd02650cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 15:25:18.5482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEPIE0OY/vyKWQhHl+epvkIbvJ5ZrOk4hbFbsFKdHw3kj6ZPcrJSiJ2utjQzulse+CMnbfQ1oWD0hXDgl5PcoenFim5I48A4DWRSGxBDkZckKIFOzAE9bl/U5hpYp8CK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1343

Hi Mark,=0A=
=0A=
Thanks for the input=0A=
=0A=
> > @@ -989,7 +989,7 @@ static void init_cpu_ftr_reg(u32 sys_reg, u64 new)=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 /* Override was valid */=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 ftr_new =3D tmp;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 str =3D "forced";=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if=
 (ftr_ovr =3D=3D tmp) {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 /* Override was the safe value */=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 str =3D "already set";=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=
=0A=
>=0A=
> Your changelog wasn't very clear on this but the tests in this if/else=0A=
> tree are=0A=
>=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ftr_ovr !=3D tmp) {=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (ftr_new !=3D tm=
p) {=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (ftr_ovr =3D=3D =
tmp) {=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=0A=
>=0A=
> so your analysis is accurate, the first and last tests are the inverse=0A=
> of each other so onr must be true.=A0 This should be clear from your=0A=
> commit log.=A0 Also all of those branches set "str" and we then=0A=
> immediately test=0A=
>=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (str)=0A=
>=0A=
> before logging a diagnostic.=A0 If we're looking to reduce unneeded tests=
=0A=
> then either that one is redundant too or there's another bug in the=0A=
> logic (I think from a quick scan just the former).=0A=
=0A=
Yes, I agree=0A=
=0A=
that also we can remove=A0=0A=
=0A=
Best Regards,=0A=
Hardev=

