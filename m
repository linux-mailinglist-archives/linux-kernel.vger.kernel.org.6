Return-Path: <linux-kernel+bounces-231736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B9919D19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA2A1C2186D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D771613D;
	Thu, 27 Jun 2024 02:01:26 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BB29B0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453685; cv=fail; b=u6OaLcCTUhcBlLMsgKWWYEQiK6GoldWR8SnSHYpHwgT9yzPsqHJWXqcY/x+PP5T4SlR/Hy7UMPsu3o5fD5ymNAt4Dc+kRUJNklMrBTHyX6wN0xDsOZxibFYUD/zx9HLjUVadJ0RzdbCjXbsQvKVFhL4nV2A7GADBZkRYuYJQpFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453685; c=relaxed/simple;
	bh=doqPDo8h1wWsRzhbBiClKedhLERaMOr3Bw4Az6JODI4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L2MgoMOHp4gxwqbiJwiwI2Vvmtsu6NQlf+At3b57TixKNmds34K60WuFio93onRt0pNpqiugRxp/ThHbT+pBKTwOQ5bK31H8id7oea6lqvfVAO5QirRSkDVW8lV9wZC5E1M2WQZe12kntwEu3bcFfOYIsok7PTapiMW/N26d6Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhVr/R7sDsRXwHVoV6QE4/5l8pWmTi65ZwtTiDChu2eurCCuSL8eyCQgAAZSq3K0fKYUcVyYXiaxvbTxAjBl+1LInZG8jOq74OTE4yZcQG9xkUGLax7LGa1FBx8KisZ93uSQQRigXoyHFQk8n9zTMNa/IEaJZ0tqrwGPb28bOsrlmNGiGTaUcczKhrM0oVL0AvKU4K3Z68ncP+lI50rbiiKxL0Fxr2OSyWC1ERsaD07EvjkldlML67WG4Dh3Bp42mZo+mmFVIjkHfA2v7g/14outNbJKQHVdwLGS0zgXwjEzIr583e+XqYFJgPhKFS5fq/xD6hmsc8OKj1/bXZDzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxjW1CWO7fLo2XgqLohNwC5foM/4mxUtXXe7ntLAJxc=;
 b=J1jKV/vs1SxKw0hKS9MdB53MApGJf+o4FlDnqmatcDpKD2aZYVM57i1qHK6Mrt+hvEZaqyZ3iT7WtIszZ96SGln8/cnvU+1dBaTdrNlNjNJdbmzdXtGS7CWJWHJ92TsLJdTxYgixcRCUjV6Pt7N9KDYBYHx6+AAE3thcvV8xgVGn2OdJL8+uFozzw9VTUFCF9pPXs2nwAcjqrJxOVRyLonRkbbLOjZr6pofcknIfLlYVJP3sM54unDmkRnbFHPH+c//2Q0nUsPcaRwE2JaSgYEg2gK9rJglE9wqKsWTpmoaNZX0EgqaYfjh/XYq6WeXOqUWnzTDEXdr4NtImiuCp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 02:01:07 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::4d66:ac5e:3903:cdf5]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::4d66:ac5e:3903:cdf5%4])
 with mapi id 15.20.7698.025; Thu, 27 Jun 2024 02:01:07 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Keith Zhao <keith.zhao@starfivetech.com>,
	Shengyang Chen <shengyang.chen@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: starfive: Correct the dphy configure process
Date: Wed, 26 Jun 2024 19:00:59 -0700
Message-Id: <20240627020059.163535-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::12) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1208:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f67420-c752-4980-5f7b-08dc964d0201
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|41320700013|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	W9Z+xZnTawrVwS5HUfzMzXykUPA7o3Mq2hUQH5Tp+nPm3Xj2Xel1eGLWDcylD/MlL9g65kNYfskEmD4aOZ253bI0ZWGOFDgaauEN7CKQDiOB9CNjGXRBOHWRtqOt6DlVfvYLmrWQgNDlSlp8JSwuNw9BYMJED9h2Kkn3owMAbydjSTNP1cnrHy/a7lzY6mMCHLFihCo5EwmvnPp2G7kA7ydOW8Nb78AzsC3bhkblS2zBG8r/vTn1waMXIeMC5Q1dRyJsXwUEf81yejyZUIs36AeR7C+AIwUhlstg2XZa6Imq325/GxYKKTes9gaiunglmg5kmo1zFb7c2YMC/dAPKjzedgKhNpg/NyqPZnblHvU1gvxXRB4cEKel14m9oym7cK+RO0wR7INhv4aGOcyokDbVXoTgRBRtcdhbrVsAfi6lgKeEwRZ5sVsF++CFycldPDjOuS1+R+ZufjaIpCQi0dVNzXw+jBzxsZUrJb13x7kcihg9jrrO9oDlEnaVZXCib9nQyycWJog1LgRIGgLYzjUCW35TGeLvQgSpuZ7izL9rbn2ljlq9Cf0YAV6B4q2XMdsjaP5ItYwQcsxHOQ7aLvR5G1r4vijO7H+9k2bH782VFn/ThIv07ih0+DfLKlFx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+lvv911r1qtpzmkcmJ5xe0KH7Da4XfP5qjr4rp3ns5a3k5snYJDvhMvsufgZ?=
 =?us-ascii?Q?0/AYUk96gs/N3TXgLVa0yTyqFiCzpdOzKAyf5oFl6tTRo4D51T7kKh3ZNsyo?=
 =?us-ascii?Q?i1nU3PKhjt40hA8/kj1B15WYrVsad2y8cc07MCi7KpGQlkppM9R0AJdiIw1R?=
 =?us-ascii?Q?UO8t8aVlUAW6+xgOBeZbKF/MbcGWbkM4m7YxUORm+SM/nOva467BX4xbfydi?=
 =?us-ascii?Q?iPOe2HJdJBDM3b42dHDBxoRZL43vCBMKgpS4xARLLAProUTOdhiPvornBQGM?=
 =?us-ascii?Q?NQIT/EfLjH0UHpIvh7PoSXA11+Olgdaotu0JfCbr6ljdepBCyaQe5/YHytkI?=
 =?us-ascii?Q?0ugOAvSmHsU2m5o7XSwrpY3XcZidEIFKjPlZWLhEPYuJiQoO7FyfbP1AqrI6?=
 =?us-ascii?Q?pzgu/TfedAuGYsog9kRvHstLx1L1IYtJwY9s3DwWvMgtoKYQ4yJIncj19KHo?=
 =?us-ascii?Q?tvgJCZ1bcC/JQRm9PYL108UpoM2bQyHmAp89CAbl+82PSLnMLRcKi5IRzAFj?=
 =?us-ascii?Q?eT/xUN24RSMxDEzh+I9vmnIezYqBH279aCz1cQlPd4G3gFW19hL1/u0g/jmY?=
 =?us-ascii?Q?wOxDTEaLGEehpIqBmYSH0o5kRwc/rzZNN5XTCEDjr4d43Ae+qGyXaeSTIs5p?=
 =?us-ascii?Q?HblYPXtqY10sDaTVLs/4XEKwba6siBf753yRAcZriNZP01nm1HBjWeW7oQ2/?=
 =?us-ascii?Q?uzNSz0fzAmNeYQj5DfT1K+xtec5j1SHXadyZpT9FFFU/fRTtSOYDurYYesnv?=
 =?us-ascii?Q?+lhcAAatLXrsuw74bhehrlnQDVRUghB1s1bMeRSiRr6rOZMhd1D2zBEnEsKm?=
 =?us-ascii?Q?LdFs7jQmaFdePWBSbG6hWKZVuFhi88nfVoIAaQyJNac1l0ESiZyTuUIV7w7F?=
 =?us-ascii?Q?mb0BP7BvyZIi7ceAl7K3Jax0pXuQaJV78zft618jN/gSbYFprhPHx9V45fLz?=
 =?us-ascii?Q?RGPgFL0kGbZuMWYyQeu1ZFeetYG6sWirmN03DCzCx3QG2UfERcpqdi66dDDI?=
 =?us-ascii?Q?hbBs5KWYZs04kehu6e61QnkD7zK5WTX01uiWX2B62Kpn6ZlhOlz2bHsF/GiS?=
 =?us-ascii?Q?NxRr5WC9Ybp2jkFXbJivKRq3RzcRecWESsNaVW0OP8K3qGJ5pN3NDAfenKR2?=
 =?us-ascii?Q?Zz0deQskx93AwejwkD9fbdvNNyrc5MaOvdcWWSUGLZE5DTr9cNtFdkh0c34V?=
 =?us-ascii?Q?JKwzJhih6ThraPbaZrNR6kDiul/fzDc9xQO8XQUmXKOyIvXG3ETD05d6tNoP?=
 =?us-ascii?Q?g0sSJLkX+JMjVytPaQA/3cnyCfbGItp6atcrafHAlSHnyMxK/1/sA+Z4urnj?=
 =?us-ascii?Q?iY0H1f66Cu9IwInY5qzvvfe4+rFnf3sHQjtsZ+Yax7+6+nZFwvPVa/G7keL+?=
 =?us-ascii?Q?0uxXKMCA/bji8Sm1UobcG8xVxJdE4xos/rqIhmsVpl8A/3Mk4E6fB1tSP7aV?=
 =?us-ascii?Q?K2g6pmULumxm1SprMwAGaGSQWnWiZ58VSiG6Jg0xxTpDhf30YQVMQP9qPjWV?=
 =?us-ascii?Q?3KEOI//EXx/R2TIkW+/tDLwgqBZsqjlDUmVlU00DfFr5qAkd6clpxxCfoQe+?=
 =?us-ascii?Q?irW0W5xtdnvYPiCJElG+TO140Q5c/9hAv+JxsJzFeC2LA8WgmlrWIX66yRqr?=
 =?us-ascii?Q?dZCD1n3QM4hx1PBY0Nw5u5M=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f67420-c752-4980-5f7b-08dc964d0201
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 02:01:07.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R92aJZU24wbc2jtuaAWT73/GCVqnbzsUJxWcW+y9hirj7MS4YfUIGTDoCYba7XaGOmoc07kn5tFxd2xkBMzIeAW7qZYfgWPyT3haltvr+pbaKCpX23FlxEvjhHPo8/vr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1208

We actually want to calculate the alignment values first, then
use the alignment value to look up the data from reg_configs[].

Fixes: d3ab79553308 ("phy: starfive: Add mipi dphy tx support")

Reviewed-by: Shengyang Chen <shengyang.chen@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/phy/starfive/phy-jh7110-dphy-tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/starfive/phy-jh7110-dphy-tx.c b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
index 61b0da6096e5..c64d1c91b130 100644
--- a/drivers/phy/starfive/phy-jh7110-dphy-tx.c
+++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
@@ -235,12 +235,14 @@ static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	const struct stf_dphy_config *p = reg_configs;
 	unsigned long alignment  = STF_DPHY_BITRATE_ALIGN;
 	u32 bitrate = opts->mipi_dphy.hs_clk_rate;
-	u32 i = stf_dphy_get_config_index(bitrate);
 	u32 tmp;
+	u32 i;
 
 	if (bitrate % alignment)
 		bitrate += alignment - (bitrate % alignment);
 
+	i = stf_dphy_get_config_index(bitrate);
+
 	tmp = readl(dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(100));
 	tmp &= ~STF_DPHY_REFCLK_IN_SEL;
 	tmp |= FIELD_PREP(STF_DPHY_REFCLK_IN_SEL, STF_DPHY_REFCLK_12M);
-- 
2.25.1


