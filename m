Return-Path: <linux-kernel+bounces-546118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9C7A4F699
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B7F188BC91
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E41DA628;
	Wed,  5 Mar 2025 05:38:33 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D01A316F;
	Wed,  5 Mar 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153113; cv=fail; b=kbogM+TBrSt6CGGjDVb01FxWtPRjMVAVMzcOTbDdb2CQ8n7ccDfuJryzAKxZBSG9DaqhBNet7tbBqScILCj89Ic+MuIxztEikHoF30yzt21QSsyX4W1Pab0tivKcfMheYf6usNXncUEJ1JF94vonPx0oKFsJm8Kk7KW2+PPhW8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153113; c=relaxed/simple;
	bh=kM9mp0DQiQlvBBJ3sRATw3aKy7l6+Psesel9eBNP61w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvkYtelvVW5wH0A6IwkJjOLzBxQrVzje1rZxGLn2sP46Nsho5kdWa+ELwAQx//TbhGRHjfumaO2UhjXeT8ZYNeGIwu8thxr2dV02YgSMiNmVIoltqC4s72LzdOF8h9e8z5G3Vx4syJm+QJR9vnA+g15MW/oruBfJwZ929ykEe3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.255.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/0CmmOLCqPsE39v9yj9Pyeixean857GBqh2YAVX28AQcwPGYdCLHxBVNwc8InTz64c6RaMTnRFj+vmZxMpT9IERHd7cd/K6yBx1XjCqmuaubgZIdLlK7DLDu4KhfsFXLkdKPlki6R7YNL4PEVMdUNlTZcCBA/6Gs+x+2tTnO6sfcWbath625WHP9oM95uSOnWlHqqMbpz20UjNgNcT38X8Px55o/34W5hinlO2VuXL0v554RRSztA9F8WyPQvpuu6r0LbnyBoCcBD/aOdwZyWQ/8SnKlKDHc0l9gVu74sBjgTMuaxgFRBozQZj0TvQX+WVnrPDcotnDr1SPXKR0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDiDMSvrkbAzlosM89SaIfOtkx2P/rMmUar5l3ixSLc=;
 b=YEtk7/R7FQy3PnCyk09H+dw/uf3SMmvUEH0CJyZE1c9tz4mNBCob+4mED/7wEkPPAvszSrUVz3NbdHFaasxSKT0hznCo5TIsKxzbwsnSAAoSakG4yzBdv/+4w8l2qprqFniQm2U36rMlb77Lz1KkMiM8/afjKLPcGTxn9xSgexeUctnynb4gjgdhOox7ljUA4NBA/9B/2hd84+CD5L7QTMWTPW2JYs+w4g8/OkjhqbBonJrBXsD6tSJSmLYb5/V5Inl081DyHUadWe+E/STkok8oT2ddtdj/BycGRl5BwTf1wMoQePf4cVRb+J+qyHSiQ5evjZkp6FW5TGNtR7oGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::15) by SI2PR06MB5137.apcprd06.prod.outlook.com
 (2603:1096:4:1ac::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:38:27 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::77) by PS2PR01CA0027.outlook.office365.com
 (2603:1096:300:58::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 05:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:38:26 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id E29F04160511;
	Wed,  5 Mar 2025 13:38:23 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v4 6/6] MAINTAINERS: Add CIX SoC maintainer entry
Date: Wed,  5 Mar 2025 13:38:23 +0800
Message-Id: <20250305053823.2048217-7-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305053823.2048217-1-peter.chen@cixtech.com>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|SI2PR06MB5137:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f734dd31-d0ac-4c5f-0c2f-08dd5ba7f3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hOiCcMiPl4SgBm2HWeBEuuMglU2ZjaU/JVGGvd75NE7PivVZzmzx6mjbs7+g?=
 =?us-ascii?Q?JlJKrA196Gl9oxSvscrlwia02MowuL8ENmsgHWs56rB4Mx7PhvQ5IMYQh3+r?=
 =?us-ascii?Q?IpuxRt9CL2JSJFRw/TT7ZwcW/bzFggZy43PG/tWK+u6JtIeRIspmmWsQYfvu?=
 =?us-ascii?Q?W+EuEckT/aWVW+k6B7O2ux7f9pmoZFZnNEJzcSkuvZNUSD1yvYycLuA472DJ?=
 =?us-ascii?Q?LGCmHdsUBs4NqUysRHf/3uRvzxZlsLmgHY6QeM1Guh01b1BIOwI/6AY6CGjW?=
 =?us-ascii?Q?3it6cxVYO06Ml4JHXqwOWL8Ruh8NTM/mq3X8xK8ubLxgjEZNrL+KXPWLvjiM?=
 =?us-ascii?Q?T6+V9SInRv8WncC9hgzltROMrykf3qSk1C2lFdhlroE44utGRafKeU+fLTCB?=
 =?us-ascii?Q?cdmW3P1Kye8gB2OgL3g9NNxGlgcQUBDyuN6zsMcY8M6/JU/h5u11ke3Jz+a/?=
 =?us-ascii?Q?5kQkDOEKwprnjpqp4Unr8z+hwyX3Q6gxW1aRUbBwI04vmdxSb+b76p7PpdMP?=
 =?us-ascii?Q?keSM42dQrvfFJdjlCWfpVUieLbhPmrb49bY8+2PwzeirJRwX8dhm4032hoj7?=
 =?us-ascii?Q?57MiQ9G22fnhVjsRGGXcLTqGBkJMprl5sq8xZw2Stz4ld0ZlgmGhnAHJJrPa?=
 =?us-ascii?Q?P6uPPdl4A17zrc/DJ51y7OBYx+Nx+0J6h786vl6FBxfBV6JQHI/Nib6DUt5x?=
 =?us-ascii?Q?8xJMBnU5esbaU2BMsFR/LAR288jnMLCXUpu16eOLHnaB7+1ve4AHVZ4PeP+p?=
 =?us-ascii?Q?Y66NxqyGvXUELVk0mN6Iy/zz0cCDWWNPUFMbL3gFJ6kbtU9EmnraxEI2GbBu?=
 =?us-ascii?Q?dmvdDoFIq+OeIkhcHLMTR2RzbIeB5wFsqSPcvkx10nENoP7NClYs03APrN1V?=
 =?us-ascii?Q?DFizpKUDQ2KRudSbOIIRfAlK4e4CleDB5yTG5TOdlnWtHIfNOLueKZX88bUM?=
 =?us-ascii?Q?wMdJsFmNCyPnbDe+0vq7qr6L684KsAmyiF2ZsBKVorT3eXN9w6qp8D4gqkNx?=
 =?us-ascii?Q?D6r88lgVLCRepwh91Pcgs1v2To/V0+c9fi5htfcWxjy1BQuAjCEvolzaY1+7?=
 =?us-ascii?Q?YBmu1xVZIe+z/ksJ/9fVyfVrnsD8LihyQuv+xKJ7S/DVsDnJ1MNfkxF3JgdO?=
 =?us-ascii?Q?oyrhQjuQMZOuPWhluf8FFD/uRaSAdM7nB2aggS74ZXmIGHlT6zObqHQKHtMf?=
 =?us-ascii?Q?cxiB5p+xSHPe1R73rdQFVdkryGq5MqAjfgqf/xNMEGvV/fm/a3lYl/lZNDh6?=
 =?us-ascii?Q?CZI41rt7FkeBJVRDbQPjY9SyKQWed7iKbTq7pbk63pB/AN0GI6zvvtRCGdPp?=
 =?us-ascii?Q?d926kSe83rJQZWTXG3SSfEYgtr0/eaxxsvyVa4HVc6BdQnMtoTRQGlv1hAb/?=
 =?us-ascii?Q?UaLWfe6Ve8w7Wv4rlLK9l9wamKnXRkAdmLuRqTii5k949AnhyPBgmQn4qvj0?=
 =?us-ascii?Q?Kkn0dhEBbYBzxsDC+MvYLCGsk+j2MptMU9AYy0auHzAMGpOiM4gIo9SdcPvo?=
 =?us-ascii?Q?AuKCV4bQAaQQSos=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:38:26.4330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f734dd31-d0ac-4c5f-0c2f-08dd5ba7f3ef
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5137

Using this entry as the maintainers information for CIX SKY series SoCs.

Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v4
- Add two dts files as maintained files

 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..edf26cf11ee2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2354,6 +2354,16 @@ F:	arch/arm/boot/compressed/misc-ep93xx.h
 F:	arch/arm/mach-ep93xx/
 F:	drivers/iio/adc/ep93xx_adc.c
 
+ARM/CIX SKY ARM ARCHITECTURE
+M:	Peter Chen <peter.chen@cixtech.com>
+M:	Fugang Duan <fugang.duan@cixtech.com>
+R:	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/cix.yaml
+F:	arch/arm64/boot/dts/cix/sky1-orion-o6.dts
+F:	arch/arm64/boot/dts/cix/sky1.dtsi
+
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.25.1


