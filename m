Return-Path: <linux-kernel+bounces-409463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862729C8D00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1123B1F233B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3312B55E53;
	Thu, 14 Nov 2024 14:37:19 +0000 (UTC)
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020089.outbound.protection.outlook.com [52.101.227.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997F3C466
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595038; cv=fail; b=iWncYwNqNN2PSMW5FQvenbyDMTMnZSGrto9wWvanAD44w1h+8LD2A1bXoopYc/AM3ygy1/avP51xLsvZwNyHOeFXu9RDht0H3Qpp+3+vMQ3G7QPyC4ko8p/QPToZ0umYu2Ea5U9+7zR8nZK1ljw+uLy5W7g/85W17lyEb+ciNNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595038; c=relaxed/simple;
	bh=m1H7RyhqiJfi+Hsr34GvO+vOADgySUX1dEoQ83ucy1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X39D53mHe6ViDaiD5DTfjUY4emAlHdZK4BV8E+/tir7zBcd2tz5sjmmESZkx0QqjtBbbTdPS+hhIitml2rYNtq3KNpXavvAhNBtlwGDZr8z+3JEcicLqKbKUeRypS/yRy6FATj3UMYRBo53/67ZYxpvvcz58JBjvlXjkOTgHY6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alL++i/Yv1iU9dAdn7euFBJd8+WJV2j/CPlmq6u8ozDHlYEr7m4tAcuFqHVmqXNol75UYLUHAFje7uOATtuNKpj0ENPTef9FReOpoNqlcD0JWwr63OLe0DT+Tbb4++879eS43ZpRSdv85dYQnk9jzOMbQKuItoeMSt3fBf2n9sAKYsMIo5UsiEsw5ka7IRWUSXBxMKneffQh400cWCH4U5itpSgMcN62rlk8w4f/PXQPKEFnZ+E6TKf0lPw57Uqa/eF51yzZMoLucVm4dNBqRG27gmiAkC5ZzZrAai1EcJ3tiM/54AnnCwcdW3HvNqqG4jZv5xohDXwX9LSuxb3qJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1H7RyhqiJfi+Hsr34GvO+vOADgySUX1dEoQ83ucy1E=;
 b=gwDNtOAmjHemfGXCrHcSJrEwhtF6cRZXfvw81sDB4RGfTb5gD7mLrgqyWaUBjsYI+3Utgwd7pM/gfWA6/VDr0Ay706ja09SlXsUETf0eJvZOibkZejZ7NGLlGi+8FFTNZxkOGA9TjJngiXhKq5Q5Rx71pnFDjQIGJbLLZ4a+p4Nfs6a4UP4AsLaNsqDX+6Em3d+Mkq3ZqJ7hLd/0pGXzQ7+q5ojndbpsKqlPbr/zyTLxEpfBj/s05zz4r+4TU3RKUBlDLgbLBU8gbFCkFSZWB8DGBGHkT5Cs17Dc4Fq0JXX0I188wT7+09blUCm3fVnsHsaVCOYnhFGQzDQwqZ8JbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN0P287MB2152.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 14:37:13 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 14:37:13 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: "will@kernel.org" <will@kernel.org>, "broonie@kernel.org"
	<broonie@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Oliver Upton
	<oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Ard Biesheuvel
	<ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Joey Gouly
	<joey.gouly@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: Refactor conditional logic
Thread-Topic: [PATCH v2] arm64: Refactor conditional logic
Thread-Index: AQHbNqDYhJB07AnF90+yVvz+NvSraLK21vA6
Date: Thu, 14 Nov 2024 14:37:13 +0000
Message-ID:
 <PN0P287MB2843A2EFD47FA629DBFD061FFF5B2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241114142333.18210-1-hardevsinh.palaniya@siliconsignals.io>
In-Reply-To: <20241114142333.18210-1-hardevsinh.palaniya@siliconsignals.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|PN0P287MB2152:EE_
x-ms-office365-filtering-correlation-id: 2f22450d-70e3-4068-1f47-08dd04b9d43c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZgNN0ngJdv2ayLHqvhPe8xm5joufFzQktlg1p7OdeEch9ggQ3YRZVTmPa2?=
 =?iso-8859-1?Q?1KVKWx8QlDtk1C9v3TMl7GA/NdbPuokfVZGVxEGs14sbsk9zPJcHolJYkd?=
 =?iso-8859-1?Q?uLIcacYRhn4YqGvwURdSletS0ykkQXaIAIzKLtnu0TxJ69QLR+NLnPmVp1?=
 =?iso-8859-1?Q?MGyQRbmzU5k0x5XDplARluDuegfuLX1CxaBM5C4j+Mv2FSo2/ojK7QWArZ?=
 =?iso-8859-1?Q?VunTb+QtTOiurrAAs6pm/sd+n+98wLotvqxASSP6NinTwcg6HqvS6FqTIf?=
 =?iso-8859-1?Q?wGOcyplJ/Mz2uGPi5g8HCr0poCYB/PY3N1xqmga7ffLKlsgHfcJL6Ci5j0?=
 =?iso-8859-1?Q?KcryGEHDYq04nTTKor7nlwdO8znh1Csu6Q2Y3kxFIMRKZyO3gDgYcxzjaZ?=
 =?iso-8859-1?Q?1qEwRDCUT+grOp+wdLIsi0JGBaJIVc9MYA8ja/Yrx3N7nu/EAq8/tM9tkX?=
 =?iso-8859-1?Q?AZ/gKNv2rVyAxQX/TAHzdKK/ufErAfv6p3yAbu7XGeyWHkYGUaQhz+l4/w?=
 =?iso-8859-1?Q?rcauG66TMwyY3K4F6E4YsKIZKoUDmQzkvpOX/u5ouBQA+SbgB/OUDfMVcs?=
 =?iso-8859-1?Q?vnHUF4VY8rl2FB+7IneheD9LB1x0WCe0K9fjTqwq0d3UPzh3XxTHpmLWjN?=
 =?iso-8859-1?Q?H1lEZ9+OFCAo6mB5Rp7oWMi5OsZZxZjkquGC/d7aChi7ASfwfnZEwNosfG?=
 =?iso-8859-1?Q?f9IBEFL2AnrZism/lRPU4ktkMDltA8Yu+HqmdRItFqAtjtLa0vDLiOCn0o?=
 =?iso-8859-1?Q?qsIbPTNtpBWyctzkdTnNrJC4e3r6VaYQtaotlCsnm+Jhi73DQTfYHF7Z0F?=
 =?iso-8859-1?Q?HOnNmCxOOqhbPe1yW4ly6t4Tqz5fUUxsPuO2OoYRWj1yNvf4MnEPxTMPRP?=
 =?iso-8859-1?Q?d/6KRwq/fNNiBnekNz2UoFz6FzdJZXbpnBZHUFzz5oKwNBNqM6GZG/4atF?=
 =?iso-8859-1?Q?7omYKGeg39YAsOgUaPEEO5ORmu9+F+KOiMKTUBZUAKA6lhv4hnQK4QvzIc?=
 =?iso-8859-1?Q?eROUcFvjpmUHzTD9M8/CLzB0aDvAhhgKsk55FvQSeOm9mLISzq4a8yQinN?=
 =?iso-8859-1?Q?91FctZz+QiyWVgqyFMp3vMULvP0n/sLlxYKn5kaSJDvSK52SoPMau2LHii?=
 =?iso-8859-1?Q?iCgX1+E7X2/to8EuAanNmmRjAtrgoSYB9tjTpgGj2P0Y1Koh3BEnHd4udd?=
 =?iso-8859-1?Q?S2zeVlxqMrM9aiPG/PYnWfyvRu3j4tt11LjQFu5Skco1kufqoei7ARxX7s?=
 =?iso-8859-1?Q?M/mBK1d9qA4+jjuHqIv9J/BNjuKIHHVrMbwxeF3Xu+fmLm6TdyTgKeHsi6?=
 =?iso-8859-1?Q?VRhNTEulxIqryruOPqBSOlCVQk0hhFHSc/Hx8VnmXQ+mzJ0EkNqb83vzhq?=
 =?iso-8859-1?Q?e0JCtCUZwZuQx4XvbiFY/5P0oYXrVmP1CD6R+SGeUSXTPceTQyk6k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?InyGtQ9/juGUhHVDzfXGZ7QbDTqAEkXfbELhX/BmwPVRpsa/0VAkh4oZb6?=
 =?iso-8859-1?Q?+yizDurNFHOCceUs+oLXyHyTpK9F30VspAAGwv1tIArEkge2KvEAqnjXXB?=
 =?iso-8859-1?Q?VuI17xjvgbNVOmL4cQx5JKxA888NZWkGJWoStyMvU4bXJyVRPgfdPUPSMd?=
 =?iso-8859-1?Q?XUzXvvJ1z2l2AK6y7JH9m+xoFbIPrpJxg5krlvcpy1VpZpECFC3MKlrUlE?=
 =?iso-8859-1?Q?QO50du9xQFT29VHSjdjr5nBsGCasSDC1ZFj5SA94jehBrdqMLhgSFg2chE?=
 =?iso-8859-1?Q?UDJ97WvgBnQ/b5VMy7QYpmj8OEIRIpDidjK9a4ZmuWrG7guecvg/FoyXbu?=
 =?iso-8859-1?Q?Q9/bF4Pm3cMl4RiU3QiPdjjkLaHTba0WZCpQgzHaMXHKNgFKhduTQL4UYL?=
 =?iso-8859-1?Q?Dqz+Y6c0raoAQysYQKdjBCE2T3nW0kNgHvwJq8nBKwCfvU9ZulkEkvhjmU?=
 =?iso-8859-1?Q?Sjh6R+Q4lXKWMSVrsXkSf+QY3+LGLPjcNa+3XWUUy/yGLSCGKGYYhLK5SA?=
 =?iso-8859-1?Q?Mcw+HhOXt5j6V5bvxg/RPHJfCX7Byjz6hAvtZi9tgXFaBPgJQafvl0dw8T?=
 =?iso-8859-1?Q?v+L1eUOIHD7v99+Zgi/sHcdVpfwMRdh/pssWuXw6UhA6ntUgERAaguTNpx?=
 =?iso-8859-1?Q?UcNu+a9JTUDkhBer6/L0/YByoZyZsgkw2Ye4mjWb5FEeZ/firR4gwzcQeH?=
 =?iso-8859-1?Q?gMGkd2XG2nZ34hEKzyWaaK772ZQm03gLk05jOoU7KNC8RQfMCQFUW64U4P?=
 =?iso-8859-1?Q?aKWOJ9z6I+yawKjU7cizPDuedHZ8papOlZ77VFASo7mCi9cSi6eD/M5PZ+?=
 =?iso-8859-1?Q?7CY1QXa5ycQETVcS22F2zudh0QncD0sjhA/p57A6O0kU7AY5Gu4x6cgqgC?=
 =?iso-8859-1?Q?M+KvFVfy95Bq5NmsGbFeh3wVT7vkB3m8rBI47yjuWh41vE5Fq7il7UvJ3Z?=
 =?iso-8859-1?Q?vz3vuRYuUdQquXtmK3AYzf9o5AkM15uwPm90ux2gpjG4Y7OJ/52y7hee77?=
 =?iso-8859-1?Q?qDQdgnaIw/4IlfClV2iy8MMTOdspyPG9fm8tMBwf7L2pbTrBta3LRqgLey?=
 =?iso-8859-1?Q?hGVPmWIyYkUaqduM9/IMJhIcz3T7I5T57TAAgka1IV13dhB/vYSDAOP9eK?=
 =?iso-8859-1?Q?96i4Tu8y9k/PeiEhM9bafUTkg4PzJs4ids0JYxq7JblGLoBy+KtSEagXuL?=
 =?iso-8859-1?Q?Wa8Bkh8z3TKOcO61uIjYlluDcMZ0ya9z608OoZkewbFdzrTBtxwP2+7Y/o?=
 =?iso-8859-1?Q?RlwPR9S2V/alb9nj0fqwagQz5vPTfymnBhTJgc7J0KSF69PK8/ifPZ23kE?=
 =?iso-8859-1?Q?wzIK3j8eYA7CYfbCdbIXSKrTMwcRta8lye+dcEO/vGFbbDaIQWwm4YXxvj?=
 =?iso-8859-1?Q?TvQBvMkyzs+Bm0fa44XiV37znerc3pZDkbfk+N9CZ3ClvrO49rD/o9Dv/U?=
 =?iso-8859-1?Q?E+RvpVbEeYeDP8m1y/wR4ABsNuXajkrJth7JWRSWTqhOXRIP1tz1Z48KXR?=
 =?iso-8859-1?Q?nQG37FrY5s0eRJErkllL98PFKtKQSGat9FiLro/S0XQ/AnKlw2rv3iZY0a?=
 =?iso-8859-1?Q?9K8RZp24zlsvwWDf66ApIVglSB42dr/eXtdwgEfgh6InXX4Mx8Cgl3ETyk?=
 =?iso-8859-1?Q?pGbFoaTaii3P37WdpDqQU/72450lcCbcXU94lPYE21FD3WAvenyTZTZJ7X?=
 =?iso-8859-1?Q?WHHpTUFHDA4Q1thHggI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f22450d-70e3-4068-1f47-08dd04b9d43c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 14:37:13.2340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GP8BcMpf8ssnq9Q5f++ccNc7Dxf8Z1p3pgWabFKhXKw68xB7DihnBWjo5plU/y2cRheCvpNSU4JF2DtWoPw6e6qO0+4o+tMBS/tBhwqdn4ithwkpmeDuIlWUI9YNXJf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2152

Hi all,=0A=
=0A=
> Unnecessarily checks ftr_ovr =3D=3D tmp in an extra else if, which is not=
=0A=
> needed because that condition would already be true by default if the=0A=
> previous conditions are not satisfied.=0A=
>=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ftr_ovr !=3D tmp) {=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (ftr_new !=3D tmp) {=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (ftr_ovr =3D=3D tmp) {=0A=
>=0A=
> Logic: The first and last conditions are inverses of each other, so=0A=
> the last condition must be true if the first two conditions are false.=0A=
>=0A=
> Additionally, all branches set the variable str, making the subsequent=0A=
> "if (str)" check redundant=0A=
>=A0=0A=
> Reviewed-by: Mark Brown <broonie@kernel.org>=0A=
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io=
>=0A=
=0A=
Please consider this patch as v3. Apologies for the inconvenience.=0A=
=0A=
Best regards,=0A=
Hardev=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=0A=
Sent:=A0Thursday, November 14, 2024 7:52 PM=0A=
To:=A0will@kernel.org <will@kernel.org>; broonie@kernel.org <broonie@kernel=
.org>=0A=
Cc:=A0Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>; Catalin =
Marinas <catalin.marinas@arm.com>; Oliver Upton <oliver.upton@linux.dev>; M=
arc Zyngier <maz@kernel.org>; Ard Biesheuvel <ardb@kernel.org>; Mark Rutlan=
d <mark.rutland@arm.com>; Joey Gouly <joey.gouly@arm.com>; Ryan Roberts <ry=
an.roberts@arm.com>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel=
@lists.infradead.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kern=
el.org>=0A=
Subject:=A0[PATCH v2] arm64: Refactor conditional logic=0A=
=A0=0A=
Unnecessarily checks ftr_ovr =3D=3D tmp in an extra else if, which is not=
=0A=
needed because that condition would already be true by default if the=0A=
previous conditions are not satisfied.=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ftr_ovr !=3D tmp) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (ftr_new !=3D tmp) =
{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (ftr_ovr =3D=3D tmp=
) {=0A=
=0A=
Logic: The first and last conditions are inverses of each other, so=0A=
the last condition must be true if the first two conditions are false.=0A=
=0A=
Additionally, all branches set the variable str, making the subsequent=0A=
"if (str)" check redundant=0A=
=0A=
Reviewed-by: Mark Brown <broonie@kernel.org>=0A=
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=
=0A=
---=0A=
=0A=
Changelog in V2:=0A=
=0A=
- remove str check=0A=
=0A=
Change in V3:=0A=
=0A=
- Add logic in commit msg=0A=
- Add review tag=0A=
---=0A=
=A0arch/arm64/kernel/cpufeature.c | 13 ++++++-------=0A=
=A01 file changed, 6 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.=
c=0A=
index 718728a85430..728709483fb7 100644=0A=
--- a/arch/arm64/kernel/cpufeature.c=0A=
+++ b/arch/arm64/kernel/cpufeature.c=0A=
@@ -989,17 +989,16 @@ static void init_cpu_ftr_reg(u32 sys_reg, u64 new)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 /* Override was valid */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 ftr_new =3D tmp;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 str =3D "forced";=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else =
if (ftr_ovr =3D=3D tmp) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else =
{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 /* Override was the safe value */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 str =3D "already set";=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=
=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (str=
)=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 pr_warn("%s[%d:%d]: %s to %llx\n",=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg->name,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ftrp->shift + ftrp->width - 1,=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ftrp->shift, str,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tmp & (BIT(ftrp->width) - 1));=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_warn=
("%s[%d:%d]: %s to %llx\n",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 reg->name,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ftrp->shift + ftrp->width - 1,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ftrp->shift, str,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 tmp & (BIT(ftrp->width) - 1));=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if ((ftr_mask & reg=
->override->val) =3D=3D ftr_mask) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
g->override->val &=3D ~ftr_mask;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr=
_warn("%s[%d:%d]: impossible override, ignored\n",=0A=
--=0A=
2.43.0=0A=

