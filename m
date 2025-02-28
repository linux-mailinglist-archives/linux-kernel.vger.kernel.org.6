Return-Path: <linux-kernel+bounces-538420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58706A49867
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD07E1898149
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A326038B;
	Fri, 28 Feb 2025 11:40:15 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEC23E34B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740742814; cv=fail; b=bSHjkjrFKnrZtq9CbzZ8/fRTRKLgpLU8lQHqQY5Zx0MvxnVgubY/SiINB+MfDk9JqiKVQNSuZkMT9aLvnD0FSbfDJTjL/ygyvSPrSXSuC3wULzHmgISDj+HOezdMi+7QOFlsaXy5S9fFfnDLLPa92B8IyVGs8eyj5hRaPJ6CEgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740742814; c=relaxed/simple;
	bh=qom+ZSd/eo9gWqIr2widcinpEzCQwx3lkuDB+lijrI4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZxpKRPZhiIcrujXdG+18v+XC/ZEXgfNNPlOdVSJlZ5s8uaBXzWZymWkY0dFG2xxLKpMytAHt8LB+Dn4qaX2cZtOW1W+mEz/cNr04oR2gG7eQn2LwIU8W2VDw4pme2ELZQ/50115F+XDnBp1/qUzL2vXLk4KbYNFvXGMDFF1vGak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee/wNb71xZmawigw2ndMNdPHHSMHqeoa/Y1m6ri3H9ZWP6Cl8+Z4CGZneEYjz3x0MssSEkzeM09IV4tnV3tlgJcs+OxIR9onhUFwouiek8KoXpdOzZiVKAg0jynHvQ7fxw3esOdZnHwJwqlFTZlO3LQ/kftVv/AwKHafYLKh9a9692J/8o0MX/ajZY3xUzIae/PglUHEiGwcokFfMynIn8p0jrgrysnW35XX9z1tnXDOJNnsMr9xmCznDuvG0Ay0co+3cSQwYst9xZRETWck2c9l24iEW+yxJucQ+gZkUsRIaBIBCrp4dBQJbhPIr3fUbA9/7bb1PnC0SQGOErEXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MwHD8nST7LROCia/J2iZVTOGRYrgXeTKG57CrWThaM=;
 b=ng/rhuK0tsNkYKrY8PEeKB4zVlEiE8O4PV98bcMZGsx3N9CJlhK8smjWd5CJ+Ix46JJcMc6gCkSwk0j8su+K845zGbzIIdphYaxv4EensdcUCcUl+9A3AyBDO/BlWR4MCgbusLuLzpF8i6OvrgFZdZFVH130lPbgi8AjfRDxgwPlLCtEF7lKZcvL1zciVWXCu7pG5hdSY4+rlbONRglUukF4sc24eF69GgaKDBGzbySrOTlSwqYEqUdkClF+32Q4pfTUhMTY+s0k0HN0hv3nVZoCeX8pyDrWJsCzxqvbPkLWVOFiqMvocKywbT0kjsADDhb9SOIYj7JZ2jm+sDAAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::11) by ZQ0PR01MB1286.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.15; Fri, 28 Feb
 2025 09:08:09 +0000
Received: from ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
 ([fe80::6949:6e77:b17f:c6d0]) by
 ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn ([fe80::6949:6e77:b17f:c6d0%4])
 with mapi id 15.20.8489.014; Fri, 28 Feb 2025 09:08:09 +0000
From: Tingbo Liao <tingbo.liao@starfivetech.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tingbo Liao <tingbo.liao@starfivetech.com>
Subject: [PATCH v2] riscv: Fix the __riscv_copy_vec_words_unaligned implementation
Date: Fri, 28 Feb 2025 01:08:01 -0800
Message-Id: <20250228090801.8334-1-tingbo.liao@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0008.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::13) To ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB0983:EE_|ZQ0PR01MB1286:EE_
X-MS-Office365-Filtering-Correlation-Id: b7340bfa-67c7-4ffd-2784-08dd57d76b39
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|41320700013|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	Wlrw1nA27U9GT5tqQTpJL3wMYkNvY/3sdeLC6qYGbetpqTfRhle1RPruWi9qkfRTRd8CSoK54xG1/kCmZJLR2I0u56yVZtTrh8eYxw8iMqc1WhrJAGZBuAKDFEQQLmj52lb3SPq7gWAcS201DgvwgyWUaUrj3rtvkUHi9FndUNd5bBJQVpRblpW0eqmLxnt5TDM1NgbqcZd68mzwiKXm2W+Q7WYm7vJ3xLgIU7/ZjJtatTBP6wuCW1Nod6vCaWYwyFwn4k8hUCYgviApZXFxu7rGIR5B3NUQy3jtKfFhliyxYRojhypEVTTiZew8TIqybmKAR7x0H1ANMfUtjNpv+NiLoEZLG+hqQXoy9459h/qp6c50q22ma9g9gWS6gJuIfK0zFEZb9nbfMbJNY52NB1mFmwXjeV8PSly2dqW8s+3wt+Wq8XeOB7ml4CDU+6DYqSqpdpqi+YgEQ3A0rpeHKPAuJ+6kfPurnah1dOka4XHUUZwZCaTM69wds6NO7QKRe1d+R91adOcEI9fwxhASmw5scLwbpfiicl+i7CQJO+8CdKxQpWvXROi2UrlkfijoI+8RxL49nIrJvnBgBPF4KRa/Ibl17uoPtNSQd40nu8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(41320700013)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bFpTQmiXMDIzmbfpX/Uu+Zo24DZSYYD/DJHruhI7qBfnwX8KgEWyQikncCW/?=
 =?us-ascii?Q?YVo9qeaCDbRDnD4zDVkLuqO/yRcLctEd+zUtCrq3YYI+5GBiGr+6XJ1fGWTg?=
 =?us-ascii?Q?Ws2DLZ5Mlz3lWLhC4BV8ATCwu/Ox1ccUq8t2EH4QTzf5mbRIO3b5+w8ruMQ5?=
 =?us-ascii?Q?lAcS8Set4CDxnTfxtQlQqRTKsUFPlUKKrj5Z9ExMiRWGyoNDuKv4dflhbkSF?=
 =?us-ascii?Q?aYu0Af7cZt+X2MUIRbve5CigJZL5+GfVjZz+1thPDq/mHgfkf+CwEyql7wok?=
 =?us-ascii?Q?8Vv+TwksEyEpy5WOVPMlUwFI8s+uHZ1ZGFDgzDIMNhlU+7sZo1Js/SKHfRKS?=
 =?us-ascii?Q?LxroViq4qZoYu0C1PGWnghutU+j8hILJ3fka6TEFtv2AwQ4Tr7Mymb4cznWc?=
 =?us-ascii?Q?S2lCoztaV4k+3at2CnR9wzlK/D/pvcOmkLSjf4jh753zXkuBZ9MFGKLD4Lw1?=
 =?us-ascii?Q?C3LTYYotis7eMWy3MtxQ1MHlCrTejd5VGrKK+/BFnZAG+ZepjrizHyJikSMq?=
 =?us-ascii?Q?6N8kWZcoxkdMQ3Mc+cbJMJZJhyQPOIOwdfGTqHt7FOdvkaW9GA3TJ3U4yLBl?=
 =?us-ascii?Q?i1gUDqhgSPYpeh0FSP7rWKsl2D3Pit743c9l9g2Bzi+UPx46n0nBoLEFmlTq?=
 =?us-ascii?Q?Pb90d9IfGTz6cOLw1HQfhy+JIQUhD1D7M/t8UhEUp31UUARTOfUfw9DI6l77?=
 =?us-ascii?Q?DQSKlo7tkQ4A9EqQt4tx4UOHA92ifQZE8sRBx3IS3nDUFNoLmZ73CmIpAmHF?=
 =?us-ascii?Q?HG7I3vbRQk0z8o3w6Llb+vvwOjh+Nw5Nhq6C9gljJm1ZvOa4114OS7Tb020E?=
 =?us-ascii?Q?pnkTY9NqcdloemuqEGXBuupX5iJLJMaSTuTmBQrgNtV50mW1zgoG1OV/JWzk?=
 =?us-ascii?Q?Bc4hrBTD4g/P1cOZ7mLh6cqbh9Eq6mLMkhL1e7bGqnvBZTYSCPzlaKsDiG4U?=
 =?us-ascii?Q?B3JulzUohDRYaBhG99Xu+6c6LbhrfVtaa8XhXhpoCtuox5rFuTGhAprLFGuE?=
 =?us-ascii?Q?yokvnFJffhCBlLUO1iItoHlyjHRaQWznPWPUl4mljFruuZRLt1u5BmofVT4Y?=
 =?us-ascii?Q?5j9ji5h3+LdSdvE61dCKd+I2lq59JYQ9TkxI9rR++/2UtR5b1AqdozJ9JJX5?=
 =?us-ascii?Q?h01VZb0gtvWdk8WytSqFA5Cqcwdsum8+rpDkJPpW3jgnZp3+MvNHDFCOMgnE?=
 =?us-ascii?Q?lAlOA8KMRz3YKo8jDCPx8fsCeJlpkLANTRJqaLBxblm8Lh4slm8CBfjrcM7s?=
 =?us-ascii?Q?CI81ujNv3wBFeBnON/eq+2b3r/AC75YlQoW1qRGiKMr0gMS/z/Dsmit1w/nR?=
 =?us-ascii?Q?tTkxA3EooFxRmwrXKpM1Gt+fwJsI6hzipEzGaVtC1E1eivL1L5Ta3hGYyNdG?=
 =?us-ascii?Q?+QeQtGWoNA5yPyvuQPFZb+3bYShWblNCStMy/2Owk3SkFLdyBLINy0T9u9q5?=
 =?us-ascii?Q?fPgT/VFlXcF4FdE1ndo940/1RwZ1UnEtroZ5vFuqz2mCb6CJfC3u/QtxbVLr?=
 =?us-ascii?Q?a5Cxw3ZstJ4Jt/fJnApwkYZmIldE3/MOsBcymBw1XeGRIebZ0IsimInAor9L?=
 =?us-ascii?Q?qjoOQ5Gc2TYLlImujgrTjqJoNoOLT0KVgrjDjYS6+MXAo8Cp4ueKRSmCi/mP?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7340bfa-67c7-4ffd-2784-08dd57d76b39
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:08:08.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfIDPvLcy8Xc5dysQnXzCChp9zwyBSmri2H+c6gFJIVwZMwCJ8KboGcrEGM9P8cZnBmokBZdTH63kUwIaNx46pxRM7JJBWnpEUnzxOaQ9JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1286

Correct the VEC_S macro definition to fix the implementation
of vector words copy in the case of unalignment in RISC-V.

Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Tingbo Liao <tingbo.liao@starfivetech.com>
---
 arch/riscv/kernel/vec-copy-unaligned.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vec-copy-unaligned.S b/arch/riscv/kernel/vec-copy-unaligned.S
index d16f19f1b3b6..7ce4de6f6e69 100644
--- a/arch/riscv/kernel/vec-copy-unaligned.S
+++ b/arch/riscv/kernel/vec-copy-unaligned.S
@@ -11,7 +11,7 @@
 
 #define WORD_SEW CONCATENATE(e, WORD_EEW)
 #define VEC_L CONCATENATE(vle, WORD_EEW).v
-#define VEC_S CONCATENATE(vle, WORD_EEW).v
+#define VEC_S CONCATENATE(vse, WORD_EEW).v
 
 /* void __riscv_copy_vec_words_unaligned(void *, const void *, size_t) */
 /* Performs a memcpy without aligning buffers, using word loads and stores. */
-- 
2.46.0


