Return-Path: <linux-kernel+bounces-386266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534759B4125
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765661C21501
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204BC1FCF77;
	Tue, 29 Oct 2024 03:44:04 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF11E0DA7;
	Tue, 29 Oct 2024 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173443; cv=fail; b=m0vUmXAeZR3B/GY2j3LFN0ifcHB+XAwhbZA7yEIl/Zq8ivTdswJqgnsFKzmo66sML33a5uCKKdqiLJLW0wf0m3LEeKsACYiUI+JIojvavZYeM75hVb6OoaT5D5mnHX/wrxz4cPtNY+OAp+pWlsDlOJW2uQoX0zKkSO8ziJA3NFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173443; c=relaxed/simple;
	bh=NaQkkHQm4fldDWEwMsHq7J5D3QlH75fqzSKvA+Cb1HM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l57miVU80eJijPrXDf7lVgScvmMm+K/6dFwNoFZ+M0z3oqhB1kcBASuITIS4yp2ar9rLAWg7fYXNGek78WaMV6MZxmSVE0D8BE4V2FJxZbpsY4Dp4af2J4N5geGrKWBNMLwDnKXnYaRqiwll8U16/kBRpsgJKS0rDu73sIww97s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJf7JtcaE+jQYDqgiaV7qLZsfydlXmJKa5BGo4yxJ19tzGZcNCCJ/tVSCGTV5yXfywEdFO0kpQfGfnv3E7If6jrxqLMEvkTnvzsFxEr9GXadBl0CsRK8kJkn1ncE56weaWGRzhXuclmeOXKtYXgt5Jqb2Kemapo+/yMK25CJ6B/GoIIpDqj3OxRu6E5hSx1Df5CRQXm2PH+24lRi+xpLN2aoWIcyiOXU1aH4Jk+LT+Yf285/7nmGY+tOxXn0zEdB7Glg+7bROPuDCyE/DEhXtLl6UWgEQJt6CdH1GVH0C9A3hsTrDQ+HI0F7UrmB1/Td2pkfp0+kiOY7JaON9L/ywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUQma0WQVXPlxwql1OEpDchic5+hhde1pyoyGabQ3QM=;
 b=gEj21ImJKe9bHTBcWtmDrcT3qQggAKYmBiFvhWi9Ajb6juYYq6+Em8Gqk3rtLJWT60+Jr5YE7qJZ4arkUojRKNqnL3CggPJpB5P5LUAm3jAtJWAyz6QL7ko7lZjybte7k4I/3V2zRb6P6rTYJHxDC9ML88WZdSaqbBL3qer3G7YGJBOXRIJtBFtQr8Dhs75DiKAgIAS2Dfn1QyUUnb/rETw2nxRPqRhkfBX0UFisMRYXSmpT5vZ9F/+a1h6BQr7r1xC2oXZ3CTFzihdLV7EjzeFeuGPrGxKA1WWN21DCskkF5hllultIbo2wJTYmTaA5n0+s8Np3Ddhi8n4XPNZsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::5) by ZQ2PR01MB1179.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.36; Tue, 29 Oct
 2024 03:28:47 +0000
Received: from ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 ([fe80::95f0:ea7a:1e1b:1920]) by
 ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn ([fe80::95f0:ea7a:1e1b:1920%3])
 with mapi id 15.20.8069.031; Tue, 29 Oct 2024 03:28:47 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: starfive: jh7110-pll: Mark the probe function as __init
Date: Mon, 28 Oct 2024 20:28:28 -0700
Message-Id: <20241029032828.238706-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::27) To ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1308:EE_|ZQ2PR01MB1179:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fa66ff-c350-4dc4-dd13-08dcf7c9cc78
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	pD6EUTgLrsP7d4IqPVd/ZuAz2oLc46t/HbQMrELDwfdOy/nyysya8Ut2caZQcFKJ7oyyWNWVPjOqI0DtzsA9mA1hCuyMBhRgOPPwX0suFd+4Nn/iQiHxNPAGHr82BzX0tXAeBTNDueZm1ilh+fO5L9I30u7Ma/lU5kevHl02LBhZuYtMYxImOUW5/d0Coov6RohnKJPPM7erkHPrfSuB7E22sPXK6WJGCNvQVkZHV0ZnSOEbgpy77am1fzk/yKp+YThWXcdsfKb5yv3KC2QoIP7lsZ1KBL67ifHBXSzHt3EXizkUgj6GMl4jpWWUJ+RqohwmBLw4HUuUniHRpyKQpxrK4c6r/4KmBPFssi/+SmUwwtDNUX9Ajtb0Uc7gZEZsYHuqFy0GUjg8UeIpZxa+gx7pkZSDhxCPX23oG6DgJsEkOAHJ0GS9teFo5TvOT4rM14MeU/12XYx0DCjzrorzKk2DNLXHGvXvaSA7KfoEx9st5RL0izEnZ0o0xAofvWhWkuS0Y3UDm/d6FtbMa9+n+zR/JnIYbP+Ue4IDJ4M6ZGQ0+fATEZRm5OKKqozTw8KeeGEuALWR6qJha5OT4+5G/QHUcDfQk0Dz44QZ/V3YxK79Ke/aSJSmt5oG9xIaGZtG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIJLA3V53iaFKo1SSji+dpnHZQjjEh3CsyC64r6PgouEe1ogrwaT/emnKiEo?=
 =?us-ascii?Q?IydbO5RsJw6xchkCj7zGJhO/vPNronyQK75EzxYyedH2cBoQJVEOE+8UeO11?=
 =?us-ascii?Q?fgn/vDyp+mMkuTtSY1aFdm3yxAZs+KqmYSS5aAY+Iwb4tSf3xnWtXUe+ngXS?=
 =?us-ascii?Q?zehBKTTdrOk0FrwTzHzgefRReuVFSPougLveDqzPug0E/r0H4Q/tWrhJlTUC?=
 =?us-ascii?Q?Xfnh/ysar62alhJ7cxHVfFIzKFxohjREMhotsUTb2SbY18FPCW3EAKlHOODq?=
 =?us-ascii?Q?/94mAb/aye3VMKfRvfrh24h1IkfDCE53Nig4Cm7RfYRXa5A8KkrfERV9N/NM?=
 =?us-ascii?Q?A2aOvNi26K4FMjCgqajkaGJLYFT5r+xawaTWudwCxkLPPLqG+Z7uhFFHVxSP?=
 =?us-ascii?Q?8utwlIOitiuHAEcESnBJukH/hUS7TyLm48Gc/SI7yHoaeejoSU9BboVPfoL4?=
 =?us-ascii?Q?lDzGQ+b/P7YuaVtojuRxi4PxmGgRzZid/KsplAqYzizuext8l3MyVaAC7Q2e?=
 =?us-ascii?Q?gNFueLlVRcqhWzfd2GD3pblc1sGaDg8v5Il2IuSJeyFniIrDiV33jARa+xZL?=
 =?us-ascii?Q?KTUBFEhjOzUTv5b1z7iuSh/G8fIepxhg3G7k2+u4M/2SU+rKdswtgfIuwgv9?=
 =?us-ascii?Q?BjVoi2+nDhz8hzl4Rp7CsevbLEoqi1egof+1aGZBOd54q5I+XH2Xgf6+1AeC?=
 =?us-ascii?Q?a/mXfWC6jrGNqeXltQiUfZ6eUJRTn/U3HZf2BhbGoURLcXx7CkpsHZ/i0hhK?=
 =?us-ascii?Q?H8PZgHN1GqhNJiF9GmQ3LCBd5Gt1NUTEoZRN9GD54141+/S8wr7/dBmerUe8?=
 =?us-ascii?Q?LZvnyqidEU3IGFQwhqf04MFeVZi0u0oUD2aROXk8/Fwa3f/h3F7BPgnIUCNG?=
 =?us-ascii?Q?k/y2IJu796Oz8evplBPc7QXO+Bv7nwui2taOfrJ/OpoWQZX0QsWU3WcCYx/1?=
 =?us-ascii?Q?rTM9cyOU4thHRIIMwahDKO5gMIWzMFE7CUofae9MtV+7z9eq+mZFmU4pAF+/?=
 =?us-ascii?Q?Y/Du9z4ey487uTRrIUOTg3z/eyrQqbYAcWlVu36JgfLU4lOPvBjZKRjaQgmq?=
 =?us-ascii?Q?AgjUGpEgnmb2YTi/DUoh+Jr34PeFRRLQocIABbRj0Ep51Y3PuEcJKnRKWZqp?=
 =?us-ascii?Q?6j7qMF09Gy8b3fh/FWrw70y7V29Ukt1WUr1qjfIf46Y8NbIBhAKnkK81RCLz?=
 =?us-ascii?Q?GZzqkvCU4dEnNH+hZI66HTCtdniBiSTPd183xFFFNJ2N7J6KvhdLz3Ebeyv/?=
 =?us-ascii?Q?ja+nS9Jm5p/MWXeYUCsvKvh/NaQ4BNSd/bLQlYSd+j8O5fO+mjmG6pkYbgD6?=
 =?us-ascii?Q?sWp6K3QS3BMOQBwVs9QCWFX5jC+CLGqXvkAgVsKCfbb7y7tk9f9DFmnSEqz2?=
 =?us-ascii?Q?UChGXBMlwdN31++mqeLBR/4ejfNhv/zqA3EjdOnV+Epw8My1wzo/vIsG4n22?=
 =?us-ascii?Q?NkiyD+J5tJOPNfDKTpQFm+uLpdVhseVHV6KZjVsInCsew4vaVTguaOqo89fP?=
 =?us-ascii?Q?IqFO7BH0VN59OR9liPyreRSU/nozCyhCeVqi2VLfNgamrDESm1nRd6t7cXD8?=
 =?us-ascii?Q?blQ4D11uA80BUVN7LYIa277cPZQxziWCbacAUsc0zeUPwhBe+cC5VggPRVD7?=
 =?us-ascii?Q?a/ITpG6yMvSrbufhqERUnDo=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fa66ff-c350-4dc4-dd13-08dcf7c9cc78
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 03:28:47.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RsfhJONf5D39plzY0gjYC6ND9zKAG8EAMvYa6ve3enwIkk2v11k0uUlAO0KeV5AytMn++lP71ePP/9KiIe6SnmA8SB+YKdLvHdXGTphWVmYmyyd40KEI+szlypBkZMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1179

Mark the jh7110_pll_probe function as __init.

There's no need to support hotplugging in the jh7110-pll driver. We use
builtin_platform_driver_probe, the probe function will only be called at
startup.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-jh7110-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-pll.c b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
index 3598390e8fd0..56dc58a04f8a 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
@@ -453,7 +453,7 @@ static struct clk_hw *jh7110_pll_get(struct of_phandle_args *clkspec, void *data
 	return ERR_PTR(-EINVAL);
 }
 
-static int jh7110_pll_probe(struct platform_device *pdev)
+static int __init jh7110_pll_probe(struct platform_device *pdev)
 {
 	struct jh7110_pll_priv *priv;
 	unsigned int idx;
-- 
2.25.1


