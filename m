Return-Path: <linux-kernel+bounces-311621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE9968B45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB57B22940
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3167B1A2659;
	Mon,  2 Sep 2024 15:46:22 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2130.outbound.protection.partner.outlook.cn [139.219.17.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E121A263C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291981; cv=fail; b=OVUYPhl11RTUwzi3qOiuYhssRwkwPBaZk3lBDN4OOk2ZLL8/sbgVBUZvJRqBPTArBpyzrR8nYXeyEMCovuERYjtmNboqG16ptD5OfADy6Znr+OqHtCDEUHBzs5KRKd7CcH5v6fFzEq58WV9ARPlbmbH7bDdzxxUwABRkBD19p3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291981; c=relaxed/simple;
	bh=eNrKdzO3O0hTE7vnbkDl7CI9N1/aybzEQjEBeXTadWw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VA3PcL0sa3nS+h/X4A/3xqvU/6RQFxwwOAcqem18W3PpEcAchuuiNoldCmnwxKIQKKkQo/EAaOuDtKFeWGREa54VHl6GwUGvaI4SUaXap7e8W5oQeWG/04WXey+lI41Y7JY7yQisS1z6BAh4gmQMJ1EbpLDSmoecBQ2AZMDQ+3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaENqe8Oq8s1Dw9CZGCKdDwp9DJRPOmq/yhNxu9flwcfgyPEkPk2vA74cktTb33P8cYlDStoAKDndjzCkNivK+cLbIB+h45nexAh2UZXX9UbrYVr6QlmkMg6jLAdNtR3OPWe20QGRDiRL2qARZIuVfxneU1jI69P6Ucfjrbd9t9lUOeGvQ44wbu7u4iF11DeDHq1ugRi7ZniGqWPj1yWWPEM5a0gznZOwtJt9gUkgcE0kzoq1ENCGESM6khRjpdOonBS8Xc9AiA3R3t40gA+GsT6kHIDJHahIzv0ZX2LL4t027UcjmciujhI0n9eiThYPlr9J5gUu+UErflUXxu/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNBy5B3NqYchU+3rxMXJMIoizLHYHvvL0dEpX3qKi/k=;
 b=kBSbpoSUq8dRNiusd1RDPnGUGnkniDckem7UU1UCns371mSbNRi7Dq0/QXO9qGRqcbMKSMMjsp/c1m8dyBk0antRFdufhQ6EiCHekiOMdngWDxxdAhBBk2NdGM1t/TlBEba8QHBZbOPBAOdmkCNbZWJcs0a5M9LjDNx6V1L01lnOQDVbutDbUTe9JyUty4zKXLiVDzNCiB2H3LLdo3kkX6Oiw5epYt7lF3oVFOg8c5pLqxsBExN5UPiiJoEicFk6lg1OUQWzfny0ltsOpLkeMefMxIJHKFxlcJS4EE2rUu7dy11rTTljIEyzxGCB0Bif6QXikvvfN7WHJlJu5GzwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0768.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.31; Mon, 2 Sep
 2024 11:11:38 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Mon, 2 Sep 2024 11:11:38 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	linux-phy@lists.infradead.org
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 0/1] Fix configuration for on-chip USB 2.0 support
Date: Mon,  2 Sep 2024 19:11:26 +0800
Message-Id: <20240902111127.15155-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::6) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0768:EE_
X-MS-Office365-Filtering-Correlation-Id: 1359706c-d15a-442c-486a-08dccb400359
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	uA6eF3joVzdeDZvMfFrUcmB2JQoE5uSx9dDiknfQOcyGSApIkSBpMuGJYTI9KyhXKTLzhF806+OMFtfMMjqpWrXb6sNLvvSzMQycYy2hMayj6omcJ6fKFoHDenCN2goDRA3J4urzbvc/tEPXkgaA8HgHjFrluzf8K3NUVC6txaVU5xZaCcQlaYUqeLWqm0sa6RLpYBAcSBZYWAKcXRDjaQQJMK5U8/+Xv1NzD4ju1SqlyCtOqI3Z7KXneusqdxwOoULkGk10EOGPFshNDUPuvpmUtR6dSWq0HktQLGy1BP8B9NcUumapJKwFnK4T2uk1eepcj81vcYraiVai4w4XpcMZFyBngxmcVsoZzJLTLKrzeiO8KFiv7ipWLGVCi9APRZakzoJQWx2joo6pMQQb1TVIEoCN4zsu3vsJOhwj04ElvAb5Dl3OqiTL7zlR8ke+2FbrWUSI76bbZMefPIjBJzv1nFzhcNlougWRqs24dVOmwI9nPHtix4byoTi0EPLT+bxsK6DSi/8WjqryVthO2Ujg/W+EXoC+P8SpVV3NzwY0CPgQG7ABZcKYDC8E0q09mejBh2s/+CYZXUqFwBPIz7/kevt+BIdIvciWCIOgylvhOw/GrqCPM+6MguOxv7Xu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7N2mb6zpp4O2lO/d4lCTycm9gxC5/Oh3YcS+HoDJIj0tCngXpAqqkEDYIqkd?=
 =?us-ascii?Q?OHpY6lxgJtC2QZMrAPtcGSlbThiXTtcwhyh+gKXAo8yShSNF6dyyt8PK3rZN?=
 =?us-ascii?Q?9f2MIUnAK4O8kfSNfLTMvH0/FsxmFL26i3ZnDeiuQdoVZoQMznWpX2FYnCA7?=
 =?us-ascii?Q?qpTeaWDG6Eb6eKXjBo/dpbBf/SFXO9WxA8uVGEVclG+Ig7eZxs5X8QPYBrB6?=
 =?us-ascii?Q?BS6fhPEEvSY3+AT5BuXx6WnUt2mtoOczq5sw1iBvcwGq4i9q8piD4GoK76da?=
 =?us-ascii?Q?ieEFwB1ZWOjkFO/MX/UzNh8McaB3CP0vqgYLXqCvWZ/t1TFoywqlwduY9qFC?=
 =?us-ascii?Q?3EQt6W5aaGRaqTVPf7mYMXk/s6qlmtUgahCB6j2ImoM4K6EQ5Wcm+Rcr2he9?=
 =?us-ascii?Q?4YGd4e6O05YyPnBvDdjyH6xjHSHTUd1FKm1fNVib3sbeGoNIwbierPzybq6z?=
 =?us-ascii?Q?/MZseLrtBStNhPywH+PNceP8zlcddpG6+1uGHDMDetD+muf1SiR/+TIDvdKH?=
 =?us-ascii?Q?NPLjzsdOL+gCR+fumVnodEyeMmVIGEKdXxJgr6Pmmo4PH7lpAogFhN+F3tVZ?=
 =?us-ascii?Q?J7kKzlKjyFuJIR/dX06h1VNKOBlgvViOt2NoMv3ryNWANxUoQFTfh9EDWrLk?=
 =?us-ascii?Q?7ZJWg91YsMtui5BGPyymYu/MUe+0aQ/Eo0aXWNVSqFfJFgcWuelyqRdtT7zJ?=
 =?us-ascii?Q?dPtGGMRcskuehKmV+zVFxzufTppmYeNtDqrW/8xgvRTin1dfIhE8Hk8jVH4C?=
 =?us-ascii?Q?Bai2/V2AheyOr3WxJguMP4LyxoB9SbKkcm61Vqm3fg6KP83RBjV2fZBo4Sm4?=
 =?us-ascii?Q?rQvLXrq3r84w7aZmLG1QqHkyGsVu2W8TKL8Dq2HqVCKdP8FRMdQ8E+xvob0p?=
 =?us-ascii?Q?wgfoeP5DwB/iOgRxOLbm3XWhR8N8sGMkG64vqv3Y4trTOGl/UbayzewiDMKS?=
 =?us-ascii?Q?PoVvzyZ1zsnrDH8oSPVkCBvSmfg/pK4zax7USWz2IN5m8DC0NAb2poWddG79?=
 =?us-ascii?Q?vAXxF6Wqrth3Zr6wiKdZ5ISilvmhgcZU2098j+8JofHlbwBYoyxQ10LOd2sV?=
 =?us-ascii?Q?Kju0AI0i/HYrFwCVePRf2MOk3DsFVpM6wI7EA8Mrt1eDpmIfeZRok8vL3x4V?=
 =?us-ascii?Q?ex58N5O7xmF7vL7KK4ftN0Vn0AY5ZDPWDg/lTZOJigky9RAggvfy9XnYBi6u?=
 =?us-ascii?Q?oBQv7afkJix8onjfVU82auXZE2UHFfY1WrNrCu7w/SJFv11QUT6tvvhGI8LO?=
 =?us-ascii?Q?21VcGp4z3pL0cxiFfcqFj+PnLZw1tpLkWhcEiFxDJwROK3pRQHWARkziO0+x?=
 =?us-ascii?Q?O2fN7oj0QASaSfjgnA4c8mofQD90dJjErPNpH9Ca/m31x5XFEm8cLuJshPhF?=
 =?us-ascii?Q?Kte5AdmXq2M5dxzhBrNM84MTVy+y6OF9PZ8j+ee3NBYAJxGmvH9z68DrxRax?=
 =?us-ascii?Q?CHzhKedJicgMuMCwX27A1W8aefjWnBPNbupcjgKECW3TJQjpMvGahz4X6zi5?=
 =?us-ascii?Q?xMtXwRHPWM0wfIVqFdZS8JAlf6OybkQt8yDus6u2JDhhXhGYtTTy9HIYN6TM?=
 =?us-ascii?Q?sATAGfMcTejS0BcTTBd/3KIFnN7QscC2CeNLuQSgCawndt4Io+hSZaE9B4mc?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1359706c-d15a-442c-486a-08dccb400359
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 11:11:37.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmN2OBWH8u/r3x/b44eIkJ0GQfl5uPEShcT4cszUcu05zzYMioVPyoi6v+kIYpCXmOc7fGO3x08mWa2i35p3hxBveH6j0sHZ00snhJf5KEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0768

While mainline has support for the USB controller of the JH7110 since 6.5,
this never really worked, even not with latest downstream kernels by Starfive -
unless you were also using an old downstream U-Boot version. The reason for
that was a missing syscon setting that prevented the connection between USB
2.0 PHY and the controller. This series finally fixes the issue.

Changes in v2:
 - fix copy&paste mistake in error patch found by kernel test robot and Dan Carpenter

Change in v3:
 - Using syscon_regmap_lookup_by_compatible() to lookup regmap. So dts
   with no changed. Delete v2 patch1 and patch 2.

base on v6.11-rc5

Jan Kiszka (1):
  phy: starfive: jh7110-usb: Fix link configuration to controller

 drivers/phy/starfive/phy-jh7110-usb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)


base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
-- 
2.17.1


