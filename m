Return-Path: <linux-kernel+bounces-302655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BBB960182
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365FC1C21F65
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8DD140E30;
	Tue, 27 Aug 2024 06:24:02 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A67BA49;
	Tue, 27 Aug 2024 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739842; cv=fail; b=mlLZic5qKSiSRQ2CyYmVMwWMFBm65Ha6cYpoLe0SeqlNsy+om9p6ZYUjbJAfaaMLriEm09gOE2VVMdgl/cL/cRuWKAnhFoP3XKl0L9UlVpcBOLOO/ronwMrWQV6xG8ovRNfyaQym7esOtvPlnpZnqSNfYRFLzn2ob43bvKoG+VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739842; c=relaxed/simple;
	bh=RPZAEY5F1xU5T9HfvbV2s2LrK5S2Dp2IQA50MebOMWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n5Gvyynu66DWCWP+g0Ci82U+R+k1oprKuRyV6RZQtRV84xtDXXY4YkV8HV1MaKtbP4z6hgG1THbRPWaDDhgxUxT5vf/v2sQ1GRNbeLuf3n2FkEsGZ6vLxkNRE9xuwW6qScsWi3Urcm3ksfrqle3IFL2z/4+KWOh4JyHnQnEFigo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEgv70wZUt5pv62gphX7kuWntENxYVMK18KOXI7Tl6TTUl9Z92qALVBx5JJKxlSywiccrtfGG1yYPhKbs5qELf9BJWoXbkh7GlvnNfOhX+KB+dnUO5IqQNJnSklzNmcBaKaRC5y51J+P+fYaDA6CiKFhmPWz58nzs0spAP0afJzF0SitHyZwBX9VtfY+uFaHbrpqmvxjsT/BPrPKdPJrrvUQj10VMe8TZzsLg0wmQzeQeLy7sV/Fh7ToBzOdXBDwJ42x7g4hs69hlhcb28ZNX7IIHWdjgSiHsG4N5FK1mrpzrQZhy8q9uNFfVZqwyA8bwOCZBGgzova5nvGVv10hSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPZAEY5F1xU5T9HfvbV2s2LrK5S2Dp2IQA50MebOMWs=;
 b=J3q8HvtelMcJYqHSVlkUvldgJI8rIrR6m/roEp1XrTVKwQDgI0VomV4oanfRP2mDhzMKyjKfth0JaA3555l2wJtFCnlEMyNBZqtvjVpsHuV/7Od9FnNMD1IOPsShJXGVW7WcQGKCexcJEU/6fuk2OuhGCAtDjDy7hKNViw3dXN63iuda3ooxnwGLYEKok3e+fPtlvvUwQ9re4JqdNrzvAvugqpy9V1ZYklXn3Cj69FD2jdNLHb9MZEo+JjuMLWa2pOtt0euY4AzN/S21VgefonOqY0iE1ylMkPsTTUovzVRMh9P2i8g8rmYsttnQLgageOijuVIL6PDXoLvXijmq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1305.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.36; Tue, 27 Aug
 2024 05:49:36 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a83:8682:b030:e46b]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::5a83:8682:b030:e46b%3])
 with mapi id 15.20.7784.035; Tue, 27 Aug 2024 05:49:36 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor Dooley
	<conor@kernel.org>, Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v7 1/2] clk: starfive: jh7110-sys: Add notifier for PLL0
 clock
Thread-Topic: [PATCH v7 1/2] clk: starfive: jh7110-sys: Add notifier for PLL0
 clock
Thread-Index: AQHa946Z6AJ9JnQFGUeQ1w+Pg1unp7I6mVsQ
Date: Tue, 27 Aug 2024 05:49:36 +0000
Message-ID:
 <ZQ2PR01MB13074B9722255366B9C8F946E6942@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
 <20240826080430.179788-2-xingyu.wu@starfivetech.com>
In-Reply-To: <20240826080430.179788-2-xingyu.wu@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1305:EE_
x-ms-office365-filtering-correlation-id: 12da1b6d-5913-43a6-55c2-08dcc65c0888
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 9lgi1pj7cZ87aLQKAdh+yslTLV/oGY8rXUKynDOwVFEOYN8O+jY3HPeeRyBzTRWqS7n/FsJdIvla3+aGTcH2sYLiaIPSI/9QWucPvKkRZ83/6T2QN0KF+Zbhei6fckjwvET6aRls168tMtdJrxrFnvToMxIFj3ZNy2Ukkr/T142gfECaoH4NKa2Pmn8bEwSk39rGlAfYizH7xOJCQwoFfe5if9/UH26Dyv9oecvLHxgp/Aqnc3kGVjDxgarlvJLDs4eOQaPF3Sif0py1EltDvJZqtygQVEm8U0ju0bfJSbCuT+sEh6nFeEXvIA0f+jV4XJ+6fgKMuf464UL448M4Vgy6NaGgE8UrEE0462mAGy8Enb0rXErI+QLPJkAfWoVTLlLpqfi//3e2mgIpmr0Crzqfo9po0isgu1G4t1zb8B06TANH/NAc1cMHZr0e3akvVhP1iEkZelzHXbNtXOlkHv5qmLQA4wH7ydeKMAKxLU7lzQ2bkmlsw86GUVKetnuNu7pRkKsD/ctzuGnF+Dh1XTDu2JZqriqqcKvTyEDw0/vIRQMmoTjAdLLXaurno1C2xMlVNfQ/+4EOP5eIfSlVcjOa3vVFr+ek2/iMN6eUwzPYZWCJCOS0S5THw0zh1KzZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/FlVFNfCSawYcyBqhaUYrxQjPBZfShMD4yVxNUnMCg7LoaxSBDMB3sIbRYZN?=
 =?us-ascii?Q?esieWCAPtr+PMSfUHN8HizGVd0FwRnb874PrmsoxJovGkC4WthGOEZOWRgBL?=
 =?us-ascii?Q?OZRgl9y2oM+LAxHB4ZHxUauYNdeh5LHrjFbwxpEUdUoKbNv8k9ajEzLjK84t?=
 =?us-ascii?Q?RgaCtDOgX+aozjCg11naJDLI6Wii8Thtbw+W+eMUb4zZMwBKlNSSg+0jpaAq?=
 =?us-ascii?Q?l3m5A2cxDn21Vg0MqJDltwNpuMB8iRc+HqogjEG7Ic5lumxhOQk3lj08cz5d?=
 =?us-ascii?Q?UvORWwAyxgCnCTph+zgNADcmcHHOoEhLAhVz1oskBurZ2eHrwozQzk4Zvnpe?=
 =?us-ascii?Q?THqahDgradUVH/T9Fm3Einq4joxDlHg7xzYCbLTDp0UnzV23emisTNOYjOEH?=
 =?us-ascii?Q?DRHk5q2q5baOzqx3+8e3YljQzgfHwKM6Tezlv508/UdW7Sx1AD5mE5mxkOos?=
 =?us-ascii?Q?5aeLVsfOgEPi+KA6Vv3K/nUSvdHJyR0ZaRgzRtSsZWU+iAAFAgbaZyki+f5+?=
 =?us-ascii?Q?Y3dcDTIrAs5zzWqF31IOS1rydqqEi/LJ7R/5jES5zqSvsLnCpxPim/TrC1Ql?=
 =?us-ascii?Q?L7/2H+mFBpnxULgE7ioUC38dazjKSWuOM2b/9id4RTmozJgk5In5l/YsSH9t?=
 =?us-ascii?Q?eD9tyijXBysfbGGk1PEwaSuS2pU/7HMnZoFi8zm64uYlbuR+ZlTkTsV19kf4?=
 =?us-ascii?Q?b8USow+aDcKnCNZD614WtH5f4IYbYMx6uG8tmUsh6iBxNVMMsM8zf7ZruZh5?=
 =?us-ascii?Q?BKoH6ZFTEkaoik8feqNBcr3dKI+Cb6KynNFKVm31xLJiOGHQkLZN7+wt0jQr?=
 =?us-ascii?Q?DPwvxNpBTDyDutbCyXPGfambzLbpuAO+cGD9EU5uU2UTtQ6PPl/SvTM8wTLC?=
 =?us-ascii?Q?MRTa4Lbai/s+OVPPZj3qVkCYI4fAc747hHyGeI2QjiStnNPMJ4/3D7X3HcqJ?=
 =?us-ascii?Q?f/FovHmQ8Az/L6+cy8n8D4JH/8aVqVNWu+GD/9afw2VpcQmYMQIy7xT1+/NK?=
 =?us-ascii?Q?LsGSIqOSIchs+ZRDBq4wC6uWjlhogg5IOUB3V0l/H2TXooVuR9UmOeXgNiGn?=
 =?us-ascii?Q?NiyWEi8z6/v+3xqU6Hg80+8wkHQuXN41CSQ6nHE/DlYoBrLVXRzeZJU0TESy?=
 =?us-ascii?Q?crhD3EzegPZ9Id5Q7H0kdHaj/bll6jFBWgAbibkIQ1gawn/jBSOC9zR1/26d?=
 =?us-ascii?Q?NjL1DLjy9ke9GcwwtiMZUWSkgLkFexU3vnbz8eJXrwuOZYur6dBnkOYpE2vS?=
 =?us-ascii?Q?iyKV6DmojfbvYd4WUjP1Otv2laEPwbZJFEvEhCntGcs5y67SlClG7O0QQrqq?=
 =?us-ascii?Q?f1923L21BBc6FzzrDS+SRrgX+SMCNoK+axPAF3466cGulc1Lc4C7nrN5iouy?=
 =?us-ascii?Q?tTEHI6IM41kYTDdt7+b9UFRCzX9DzJM0cjlBtXM88D804B06gOeP9q6PUm+8?=
 =?us-ascii?Q?wnfJUpxhPPYZ2a2G0jswOdTt3R2m/61pO5rNGwAbNWa+UMAKGrD1ByH/JM/M?=
 =?us-ascii?Q?4PcuLLlRRMYOvMNDY0pyQsjedYVp4HMEi9xedj3Ty2mo2jXXdHqdaZq4V4ED?=
 =?us-ascii?Q?+Kibzl/0lh5fAWOrRyihPks7Q/9QtCFAeDg2Uz7L?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da1b6d-5913-43a6-55c2-08dcc65c0888
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 05:49:36.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7c3xM5PIUNSWTzBypM6DdZk3c00DFrboBnnrepavB5XQbVLNMII5XNvxqTFfbCFhgXtOrjR/OrXbHey5JehhdltcJZWwr5fUElgB1XpVU30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1305

> On 26.08.24 16:04, Xingyu Wu wrote:
> Add notifier function for PLL0 clock. In the function, the cpu_root clock=
 should
> be operated by saving its current parent and setting a new safe parent (o=
sc
> clock) before setting the PLL0 clock rate. After setting PLL0 rate, it sh=
ould be
> switched back to the original parent clock.
>=20
> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 So=
C")
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>


