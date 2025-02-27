Return-Path: <linux-kernel+bounces-536220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E3AA47CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FDB7A5799
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5F22E3F0;
	Thu, 27 Feb 2025 12:06:30 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2132.outbound.protection.outlook.com [40.107.117.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EFD22D4E3;
	Thu, 27 Feb 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657990; cv=fail; b=ie0Re1PTfPCkDRjVzJz6AWO6bCVcHLPBzce3fY5Zkl408NrerdkCUaBDm29UZ+7NLZVfwjUo66Vl4zqvsOihtC49VedOgJOVoF+iSH2R/+bFucBKSNCs4/vhKgIHemc+IQoBGffZ1P6FerX/6KSLINoGKnmK9N7Gb2MqDe9p9bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657990; c=relaxed/simple;
	bh=MLo4meyq0V7QhUTadnCXz2q8a92OPpAydvB461w62vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k97yTC1qGCpC7v93yrrmsc1ShSKJfFvnZaLeP7kj6ISDcepiEVC1kWhWZBj8X0UeSeEoRtRGsnv49xynaXd05iC9BVEM+d1OIjliiJUU11v4YZQoIqlf7h8E8nL5C3u/0wGOKUnAmlZcqMtumEihSehbouYA2fr7rBdkvMfBTLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ak1rBOREyEJntT8I031vy2rR0NG9paDbNkQklu5kQAfugHi6oWA/Niz7MutImw5FQyMpmx+2bc+1SHkgpeRj3RIFEeB0SlTPPJTnbrPKuMHNzb1JgefxZXkqzQX84gLVJrBwZQeHQk6puKesaVQgV+xM1z6KQ2+/mx+xMzn3IAH68B8zpsBlL4rjUtR0mGhtoY93KocSKgmqsugvlmqwwQ6O6eNW1NV+kNFLCpC84szH4EmVd5wAnAgJdhvT6JwF3FWBWeQgcqj5lgY+e2vU5m11pZp/iNy/6/NybhEok7kSKSRUBXo0x2+weTULebfyM/OO/1GZ6M40B3S/qm3C0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxHL/z7KVPyEEvM1kjITwFO2qXWe/VB+sL8iK7Zi7NA=;
 b=fVMi5AaU3yd9jpojyWHhOtghNiY89VjM71gRzvbShh13p0atgXfY/1K7VxwW7luwO/H81ZcUQ3DYlD9N1H+pHQGJUY/BqcS0DQkj7RwkF91mOCk92ES6JStCcuMCpyqIcpn73XwwYckkOhe8eRpnlCnv5K9ZOIu9Zm/6t0wmeObo86SFFzn5L+EYpMgP2YqHJWJG94WCT+fQbL3raWvs8CthqiMgn431kyGwgstCCtkHaLgG0dnKXEUWg1jPzG4HuI5/aX9GoLjyT/vpcgbQASBWFtr+t96KfKVovJ7LeoVvN3rIUgsg9kE9rpmQjrJwYennpbmI95IYgNCtuqL5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) by SEZPR06MB6485.apcprd06.prod.outlook.com
 (2603:1096:101:17e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 12:06:21 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:191:cafe::ed) by SI2PR01CA0017.outlook.office365.com
 (2603:1096:4:191::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 12:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 12:06:20 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A0F6A41604F5;
	Thu, 27 Feb 2025 20:06:19 +0800 (CST)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v3 1/6] dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
Date: Thu, 27 Feb 2025 20:06:14 +0800
Message-Id: <20250227120619.1741431-2-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227120619.1741431-1-peter.chen@cixtech.com>
References: <20250227120619.1741431-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|SEZPR06MB6485:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d3f18c4-fae1-4fba-c31c-08dd572725be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cKPkvpap2WAZLh9Vlk66YikzoPx097rFdBjNfsMSpWq+oIu0NETiTyjZYQEj?=
 =?us-ascii?Q?tkFl3Xmv4Q+MuYlEhFdRdSmY/8SKrjhgxZR3f9WSfp13Lb19/uygKj4J4rwv?=
 =?us-ascii?Q?CCtyJpq/Za77/NweLdNeRt+08s90LgqRrDrWu/29t9671DKfr0cMFqNzTIYn?=
 =?us-ascii?Q?LymepquXu4gKfh/Cq5Q6//ldC2PeCK8N5IFoRTLZh0gGfr5t6PUb2MNcEmUW?=
 =?us-ascii?Q?TVSWcye2HYekMrTKgzr7jHm91bHzBM6EUZrmbNBccX4ojTAfxurvwlCamBI+?=
 =?us-ascii?Q?ek5hxVjiznrpvDWBivtvOOiZGs0OkvbYHBjbAvw9jFRaL65V9RIKjlCeAOZM?=
 =?us-ascii?Q?7jjvfUoYjAJGnyM2o0CtNO25L5F4re6YuPSu3TzcZsm8g9UbMVaqBndVaZGI?=
 =?us-ascii?Q?Ga7wffAnNUkK39vdclFe7Q+rTOkngnY6NzjY2e1woH9DzkNwy76g7MYSCqa8?=
 =?us-ascii?Q?pfKiOfwKls+NOvRspdY0tTwMN4Rw/Egp5lirWLqKvPQP1f4QRXqJI1Xq7Tpj?=
 =?us-ascii?Q?rJ28ZPsBG/Tqfrpkz3WhRXeckIX63zcuKSpphwWRI2AtzJm7zJT3X0TTfPZK?=
 =?us-ascii?Q?YVJ7JETFsomqD6mDljPtHXmXkbVDWWcmDSwvKBHUv79O6tuKoD/bxMOBY9z0?=
 =?us-ascii?Q?4x057tLHJUS34F5t3RppSUzAsRBs2RFsvvqX1tCKre9QVNDITKaObb4mMEhd?=
 =?us-ascii?Q?+Zzt/BGAo6+Hvql+/jkY2T7G7gQqm7gnLdWgDmPqsM4zpt3LXvxpJWTdCcrb?=
 =?us-ascii?Q?336sILuV0LTcT2GiaGeUGsQyIO1QqwhWGCTOfs4eWBmtuE2PL9rb8v//bWMw?=
 =?us-ascii?Q?Ct9VGdfg/8r+xdLLqzl4U9UK8XjEPbFsmchDvRpgVCW7smASF/4XWqHWfUW8?=
 =?us-ascii?Q?gVu03P5xmQpIrgidnBEDvHq7JGQWwYi5ocG72YJbOBx1XnAm2f/plm5TaqyZ?=
 =?us-ascii?Q?WWNIDmFAcQ/+79tmPKWQqIlveGOlwULNlaPjD4ck555JKzADCKglhO+LdC3K?=
 =?us-ascii?Q?k7Evhr2+OjgoBO/8elCg0a1avXf0qTmVxX/QSr2pCMHOtaW83AVBAo141t1X?=
 =?us-ascii?Q?EKgOYeWyaj1CToZQ5LLZknb84rLuzsG6n44U5Ix7HRaQeDGDjrZaeOH7bFe2?=
 =?us-ascii?Q?c/jcBxnj3wOl6j9PNIib6wVkVHqxIfoQWM238cChOsMrh4URKV5V25ODghig?=
 =?us-ascii?Q?CgnN5Vuc+kySOyoAHXWyIb9+xiRy4bHfSIo3hS4AnXn1yFyhAjr1tnBjK8hy?=
 =?us-ascii?Q?pjQXeYs8/DkSvuZGhM3JY2yHqGxSEL50Sucp5AiuosSCROP3ncS/nc8v73kS?=
 =?us-ascii?Q?8zgv+mDdesfU6R1zMegQ8pu6bdcosDLBNOtwnr/CxU3gu9NyDHYPTVMOMNZJ?=
 =?us-ascii?Q?GaiUoYwdnAC0IX6IPR8Q006d2MX4FUVs4/78kLDMeIOCVBN0gc6SJ4CMicZF?=
 =?us-ascii?Q?8i0XnYRQHoI=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:06:20.3359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3f18c4-fae1-4fba-c31c-08dd572725be
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6485

CIX Technology Group Co., Ltd. is a high performance Arm SoC design
company. Link: https://www.cixtech.com/.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v3:
- Add Krzysztof Kozlowski's Acked-by Tag

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..5e76223e4570 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -302,6 +302,8 @@ patternProperties:
     description: Cirrus Logic, Inc.
   "^cisco,.*":
     description: Cisco Systems, Inc.
+  "^cix,.*":
+    description: CIX Technology Group Co., Ltd.
   "^clockwork,.*":
     description: Clockwork Tech LLC
   "^cloos,.*":
-- 
2.25.1


