Return-Path: <linux-kernel+bounces-177273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B648C3C45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A621C211F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F00146A9E;
	Mon, 13 May 2024 07:46:30 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2102.outbound.protection.partner.outlook.cn [139.219.17.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90B1E4AF;
	Mon, 13 May 2024 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586389; cv=fail; b=lwqlOqF2YhtopKp4bMCBqMJkm/qBnAVBL/NvkE1iRNmJ6SfrbVXMVkdts9qS8AMYiR8X9/n4muCE1aO3JpHSFmalkUicXOg9KBZbTlaW1qlumr4Hup0Yj7NlyBY79gnZzIps+jQ9UHHCk2D7NLE78AvUejDVaqBlC/YnTqp2xgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586389; c=relaxed/simple;
	bh=9uEL049ZfaPbWP0vQToNe1386aSUze0QgGVGlvzpIc4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d1BEMtrnMoV+LCGFxEkbrwI4aaPMoTIOqQWt9U5FZIRerjJcpj7a7ym9iql7iKOKmdR0XFIEn0o0MIHG+2Dz9ZfSzNmU7NWRd+twenNpfDwLu9IIPX1E32/AFKXKC1W6SNJ23QESGTbeeejyaAyYH0+cpDabzZ4d5DeE/eEAGOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRx4zWWijHI40O6luWvPVP5YS+lJQ0zJ6IIM4sAaryri7TK08kFCVi4tw93SnmiLM+otlugciSBAinz0ZGq6Yv+rnaeWr19ppuOxW0/ziE2lgWE4MvM/VwjBZ4uBxpLGyT7z8FHukg94hkm0CnCjqX6snqsoOADuFm/mSLQhWTEQHPMrFtaGJdtHf3/5l6++7CPQeLudHJlr3Au7UufRiZ9scZMeDbCL+vZI9QbMaW05hDspvjiOK/3tLb9qUm1SUaaIJylKhVsgdVKDDHRwcrT/0vSVgR1OL4hDq81Ek8oeEF8j0DmhpMCSwcSru6ygTM6+0OD9S4OaWSUv3JkAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaNyDTvKdSI5ZXeAMRZ6b+VexMfA48M5hTi7Iepd86U=;
 b=l0arDzdHYSc3uuTL0gXJY/j9vTVHGvVf3w2kuBmf5MFAfJp2HEeSem1bhS2M+ZGDiDBUkWDkW0VdYpHtcwvgDEiEVbUlV8pujJaOJ1EqxhKtpvQXLHO2Cic9BcruFbX30bAAX0rQAWiZVgLYPrd1GFelhQvDb5FygM3XVMuROGZijBcSeDTP/YVBNczIVTzB/ErCoZG2sEsUPJzh8DAPdmsORgtRPJ51qtRhHi/3PDvOIGjxJKIPwT9An14smHoo4g88CXIf1fQfBLd4mvV4ztPXk559NwkLW06uvnMM4A+ZK6crv7UbubgkJXZ+shtz4+FPzbjIQtEdNMO1uxt1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB0990.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Mon, 13 May
 2024 07:46:14 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::2bb1:5ec6:5260:17bd]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::2bb1:5ec6:5260:17bd%6])
 with mapi id 15.20.7472.042; Mon, 13 May 2024 07:46:14 +0000
From: Shengyang Chen <shengyang.chen@starfivetech.com>
To: devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	aford173@gmail.com,
	agx@sigxcpu.org,
	rdunlap@infradead.org,
	u.kleine-koenig@pengutronix.de,
	sam@ravnborg.org,
	steven.price@arm.com,
	bbrezillon@kernel.org,
	changhuang.liang@starfivetech.com,
	keith.zhao@starfivetech.com,
	shengyang.chen@starfivetech.com,
	jack.zhu@starfivetech.com,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 0/2] Add StarFive JH7110 SoC DSI support
Date: Mon, 13 May 2024 15:46:05 +0800
Message-Id: <20240513074607.28271-1-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::14) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB0990:EE_
X-MS-Office365-Filtering-Correlation-Id: 48aeb285-ba62-4935-fe84-08dc7320c3f5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C4cXfxT0hMpb9/s08nnNpTyAa8vb4TzzBQlDryCRFLM4I5TyrTfy7ucGTYsXnXJKYP2fXW+CXSZcyTwyPlQC6qI5JvK+DZWqH2NN4jQvgi4sUe1+5nPtebLK/f+9JKPC/F4Bmh3GLodPrdAse2p9dfc5GXgop/hOdLUENhBF/Do+bFM/9Tcd0/7x+NCsRFHJ+8aJL/Q1jPJ75LiNhEMVYgCaIBgz44BiB9j8Jlob+l4d8OAd2SyjQiQKFnVyY9YEPKn7iQvqqv56/jXNq+nZeuE295Kz0YPFGhxsGLBRGLVgXDnwurqHfJgXQdL82tKzcNuixQN8O3Iivyn4k2KmY+sI9s+BcoxKPS4G06aReTIlWWgl/gmYZUJHbakU/OTN5nWNHCKOF5P6xyEtvrPSamROXLH15GOw8lQdaR6TAniUE0V6/bATj7FeXoSHbvqeSymPmKCYbrWqi4VynvtK3KFrXzRmll1zIDQsv0phcOPy6Io3HOdI3yqttAZRPFORTNWjUr/ckeXnsZ9GHKpnnkpA1SKyt+pppWG7/o16is9t+o6K38bvUuABmiG2R0/mxXsOccmqG3fKJ2Jc4g/4Qjp86BbqNmEPmQ9IV0lJ9GeX6IgAaDXiXBV/H0A4IaPy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aV2+z4SD0j3uLjQzXsclVEvdiuGcd0Pj97lkHINFKNTLLwfhiuxBQKL9hZK6?=
 =?us-ascii?Q?hJz8bfSuYsZqU4lgbpIo8syl5swZAy/pjVy2fz3VRE/bgqCgxE2+HlLRzLCX?=
 =?us-ascii?Q?Tlw7pq8bT0w9wq43CDNAxSGJgHexQES0CPY1cDYIZuGukuT2lHu3P3i6Tsfb?=
 =?us-ascii?Q?eaCf/pctYy4l3JAzU3tyNa+ohxDhFRs2jS66xd4CaHMQCcmEBPo6Aa1Eew03?=
 =?us-ascii?Q?bn6QnsC4aI+ljTGIy7FewNV5FHiP7psA7c8vj28K5a1NMywuiDwrfJoAzUbw?=
 =?us-ascii?Q?gKLzJFgimVaWiNdhknXzkh/nrYrJQxoZnYyyi/apSiq+e5/22O4O7wQBmlsX?=
 =?us-ascii?Q?4NyINyfezoIbvaO9NA75/YXYO1xq7dcJyJoz1MSG2bkohF5GZMwXcno7xhN7?=
 =?us-ascii?Q?t0HMPinCQ4R2HUbfOI63hvoN/1ttv7DcqYNJ3uPO06Win8iiYp55gZ6zAHPo?=
 =?us-ascii?Q?apmDYa6c9o2r26kb6zjnVOu9MC5kV6A4eZ02Nxlp725eNkmKtlCDEzA5Prm/?=
 =?us-ascii?Q?6G8wa/7RpBK7gjyDJfef1Mx5IcYOysPZWLqs1TigQg/bv+M9Y8sEgXHV4i5Z?=
 =?us-ascii?Q?pZMSrRbMPbLfoHR92ruXJlgr5VVyawWziStzc+B5E7lLjFJthUUsnDrPh2+Q?=
 =?us-ascii?Q?HnoVCZIKwwBanpAKKQl/QZBiWdXV0NPBfml/0WYlvTH8ewGVTaUH1kbq82Ny?=
 =?us-ascii?Q?8F5ivxARqILOdlmcabKbJuoQjEDZ2T6s1byHeE7PG6O8z5pjZgrLkS6UAdyW?=
 =?us-ascii?Q?pa4MRD1SFZi/u1vPz9gdJoktL8W9YI2McO/kmf/ZFggDYhGi4m+/roMBpUhr?=
 =?us-ascii?Q?TNqdC9DUrUQxZwTfgeKR0oeDLOnQfPrGyYlLXrZfIe/GKkwt0oSKK/ZnLOeS?=
 =?us-ascii?Q?4awLKe59YHr+bvQGEd2Wop6a5TbOvLLtuasg5+7o5KIzRpRCTz8zV62oBLNV?=
 =?us-ascii?Q?+qMdkxHD2vk+zm0bmlfyLdHRcpLd+2q6XyMfoZIMvlAC71POHsgbd4LAY4FU?=
 =?us-ascii?Q?6gk2OA6Lh1daJeemIxEXLrGcT63lKs9rUIe8RG48kjWv2fCoFYu8OYOeGJ5L?=
 =?us-ascii?Q?c8h1/7dGlqNOYn7XQvW/cmrO/ekXrU6vAKWj5Z5Ya6q7OxO+poTb0qjNHObI?=
 =?us-ascii?Q?5DtXlGNRg+a/2mNOY7aDTPui2ZmpiK3AvyMZjE7Vj5PDdQxaoFyPD5DgPaul?=
 =?us-ascii?Q?1ZqOacawfzGPk1rcVijFfwzs57t41k9e7RINhCueMmSwq0YML4521lIkDN+o?=
 =?us-ascii?Q?4UtnqR0oXf1jIy/ZsU27yzC5UqWk8aon37bleK8XyTBEmQRJES0ROlaAYwp9?=
 =?us-ascii?Q?sLkmRsRVKduACEfLDzu/1FUXucqxQw0m2CocQjwsECXdYAWf/ncrfw5FTcq0?=
 =?us-ascii?Q?RF5WLDkVHfEDTgGkSAYP8uuNUJZrbo1jl06AZW9sin/iSwjNGs65JYEFQqQn?=
 =?us-ascii?Q?JOM+EkJMhMib2Ko0n9HaYSI7BSCNga++SoJvMv0YRzkoEvxY6RjZnT80WS49?=
 =?us-ascii?Q?GEOKLT9vAd2Cc1aYsoHC3RN/2ojHx4KDAQ7tdloZteml1x0X2XTzoCameSFv?=
 =?us-ascii?Q?2nvOGUi2ugEBHJXAm22CO0jxDlYKmi6Xjsxnm4VRoerJQJAvHuxu6Nedfjrr?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aeb285-ba62-4935-fe84-08dc7320c3f5
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 07:46:14.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sF7hVG8ZdMPpa1OXFPKCAAztm7TC7+rQIn0pZiZRaBmrxQMPd62pI3Dm11W2EQd/I2r/sYzBNt8DCe9OvXmht2lOZW7UPyeo9y0UHB9mDdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0990

This series is the series that attempts to support
the CDNS DSI driver used to converts DPI to DSI.
CDNS DSI is embedded in StarFive JH7110 SoC.
The series has been tested on the VisionFive 2 board.


change since v3:
- Rebased on tag v6.8-rc6.

patch 2:
- Replace clk API with clk_bulk_ API.
- Replace rst API with reset_control_bulk API.
- Use roundup() in cdns_dsi_jh7110_mode_fixup().
- Add assert for txbytehs reset operation by reset_control_bulk API  in suspend function.
- Add clk_bulk_disable_unprepare() in cdns_dsi_jh7110_resume() for deassert failure situation.

v3: https://patchwork.kernel.org/project/dri-devel/cover/20240206065709.108684-1-shengyang.chen@starfivetech.com/

change since v2:
- Rebased on tag v6.8-rc3.

patch 1:
- Modify commit message and patch subject
- Change 'starfve,jh7110-dsi' to 'starfive,jh7110-dsi'
- Add constraints for reset-names and clock names
- Add resets, reset-names attribute
- Correct reset and clock names

patch 2:
- Modify commit message and patch subject
- Drop useless MAINTAINERS modification
- Change callback name from 'update' to 'mode_fixup'
- Optimize the mode_fixup function.
- Change devm_reset_control_get() to devm_reset_control_get_exclusive()
- Correct reset and clock names

v2: https://patchwork.kernel.org/project/dri-devel/cover/20240109072516.24328-1-shengyang.chen@starfivetech.com/



changes since v1:
- Rebased on tag v6.7.

patch 1:
- Changed the 'starfive,cdns-dsi' to 'starfve,jh7110-dsi'.
- Changed the compatible enum alphabetical order.
- Restrict other variants.
- Drop 'dsi_' prefix.

patch 2:
- Optimize the calculation process.
- Drop useless definition.

v1: https://patchwork.kernel.org/project/dri-devel/cover/20231127113436.57361-1-shengyang.chen@starfivetech.com/


Keith Zhao (2):
  dt-bindings: display: bridge: cdns: Add display bridge support for dsi
    on StarFive JH7110 SoC
  drm/bridge: cdns-dsi: Add support for StarFive JH7110 SoC

 .../bindings/display/bridge/cdns,dsi.yaml     |  56 ++++++-
 drivers/gpu/drm/bridge/cadence/Kconfig        |   7 +
 drivers/gpu/drm/bridge/cadence/Makefile       |   1 +
 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    |  29 +++-
 .../gpu/drm/bridge/cadence/cdns-dsi-core.h    |  19 +++
 .../gpu/drm/bridge/cadence/cdns-dsi-jh7110.c  | 138 ++++++++++++++++++
 .../gpu/drm/bridge/cadence/cdns-dsi-jh7110.h  |  16 ++
 7 files changed, 263 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-jh7110.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-jh7110.h

-- 
2.17.1


