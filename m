Return-Path: <linux-kernel+bounces-570620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E25A6B2B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A814A0D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC721DF965;
	Fri, 21 Mar 2025 01:40:16 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2094.outbound.protection.outlook.com [40.107.215.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455B1DED40;
	Fri, 21 Mar 2025 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521215; cv=fail; b=lEom1njeK5Lu4rkZHnR7E0pEewrxPJ/5o87BRfD1D35J9yxlo2cDbhuALbL+3dGyR/7WDXpggFFzI1MUdg38oU79zEHlKL2xb0nq9b/WUWjb64gKKcDvZQlmxCJeomK6U9OOgjVfQci6cbH9nKFM2TYReLu4pSpePDU9vcxOU6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521215; c=relaxed/simple;
	bh=KuA7Q4LVhuVKXu4KqZUIMhRsDSU+aEVfzBvosflmF0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ2Zab845BlPwF0bXkU4CUnAdUImfl+ynn09gCjS6WUM25jdG4EG4uD4uF1qowJFBr9MRmJyy2jnzpkgvWVz7FeaQiIn6RE3ix4J43L8ewucNLf2aCOF3ceiEakf8zEgcOEHB/K+S+wYzngEYh+m4oLubiae4syK4riCstcBTE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXvoKfP2LoyPqfbE/f7Qy+4rDnYaduI+obOc3cTa7uqlaxusgg9qdsSaB5rYynE8wx4Qwo/81b83XX/ppcMEpqtLYGd97PQUDVkycrD5yzPyQVNo2rszMJkTH9chg4cGCbu0HE4UATWiC/mbE1ygNu7xm/LLxrD19bJxQ6qYNksvv7Hl7BNlx2GnsG0EdukeiOpNYk2fZG+Q1HiSGvp0lPxBE1F2YuvEQ2CjoFRqCUP+oNVwg+5XHlXrJtjbSY1cCyuK7OeSL7pBTndri6vDXEWRPwANwn0KC65kWCYe+I2/GPSw3n4CZEqhI7qi607krTCNRF5kI5oJSe0dASp9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfONhRl9345mCoz2uzNlqfXAYwqJdwHiegxkU3p1npg=;
 b=l1ihq3JS98+xqkiWKkYWRgwFfA+bwQXFLTghE6Rxmq3N4mQzfhj8bgUPk2cwAGylTbaA6mDRPQxXUfrZSZLuX7yHikFpAQTMJ/Fs/JMbFzxTgzYPiCiQ5VHfnYqU8enM7i1xYt5FJlZAmMVUqi4+MnjmC48dPi0H6UvGVS2XLXZke6eHOruGO5wcmPCIxOX0FfqiEECfqC+EdstwMIGJS19s7ik6Ep6H+ul6g69vmx45YiTp0yU3BJAeLGomSOgrLiUBnQsQptZSAJ3nP21l0Bti3Fsv3mBtxq1Ff55OGeYwp/kIT2bm6wyRr9/9Va2EH3J+Qy2AgKccLBsOatqp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) by SEZPR06MB6350.apcprd06.prod.outlook.com
 (2603:1096:101:133::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 01:40:08 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::64) by SI2PR01CA0039.outlook.office365.com
 (2603:1096:4:193::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 01:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 01:40:07 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8C2DA4160CAB;
	Fri, 21 Mar 2025 09:40:05 +0800 (CST)
Date: Fri, 21 Mar 2025 09:40:00 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Kajetan Puchalski <kajetan.puchalski@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cix-kernel-upstream@cixtech.com>, <marcin@juszkiewicz.com.pl>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v4 6/6] MAINTAINERS: Add CIX SoC maintainer entry
Message-ID: <Z9zDcMRVqAcJW8H7@nchen-desktop>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
 <20250305053823.2048217-7-peter.chen@cixtech.com>
 <7419360a-abc0-44cf-8d55-8f5fad8e9079@kernel.org>
 <Z9vyy7f5NOPyzUES@nchen-desktop>
 <zsmeh4ukuspyetowryqi3blcquxlua5wzy5ibgy7lupryr5txx@74ic6drtremv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zsmeh4ukuspyetowryqi3blcquxlua5wzy5ibgy7lupryr5txx@74ic6drtremv>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEZPR06MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: f623761c-c481-4a90-338f-08dd68194f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7aRcFhbSjQnYAC/a1TARIu1YRnLz8P9G8NibTldr96ZwEMF+fANqmd+Lfkgx?=
 =?us-ascii?Q?axctD4v8ibzB9LDScnX0SypB+ZrMNxhvyazJGZRcTB+RmYNzLl+5nYJV3FK1?=
 =?us-ascii?Q?7nvLtFFR68B+PCH41oWA5psbmInIZOGnatC6Jm1P+1LFg4yunVw2CcSi8FQi?=
 =?us-ascii?Q?Rm0AU14CM3QhMFLVKgef4x33c4NVrnl0IGDMGscvbxGSfKKS7o6rY56KB92R?=
 =?us-ascii?Q?Enax1HXjYQqRFGaZvVc18/EQmfNcOIFpfhbCMJ4hv4NSzeZz1m+lcj+M1B/R?=
 =?us-ascii?Q?fGP/n6JTIyUMs8jRmvEQlrJu4ITBhHp0o9KwkeyzbWFtzA/owIGkhUtBphyy?=
 =?us-ascii?Q?q/sNDUJpqg4tzErsnMOclTwMVCaJOP4WF7NtWg5aGXB6IrDa068qOhhrOzMR?=
 =?us-ascii?Q?zl/vgeH9o3aeiWc6k12XKoTS6FfMhXfk1PRSRsiJGK4MsRh2OekhLQl6CbU9?=
 =?us-ascii?Q?FIQc9vnbXVW0jmBMFbD1pXoBcSt4AE+IzHVFL7ThXz+a/JpYnSy94OZKD+5T?=
 =?us-ascii?Q?9u/4AN56BusFu/sQ7AaWt/2swiOD4Xi20jkEl5aceBuU52AotVRe222Daorr?=
 =?us-ascii?Q?1HxX2FEUyLJdIyURDRpkNkI8SLzwr1zTRZiOEclrofqH05HGoDKvX+V3eQoa?=
 =?us-ascii?Q?CWK4MCPm/VpAxi32bHNLjQ5vtYfJS7oux+vGvnC2ncn+UX2nxsELXifTiZzp?=
 =?us-ascii?Q?Tb9fZ9fAfRbfk4phX24dwn3mGaoIQWm7ShwKiHBczcVTDP/OgSEmjZr504Ze?=
 =?us-ascii?Q?EkHdQy8BSgrQZfwH5jgusoJigmfRGwKBZ4D6Gafa2ovH8FS5a6qzrygLAJ6s?=
 =?us-ascii?Q?jO6vouFksq/RCb1FP4DE8gkLhiEG0XWJberccet3x5jkx80g0bAL/FY1iR59?=
 =?us-ascii?Q?mBBrhkgXShmh+S/TRqbySO/yVY6nwNALROBL90kgHoYZBD99mnIx3yf4YFeD?=
 =?us-ascii?Q?2reF3HuqYSX017YmPxkwdfDUwx97B+HoX/rty85jv72T4NPwDBAtehHtFEfP?=
 =?us-ascii?Q?afeQEjf29zMroFrfaeKyEw8o1sqWUTnMyD0oaXlFG3Y9G9nmXH+/4bDY3DFE?=
 =?us-ascii?Q?qcy4zDMx4+vrFe68aYrWqlAAmTMBEC5ZSoEh9tMpsRld+dTPqWtvqOKeqiHb?=
 =?us-ascii?Q?EPoyuzANvPaRVGQXXg/Cq6OYkR1ACwizQrKKM6zl1mhEexQGJ88nstr8W59x?=
 =?us-ascii?Q?xTxkHMzO3PsCKjo9U1SHJt6hmuW8lGO8r0SOIDE/94KnJ4zTe4yvGkbdbveQ?=
 =?us-ascii?Q?0Lj1QEGuABACoPeOagxDoRTUJButJKjN0uBDYuJQlf3nv729A36ZP0dC2OFw?=
 =?us-ascii?Q?U7rKl+yOSbCA5d2u7idA5Jgu2wFN/LJN+cD9leB+Rz70p4RvNt1H4fnDHBsY?=
 =?us-ascii?Q?fd1FXA19es1xOvQequD7pfDI6exzK9X179ftvC7fhMT0/FVbHd2nu49kUi0K?=
 =?us-ascii?Q?uHuHnzYB2jk1uXXj1dfiIMr64iFyb/EaR/aTb5Vjde0wHn701Vdv8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 01:40:07.2687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f623761c-c481-4a90-338f-08dd68194f8a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6350

On 25-03-20 15:28:49, Kajetan Puchalski wrote:
> 
> > > > +ARM/CIX SKY ARM ARCHITECTURE
> > > > +M:   Peter Chen <peter.chen@cixtech.com>
> > > > +M:   Fugang Duan <fugang.duan@cixtech.com>
> > > > +R:   CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
> > > > +L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > > +S:   Maintained
> > > > +F:   Documentation/devicetree/bindings/arm/cix.yaml
> > > > +F:   arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> > > > +F:   arch/arm64/boot/dts/cix/sky1.dtsi
> > >
> > > Instead:
> > > arch/arm64/boot/dts/cix/
> > >
> > > or if you think there will be more different architectures coming from
> > > cix, which you will not maintain, then useful would be a "sky" subdirectory.
> > >
> > Hi Krzysztof,
> >
> > Thanks for your comment, CIX is Arm SoC based silicon design
> > company, we may have different SoC style for middle end in future.
> > So, for that SoC series, it may not name sky.
> 
> I believe the idea is that the file should either say
> 
> +F:   arch/arm64/boot/dts/cix/
> 
> if the two of you intend to be maintainers for everything under cix/.
> You don't need to list every specific file.
> 
> Otherwise it should say
> 
> +F:   arch/arm64/boot/dts/cix/sky/
> 
> with its own subdirectory if you only intend to be maintaining the sky family.

Hi Kajetan & Krzysztof,

Thanks for your valuable comments. We prefer maintain the entire
CIX architecture under one entry, I will change maintain information
like below:

ARM/CIX SOC SUPPORT
M:	Peter Chen <peter.chen@cixtech.com>
M:	Fugang Duan <fugang.duan@cixtech.com>
R:	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:	Maintained
F:	Documentation/devicetree/bindings/arm/cix.yaml
F:	arch/arm64/boot/dts/cix/

-- 

Best regards,
Peter

