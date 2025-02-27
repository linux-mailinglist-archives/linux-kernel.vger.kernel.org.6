Return-Path: <linux-kernel+bounces-536214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63961A47CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 244557A683F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FE822AE42;
	Thu, 27 Feb 2025 12:06:27 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE69B1FF1B4;
	Thu, 27 Feb 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657986; cv=fail; b=DCPJmAM/BF4eEH8lEWmKD5O/QYUtYnveY0eWK4bVYV9loP388FglPn9TW5hPoJkTfalQDFrdNt6sqKR3jGmIO7DswIHbfPG1yr1yp+jkGjHtmJZA3AYaKcq/EJR6Azru6vsQQzS4B9O8FSbDvuh8SgFACY3imoihDzB++ujMyiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657986; c=relaxed/simple;
	bh=e7hPk0jLH5yvjXhyQItDLsu2jj8s008PyXT1KCsFnwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzP0PjpFYZfDzynlolWAAMdBbiBlwZ+Fv5fYl0o1c7OHOxC/Z5HxNVjVZMLYEyzWV0qHu2jpFKvkx+K40R8IHGxPZIufrvkA1bXQjmY6FBX/d6LwJQpWY2oUuK2ZPTxl7IB4OeVPi1rzsg8GN4+aVuW31m7BHKC4hKwMO+buyOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.255.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoCIlZdI4KOTpR+lhUVWe1eTEqqa7yGGJHdFU7bN8Qf7Jv8K7dBk5FfynUACsNr9akbXnEN5QlNtvGZPXvvV7fR4j+LWenINyWlOBnXRr5ZIK+e7RjufHJLdqef0jRKwYeUazaOJD5eUC//0N0+58wrfdioFhOyLXwcBJ5XwvSTyNxRBFqMn97kogxlFSTVB8WEWNKGXVDEHdeD1PFqxRIHhALjx6RrqzukDgGWxg3AvIC6UFTNDST2Dz7b5vIpUE5i8fOjaIkWxwWX0qcMW7Mncks7i/ChUO7jOcV68oDRNtKxZ7gqaDjNGJpCLtlTM/V/a9K681sBsWAoAM9nhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haR5tbnvIj2P2bamJeswnPFGYF5HC2vavkyiI1t+w3o=;
 b=WfEtN2IJRCXwe0a2xFEGeFlf6Bi2ZygQXhbFU2JJBP5XZey1AIKPnwzam3SwwSLPtCDkUXjIJVy57VxxTv4v4kaxctdyuo4TYQsyysn3Bg4dP6E2KdYRro5tct3E9n+DxIEegRD899OHCUfjdT8mCBcmU155V9XZOe87W9tenYgmwxnzIi1p8VY6Pvo/Q7JiByUUupzVUUayTTV4NQa5cvP9tkyWd23XDhwNATcX60A3r1XJxIaYAozviMe7huYfKGMf5Hut7irGO+NNjXuWZE0LaPuIzyx8YQYjKSK/s3AVIg3fVBBXK9Rva7JuQ9Z5KRxKMoeYuo+k5v/BqMyFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:4:186::19)
 by SEYPR06MB6009.apcprd06.prod.outlook.com (2603:1096:101:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 12:06:21 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:186:cafe::42) by SI2PR06CA0006.outlook.office365.com
 (2603:1096:4:186::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Thu,
 27 Feb 2025 12:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 12:06:20 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C3A9C41604F8;
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
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v3 3/6] MAINTAINERS: Add CIX SoC maintainer entry
Date: Thu, 27 Feb 2025 20:06:16 +0800
Message-Id: <20250227120619.1741431-4-peter.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SEYPR06MB6009:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 00f2b4d8-7546-44e2-f431-08dd572725f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qITiwnQHseTN31gaN74XQgr8Mrob3Args4WzG1gjNgj6JnHhtIu0wC3aup0T?=
 =?us-ascii?Q?eZ8oEq6N6oUFVblBwGuBI1V5U+xyPx4FjADIBTIS1TidEEkqYBUXb6PrCC/R?=
 =?us-ascii?Q?jvWmAgtHxNX6mexO+FXhm22DbRkWN33ysSFSzTd3sMTB3YP6MKQpsO3McH2n?=
 =?us-ascii?Q?2ADTf1x7oKnpMNBDFP27W+G/5KVybFz8Ci3czwpVgAJ88XLU0hnh+p8G5VAA?=
 =?us-ascii?Q?LlJpsB3KvwgKsCOOwBbtH6WwssNtVlg+2gZONOt3qnq4lb6GAN4Ahp8IiWhf?=
 =?us-ascii?Q?bWZE/D6+cDL2iiS8UMzbINgYfOhogYKEiD9ab3HM6RssPU/sq2ZPxYN2oKjS?=
 =?us-ascii?Q?Hcf8D+XRTVMt9Qxm4AbDz2OKGKtVp6leihnJ6K40FpNd+prxRvuQcHTuFctF?=
 =?us-ascii?Q?HTwhslOHTGuyyXb0vlVkaY2thjIDpFoO0suZQJvvsHkShQSwp7tysM4r9RDU?=
 =?us-ascii?Q?pE+Yp3kKRJnTtX+CCKPH/di26OzfRf80rqJDZkU+vz0pqNF/c5OyKCKTYopo?=
 =?us-ascii?Q?jv/4Ak7Jr1uQr2IKxwXviaCcuks3KJTZZMglNcWlxTW+511DeRGOZqk18t4A?=
 =?us-ascii?Q?9P/Ol91kTqod3t54JkqXt3AdwlW6KZt2D80uUA8WOjYtn7aTqfLDnqI+lQa5?=
 =?us-ascii?Q?CY3yqDdSuHvMj84kyq6zqJdOHvirtU8b4XWqzMe1WHVvxuE5QR4Pd4TUqQM+?=
 =?us-ascii?Q?bTBFtxTL0FVp2TIHP2aWZGELX+OvnJYySu07LtbSekmFvYBj4QqbpXkYQiFm?=
 =?us-ascii?Q?fBmJkumT5OyY8QaZzjUteiVyu+HV3cBYBZJLQxpKNHH2xlw6eRL9DN98r/pu?=
 =?us-ascii?Q?EMjCyxPMhHH3pUNQpxNYa+a/iTgZhr5IxGHtLuIZvDEmvx0e1ud5NFd0xj4D?=
 =?us-ascii?Q?RT3JtEKEYbtvIB68m2SAtxaYnjRLoTnJIOQMsdNDgx/wpTNgYaUPhHTNdkJg?=
 =?us-ascii?Q?oAnIWDJDv1FUuzC3K2TJCaPr3O0AzQgAaA1HLSTZp74I6GID9Y08I/JOvpTk?=
 =?us-ascii?Q?hVSxnWa6n1XC6mOc49oYjlSo5i0JG+1/5uqtVZtqjKOAzercHH3wndX+pcLs?=
 =?us-ascii?Q?GN5y4wGM+QqvxMmDJLr7XuEAgxj4BB6zIkDsIR68GdWKo8kEVEmrFlx6AiPH?=
 =?us-ascii?Q?R6FrWvpMi65BjPgnksSsh0Y+CNumZkXqUC08+tEryMIJ0VCDk6PNdRod5zEz?=
 =?us-ascii?Q?IOzF0ZrdcppqgmYw0oi22ng+Gi6VOK+khlD5D0iIgkdi5hpt9fHXLZHW+7us?=
 =?us-ascii?Q?YBIxAA4JP3U71VpUI8ReiQEelzt34OB5Hl2SGNftsk7yeL8fKX1MreiINqwK?=
 =?us-ascii?Q?9no6J9pWpinLzJMXXCdXFwoq579rQXMoIvFERVr/sDa0ipkvlMPvqm64CW9H?=
 =?us-ascii?Q?toOcN2XgZ5vVbbUcKksUN/wnhlHgkuIxErMyG2+m3ub3K3/yLvO2MJqG9m53?=
 =?us-ascii?Q?mKrtXAkS3dmmZatNmdVu81OV0zvLhJA/GY3suD54+4GV9boJDVCicHh7xAvq?=
 =?us-ascii?Q?LihYp/yCr4AyF98=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:06:20.6532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f2b4d8-7546-44e2-f431-08dd572725f3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6009

Using this entry as the maintainers information for CIX SKY series SoCs.

Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..200d2529c8e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2354,6 +2354,14 @@ F:	arch/arm/boot/compressed/misc-ep93xx.h
 F:	arch/arm/mach-ep93xx/
 F:	drivers/iio/adc/ep93xx_adc.c
 
+ARM/CIX SKY ARM ARCHITECTURE
+M:	Peter Chen <peter.chen@cixtech.com>
+M:	Fugang Duan <fugang.duan@cixtech.com>
+R:	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/cix.yaml
+
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.25.1


