Return-Path: <linux-kernel+bounces-332189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03F697B69D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3CA286377
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E297B658;
	Wed, 18 Sep 2024 01:46:42 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD61C01;
	Wed, 18 Sep 2024 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726624002; cv=fail; b=FO3S6jOWkyWubmnVvrEozBUOkStnUQpVJxxk535teqpdrm8jyPpiYmslzsJkv7Jl1dm0zBwmutVjj/kgNMGyOHmVNxSZ360wxHu0xZTWsw/gyKyaSEdn/jHeGO+8Ur44ZM0YFxmduh55y3kHoXEhOi6GiVvcvX7S7jp1pJdPdLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726624002; c=relaxed/simple;
	bh=embT5T/6iiSfLEy6eHwNR+Pspd4/7+0HcErX+hzqmAw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ozfnR2l4E0GeKQuwp6dPHMCX6Yi5q0sSGFyu/NsDWUXAzOiRh8+Gx52m+sb590hq9VLO2krUrrOpDuStdJGmftgIrGBRDAxvfKi30tVysp1ex59sxFo0YUrnQZBiH3EqNqiJ5mRzeXvnjmgHhAuXX3oGtyFw+Frf3XmdURGprAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrJHeVkDaQUDgQOB/U3jXmy8lS1jZZnW+f7ZiJO/N+/m4BMy/W9f47JCVDtpkmFgZXUuxWThn+CAEheovqblLwqT6L0iUop9IlrOnmz99GIGqovNF1YYAg+31jHgIYa+aG7iV6DHMqC3zVkrkxWY7QjitH8dvbpJD8TGPBAjohDSjmXWI7ElnvetHcWVBd0PkF8jzSYQnYw1jt5mhx6lBWcSjHGzgm5uyYrvORk2IjTfsHrCDbSM2O3276D8U/icRm472LqzMX+oxtw066mloaP/eBoFOMJC2l6N2IJ9o/U1El3ONT8QoQOkMH3MaD2Tm+jMvMQejm42aWUdIB4AzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEzOb6KomuQxBCSKjp70uRdoq+I42OufVzOKORTzk/Y=;
 b=euFAi6TirlgtucgQpEzqXvqUyQcDtxpLHbWxQ8baOGtxReJ5wWplujtEfatEMz24mmuGqQ5Sd7JwwX1D6xpbKW1PAA+6fxmDsu2wMKYoKxNg5kWr6vN1/LBZ3kwUeLiMTJu4/lxQI0ZZZjgyiMZnjNvvJbLm48/2h0uNUBjem9jf+GurF/6mn1n9n9rIhmg8p9Yt8ZhZIBkmQTFtPRHcKOJvIiG3yFEA24AFI+bjewYid+KibuOtSbFgJjY/K8h+aGcIwG0O/f9YXmpvnRyun2nQ8pMUHBS7TkWpB8nYqwhoRJIkzl27T8sUFqAXxviKWbU2/jxJzwZPZk1BIpSr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Wed, 18 Sep
 2024 01:46:26 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%5])
 with mapi id 15.20.7962.022; Wed, 18 Sep 2024 01:46:26 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: kgdb: Correct parameter error
Date: Tue, 17 Sep 2024 18:46:19 -0700
Message-Id: <20240918014619.1820659-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::16) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB0982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d30169e-261b-4ae4-ab96-08dcd783b575
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|41320700013|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	vcYyCOPCOcP1DUTZmCS+/2jgp+UgKZu0fRYD9veJoI3CIBzwc85SKvUZbtliFfBaayjoE+wYY2MN+9bP73mW7+f+yx/ztg//HqTfsEwcAlg2pYcaYnVK3ncYcNNxlco6vZ+vvBrP4EQjAuKRYyQrz2vpd28oNshcm5EpyrhkkwWwUuAcvma8BdvNNnsejbcrRuDbWg+FwMWG5AdgnY9dfgHtGdY00H13B47UbpNzlYZYxqdv4A9IyJxe0qWQs06Q9FliDGCFaMHv+KsF9WQzyzinu9SIDCPiwYKFpYAKLuI1gouTbGszPKQww6yDhNrwn176nMQqLXOtbuf96+S/c7AM2owBlvdsTQfoDYggqlS4BENHD+sSp41FkSyVaa7RyPiUmkh4w+WLw8mLx5SnJGZdlBopkdlkpHVb77PukcnPC+CuSMn0ttL3q/JsFdmNtxdCebqmK41YKtJ/aQ+kbXOx5zvDIS1A0odXIBzP1UidrnTVhxSXtsw9z7Ab4bb/lqfzq2BM5m9cVIwW9L6COXwIE+cjiTy25DDIx6d7hn+VN5P5Wa12Dd7HhQuvfkIusyKEz8ft1QKUK6iuiZLRia8mi2HhVp7GwkwMViM0EeOqJHTh6kX3b+dago4NmIYL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WGcUHyFseSeoRHLbHTthIrvP4Rl9Tj+60WcpB0PnQLFvmly31CfBEmqMY4xI?=
 =?us-ascii?Q?7SS4IwHfOoHixToyhw/cVDEW1KNO2TdZb/4i3bkkjArFXKQZP8liT3zqcxkq?=
 =?us-ascii?Q?gt05/hgUrDE1LcdT95c6NMviu0t04QeKODEi5Ow0C7v2T9L8tzr9CSjKLByC?=
 =?us-ascii?Q?0Tgwm7cX8C14ywqzLpXcAYtw1SZ9LNaKs2lunZbfQdNJfMre7Y8HFm0MT/rd?=
 =?us-ascii?Q?hBm8lmWiTMaFeYfKmAmJomRkMxhDa9RNYH+HR6S/4Ne5X8DN3WyhhsGqN1dz?=
 =?us-ascii?Q?zPEsRzfIXaRcdocv7c4lvPKN3x6HuP+9wbDZUSpfNJEzURUA7MUf5FItRTiD?=
 =?us-ascii?Q?vcj2gjGGobM5Y/2vlXBBiiDD6GOyXvHrMymO66QbGsZoGF0G24m9xsh+zSKC?=
 =?us-ascii?Q?UIHeDuVAJc/if0JFeC8bnMWFUm5A8bXUq8mcQjCDAp6J4UgKjEYudAlUlN2P?=
 =?us-ascii?Q?zM946v5KUhcSSc0bWc6syWIyoMttX9s35VfjqTP96mGP5TsBvy3+uLOme+At?=
 =?us-ascii?Q?KAN7PYdEBI/cLzQ9f1YGWetWqpWu4LSOxvS3aUTPrnyS88FjGSaCnkI/em0r?=
 =?us-ascii?Q?6uCHh8btjcQezy5BboEWyCKQAa36IMmArDgZDCTL0Ztsaxw8diHscSHqjGjF?=
 =?us-ascii?Q?K/lwjzIS/qLafv3yIpxPojS9ABi/BnawIm1E+X3T7jjAeDNNZA9r8OZDBmAR?=
 =?us-ascii?Q?vVUD0+zW5FmYiNs+Z/ZRFf/OPg1Sg46JxDxfwRScSaP5UvtPpKuVyPunLWnW?=
 =?us-ascii?Q?b4ZScvXvXmILXcuTYxbe7vOgFaX5d6S0/qCzbLJsLvTwXyUlZHcZvPmqYBKN?=
 =?us-ascii?Q?PyJ/QqoULqVkTdUdakhKpraqFCcAD8+qVGWznTsy1DN8YXByH1FTj7NX0gEq?=
 =?us-ascii?Q?c+9pm5HZnv7XFGjvcUSqJuT/q0dsgDbyrurqLVdbjvmmWmnnBZCpwnzU8fqG?=
 =?us-ascii?Q?BZ+TbJhx+uYTAVJmsAGEMRqhiTwYR6agZg/8I/fSOJQcm47/24GomwQWaZpY?=
 =?us-ascii?Q?GalipvKk6g0QxgKqziYOcMP7es76E7zqAUIXXuAbUiXIdo8hMc6aPv0ezetb?=
 =?us-ascii?Q?Oi8YXyu/M7o/mqGrYBGmgDjo0D8Fjbjzi53Rxh7o6uf8yez/0m8UdxoMeW17?=
 =?us-ascii?Q?UKqw0G8N0pD7HJayhrjTmiVbtyfNbIVG43pz/USokwcgaR8RRZ1SwRvW0JFO?=
 =?us-ascii?Q?+MC7SF+MeRFckCifNxd0FkU/+y2HOLzoURCNKdNUhqLBoH7fN7fYQb305ZHJ?=
 =?us-ascii?Q?0Eh6KGezFHULHJeO5t5ZlSE00AJ7dIp6WF+LYSAnYPP8ZLcYh5lWKVy3ium5?=
 =?us-ascii?Q?moAuyo/b2+pLcAZEtSqDdHi1GoNFqnXKhCxe7mAMkfSZWW5a7RqV3XvyVQG9?=
 =?us-ascii?Q?XZ5FqRIfn7qXRUhK6AFcq7/nhbRP6yWM/XslMIBSS7mFZX7HYVVQ10PEJEfh?=
 =?us-ascii?Q?G+DUK2rEIsFDnkQlJ0CIyZDZnIG6Bi93r0KGP6mT9bWhilJFP7yjbySgeUzN?=
 =?us-ascii?Q?Lk5kRdI5BPfGko36rmWoSdMyJzX08X7ri7WeHtXImm1OXZnS7wI6mUPVgK4e?=
 =?us-ascii?Q?OP03t+f/ZLTuK7THMCNmLZzrlsGXNjPqj7Tj5jz0/J9yNTxXso1fQR+pqf4f?=
 =?us-ascii?Q?WRoW4ffIQCu+N8y2QWujGBc=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d30169e-261b-4ae4-ab96-08dcd783b575
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 01:46:26.6606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kz9ULqlD6SKtqiaeZ88FNOAdtxbLOpfEfF5LJwtVYwu1nfunow+zwzZdtgKVaTrnri1aMqMPnDjIcpXmUZyXXsggKDC7q9FXFUCd6iqUTAA+Ol+Bn894LrhWfUeovc4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0982

Module kgdb had been converted to debug_core since commit c433820971ff
("Move kernel/kgdb.c to kernel/debug/debug_core.c") be added, so let's
correct the module parameter path.

Fixes: c433820971ff ("Move kernel/kgdb.c to kernel/debug/debug_core.c")
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Add "Fixes".

---
---
 Documentation/dev-tools/kgdb.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index f83ba2601e55..a87a58e6509a 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -329,7 +329,7 @@ ways to activate this feature.
 
 2. Use sysfs before configuring an I/O driver::
 
-	echo 1 > /sys/module/kgdb/parameters/kgdb_use_con
+	echo 1 > /sys/module/debug_core/parameters/kgdb_use_con
 
 .. note::
 
-- 
2.25.1


