Return-Path: <linux-kernel+bounces-535739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B0A4769C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D543B2B75
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57607224890;
	Thu, 27 Feb 2025 07:27:44 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2093.outbound.protection.partner.outlook.cn [139.219.146.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EB223705
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641263; cv=fail; b=areUKS7K1sJunVXTxRGZhuaStOGRqhpLEfu68vY7bythj6pHNP99U9RG/3c7T5LpWfcxpVvm5xkUHhM4vnjf05b6wVWVzfF4xIldhYOwGO8QTeK7cj1s0s7RW3KnlKspK/p/rmki5giWlHVKqe93FLvKZX91imdKJ66rSuNcx8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641263; c=relaxed/simple;
	bh=1OmhJdwn6V/MBhnNmmth1O67J/2YSYBshz65TgS8peg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y9Pe6RmcpXynNJ+IJ0231glICcA5ZjFcA7zzxW4vgbdcygobh2jN3ucmx1O7Gzb/XN14C4j8ohMZJvop1T9rcdb7jUzI3s9bb1RK1EsQkPRqOWMOXV7FmQKWPZ/eq0RX56PYogiM8jB/im6mWpmNH2Fnfstz4PuXg2DEy2NuvQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpfOk7LNfeWTdRhGz/GIf/wGdLXeIFwAK3kKw9po/fq4RkK332ARw8lg2OZMDtW/iQYf/JLkJ0um//1/8xDW/OtKuXWA984+A7jV1QIQInBrHbNONs+vFxRobDq9OQuKA5X/35vMqaTt1jiR84/C7gKK7p49Z7ojoVZQrEQVgIE0Eu72ppjg1FOc4WGGOuMigug0f13v8ygHysd9BFPBINVAOVl77c1gRLTq8Ov0s3xOfiq0wUjM/6mMH64AmfZwVeLrtSlcivyREzm4/73VD6ED8FE6eyv6ZQLPgnQbDmFrVMDJI3U1XlFypFX1A8xwd5YPk8J2hB2nEizkknumCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeleWppTseCI34/hGa8azHbDXJPln//jICAz3Vq67oU=;
 b=SKjtEixln6Gqo3FXV/6TlEmSfanY318mI7CGBQPUTLolxYVlIcI98guR7yKlL2A71OHX2L0Qt/QiD+R5fKeu6ONNBI1Id0s1d8JS4LwchSjZjUQ5C5Mf1O8L3XyGFXTM5P7qJhBbUhWC+y9jeOK9QHwRA9FgfEeiQrFFJHptbKTN7K5KV4aewv6CwVu8zVkcCCRZ46Xc7O7AO8jlSC9hbmgJh/sfN2SIert49Vl0VviyRaH4PDy+rG2KSs7QhyB7HNMJHI3rD2k6f2MRq0BVrAE8y2BnsLl9iTts7VLZIXfymHdKKY031KlbWldXeeoMIijVTPo94XwzSrkR4UbTog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::11) by ZQ0PR01MB1240.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.15; Thu, 27 Feb
 2025 07:27:29 +0000
Received: from ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
 ([fe80::6949:6e77:b17f:c6d0]) by
 ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn ([fe80::6949:6e77:b17f:c6d0%4])
 with mapi id 15.20.8489.014; Thu, 27 Feb 2025 07:27:29 +0000
From: Tingbo Liao <tingbo.liao@starfivetech.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tingbo Liao <tingbo.liao@starfivetech.com>
Subject: [PATCH] Fix the __riscv_copy_vec_words_unaligned implementation
Date: Wed, 26 Feb 2025 23:27:21 -0800
Message-Id: <20250227072721.5889-1-tingbo.liao@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::8) To ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB0983:EE_|ZQ0PR01MB1240:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fa9780-f9c1-4799-69ba-08dd57003139
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|41320700013|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	KmgTYEWCxw/rQrOFTx6dJpSheRjgS7+GlnVvRfqVJ6wBV1fJ1My8a3sVNbD++WHklFIW6VqgSKVGIJAhc1X4+SiNiyHM1YiK2V83fISSfDfUo1ZoB3pFzKebNgNROPLtUdsrcSj8tP/lnbUXS5bIhxamfCU0JI5vMgZ7jaiP7q5FH+zj61phOtpdriCsVZQohM1SBg2C0uVf7H50ArTUvLkPY5h5/kuE9ETWvaXgiE0NBAdh2yAUvFkIdSeYRsjKOctHKuztYy/Qk2T9pBslcHg8E77sU9cwLZR8AeAdLCWjDINYtbrQiBBiuPvi92hRSAvLB2n+RNGuRJyOY18QQQpnum3n/lPh9I3SF5ljmL155wt7rmjkrwxwI+woyF04Esr8S6U22KX3jhu67XOOgd8H0sNdB2biK+Q7YWX2vceIb9SEBxQ4nmjiPvePCtoAijGrhiQexUk0nQMfRvhak7FTg2sNaYJ47yQ/xeMN5cT1qA8JA4V2kvuqLNOTp8xlSx0dx92ZCi1gQyLlFzaHGyKa+zx3ALKMqLdVoFdYjgm9nK6MiygkKAZkST1KUw+ZfUOY5y9rQymGDbLfnr/zCBKfWwd0Mn0FDXol7wtU0JY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0F4eSSmHdcqB4iadwYahw1hiJ72TRNwvPUuk7XAVe9SgOIcPo4ijEYwYeF8O?=
 =?us-ascii?Q?vDWUG2aKX5VCURCLIDyV94LHpflFTmIX+uwvRPZqTdZODTfOqfbumxP2EZhG?=
 =?us-ascii?Q?QrDPW8nwfzDc73vkoiOEbLq028rTVrMhK81FKh3CNRf9nFqnU+7RnMfi91LR?=
 =?us-ascii?Q?zIKonsKZenMAOalW+2WV/9xpZsSqT9uD/nacSdnjAWrVeqJT3ofFEfqSAem+?=
 =?us-ascii?Q?yCzP16SOSC6QSIbIUe4D9d2pIiJdW8uQ5iZT24nFtxSA0pFCzar/99F3SFsM?=
 =?us-ascii?Q?N7eFYavDpK9nO3OmRjQi3qyJ0QENt1TO2F6ZcG5clozmbwoOvnUQnQQ1pZRi?=
 =?us-ascii?Q?UbaRH51FbaZunnseEh3XTNwia2b2OS1CH9JXFAUWtsFyPM0O8sw0lSidGr+C?=
 =?us-ascii?Q?AC8gF49tO0+EAs+ueoEuAV7iRD37HfilDrfs5wOSG12BkCqc9EwK2PZ5jldp?=
 =?us-ascii?Q?nCG63TU0VvIB/X2JNUeuvLq5kT4HXgHDROnBO+UVrp2aRccIhmYZxobMZX/V?=
 =?us-ascii?Q?bX5d/m1gpUZeB92UU4QZ9f3IpBQS7nU0TzbYpzpOqZI1vNopZrOOInlFZ5nw?=
 =?us-ascii?Q?RzMBNmIU1hdG3Sqg6kVXBmQWdy0YMwn9WGZObWTcL7sjiBc+Z63Wrt0l3mi1?=
 =?us-ascii?Q?a0InK43re9C3ylR787zVXxciKmeeIdmf6mV5tEVWy0Bvrbk9xVpuMnPJx5aV?=
 =?us-ascii?Q?wmTb8V2PDlHeOSqcCUdSFDi6dNfDhPID7e2AQIX5o2lrfWteaw88zlxjc97j?=
 =?us-ascii?Q?qAcGvwt07HyoJ05OrOR/KSOvtxsEf7JTIw/NIwlIW5toKPkljsjQXQto2Ri7?=
 =?us-ascii?Q?yXYTLy9ZDRRxpFnNYoyrYeXWBKv0u2I1m5z2HX8jMJ5mbKA8breJ4eA7jriI?=
 =?us-ascii?Q?8tCyYx9xeCcLH9YT/akgXOqrl7pYlRItDXl/zEBlIfN9GGQ8gVPeLHtz6+JU?=
 =?us-ascii?Q?5VrMX3n5y8ua1rcohQkmL3GrIfy6o0mq7IUwDnUiGJq6KNGbe5SwEbYlMMze?=
 =?us-ascii?Q?ua0uzg1VhWG2+6WACPXL9iOq3ygmSJljbnTtMVufzqjCB8PvaK3B+kIqnyTU?=
 =?us-ascii?Q?npXvjHaF1145LTrbZv1tC5Z/FleuhkSLLYLwCpaHQ5LPtttxQaPd8UoM5seM?=
 =?us-ascii?Q?zz4ZPXK5MNLkInIkT3dbL1psg5lamk7z6Qlb0EZG7Gmw6Wzvm77P2dxxqLic?=
 =?us-ascii?Q?+DQG+7pnCBciaTQ+JbPrK+vXQoAmVWuRDCoFRB+uQ+ukfkheJNiVGNpkU7J8?=
 =?us-ascii?Q?jJ4woodAWr1ZdaZVuPMGkzCF/gNd+rOKKJNnUoMjUawQzdklsIdsAmoKJqF4?=
 =?us-ascii?Q?diF8XXVl6b23ZisuHzsw9LFfzIKnPuSipX6m3vDFBzEKm8mq/QPj8Ku+Mxig?=
 =?us-ascii?Q?p2n6jeck5ZZar+xY/45s/ekuoy3f1NqDg0AFf3Fp7yxl3LYJS4d7/A0Em2KS?=
 =?us-ascii?Q?kVns4XlJNRK+4CXgIVZ3k5EiiyjmlQwN9tjnLwOUvk+rzOLgCQxWwFP0v+g2?=
 =?us-ascii?Q?90XbFWoAOjFVFVH4+TUj9FzaVeh9y/hiSGeUakUs12Hcf5AGTbfrUNhKY6mh?=
 =?us-ascii?Q?9BkbI6KbW2QxnJX/shNYhij0x9yvWm41nFOrt73AQyLX1dzl0V91Soy1RktT?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fa9780-f9c1-4799-69ba-08dd57003139
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0983.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 07:27:29.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SJDxjmt5ub1UefuERxZ6kWkNJU5/4Hskh1BRw/w7vhoE8pAfRltjanrqHGeit9rhoq+BudB4j8DTCpnMe+ToX2VoBwmH00V+Vv/zFYgZeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1240

Correct the VEC_S macro definition to fix the implementation
of vector words copy in the case of unalignment in RISC-V.

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


