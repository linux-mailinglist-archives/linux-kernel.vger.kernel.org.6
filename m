Return-Path: <linux-kernel+bounces-546120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ADFA4F6A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34469188BAAF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A31DE3AD;
	Wed,  5 Mar 2025 05:38:34 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F4155A2F;
	Wed,  5 Mar 2025 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153114; cv=fail; b=lKmhd55Hq/+czpmuPy5xq3QjT3karePz3K2QnbMya4LFzYP5B+YRWmdV9TfSbHBSZOmGnbp70o+vRoTGlfjMAgvOy9NSjTpzebu4W9f9LLTNPy2NvuNkgXEyHbx2j7qQ4l6QUmo7U1WqrUs07OLIY6GkC45jBi0CEKtcPgwaMGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153114; c=relaxed/simple;
	bh=hzdOYXVKoBu17pTnaH9ey9w6D8MQndrAv+YFruxpAvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYZsoxQxe50fLyBrYVDTpBJIxdCnwOHGaar2dfB5EwKgN54VgqLVprK78jJBYbY62/fXzwglDJAYgLOHE7ci/dIoEFUKnJwyhQFr4pZlobFPEjMraHlXvQQCc2NQFaKYBnSVEB+V1adEa+HLD+T8MQPG/2U4zBVstyr0Gxn6i3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swOS6sK+OSLnMI0XZDfmXctpPg8V36oonfbX48/zTvrNAYihb8z/dkvaU8IkA06EVHFTDUKsgzFQ598egT1FFbDMikO5FJ5paeumqycw/N1hDkUSJIlMYvqDac25gYu5tqjwqjcSGrOgKm+9OYVPOElG+9zPuJfmBQyLSfHeAeQIKuVEOvZc9OMgFhiaf8qtlgBwhVg9vDtoA1Om2+9mMFP7kWJgS3R5j6za82ts9saOAndZaAfHMOTT9sgShji6+ndHHbgBolsUaIq4C+xZCYkgpqEOX/4ZR28ISWiV2QH2zcZf4iksIcssoW0MqVzqZ5R0U5+9ENcOwX678xP5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWj7ThhfDZmlsOE7AAmLcqR40K1uqWe00JMRyWeGd+g=;
 b=caVso7brFYXlewXu+mDykj4SLoY5LkUP88hGeB4ABl6S9h8+CQbxK7DgNEm20/hzFEBGCMobnzE02ZPILf6wLfTYRYd3atRyCaSNMvsctrDEVmoiJfgdsEQ5gqWl6dS0t1wCVaKMx0M46jzNqSzxKC+/MoVnqcrr1hyTaEU4Iu0+PxSFxRSxmlFWERKnFCrBDki5K0jUVUKvU2y2qmJ8jo4JBcdQH5uvkHNMHY5rahe4wcITV9Li7Qu4rRpYJAUBiS98YDzmrnELiWgTxPfB6gKHRTV1Vfh4C/VQ+HM1h+vopza+bI86YlE6e6n1RezKAktCzZXvmfwVO1b4wAlHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0050.apcprd02.prod.outlook.com (2603:1096:4:1f5::12)
 by JH0PR06MB7149.apcprd06.prod.outlook.com (2603:1096:990:8f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 05:38:25 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:1f5:cafe::ec) by SI1PR02CA0050.outlook.office365.com
 (2603:1096:4:1f5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Wed,
 5 Mar 2025 05:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:38:24 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B979E416050B;
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
	Fugang Duan <fugang.duan@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH v4 3/6] arm64: Kconfig: add ARCH_CIX for cix silicons
Date: Wed,  5 Mar 2025 13:38:20 +0800
Message-Id: <20250305053823.2048217-4-peter.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|JH0PR06MB7149:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e927d8f-c85a-4c10-4f1a-08dd5ba7f2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9m+8bbG+Bu8L4zIvhxYcmew1zD+n3rmTcWXFWnj9LUJUmk3lUMH73jwj+DsA?=
 =?us-ascii?Q?qrgn2XdfX2rKDkCPYtuzThoVzWs9Skj241UTGqri0GaCScJV2jah7nIb04+N?=
 =?us-ascii?Q?T+DvAFRbeAY4WrPl+I6/8g1b9ve6zPecj5uYdk2xR528unMU/r2lS8FwVy97?=
 =?us-ascii?Q?IBC11t2Y0CtZXzV2dEWZuQZC7woWHCqQpekM12bLI/TLnks6Z1z/Jkgpcp9R?=
 =?us-ascii?Q?O4fpW3lPaV/zaaQVrcmstxV0XRpWeUQUQo77rBiI/dcwrY2393ZVE2T0bboj?=
 =?us-ascii?Q?w4GR4mxh8atI2/r+rlkmXERKizqxoIWbBd+rZrkukIf33ufZtQ8bErjwkkVC?=
 =?us-ascii?Q?jrxuvmxw2TSbrinVCcW64NVfmUC1UEvbkCxm3Z84b4BelSXvJ4z7XoYrNhJ4?=
 =?us-ascii?Q?HbfzFfho1AHtU5F1hBoCQRx6K1gLCoty4j6WMJhjktQ0blwKMCRvxfvcGrO3?=
 =?us-ascii?Q?hVS6gFdEY6NYlFEaxfMCvIcbTUCKjQxpglj9d5/p2KhvumAlbw5fOqJRpTng?=
 =?us-ascii?Q?UfVYjr2z/+0ize/DH5FQu3pbnnfparqlJrgFSF4Ch2NawHKi/ATsBCyGFieZ?=
 =?us-ascii?Q?R4KBbXfa9BkwzKvCpqIiB2t+n8fRJ56QEf2oOybD2N79xJuvbF7pX5SMMHuo?=
 =?us-ascii?Q?nabQFUQp2fIcq8BI0g7o6VEip+6ivprWoZMbI0Rx3ZeePefwj686OtHbPuq3?=
 =?us-ascii?Q?DGNqraPRhrGENO54JrKT7MGZgEW84kqRQLBVokLf+XEcGIjWzd2XLuuL/RA1?=
 =?us-ascii?Q?1U42WougeBAPTBV0edcC9wYZltaxILb7iPilrsRNfe8/ZdyP79Y31o44j1K6?=
 =?us-ascii?Q?+/av/7A73hLWnAWJuDMEl8vI5+4ohMSTvvR8WtqVx/5m9IxooDUt+B03YcIs?=
 =?us-ascii?Q?jQZvUf6/NUjwJBSDc6k7/EzzApxtfJutsF+eUEiDpyRptopL5MtzU8k/RbY8?=
 =?us-ascii?Q?sZrAqVQCihE5ChaHyBkJR1agcAgMBHl0SYzbrA0GYZ9XguX1nhyQqX8hd/KX?=
 =?us-ascii?Q?RFrt7GugFozIR9Rdl4TAxXYWq+YmYgjrhh3e6AAA3QjB5ZEDAOEjfF51YVBp?=
 =?us-ascii?Q?tlSE07pd5DGgRWibcB4j1JHD5fExNLRIHpU7UsDixY1tuilm9D8MEnbfxSVA?=
 =?us-ascii?Q?KUxlSPO3A3LXKHGVaGKIM5vENy9GxAafoLfzwPANwesbo1NqOIlY7NWoCena?=
 =?us-ascii?Q?B0/9wF3V4Z7mfDoAOD/OdZdMUaolPojwo8mjm7+hq3++WapomLfdrMnFz+DW?=
 =?us-ascii?Q?221zc86jiekmEm63gALzfKY5YPx9OSv9c3jpuZZfCH67Gm9NeinLGu+i00SZ?=
 =?us-ascii?Q?kGEScgDrBs9mBXWp8vSPxzTonjzTBv4nvYzl2H3m6ntcuqdd+HMoeqEB7Gre?=
 =?us-ascii?Q?+DRX4QSnYwnPunl4+0DCJ241HjSA1Mhfc0jCOpwJH7ZSWrN7cX9jo9foctRh?=
 =?us-ascii?Q?eUCxrpc76927ALzvuhOZBXxYVO/56x+GJQ5pJSlTvogJjLbdTslzOF4AtS0I?=
 =?us-ascii?Q?7j1R5Chr9Hgt3m8=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:38:24.4328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e927d8f-c85a-4c10-4f1a-08dd5ba7f2b4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7149

From: Fugang Duan <fugang.duan@cixtech.com>

Add ARCH_CIX for CIX SoC series support.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v4:
- Add Krzysztof Kozlowski's Reviewed-by Tag

 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 02f9248f7c84..abe41db9b9b3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -106,6 +106,12 @@ config ARCH_BLAIZE
 	help
 	  This enables support for the Blaize SoC family
 
+config ARCH_CIX
+	bool "Cixtech SoC family"
+	help
+	  This enables support for the Cixtech SoC family,
+	  like P1(sky1).
+
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
-- 
2.25.1


