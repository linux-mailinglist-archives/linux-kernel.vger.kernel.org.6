Return-Path: <linux-kernel+bounces-179462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850728C6033
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FED11F218D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F403E3A29C;
	Wed, 15 May 2024 05:36:42 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2120.outbound.protection.partner.outlook.cn [139.219.146.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50683BB22;
	Wed, 15 May 2024 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751402; cv=fail; b=jv2JCNmyi4wuuqpN3VvbU/U8jCkkbYtyImL8dxVXffhbFvYD5SsUMChhK9Wf2eCh8o7Pdz4jXUaq5zNsP5u8uZfRpJIe9RiP33E22PZdGogFIO7mKpIP6RaMjc4xUWwjlbSFCquouomTEBlPLcvo6OJI5PY8guOigsRWF/exhqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751402; c=relaxed/simple;
	bh=mJtK3H9awnZNnuBREuluVaHJZfuUt6HWLYgginDbU1E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HigclSPpS994nUFeyN6n/dEVt9MuiyO7PpDKJ3R1YruXUOH9jbtgBdrAOO4ug3oZw08DfQItsgJUP17WvQRmB5anbHnPJffPDRi+ZN7OuK2sTct25YYlilRey8pLGrk6flJFcertKSYLetJrWO69pPlTVTlyjq0YHl80QChAPrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP9Bo1HusBbixh9c8+ELQ+Tux6HangrY9Na6AXZXyUPpbN7G5pt1zupz0OWfYNsBoluPtqp9ckeycyiQUGg61alR0mQwmSIlYv5WpNkUZ5MrsaMl40EGUVnUMEU5hogbHTqfLp9WBDzbXb0OcumMHEDJ6hP1jdb9dRp3UAKMCL4FUTo1Ve4lxvmHfyRTEjb1MFCx2Xeya/6EuzildSDrzc9iNBngg2yciUUK7b+To+OfxtBn+jsHZjO7qN2hadeaZ5Eipqu7M886WcP/8Bj8NUtuLAiDOgArZfF0kMRxmwlQcDz1MsM2U5URVgJivu3nVZ4dxST9JzdGFcpZGcCtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z26SQYXXM7aqkVaWv8SVjN1n2EP0zi4jOnPPszLLW90=;
 b=ixBI/A3JedNlaXYW6bNXrVq3dC7LyrM61VuZCk+37zH/DO+SRWWtoqtJYHf3/Y1JtxB+SiBlRZ6+Q3ZGPbWM0D1y4Gg7SvFXwf5FQaAD5TPfniXNUp/pCVunfReHv26YAmtQpL+kbnYG/crOpSiHl+9nC82HOHHUYv7m7hdgyhNY0z26EFUXZKNrtacbht7kvXtf3dbC+ttLSncFS8cNeZ/W/EuDIEXMOlm7Bg1QXqW/B9n9wAA2nxUTcWVKQrxxRpUEiW4KYPbwTCN5O3X1Jh2UsJ0eMSdCLLGaydBC7/jKI1VzRh0uvA9PIeI8i4p7k0jSSxVOPaQSLFIAfyODSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0859.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 15 May
 2024 05:03:30 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Wed, 15 May 2024
 05:03:30 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	conor@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	joshua.yeong@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/2 RESEND] Add StarFive's StarLink Cache Controller
Date: Wed, 15 May 2024 13:02:51 +0800
Message-Id: <20240515050253.38061-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0859:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e0884f-38aa-4eb0-3e9f-08dc749c5d19
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Td6YSAlJFSd6DmwLYCqYJ0rxyvkJReseuhub5YPN7WGtRBANTfkWMD2PIfYTcCsKOf2l+ntWnS0drIul3rlGD+qDIXkxCgPAK89tVmLb9gBCC3iqsgBj9ewVSDlbgLShPJK5cF39zGau0adykqBdPRrL5TQZNCT2GinO2mx/bMmhzvIOxK4r93YvJZ6cKcOa/4igJMKGDiJFoEa11xTe0PycdramKEgW/uexGmau0QEKDHUuEZC1zERPIN74q96ebmOAHFCk5pX/l2FG+bKFo4L7Fs4fluoW0avcA9t0O9CTpLP9JDUTJ3GEJ9ZNhSaQOM35UEaDq7ODbMUjYQFTmhDq0Old/F+i3QMKtBKV4Kp2aQGvtwdzjFyjHA9jUX6S2y1AtphMFUPHAszeQXe4nOh3MoHPye1Cn0B8ETv7ndMkW0imBy5/jsFwpSGgllyU+RyoG4lu7xc8OfuQCSFGV3wX1Hhd2NxZxCsQgN0SqowJmKx+TMEV7HDbs6oDLCNuCI8zESNJTKvANHmqg+NXq70UbvQesFIOjBfBt7PaDVdC9Lvvjj2A/gv3ENgFY+3aSZKba5dSsdXt3RbHDtkseqEN1KIf+sTlHJmUq4uYI2G2PaOIeRm94vCgvuvlLTTMnG9Dvj37TQX6FDIEiL19w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(41320700004)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gK1Id9qvcR07FoLCmmsWCoKDswwBMPI4HatFdjmq8mTBGYFMMsF8BiGf3RNb?=
 =?us-ascii?Q?eM6+QoEfNPmO+FPrgAp3UdEU9kLF+076ZgJHzkpcnLYvDjaNN2zkATESiDUF?=
 =?us-ascii?Q?z2HQnU2qW9ikq3YF2e56VQfAYEJEBaC5i/WX9ogxTtsHSPfZejuz6kO4/ksG?=
 =?us-ascii?Q?ktXs2y855YFb9pLdK1dOJyRo2rzGOz3PgZrA4YxoNrBB3LWz3VOjqQfWF9cc?=
 =?us-ascii?Q?GPcfEB5ZlDzMIrHbCavt60mpmrKeAGrKnon/0ospVV0egq/pSX6T8vRif00P?=
 =?us-ascii?Q?Ki1zBG1W/iR5GIChEeSMBlH+D8/aLO1TmaPrBHAOt+4q9dsGXiJQLabsdqyp?=
 =?us-ascii?Q?lCLipRxFTzFJJbz7yy6DWkjzO9OwB8k+lJQ7gDPXk9x1GhnOG1XTpp4S/is6?=
 =?us-ascii?Q?/sFQoDqCcQDtc1T7WzaoGEg1NfnWw0XTtfV1Y9GOcITP0id5IaXmgrFVw6VA?=
 =?us-ascii?Q?f8iTRzSRMRDoIx4ffq3u7RIhxG9OFldvPu+4GN1yWnu58+S63qBMftqvhl6y?=
 =?us-ascii?Q?0DIhMK3e54/rAx1kv/khXBWnO7DgC0XcMkmea2Nw636KgjoMdkpESA5ow5cD?=
 =?us-ascii?Q?ATkd/8mv1K1v2Dlva9IABMSWWb/gtIPNi3N0s6q3YzKJLhBFU0LpelWBkI1P?=
 =?us-ascii?Q?n7htoyNK4VWp7JYl8SyEE91bd0yNR0CfzHx8htOTf1YCEypSjaXpdwyuHZr9?=
 =?us-ascii?Q?RYTfqB52QP4X20qwk/NFFmxhm9ZCSToLOf79kuBh3U2Wu2+B7QW8VfaVfiCf?=
 =?us-ascii?Q?7D5rZt/QJVmOH+5SdxUP9v7fYkoQoak6Q0b7SYmm3qL6T+B5KcW73a07+O6X?=
 =?us-ascii?Q?Sh3NdC8IGkRlD+aWS3L/eySuN3kKTK3aapEGZNKHaMWWZRX3YlZhlrInLWAy?=
 =?us-ascii?Q?hWEyjq/Hx5EbymQiF5cHstx/RGuo1+hbN5B1EkMADDugOsN1sa9aMVXDvn1h?=
 =?us-ascii?Q?xnTEQPLsVCyAnPAFjKH6bFttXQP0bLh0MyVg5nuZ07qycrJQw8JwBwS4VHS4?=
 =?us-ascii?Q?Wa/VV6PnkRBe01+7fucroM/VB34ftpWHXq+wqhgYgyXDkhK1MRDhEnDSRrF2?=
 =?us-ascii?Q?6sDYkNIW8rfyLg48v+kDZXRKBOz4Ixsmd1grXAfw5H3aAa3kyyvdp+sSk5XD?=
 =?us-ascii?Q?KIKGUx46Wyzp4HHXFTEf+n2eOnA9/bYJRqcEXV2YxGK4JSdo7RyasKNhm0Wd?=
 =?us-ascii?Q?eoH47y7ZFuFHQAjg0CEosknJoRygOGKfIoZQc8aJqtpbaoSBIC/3FomcaQn/?=
 =?us-ascii?Q?y0qbDFXjg6Z3be1+ogQ28FlxFw3yBqUq1acpBAgRIc+VIaOHZntq45U2twiR?=
 =?us-ascii?Q?fih+3oAaK3xnSM+3vIKeNDJ4OMNYVMS4PtYkLsBHKdJCFsEwq3KrE5b6FHMS?=
 =?us-ascii?Q?6UqAtoC+cFoSgJh8M3fvxd0DHA6fpfa7IqHVje8Xnx0KGWGjR+JL/Rr7x/HG?=
 =?us-ascii?Q?bGx6Q8mqGwhDLdgmDAi8RZndYrWta2e9aTU+h7wDxxUOKqudeRUVf48FIAS8?=
 =?us-ascii?Q?0U/ZiPyyvwKULxB4UFWwb5xfPsXZw0ZoBaqyRsFv7pYuBVnKRnzFGliW1t7M?=
 =?us-ascii?Q?o+KdpoPR6yqHIbgSsQCaTplAskZrdlPoovSgqFr+Geg4ff/+3SE6wVF8/G/E?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e0884f-38aa-4eb0-3e9f-08dc749c5d19
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 05:03:30.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09Q9lFGquOzsw445ulz4if7rtRHSGXwPT/Zmqsr5BoS2sTyE6VXi1CINC3nYjFFwSpt3Lb6JPDjbV0mudSPv4zOMHbsL0dIre2Gedrlulx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0859

StarFive's StarLink Cache Controller flush/invalidates cache using non-
conventional RISC-V Zicbom extension instructions. This driver provides the
cache handling on StarFive RISC-V SoC.

Changes in v4:
- Move cache controller initialization to arch_initcall()
- Link to v3: https://lore.kernel.org/all/20240424075856.145850-1-joshua.yeong@starfivetech.com/

Changes in v3:
- Fix code syntax
- Link to v2: https://lore.kernel.org/all/20240423072639.143450-1-joshua.yeong@starfivetech.com/

Changes in v2:
- Change patch title from 'Add StarFive's StarLink-500 Cache Controller'
- Remove StarFive alternative from errata framework
- Fixes warning from https://lore.kernel.org/oe-kbuild-all/202403151625.boKDjHGr-lkp@intel.com/
- Flush completion through atomic timeout function
- Link to v1: https://lore.kernel.org/lkml/20240314061205.26143-1-joshua.yeong@starfivetech.com/

Joshua Yeong (2):
  cache: Add StarFive StarLink cache management for StarFive JH8100
  dt-bindings: cache: Add docs for StarFive Starlink cache controller

Joshua Yeong (2):
  cache: Add StarFive StarLink cache management
  dt-bindings: cache: Add docs for StarFive Starlink cache controller

 .../cache/starfive,jh8100-starlink-cache.yaml |  66 +++++++++
 drivers/cache/Kconfig                         |   9 ++
 drivers/cache/Makefile                        |   5 +-
 drivers/cache/starfive_starlink_cache.c       | 130 ++++++++++++++++++
 4 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
 create mode 100644 drivers/cache/starfive_starlink_cache.c

--
2.25.1

