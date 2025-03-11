Return-Path: <linux-kernel+bounces-555316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C176DA5B594
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B9616E1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDA413C3C2;
	Tue, 11 Mar 2025 01:02:46 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023121.outbound.protection.outlook.com [40.107.44.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9308821;
	Tue, 11 Mar 2025 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654966; cv=fail; b=db3cWfMUjs6qnN1jUqi95eswbxk8cYABTfsBIEKlBum0+kK8S/ik5aZx8cHcIfidui4e5YhxQLH6zUGkKfgVqv4DbLQ5cYz981CPhZA7zES3uMek/HvxoGEI3Q1xY/oZWKilCop9ZWqGSfcY+bf6guh6Bg+MLx6jWdorKHw+NuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654966; c=relaxed/simple;
	bh=Di2RJ96LS6OA2MUNE4ZL9AfDpjlm/nqGn+FL9GHqERI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0xCBZMl3X/744UbCYp95s3/Z0mYlmtqbNBKJNl+lg4tHRzOKWnZYAWU3MnARNUvk3/DEcQMAQ8alZWC4lx+AY8VDiMcORiZ8uy7HIlSRR27Jga1WuNy9tuZII8LNUdQshNRgivgkhvlEqRYh3DP/krqiUcDc4ZsrnGNQbI0UPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJ1ee7fmglIHwrjDoR7y+orP9yJoLgE8yiKhKbDOj1xQgbdiS78DENTbFyIT/qTEeTGtu3ZidSSa/pWiiJ8Tz1gD8f6IDUZ7TlOWYMb0WRtS7iDV1uWZ3R9oo07JF5DXNpvs07OCajyu7ZLOOzG1WgjPSOJAWga982AKLXy7zGXJGXeU/DeoH/9EfoxEggy1jAUABwuZ/g8f/78TTuAWqkJrOvIRmBtxhDeuKZwniHdkC95uunPzP4YwsdTtuT802C/q18FdeZV0hHN50eq4kWNJPrH/Mw5B03H9JllCZASO9edBstbkF0XL/ECzoDfjr/I8wJ4Lw1bYG5wYdQm/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K45Su070n7Z9TOqojxH/BrBPM94FqhQu0rzoSdVVebU=;
 b=X6N2H+44AGJmeKa7LPC2pgWWosodMQuhYogsXg1UR27jdCpFcH8yBQf4Q0A1Z4BzNQvuBCj8x/mZLIDE1fNBIXHDswhIwAm8FU9JQIMeTjLmM1aoG1LfXe1TXlheiVo2TO3Cmw6GArIt0YGIn3EzcL0ytYjTQPSRSnrT0Ve9sOb2xVmnJnfdbjWUaeGNIaWWTJAZVN+0SVP6JofxuRS32DSyppzG47iKV/I5jhEpnveSBrgycc0C3V7KN6vko8HI8PHMsMXwT3kyQTnSlhCZ84SZ2DZRnAnLFn8ljfhjOgepe1q9ffjo90EgUDs14LJeVmVVLeioe98TLd3ydVPXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::14) by
 TYZPR06MB5710.apcprd06.prod.outlook.com (2603:1096:400:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 01:02:36 +0000
Received: from HK2PEPF00006FAE.apcprd02.prod.outlook.com
 (2603:1096:4:190:cafe::5a) by SI2P153CA0035.outlook.office365.com
 (2603:1096:4:190::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.5 via Frontend Transport; Tue,
 11 Mar 2025 01:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FAE.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 01:02:35 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9F4FE41604E7;
	Tue, 11 Mar 2025 09:02:34 +0800 (CST)
Date: Tue, 11 Mar 2025 09:02:29 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: <arnd@arndb.de>
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cix-kernel-upstream@cixtech.com>,
	<marcin@juszkiewicz.com.pl>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>
Subject: Re: [PATCH v4 0/6] arm64: Introduce CIX P1 (SKY1) SoC
Message-ID: <Z8-LpRCQfsVfDYtm@nchen-desktop>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305053823.2048217-1-peter.chen@cixtech.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAE:EE_|TYZPR06MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: b78e995f-36a1-4dde-e262-08dd60386964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XqVCn9Jn6afFVbMoMW9+QjR0w7QaOBH//NcVd6B1/hdEUqYIvUcBTg8qNy/j?=
 =?us-ascii?Q?05YL/cHD46KA75+OjngPhP8XcYp/mw+YqbuMc/puoDWTHj4+DstOC3MNTIxP?=
 =?us-ascii?Q?7YZ2jAeq9Bk2qWi1VtULBGGQX/yBKf+CXrrkDTsInTs//dXn5/OlCfls4+dX?=
 =?us-ascii?Q?49oh3uQp4//7dAsWN92Wq8WEyuy2tQPHSDBm8to1gjjbiWHWATVDLEoJ4HiB?=
 =?us-ascii?Q?T1jFZsmElUA5uCYDeXx8FA7fwKbV6OwEminyMrgu6bnh45axh/u4o5KVXPNI?=
 =?us-ascii?Q?YoLqFYUbfcFUk5LDfdnrn/FcLEMWthH5KhM4Ifc7AVW8zIU4Ua0sLj9oHOcl?=
 =?us-ascii?Q?kpp2D5i8amEqph5JOEit4/2fBoli5AbJ87G6qRdE+TQfVWdiE06kkCa68G6q?=
 =?us-ascii?Q?MJzZBhpKeAbbxZD5DkyzwWXG75z+rIUTulofwhvrrwbzp+jWxlmKGhhKXacX?=
 =?us-ascii?Q?JagaIhULSrly6V8C7MusprOn1SIOE8Otl2U3IUq2L5G5GPvgP3fTij2hD/Bo?=
 =?us-ascii?Q?kqPFaSaG5gzZeHfXXpWECXzzKNaKGfOswOROU0DXUKC9yJYCnN0UD9X55MvK?=
 =?us-ascii?Q?J6X4xSYYjed2fye0T/EumYbVI8f/MNAQc3WyhdfBDrSvL2FP4ztD4nS5VV62?=
 =?us-ascii?Q?lskDvBAVnM1Rhwe0lM8qFYl9G34mPDHg106x1NgFTzeuowGEP4Xc0Qq+q8k0?=
 =?us-ascii?Q?OzCsTcN0JVNAGvc/Xobi2m6i3oyJUMLrFn0SsFSXwBxbA6piBBfa1kDXtKaH?=
 =?us-ascii?Q?WzX0PGOc+r0rGXTnK05V10XCvFIBpUqiH2p9IRQk+RZuHE54Pi2QxKJrsza5?=
 =?us-ascii?Q?jdHyxQx1XFaXKR6eX9nT4jhJy3JOwNy0s6dRhW8u6i2scjN0pmaZSPGBjU9e?=
 =?us-ascii?Q?vA5j0BBImSR+6c8JN+6xUXvRNBM3QvPfZMCj5n65UT8TgB7INElnw5fe4pAW?=
 =?us-ascii?Q?uQkyWIuHdZs9+LSTR/WAYX/wphLnYiwIZOjfFyUSolC7JiVQBext99cwwVh1?=
 =?us-ascii?Q?m+gsBUd7svAPvlg6EY8SX++UMYp8gwiDPkjbG085maxTy88Cxr4PaA2f3F5c?=
 =?us-ascii?Q?6i5byTX0NteEf0g19/4u9Iz/affJSkoRlhk4mg7OAnWnX2/3gjs7hZ439Icu?=
 =?us-ascii?Q?46ltC9EPkI8lvEEZH7S+8xwAUfYmJqsMlXM1fO7TW1w/38WXUm4VfVUpY+Bv?=
 =?us-ascii?Q?qbxoJeu/bnmFCML8pTQXDOHHgkgFwz6qEfTeoGO/DQPKVxc300Np/ZBoF1DB?=
 =?us-ascii?Q?Ty/fBG3re57Fom8XpFE0oorhxHFetYUORHXaoupAtVyBHfiFKx2o9HyN6pvL?=
 =?us-ascii?Q?73AZHJMlWsGBrBOlD4O7nLnr9gvCKaOU5ECh+yV7kRcJHR037TWoXlWgw4/s?=
 =?us-ascii?Q?oIkQ3z1+lwNi0HLslEp1xbyDNe8H2wsH3KLSuWpgQGvTq01DIvN0rSKIFjHK?=
 =?us-ascii?Q?/TmbP72Vg5XDmclqdarOPx49TmMPny7R?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 01:02:35.6632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78e995f-36a1-4dde-e262-08dd60386964
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAE.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5710

On 25-03-05 13:38:17, Peter Chen wrote:
> Cixtech P1 (internal name sky1) is high performance generic Armv9 SoC.
> Orion O6 is the world's first open source Arm V9 Motherboard built by
> Radxa. You could find brief introduction for SoC and related boards at:
> https://radxa.com/products/orion/o6#overview
> 
> In this series, we add initial SoC and board support for Kernel building.
> Patch 1-2: Add dt-binding doc for CIX and its sky1 SoC
> Patch 3: add related maintainers entry
> Patch 4-5: add Arm64 build support
> Patch 6: add initial dts support for SoC and Orion O6 board
> 
> To run upstream kernel at Orion O6 board, you need to use BIOS
> released by Radxa:
> https://docs.radxa.com/en/orion/o6/bios/install-bios
> 
> Changes for v4:
> - Move add MAINTAINERS entry patch to the last, and add two dts files entry in it. 
> - Add three Krzysztof Kozlowski's Reviewed-by Tags
> - For sky1.dtsi, makes below changes:
> 	- Add ppi-partition entry for gic-v3 node, and let pmu-a520 and pmu-a720's interrupt entry
> 	get its handle
> 	- Remove gic-v3's #redistributor-regions and redistributor-stride properties
> 	- Change gic-v3's #interrupt-cells as 4, and change all interrupt specifiers accordingly
> 	- Remove "arm,no-tick-in-suspend" for timer due to global counter is at always-on power domain
> 	- Remove timer's clock frequency due to firmware has already set it

Hi Arnd,

I assume this series (all patches) will go your tree, right?

Peter

> 
> Changes for v3:
> - Patch 1: Add Krzysztof Kozlowski's Acked-by Tag
> - Patch 2: Add Krzysztof Kozlowski's Reviewed-by Tag
> - Patch 6: Fix two dts coding sytle issues
> 
> Changes for v2:
> - Pass dts build check with below commands:
> make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=vendor-prefixes.yaml
> make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=arm/cix.yaml
> make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb
> - Re-order the patch set, and move vendor-perfixes to the 1st patch.
> - Patch 4: Ordered Kconfig config entry by alpha-numerically
> - Patch 5: Corrects the Ack tag's name
> - Patch 6: see below.
> 1) Corrects the SoF tag's name
> 2) Fix several coding sytle issues
> 3) move linux,cma node to dts file
> 4) delete memory node, memory size is passed by firmware
> 5) delete uart2 node which will be added in future patches
> 6) Improve for pmu and cpu node to stands for more specific cpu model
> 7) Improve the timer node and add hypervisor virtual timer irq
> 
> Fugang Duan (1):
>   arm64: Kconfig: add ARCH_CIX for cix silicons
> 
> Peter Chen (5):
>   dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
>   dt-bindings: arm: add CIX P1 (SKY1) SoC
>   arm64: defconfig: Enable CIX SoC
>   arm64: dts: cix: add initial CIX P1(SKY1) dts support
>   MAINTAINERS: Add CIX SoC maintainer entry
> 
>  .../devicetree/bindings/arm/cix.yaml          |  26 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |  10 +
>  arch/arm64/Kconfig.platforms                  |   6 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/cix/Makefile              |   2 +
>  arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  26 ++
>  arch/arm64/boot/dts/cix/sky1.dtsi             | 222 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  9 files changed, 296 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cix.yaml
>  create mode 100644 arch/arm64/boot/dts/cix/Makefile
>  create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>  create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi
> 
> -- 
> 2.25.1
> 

-- 

Best regards,
Peter

