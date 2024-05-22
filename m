Return-Path: <linux-kernel+bounces-185704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB0E8CB918
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B3F28178E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA523EA76;
	Wed, 22 May 2024 02:48:26 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2103.outbound.protection.partner.outlook.cn [139.219.146.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB955FBBA;
	Wed, 22 May 2024 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716346105; cv=fail; b=cCBSXnzzOYpquv8DSaeLiUUq8zeslO4xwd+ouXpfknz7KkQ1AphDf8jRcFMUvYsjT8Dc3Pg/rsJKeGTvTQHL5BmCGwaqRSvwcZbL9povmf6xulRHxiD/ydaGKg5TjRawSz0Hec3STr5lx3d/iBNctyBf2G1rCYFbXoSNpwby1zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716346105; c=relaxed/simple;
	bh=xwYIroQPCN0+m3yp1U8/UACwW01/gen7ooDs4+6yrW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nCdLl6H971OklFZ17s6qUEqQVt8hjJ6WldhC8722TlGxqejCLxX4E/iHgAdamVwILSf8UidH+55xX0GY3DTvTLQiUeFPy9dUXL5awqs0/fMxPQTg0KALsjL4CQeXI+czaf6ZyUpa/BKaQWBjibJYeB9tQ3I1mFWPxCoGe4Bgrhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN4KUno7j8ypLInNVliwQm37UZVsxSWKhcxpJUQU+06FKRXf7XX0xzE2JbXLYugECMj04ZgeDNtG7tCeXIrOg91mz8F2ZRBzWwmDsQZNhEwZrzyyO8AoKtRCnEH4p+TOCdgcwYLDfno7tXty9/4xBHzxN29TBELGwtD1dFGnYdI5CDlfMw9UB99vVw5C8LQbZGm03iwQ5TV6qBvitz3uaOKBQbG+YDSSaEKMlaFQWUeSXNoqLCziM0LcKBkEBGO1VSVOxJWqm9rUHlOpUA+/5SvLYwZvKb11q3rvKxQplI5umAMipvjY6jIsF/ZBES8yRbNB48CvcfmW34bm84TvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f98g7p1kqgM4DA46Y1BKwM0baIzCBPoANJUTi7qC4ZI=;
 b=mMFk7tSkOf0jWKtFnMYK3FbSewXJBRB0ycQCzgk6sH1ssCjTqoXUan/PRU6DwTTdUeRtZbpGMRcEqPYQx+ST2oEpYp09pB47a0RWQVw2rtlxP4YArN26SKJO9y3ALNH8h7AVdwuTjSMkrHlUx2UPnkhl6bssSSfAY/dBvsr2bovy7kYNiITN2oXHao2pVLmtpjeT5P/pLC1DHunoQ5l9Xt1ciYxuTcjmSRAsCN01PCxA5Th/pP46p6fhIgwDJY7dm2fm3aQawg+cauiQzaFXyUQfy3wnyuaPaGU59AbGQCbvsreXQlp7nyeLvHAxehQfNDqGyFGK7oE9MiSSbfIlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1081.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 22 May
 2024 02:33:29 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Wed, 22 May 2024 02:33:29 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, Claudiu Beznea
	<Claudiu.Beznea@microchip.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v3 2/2] ASoC: cdns: Add drivers of Cadence Multi-Channel
 I2S Controller
Thread-Topic: [PATCH v3 2/2] ASoC: cdns: Add drivers of Cadence Multi-Channel
 I2S Controller
Thread-Index: AQHaoRXwCwwKaFEsIkWyZsjjo8jatrGimlbA
Date: Wed, 22 May 2024 02:33:29 +0000
Message-ID:
 <NTZPR01MB0956937A2D3D8B97DB1C8E079FEB2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240508070406.286159-1-xingyu.wu@starfivetech.com>
 <20240508070406.286159-3-xingyu.wu@starfivetech.com>
In-Reply-To: <20240508070406.286159-3-xingyu.wu@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1081:EE_
x-ms-office365-filtering-correlation-id: df8d8ff4-9a12-4696-3fab-08dc7a0790be
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0dw3zhB2hC23R676M/ICjmawahHJNUakHhcU2g8h957mDzcNBy8G+XJZCfUxdDb/ZfGqLNYIpNtOF10TIxNjfQ/emGbFIu1jKJFjYMuTN+ZotE5E7tniyM4P/ysoSREbOuKwsTnvJZPOKi2xj9r8+xtmlZ4ehLwmZZ26dyM7GbnW60DlXZhC1hZuuHbu+SBvW13w+j2LSy8OwrZn1p85tC64dlf9zCuG0QvfOUQNGhJWds5neWCCj7D7pN5NODTh/y1MjMY8w9o9i0jNlMY4NS17ZB1jXGDmX957W00jCiZF+yIESwouEbQ/gPvQTpP7IuJQMgZXlRk8k4SZ06/QbO0ArXJRGSEJWfMbuO/W8Z/hEO0o3EGsnel+2TmSc92/+T51vntbQx+zYV46PUYou+AYlFgOQXdFMbmU5ZcZCQnaKVwiV/dt72FgGKF2KS9W0Al+gS2zCjsMvCcdr23S6Hnub926FyoJV1mz1MfarD+NvK5CdAwLH8TWmIFuPRQobY06RJetXW3iPmMLqwX0V9Hf91pktDoy3wXL7tt57Re0lJI7subcW1vPKjBxXba4R/8vQbev0f6qP05PAL6qGws9bQQRR0v/P50NstMKa8EPcSS26pZIyAP3LnhAkI1x
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WV8UHLEtFbGRIaRfNTgkWXUx9Y37Z4MJzZ1k2YguYbupz9ZEyTDMGYBDgL9d?=
 =?us-ascii?Q?XYG1P3sM/YTPRX1jZWr01AqM5gwdlnPe/AVhvFKycCwz32ekNzw677SrPB/u?=
 =?us-ascii?Q?p11wRqGhUSUN9N/NRKQVntio66SMhvSI012wDZa43gjRzfjOafZ5mx9wlTzX?=
 =?us-ascii?Q?5eq3Ly4tvLGrVK6BWMlgJRkta5ioiGru+V4Ef4QZbO2JmZCH997RHi4+wnTy?=
 =?us-ascii?Q?45DXGMf0MiVAVoZa3WBHCZjFUha0Wn6oh4/SZTodYe/v6bAcnsw6HhtHaMqR?=
 =?us-ascii?Q?OJy+xwwKgxaPYejLGqIjZCMTv/WfOJefcz5XUvYIOZa7gW6haOYimJJt8qQ7?=
 =?us-ascii?Q?8XxG31MKCF6zqUc2yTR61moOXcM6fqHyi5seoCf7Scggkhn6TvrNK6MN94uS?=
 =?us-ascii?Q?4D5c8SVjVzmoyHmbqfuMyO8bEbUinTmRwS/qc2C08D6P1oQlNfS7QvjB060P?=
 =?us-ascii?Q?mkLZefFeZKZlTe3nVCR6GglBrHjxEm2gc07vM3+e13XuZCKZTkLU9JWKWpe+?=
 =?us-ascii?Q?NUKDixR6ZTFVWIWGw/xqhSPqu7trcek/TRAcMr34b1JdF9Pc8RIuCmBIC/Ad?=
 =?us-ascii?Q?aQUBP+T7wMMIh+23QLHbY/t7qn2m9QgmzHeXPBxqdCnMFYlbhkMnGm2qegGJ?=
 =?us-ascii?Q?wAxUApsXeRIOUkb4vTVG+AC7c/M+meiuOkH4gfYiNiJTo/ZKauFfcIvOfQQ7?=
 =?us-ascii?Q?mXL7L+bYdibb52kowTbSR9f8k8Z0Q3HS9dWIBrjNjAVwyL15dZNMprROysXo?=
 =?us-ascii?Q?6cfqBxttaF+O/XcVANBiq8z2IMvcBc3rzu9a5U8d3xq8cg3Ef5Yb1g0l7Qib?=
 =?us-ascii?Q?rkbzNlwMBXldsimjz3+TAJyQ/0cdKAaFtjgLScmjvolcbiFTvmZTbBAADK/X?=
 =?us-ascii?Q?cHemOLq6raTmTVEuCXMPKE0kQ/QJ8i87+atgiSjfnEBYHU4yKoPW37uGAx94?=
 =?us-ascii?Q?26Y1Hn5s69Qo8f4bHEB6dZ1m4KGTwW9/GuLwi0p42LokWh9uy5w33os+YfBV?=
 =?us-ascii?Q?Ul99dsG+JOK721eG3rWZBdLzogLzIjNGcwXdi9spOcuewy4xMdo/uUaAwSAi?=
 =?us-ascii?Q?S8/oXW9yyRtd+Y9MkYO34lOmUkXAJqRvQKk5ZxwOW8OlotED/dSkIhxhKY43?=
 =?us-ascii?Q?wtcrE0ybc25B5eJqMLRmN/eeQXyf8xyP6qbEmXBGPLUnifIbx0xBlvClRQNt?=
 =?us-ascii?Q?e57FO1nr2iegGUehYfVZ5TRaqr8kKuWEXUVhYPM+sFHGdqcWw3tvGw1vCcSi?=
 =?us-ascii?Q?crw/b3pfe3C2C3ujw0kIGDM3iBIJgjnHrK46n6wkHD5/ssVgRHDYTPFQQ+vZ?=
 =?us-ascii?Q?JkBvSlG08BxBIZvCAdF2o83xdwi+QpD65KwTqL+yLO+A5doLhTva1cD9ndLk?=
 =?us-ascii?Q?X3j4oLn7PSf7tLTT++fNec+/HoZbXKO6uKZPLwN4tzzyL+Ji0Vt0R9m1jEW8?=
 =?us-ascii?Q?bWGjPLsNXVIbrxFCxNY5c5NnMoC6VZF76ckCs47eIwb+EJFsEG2aGpfnkSvR?=
 =?us-ascii?Q?tjanbhWyc+J68SSbCWwkJY6Wix6qdR45cNuZ0/CqpPR4N7ykuN0mm+g8gZSW?=
 =?us-ascii?Q?VIYoYHiOy08C6g9b9pLSsuzPQvayxjsUvh7ZCiFP?=
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
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: df8d8ff4-9a12-4696-3fab-08dc7a0790be
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 02:33:29.1357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqFK5Nbp64/YQv9519GbZxsR59EOEwzOqfRFJiVFMdAu5Eww677rDAL2lviuNI8qqW+euFdr2CqlQnRlBNR3KcxvKyGCzrawvI3+sthBUFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1081

> Subject: [PATCH v3 2/2] ASoC: cdns: Add drivers of Cadence Multi-Channel =
I2S
> Controller
>=20
> Add the drivers of Cadence Multi-Channel I2S Controller.
>=20
> The Cadence I2S Controller implements a function of the multi-channel (up=
 to 8-
> channel) bus. Each stereo channel combines functions of a transmitter and=
 a
> receiver. Each channel has independent and internal gating, clock and
> interruption control. It alos support some of these channels are used as =
playback
> and others can also be used as record in the same time.
>=20
> The I2S-MC is used on the StarFive JH8100 SoC and add the compatible for =
this.
>=20
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  MAINTAINERS                      |   6 +
>  sound/soc/Kconfig                |   1 +
>  sound/soc/Makefile               |   1 +
>  sound/soc/cdns/Kconfig           |  18 +
>  sound/soc/cdns/Makefile          |   3 +
>  sound/soc/cdns/cdns-i2s-mc-pcm.c | 285 +++++++++++++
>  sound/soc/cdns/cdns-i2s-mc.c     | 704 +++++++++++++++++++++++++++++++
>  sound/soc/cdns/cdns-i2s-mc.h     | 151 +++++++
>  8 files changed, 1169 insertions(+)
>  create mode 100644 sound/soc/cdns/Kconfig  create mode 100644
> sound/soc/cdns/Makefile  create mode 100644 sound/soc/cdns/cdns-i2s-mc-
> pcm.c  create mode 100644 sound/soc/cdns/cdns-i2s-mc.c  create mode 10064=
4
> sound/soc/cdns/cdns-i2s-mc.h
>=20

Hi Mark,

Could you please help to review and give your comment about this I2S driver=
?
Thank you very much!

Best regards,
Xingyu Wu

