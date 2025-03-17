Return-Path: <linux-kernel+bounces-563238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F75A63A77
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AEB188F199
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEED137742;
	Mon, 17 Mar 2025 01:38:38 +0000 (UTC)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020081.outbound.protection.outlook.com [52.101.128.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5AE571;
	Mon, 17 Mar 2025 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742175517; cv=fail; b=Hhm1vh2xThIfu42e5Sumuz5onYhSzlwmAqS0zsdLThxj/qeN21OEb8giGqDaPdGuFsQoe+FcQhMC+N/Ztfc3wj5bQ08MbPcsrrH5uMcJNBNQYIl32hn4ay5P2omrFowJAMXhrRoZ9Lpr/dORqO1Pw+mAWkFjYiY/dbheMQEV5LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742175517; c=relaxed/simple;
	bh=o31w9oU/JcWbo5pw/in2Pte7yzbqHY94VsPfjnDZ2D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdr9X8B7Imvsd2FyNbbFfZjDJ6UiC4JDAXNr+Qjxir6hNyOd0LFXSEF7kXAVqtvepanAGBWDPWFZRmLEPnb/GQoBGvxRYUnSy/XCw08UWHTmuOTAO5zjfvrMWeuKfDPqxRv7ByqOxYK/9aUXxBCI3oSYW2n7XBiAEP+RHHcq8XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.128.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CToIjro7MZRLmutK1uzndxj8I6Vy/GLimLyl/tdeUMflxWYUDZ6/nRdbwhAdr8F30cG5P/oVb+Cv6DTzMu/zjsug0Oj54n7vZTE4wZlNC12UJMZ/g+Ek9/Ghx4rIsUYe8SHPR4kNDjWZnLl3BGyU0ia2bfVu7FBqPc+KQoZNllEtgxEXysGUmffPnm5lLWKIjcec8KxI5oSSLQ546CoRdlbkVtGNvLGDQVDxdLcOnZRhhSQrfeOcTMw+CriXzXr+nUIf4XftkoKmi/EQpXI5buVF3dALUCTAZ8QIOYw8eRrSPuF7YlZXwpoI7zq3SElR6zf5juF8bprUiIZYaT8syg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F70eKIVFAZbMHUo7AnV/k24onkogp5CmZmMfPzkmjvE=;
 b=OdScvwt2pZcNeN5LksMt1UzJbZkUuixGLeCxEpOFVIlelSXNxDl1Guri5lHRJxOWqJiMBi86sIUIl+di8955E+F4GehKKYITg517Na1zqxp1HyQV4T+ptuyVsucyfu4i6glNstn5v1jIVSq8viHBf085YBJlJElOhH+cphpTbFXthORZTMnAF5p1Q6DF3qbQVkvzEq/kKmYwtn58SOCMcnbvCTqZOlknao5ZvmzLd+CJTee+8OYza1b4dqku3+klKEGlCkk7h6IB6AdJAN9fc3zRqbSn4OuLkEN703F6IdAn3zCGbYEJoRhQLlfavJHQL/bMh72SzQi0QLEvHQDkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR06CA0234.apcprd06.prod.outlook.com (2603:1096:4:ac::18) by
 JH0PR06MB6438.apcprd06.prod.outlook.com (2603:1096:990:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 01:38:31 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:ac:cafe::b7) by SG2PR06CA0234.outlook.office365.com
 (2603:1096:4:ac::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.30 via Frontend Transport; Mon,
 17 Mar 2025 01:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 01:38:30 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A66AE4160CA0;
	Mon, 17 Mar 2025 09:38:29 +0800 (CST)
Date: Mon, 17 Mar 2025 09:38:23 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: <arnd@arndb.de>
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cix-kernel-upstream@cixtech.com>,
	<marcin@juszkiewicz.com.pl>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>
Subject: Re: [PATCH v4 0/6] arm64: Introduce CIX P1 (SKY1) SoC
Message-ID: <Z9d9D2X8V5A8Na3e@nchen-desktop>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
 <Z8-LpRCQfsVfDYtm@nchen-desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8-LpRCQfsVfDYtm@nchen-desktop>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|JH0PR06MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: e839b8b6-15b5-4bdd-9f61-08dd64f46c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l9Wsr0f0DwsmjIKfM4fO59FFhcNOWle+O9smsOzrfQjoPbgnV5Wx54pCKrCy?=
 =?us-ascii?Q?PU+nwnwRHmEh9S2VZhdNegvIqc27gBAolnD2V2R72y1317rQnEpucUH0QIEN?=
 =?us-ascii?Q?UPLqoPMp/qgyPENiAPIojdoMDlmovf7M9NOclU4P6afu+SAw6fpbUFrpj9g9?=
 =?us-ascii?Q?gHID7+b5lteyMaFciuzCIhn/CrNoan6kJkPyUXk4wD508ljHVNThmnt0E73E?=
 =?us-ascii?Q?jZFtIWvScTNQWi6YYM+Sql+Vp9CMjx5Fzf0ZDeSfo9BBCuNU80ESpId3cG0e?=
 =?us-ascii?Q?Y7myHbo3YVIqt8bBqWyZEmrvp84n8CPf7L5v0crIE9V30E9OOc73KwCVXBva?=
 =?us-ascii?Q?E9DXyjGEanwrAXQ3tW/C7ZwYuIgtvVOSEhACuUer6seiYJXpuW9UiXE/Wb+q?=
 =?us-ascii?Q?YH15O96ZKEN7k+CLlwJfX/ykbD3l57tWiM59yg10GRN9lkVQnQ2s3yTHpuxN?=
 =?us-ascii?Q?XdkiL0IfWeZSthvibndztFYXMT5cI+3dfdj3AOM2/qlKbHqrn/5IXPHUxEkp?=
 =?us-ascii?Q?I8RsjPjueZUtDDRmny2DxdY3VLJOQFS/HYYLmI3sH6tFgT1eai49AbgACyf+?=
 =?us-ascii?Q?4Py9uFTG2V3JJg4Y1HJtR65ArC7PeZYj5hsSMItCpnaopEBgDHgpg7c4Ip+W?=
 =?us-ascii?Q?CMHCr7EmWmJPVRHeByAc8vpuLGBxGvKn26eS9xJr8wZqmNjV/eh0R435DwFS?=
 =?us-ascii?Q?5tBIvcqmdOQSHE/4O0lr3Hyn/SoKJK/wfPZ3TbcDJ3X0Xk876xz8jt8AKx9d?=
 =?us-ascii?Q?ctSUeU8lAGscc+68Uoj8QFVZpSWIEO8gwISpXUmdzdgIKaijhNHrimR/l0dq?=
 =?us-ascii?Q?JETGOoBDI/Vgury/BlTlJGrsv5bjhjpLSYURRtRlNSlB+TJA+dkVk0cZBwwF?=
 =?us-ascii?Q?x0JkkGH0/7Zgwmb2aGun8da2yfOSB/fKYDaeBzpQfUIHitpS0FtDZCxDM/xG?=
 =?us-ascii?Q?9QqbzKnuQtcZYgpo9Rjjm4SgxtMnBAROfShjtHKhgMdAUtSIKsVL75yslipK?=
 =?us-ascii?Q?VUVE1Dk1NJLQyvYkcpVVl+nyetqvntZtEGn7/rQOi7IGsB6T5/9GhAGeT4AV?=
 =?us-ascii?Q?o21DYBIl41CKnuxn2o9J99ONlrOLq5magUp9/OU2xdzQKY8dDvMxVgl3oF5r?=
 =?us-ascii?Q?ueNSxEH8g4ytNrUTO+0qHVSdj9LzSTezj+LGC6VliGJpoCwdSuMuvEGfMW3s?=
 =?us-ascii?Q?hqSdWgfI0EEgtZvmsh2BgFh2yLuDeyMt8QLH+eXMWMOwyWv8liykNq8q1Rhs?=
 =?us-ascii?Q?sAsIojx7eyWWru/1jvszMTCgkC1rHBaUuLBwmyqsm0vXkWiT2iYvhEKzaUr0?=
 =?us-ascii?Q?ayrS3IJODASDY0bvc6JeoWKjb7OlNFClg2+EW6n63vyI53+UDHm74AZJ21ef?=
 =?us-ascii?Q?LTgn+NAemNMNUCCEARlWaskPdMn9UzhYbGu6W1VF5VgaeNxSYLCf6AOz9OaO?=
 =?us-ascii?Q?b8BlAMHCA54rGw1Is2QgQ0Y1D7CYp4/v?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 01:38:30.3675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e839b8b6-15b5-4bdd-9f61-08dd64f46c23
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6438

On 25-03-11 09:02:29, Peter Chen wrote:
> On 25-03-05 13:38:17, Peter Chen wrote:
> > Cixtech P1 (internal name sky1) is high performance generic Armv9 SoC.
> > Orion O6 is the world's first open source Arm V9 Motherboard built by
> > Radxa. You could find brief introduction for SoC and related boards at:
> > https://radxa.com/products/orion/o6#overview
> > 
> > In this series, we add initial SoC and board support for Kernel building.
> > Patch 1-2: Add dt-binding doc for CIX and its sky1 SoC
> > Patch 3: add related maintainers entry
> > Patch 4-5: add Arm64 build support
> > Patch 6: add initial dts support for SoC and Orion O6 board
> > 
> > To run upstream kernel at Orion O6 board, you need to use BIOS
> > released by Radxa:
> > https://docs.radxa.com/en/orion/o6/bios/install-bios
> > 
> > Changes for v4:
> > - Move add MAINTAINERS entry patch to the last, and add two dts files entry in it. 
> > - Add three Krzysztof Kozlowski's Reviewed-by Tags
> > - For sky1.dtsi, makes below changes:
> > 	- Add ppi-partition entry for gic-v3 node, and let pmu-a520 and pmu-a720's interrupt entry
> > 	get its handle
> > 	- Remove gic-v3's #redistributor-regions and redistributor-stride properties
> > 	- Change gic-v3's #interrupt-cells as 4, and change all interrupt specifiers accordingly
> > 	- Remove "arm,no-tick-in-suspend" for timer due to global counter is at always-on power domain
> > 	- Remove timer's clock frequency due to firmware has already set it
> 
> Hi Arnd,
> 
> I assume this series (all patches) will go your tree, right?
> 

A gentle ping, thanks.

Peter

> Peter
> 
> > 
> > Changes for v3:
> > - Patch 1: Add Krzysztof Kozlowski's Acked-by Tag
> > - Patch 2: Add Krzysztof Kozlowski's Reviewed-by Tag
> > - Patch 6: Fix two dts coding sytle issues
> > 
> > Changes for v2:
> > - Pass dts build check with below commands:
> > make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=vendor-prefixes.yaml
> > make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=arm/cix.yaml
> > make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb
> > - Re-order the patch set, and move vendor-perfixes to the 1st patch.
> > - Patch 4: Ordered Kconfig config entry by alpha-numerically
> > - Patch 5: Corrects the Ack tag's name
> > - Patch 6: see below.
> > 1) Corrects the SoF tag's name
> > 2) Fix several coding sytle issues
> > 3) move linux,cma node to dts file
> > 4) delete memory node, memory size is passed by firmware
> > 5) delete uart2 node which will be added in future patches
> > 6) Improve for pmu and cpu node to stands for more specific cpu model
> > 7) Improve the timer node and add hypervisor virtual timer irq
> > 
> > Fugang Duan (1):
> >   arm64: Kconfig: add ARCH_CIX for cix silicons
> > 
> > Peter Chen (5):
> >   dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
> >   dt-bindings: arm: add CIX P1 (SKY1) SoC
> >   arm64: defconfig: Enable CIX SoC
> >   arm64: dts: cix: add initial CIX P1(SKY1) dts support
> >   MAINTAINERS: Add CIX SoC maintainer entry
> > 
> >  .../devicetree/bindings/arm/cix.yaml          |  26 ++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >  MAINTAINERS                                   |  10 +
> >  arch/arm64/Kconfig.platforms                  |   6 +
> >  arch/arm64/boot/dts/Makefile                  |   1 +
> >  arch/arm64/boot/dts/cix/Makefile              |   2 +
> >  arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  26 ++
> >  arch/arm64/boot/dts/cix/sky1.dtsi             | 222 ++++++++++++++++++
> >  arch/arm64/configs/defconfig                  |   1 +
> >  9 files changed, 296 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/cix.yaml
> >  create mode 100644 arch/arm64/boot/dts/cix/Makefile
> >  create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> >  create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi
> > 
> > -- 
> > 2.25.1
> > 
> 
> -- 
> 
> Best regards,
> Peter

-- 

Best regards,
Peter

