Return-Path: <linux-kernel+bounces-314519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC5196B469
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579491F28247
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62B185B41;
	Wed,  4 Sep 2024 08:21:07 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2118.outbound.protection.partner.outlook.cn [139.219.146.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1A17D8A6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438067; cv=fail; b=WLbU9EFbh0yynDdhyFayIb13oCnFrGdgOGUJvGX35hSIBhCzqE05rsfDLBAwiTeWUh2Foo+7lfbqW59pWhQZsusuv1mN4Ox8AgIN6ZBOURgPZql6UHqLYgQ26JH/1B8gK9DcpQkapSu7KY+U1uSJEgDzvBKuaW4N9TXU5EVark4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438067; c=relaxed/simple;
	bh=5/oPuOnWmoUBuUyTirQU8uOWKiQ+Gqt1kT7mA/uWMJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PGMGz4Mzmq7yjivafqWky8WjTiP1S87YbVfFFoB+6/tf3SbeDDXMOSfaACenfNSMkg+jpdQCDtR6RRbRHEa/Bl0Lit+BkVCs3UNGOzpyG8WXqwY5HII9kSvPCpyNUqGQVbn8M0Gcugu53AbC1nyQ+veG9Z3jU/xxWElYh5iUdzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4SRnhnEIgZHOBs95Q1qjbfe8RnXEPCWTc7z9ghSFg0ECd64QSK+2vv9NsqxrAcEC5V1fN4sTygeV8dBlRNOcuZ2jZG/pecTBteu/ZRv3t1vnZDGUpzHUdEREPo6P3Vtm9W8vHb8GdCrs4pWlEyhBcfnMQVQHRl6WTqtMwCc9PMJScVGC7c/waSR1YKpd47kkAZwmiuOZaaZq13bDrFZJARxxdvCSZ5YtJKk4LtIH1QhPJEYK5MPdx8msZK50YTR9TCM5NHH/aKD+FteRVl25Hd76QZFDRxj/tJz+g0h7+LruPp5f9nGqwNWjPn7dhOFwrQEv7DP66urDwxpjCAwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kL5r7aIYq36NHsX6PK44xGCQVVjTLDSLc+FQTu6QDQ=;
 b=R5/0nZdz/jT9JjNbLmgXMDjtdg4TbZkQ9vuR/2t1g7gaT6Db3V59FQ7XyF1wTRcIuVD+JJxRf4hmMqyqynzzmOygDPFm7BCa91ANFg5hWazB4hg2jnVrv6sVRDBK1ajD7nlZy1FeGxtvArCkpVi0HpYr1RBhgn2ActI8/uhL9LYISY8JE2zichmltLmpv0orS7E+b5f+Ah3te2wx4cpCaamJU/tCPXL9qCz9Dh8nMxWTFiM+km1CyXqbwVL9gwlptJtLjfRYeuEKz2KZg5gN5aSmTpsANmHZAvdH2UMZlyPHCMpfgEHXifFMtlRy0s3y3KdiSlJbb57VC+DCObjt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1286.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.31; Wed, 4 Sep
 2024 02:46:47 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%4])
 with mapi id 15.20.7897.029; Wed, 4 Sep 2024 02:46:47 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [v1] reset: starfive: Fixed access the empty member on JH7110 SoC
Date: Tue,  3 Sep 2024 19:46:40 -0700
Message-Id: <20240904024640.809425-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0016.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::28) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1286:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f07dfc-2b1c-480a-d6a9-08dccc8bd1ba
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|41320700013|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	WJITaSbs7QmdJZpfCA9EKuFahY07PnT3zA1yGp4pH2/C50sBs40bvno0IfJxbFuDAojjceEh/4AAGrN98Y05dwpKA2Mi67JL53ks0DKOjBPsdb/b7RFmkpzQmI7JxBhM7C/1GdHjEzGPmuQRVGUOmENpx53Y3yz6M0bAIl+Qbe7O1GJJxj0iubAtdxxMzl4ef2HySrEHXoju4fvzVwVOPpO83+ZYCMHVWfIii+AfCN132RaTN5b0W5ZvoxyDDR0bCvPoq9uXXIiMYpMkEELLIWfHEp5phht/d8FqEr2ILKLPjgJCoo+vemGquJ++DD1hlLtMQOYDZ0Qjsg43hA6RRf0iBqRB/6tBCBderjJ/MvNyCqxLWAba9p6U/mGR1GmzaYCFsc99TbjcKk/zW22bdtDSEl/S4S1PZKhS2O9W7azCBuXnO4uAN1YJdh4YGx+kjUXbQA0FEssBE41mMO+DsF4J8LoYYMLTLDjE8FKtXb32Vya9jzocP5+yVrJNAYKznFk1tm941YsLzi2daBlUEe9nJjvnTgZ0xZHk3MrvbrGyWmG5B+o+xVsB/acZE9Slz216j1tVLk6ZEECPhnzkE4VBkItWCn/8Lq0fjUTJIsvcSxNJoFZD+c+ELGRWDhxF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIqmNLTYH81QNoqXMFgxbux/K44DUCv1PIVQ+IyANtmoPxmhe93TxSN9GExY?=
 =?us-ascii?Q?bPWyRsKmQZa1Gb5LESCQ4Yev0rXj81EXuMPmAn2AyKCx1O88TdJOkXhJV9Hi?=
 =?us-ascii?Q?eK/abhM+2YbO5Z2hKi3LbBLJ9kXz7QugpvqRMk8FSvEnEulZLnVf8erPWrQZ?=
 =?us-ascii?Q?skVxZmQ4rWLrKKvhyy7e5PADSVy7Q4IdNtEGfV4UNEq8ivc3P3kIMZp4nizB?=
 =?us-ascii?Q?JR+LvWk/yyFIxjjny1x4K6DqgAierFY0ccaD9Tp+ApNHXQ67sAsEgAKIvY+P?=
 =?us-ascii?Q?BqCwZAnia8xF54iZuLxFRpoa7c0P6F0BU+r6GxbhVixlH2gBips/XstrznMD?=
 =?us-ascii?Q?O57798z7hpRspOi7yh52EO6RryCYqahl0lgC3/ev/SH7t4Wj3/BJgh6mLFD/?=
 =?us-ascii?Q?ool2VWBS0WvfgG74O6uvhXO+rEBlXU9u9ubBIp6USF0sgxp8x9VNH/okiUH0?=
 =?us-ascii?Q?pdoldIRyKf5iC9Pltl9b2j4kGECZJW0uWRhgGeuSDRXcuE5QY9b7zBaPAxvJ?=
 =?us-ascii?Q?XLJ1PsbvQbfjP4bvBM2kxgSrwP50/Gj8zAqkxoUM2N7NweanBMcO0w8dQq02?=
 =?us-ascii?Q?5M92Su4vfdVxJqZUq/WDsEPcOc0Jpy0YvTa6fVsm4aNyyb5BPg25hbTGRsim?=
 =?us-ascii?Q?d3AxFO1ykTEDoy3qbtCIgnySqOYJsxcGXP//6mhl1410JwH7wtVwgYK0e5+/?=
 =?us-ascii?Q?WdFpAJMsAKNidW4c7SJUs2INfn2yyyZVEfo+kxTaauvWITvTvyLFfIkt29bB?=
 =?us-ascii?Q?unUJTvOCnOAUcgsudg/VIMPWeYfAMDexZviHOZhJBkzIUlHiHS+MJtrUh2mn?=
 =?us-ascii?Q?2RMrTNe+xKlgLs5Mkf3Ip28ndcXEr15lmpGPPAxI0OJyCYFnQWBr9zzyswM5?=
 =?us-ascii?Q?7vmOwPCbsRlALdUYKcMKinU96aQZbTeMP/UuIV4/QlhBSvFg9aoXJcUDb5+d?=
 =?us-ascii?Q?WzquomwdKDMwRdyHQqLfarJe1hSt0RvfeYmzY2BtMC+0UZbO/zHJe1kzHYPH?=
 =?us-ascii?Q?D0GKnalazbUe0wexUrlKRTNL0vi5fduiAcpYMPu9DXAQdzD/8kKs/BKn0Lr1?=
 =?us-ascii?Q?OXtQGvBinSA4jzt3PSMVB6p26aKzB8sQCWumd3htnQpbB947dA4vYl4abrwS?=
 =?us-ascii?Q?/QbBmWPwfMTJ8dJox6uwLi4bgb6djKpfNtV6rBGsNC0ME19NsINONPW//5Fz?=
 =?us-ascii?Q?Pup/7ywR3MXaAwlhx8GIdbQ5ORjh3P+EmeDTCTyjTKKvP8wHIYR4nG7iFCDk?=
 =?us-ascii?Q?Nc1t28iHVom3d/J2n5mtXJ2qztZd1UC5nf1IQWBFIMcV2Q25/5l984Is/Gwc?=
 =?us-ascii?Q?V7PhW5W/vEBcMmdqmuEhGS/RXAlYdZYedaPUfxW4YJQqjBUWZd51GHzOAzJ2?=
 =?us-ascii?Q?rcRwMnSGmQFvcJKiWDvOs0weydWRQQlKE70ASP6A65mcoiM/Tqxl2AqsDN4P?=
 =?us-ascii?Q?p7XkyA6CVfmUJN42Pvo5R/Lqq0r6PvcFFutivv32pjuFcy2ws7b1BaFNMP5j?=
 =?us-ascii?Q?8p8XkjMsjhGo35KJyeumypu5icm3E41FFByO6jNF5KlPtQhyJ1GwED4Dof8J?=
 =?us-ascii?Q?V/HUtu1ec9UNDjdl7XpkX4r1jAD0KW+HALsJjH5n1ThAMevEPui64hmXjNeK?=
 =?us-ascii?Q?B5MqdpqJMEQbJXi3JbZgoEk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f07dfc-2b1c-480a-d6a9-08dccc8bd1ba
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:46:47.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gd8loMQsIwHjhzTMYiDL2tFqVX9hu3+kEVond9Z6T2P8k05kudqDtzIXPj6yefhhzHQJ0/XqiQemdWoFNUPxRFowZiFRoJTvTN+gUwCDCubBYc2qYikCgfwgssx2wHy8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1286

data->asserted will be NULL on JH7110 SoC since commit 82327b127d41
("reset: starfive: Add StarFive JH7110 reset driver") be added. Add
the judgment conditions to avoid errors.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/reset/starfive/reset-starfive-jh71x0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/reset/starfive/reset-starfive-jh71x0.c
index 55bbbd2de52c..29ce3486752f 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.c
+++ b/drivers/reset/starfive/reset-starfive-jh71x0.c
@@ -94,6 +94,9 @@ static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
 	void __iomem *reg_status = data->status + offset * sizeof(u32);
 	u32 value = readl(reg_status);
 
+	if (!data->asserted)
+		return !(value & mask);
+
 	return !((value ^ data->asserted[offset]) & mask);
 }
 
-- 
2.25.1


