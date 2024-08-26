Return-Path: <linux-kernel+bounces-301036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D948495EBC4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6432C1F210AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC83C13C80F;
	Mon, 26 Aug 2024 08:20:04 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C34154458;
	Mon, 26 Aug 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660404; cv=fail; b=NogLZvL6dIOXPv4wwrfmgAttVwp5/BpnLoVfW3GBocjB8+vC3esSltdJBAdIeVZS7yRKZ2B+UW+8B+sekUUCOGTMYTU9dfFZftdhKoGELpea6+I/3+0FMLg+qBdFZK8OKbe5sce0sprlKmwaZ9iRuYoQV1XAS5aqr+mGvnF7WpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660404; c=relaxed/simple;
	bh=HqOqHj4pvU9+7bFH6hgmU/2S0zG5prf850dwesPFe9k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=roD0tH8BsCw9UeGzEG3bcgOEnf8kUiB/XyDdB23aLMIAf5r7BPtTTPadsgWf9lC+YHWxU9Lq4TZgIhzT+Ro7B7P2cFdOf82JzKVhd/Qbik4q7d69gFsWhs4Dl5uRTUHTTA7HeefMCkREBoCS8KBFNVZwsx3b28vXTZkHzEP0Sfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M33kKGHl421Qi1hRnOjmIeumtZldizNTxOyS2YMnjlPjzPQb1dDJxUNEjYqgI3st2sgW/vTSVe+9dmVY/m+4n/L+BLS+VUN6+KNKCq+2dssTP1QE0TJz59lip0WBR8VhAFWDUAzQZYAGpuy5BqE3nija9V/8cbzwbYAHNz9DJnztyOInoXLMjPofo3iw8WYHkynAiLMzqp2nsCVAngEs40ZCOaySeHATh6ZdL67eWQu18bcWeQkzWKsAWFcZlvuhsBsuV7rrKmJ+9udgO+YmVRJiyEtGMY+gqoIyDDt+PNCGcjp6SltKdLkl+2OOkqvrKdsFesITHt9bUI9Jxc+yOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hle6pV2p7OE51Jj7M4BBo+ikrObNFJgjsJG97zK7abU=;
 b=SNxYIbw3AymdrBjWqsZpR3y16yvyiOtPHUaWmL+UZmFd5TgAXRfoneD8Hvn9T+BgxTYvNVPTCZW1NMbtdmVJCEYJHKLgMiubqmYInUOsFezDfOWQegqzG8rxsCvRTwO+J/sdMdIqpa/niO+JurMui7bPiXOLo6+rVSYne+lnMCP/OmZ/q9rbgM4BIGz4iKD7g6p2dfA7T5+A7UKhq7pcvH9zvAibYtODORZcxAkRKcmy+90YaactFAqvAtr/GJXqKW3Bhsx/XS/mwrUAATMM0u867jzud37xbrt+D/9LvbBrYDs2ZbcBUqhmNRCP9wglVQrtYAUhLFHM06c3c2rE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Mon, 26 Aug
 2024 08:04:38 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%5])
 with mapi id 15.20.7897.021; Mon, 26 Aug 2024 08:04:38 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v7 0/2] Add notifier for PLL0 clock and set it 1.5GHz on the JH7110 SoC
Date: Mon, 26 Aug 2024 16:04:28 +0800
Message-Id: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn (10.2.0.72)
 To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn (10.2.8.138)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1034:EE_
X-MS-Office365-Filtering-Correlation-Id: 1430e9cd-88c1-45e7-5ac0-08dcc5a5bb35
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|41320700013|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	E4dZrKnA+wOEymcsYbr9jWOOgbIkEzC9o9wrSX4r2MB4tTgk/p/L0b9lk/g/AyQwZ26erO/03zOuN3Vtbyud8INGyHuJMc/NSCqM9b0TnqDp+TZiyGN69I9rlEqMwAGhvQ9SqgsrH97s/Tbx2+6qXRCm29vuogOALNLGxgB8ys3mzzI9GdLj4//nWPwh0vkohq+Yih7hVy9XCDMiaHBQGuGuhmEy6sQY+OcsdLjHgtRp9EHKlwdPj2VwPdqxUsznMmIhoc2chgYptns+z7cQoHFoMfCvwrMV1KbSlRSCTO+6IP2oRNB+j6A/jDShPnHyHC6JxU7YaB2jKYa8UTAKLucKgVWmexPg0kH0EB6htJTXwzCtPo/C6Itxw338+R1/5MUtGdr8IenUVvJUfCyKiMYsnIqgQ6RPaTS4awxbGnnTw+G7HK2NrhVQCFDiUmw6MhRGRBEQbLoDrcj7T2YscZeAZx/prwq3Z7tgomNQqUTVYMA1AFzfpad/i+kjxhwClsXWWRsLpMY8zDl0hNnslC5PoAOz0EH9l1LyLHci9/tH6N4vMxLx1fUieJt98DGwN0lbfIvSGBiTLBKUdYf+KC2WT33NRBBkPCHNgi60fsXNViMXdeD3qfrSjeq6cKqI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3BLkVvKJltQaN8jsEYdTHR5yXBLoYQ5cu0OBbB2+OY+IsLVdOXS3eVnmyzTH?=
 =?us-ascii?Q?qWrxzEQlfS9T75Bv1eKrISaE5ySYPnqYuTdVKUkgVZM7+EpQ5EHMKD3Jj6NN?=
 =?us-ascii?Q?4ngB5W7Mx896/uIZDYlS9OtyqN0NgYRHL1xKfIWH0ZeCuFyHjG602AIt5Dn0?=
 =?us-ascii?Q?c02HfQTaz8TQkVZxQCvG20z/QfHhPecHgsn4DeY9Hm5Sq8HRvlLRaEGaPsQU?=
 =?us-ascii?Q?pZV3fh01MiRCCYN59253802OMrUqrrIRuQED8NJkvVQNadICNtDuCm/nmwYH?=
 =?us-ascii?Q?5QCdr3fepsKuLjTGLYFHKTETA4XwgpUwmelH7tXQmsdWRbB7VekMrpqmOp51?=
 =?us-ascii?Q?QrZEhkC7b3/6aRUHVjxsPRFT1GJvm05sN+BduuEC+D36t+c2zQTpJWlXq93Z?=
 =?us-ascii?Q?JjXx9ChDp6vLcVlfgVppoWT5jf6dj+z7W43QdWdn+meCLMYBnqc9B0033yNZ?=
 =?us-ascii?Q?A6ztsDyVd8R5hsrMZSChEshQkebE/ZDNe+KDpBog1/SHxrN966xcyH+GTQop?=
 =?us-ascii?Q?w5qt3hcFVjKNUVeK8m/oBPYj84mMYIPZUued5r43eE+I/HQz6fgZ37FP0Tlv?=
 =?us-ascii?Q?b88OmHvxQsaKrVMI100Ljf0XyHMIO4yMsDtZDxhzKClhT0HWZoaJMewt8RLh?=
 =?us-ascii?Q?1sbzrHm4ssjsnWh2dejGaT28TKTKIDoIA/9sbd86OGpdARgEIHERTqtvlL9C?=
 =?us-ascii?Q?mPhY6eMDnNTCH2WJ7hNLes1HWQreAWg/StjVKLQGozDW5l0dy7q7zQHLdBw1?=
 =?us-ascii?Q?jU0foiw87ntfX+++WqT3P+zn9OUYQlq2aT6j3RZW+9kle2y3EJdNq1x+NKw6?=
 =?us-ascii?Q?Rq+bwUG/OVJCVZsFRlpLUq77M8J/ZjinU/ibUdgERl7rTSpUauCmYQYIXrCT?=
 =?us-ascii?Q?B1gRV9Zs2WQpplCbHLBXd7Yh79Qv9HOkFZwYG1dZVSk2ONpZNfYwjsJHleKw?=
 =?us-ascii?Q?4uXb25fb3pa/gctj2maK8ojLcG/SRxPSz77qmx2VewdFB06sK882btUhuE6w?=
 =?us-ascii?Q?LA2UegQMCRe08qBNgsgy7Ntj39bNZaR7pai6XJA9xqvEJEgGN5wh/3282rI2?=
 =?us-ascii?Q?04FbUstauwhaW47onhC02Jn7LdQPh6qlQ+yaQKZVEuQ4brXCDFiAj9z2CRV7?=
 =?us-ascii?Q?3tv//oP5SkBjjFXJZOrIk2Tw1+yb/K6eKPzmuw0DyWn5JL8d2fm1hulzpU5K?=
 =?us-ascii?Q?c6Ciyt/GRi8G+Qp1f56Wujr0jmgPtDgfVt+BqPQHmCDq3U5kOgRpc4a9sF5o?=
 =?us-ascii?Q?uUBVI6HHtQDDdQ+wV/29Nwpx4HBstgwf1loj9epVe5xtqA0qBDqsO6Ntzkij?=
 =?us-ascii?Q?DWo1HNXi09Ov9WaPMbBDKHnLe16m4gyz3XMIuM1vR6ixXoL5haSYMeNGLPpy?=
 =?us-ascii?Q?dDjPw1vxvvPWbiGM1TMPestCns23S2Py0icEsEWDG8mN6rL0v+gBAPCuhfif?=
 =?us-ascii?Q?vqo+BuCebR2DOJijoFqq0sqBBcgm5fbaVPHRYsYREhDMBqkJcJ6u2cKweLym?=
 =?us-ascii?Q?1QLcAV/TK/omGSqcfz02soo9I2t9I8ro2LOicN11vQdrLPXVNHY9VTtaNDkJ?=
 =?us-ascii?Q?X7ZkFSQMo4W5X04GPbKJjWG8iHUwb2A2iUPQ1RRwUtYzvSmtw35Y5Ot7lOY1?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1430e9cd-88c1-45e7-5ac0-08dcc5a5bb35
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:04:38.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFJP8gWeYwX5/pituBwC1X96V3wjawJeWYhhczm/0dBzy7BV2jy2ByizFR36mpXSTAqWtX+Nr4POsIe/q4cu8zYSM4IoTIzJUR0FHv07MJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1034

This patch is to add the notifier for PLL0 clock and set the PLL0 rate
to 1.5GHz to fix the lower rate of CPUfreq on the JH7110 SoC.

The first patch is to add the notifier for PLL0 clock. Setting the PLL0
rate need the son clock (cpu_root) to switch its parent clock to OSC 
clock and switch it back after setting PLL0 rate. It need to use the 
cpu_root clock from SYSCRG and register the notifier in the SYSCRG
driver.

The second patch is to set cpu_core rate to 500MHz and PLL0 rate to
1.5GHz to fix the problem about the lower rate of CPUfreq on the 
visionfive board. The cpu_core clock rate is set to 500MHz first to
ensure that the cpu frequency will not suddenly become high and the cpu 
voltage is not enough to cause a crash when the PLL0 is set to 1.5GHz.
The cpu voltage and frequency are then adjusted together by CPUfreq.

According to some tests, U-Boot can also run 1.5G so that the DTS from
kernel can be used on the U-Boot and could not cause any problems. So
the way of patch v5 works.

Changes since v6:
- Used the patch 1 from v5 and added the reviewed tag.
- Modified the patch 2 from v5 to fit the new jh7110-common.dtsi.

v6: https://lore.kernel.org/all/20240603020607.25122-1-xingyu.wu@starfivetech.com/

Changes since v5:
- Set the rate to 1.5G in the driver instead of DTS.

v5: https://lore.kernel.org/all/20240507065319.274976-1-xingyu.wu@starfivetech.com/

Changes since v4: 
- Fixed the wrong words.
- Added the Fixes tag in first patch.

v4: https://lore.kernel.org/all/20240410033148.213991-1-xingyu.wu@starfivetech.com/

Changes since v3: 
- Added the notifier for PLL0 clock.
- Set cpu_core rate in DTS 

v3: https://lore.kernel.org/all/20240402090920.11627-1-xingyu.wu@starfivetech.com/

Changes since v2: 
- Made the steps into the process into the process of setting PLL0 rate

v2: https://lore.kernel.org/all/20230821152915.208366-1-xingyu.wu@starfivetech.com/

Changes since v1: 
- Added the fixes tag in the commit.

v1: https://lore.kernel.org/all/20230811033631.160912-1-xingyu.wu@starfivetech.com/

Xingyu Wu (2):
  clk: starfive: jh7110-sys: Add notifier for PLL0 clock
  riscv: dts: starfive: jh7110-common: Fix lower rate of CPUfreq by
    setting PLL0 rate to 1.5GHz

 .../boot/dts/starfive/jh7110-common.dtsi      |  6 ++++
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 31 ++++++++++++++++++-
 drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 ++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.34.1


