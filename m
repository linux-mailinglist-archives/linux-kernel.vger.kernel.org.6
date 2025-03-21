Return-Path: <linux-kernel+bounces-571076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509EA6B8CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E8C19C5153
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2FF1FC7D9;
	Fri, 21 Mar 2025 10:32:11 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB578F5B;
	Fri, 21 Mar 2025 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553130; cv=fail; b=Ox+umyDZLELlwUJzG8TlfhdNUdhpXnmj3crgaABKhiS1NztdQeh2HejxZPt5+FrHOnDSKKy1jCfWHnvjRobVY0XpRlW1WfpvyoT7iyCRyOhM7imjcjM/SuAODtSp/E2vthSfVl7gKkx6/A6ay3tASfK80JW7G7wKC8Xecblzl4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553130; c=relaxed/simple;
	bh=LenNnK5QC+/ooz3QxvZw2OsYRWohlW8QzpKDEC8YJCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xm7pmXX1RJJOVQZAiI02uDOMvrIFdALOz0po/FNsqE5oxr79aKnT0bE0A8Q/N95nSDmnjeSajHxk1YgKnPPGn8FXYAeoB9GKJGlcygzQ2cdXjF/5kEwyyr/UG9GvQ8AWPJyMBxS32E1I5FlSllws9L34ZEd+pCtoNhCDMNvi/B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOx4OBIeQ1I8BK3adF3d2SDS5ip3zK/mCf8WEHnaB+9A8N2rnXNBB8yEhGO0nRNByoV9rdEpIXY3UhBGpc8Udp/xQJarB6XkSSf6U/6eWqIhAcUAlohGUE5QySAXd6iz04N88FsDRXtZkMANfeWgre9eNE/ObX9oewv0Cio+IOt5p3ODLvD4x7QPLr2iR0QM2vwmI/tQt4lKsNhIKnkahqtHXCo9zakKc7dM7AroVsGYGCKN/u60WlFcTx+KkegvpvaBzK8ibGOjVyduE0fGvhyzDAV0ViPsRmqpiGsXbkGf7ct+Rh6HCwYUJNhZzWYq2mfkdZiLpFe/gMfUqjl6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRZ+XSjQ/3l77gzAWIABboWpdWXlzKhZWMQiOVr6X2o=;
 b=LXi4WD3XNiCnnsoRuPANFXjO/OASAEL9+Q4f6fkedm1ZpQzaxlIPWYdUIhV5LPRJwSLMxO/IZNWu820QGjmZK4lkia3A1lgK0Ildmg/ynuhH2v5My2YNpDDnG0NvS77yufE/YMw5n4M7kR9/s7z5dQDNq+AkZB3tNoD1VqGRC+UbaTJr5FSx8GVJrtFRMkVE3c/NPdyRROOf5hiJFREGV549X21WGZj7O8DT+lG3m2z23HND/Z9O31DEwJ10gd8UtPu5h2WHRBkZEsOrTtZ11fFhY+bm2wJH84ba52d6BGWJMCY8osLw++SFW3iUc5SBcM8sUWqYhtFqG0r404BgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:4:186::19)
 by TYSPR06MB6361.apcprd06.prod.outlook.com (2603:1096:400:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 10:32:02 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:186:cafe::c3) by SI2PR06CA0006.outlook.office365.com
 (2603:1096:4:186::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 10:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 10:32:01 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 66FCF4160CA2;
	Fri, 21 Mar 2025 18:32:00 +0800 (CST)
Date: Fri, 21 Mar 2025 18:31:55 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Marc Zyngier <maz@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v4 5/6] arm64: dts: cix: add initial CIX P1(SKY1) dts
 support
Message-ID: <Z91AG0lH1JNN7NHq@nchen-desktop>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
 <20250305053823.2048217-6-peter.chen@cixtech.com>
 <86frj8m4be.wl-maz@kernel.org>
 <Z9vmeTj68LmwinPD@nchen-desktop>
 <86bjtun4an.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bjtun4an.wl-maz@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|TYSPR06MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d733ee3-3e14-45c1-a9e9-08dd68639db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HzjbeHE+DvtnOWAClnRLrKqGY2d+jgvnME/FU9irD7Arf4Pgz+jQuQKiVNeb?=
 =?us-ascii?Q?HQdLTkC7M6A6a8Ot95d3iJ/xuEKJbpeIQTkUPFyROGDIr6RZlgfbEvIA4/Oc?=
 =?us-ascii?Q?VyXFXHNebkceR5RIttiYWQW3qrRueUZ+EHdp+je5R/rShNGakQCxpstNM92L?=
 =?us-ascii?Q?2q+LP1Xeo2sqdN3Azdg67wg6qv352AoYk7/9YtnydEcTXXicqVpkkQD5/lJr?=
 =?us-ascii?Q?uYObdhxOcNNr/8EgrHbLv6SVzOTfcpXeFUAV0svL3mu+Ngea1aKImoKoXvtK?=
 =?us-ascii?Q?5UDMg3auWLxczSMNj0iXW/uHu1bQfTwC1ibsG136qNMGTxKfhqrGczxcnCKd?=
 =?us-ascii?Q?xtcQbmy0nxe3anoKk1ZEgWqv0h8fae+mhoIi6mhoCC8fNOMfj7nj+INGBGoq?=
 =?us-ascii?Q?cjD9mM8btXob6Nsk2wZYdwbvBSd7XI4z+nyFQzyJbCCvRXJnBveOU/7oZCtj?=
 =?us-ascii?Q?OEUk6+yLF9pgb2C9sG7xk7UdCqoYjuZXRlccNi7qk0P9to98izadFI0CWTnV?=
 =?us-ascii?Q?CcQHEx60RmoIFo9WFr9VompkLwMXWqJKgmNq5i32hgmqpuDFJjjH0uZESu6Q?=
 =?us-ascii?Q?D1A9ewHjyk5WTSA0st6qGsvqHLa+aYXxbZueDQjRnxUt17N2jtO6eeUzn4tn?=
 =?us-ascii?Q?sw72TsS+JIe4JGPP6Tc0N3aCAvxxYHZHbmShocnSY3sgnBqnJYnx7t4HL5Od?=
 =?us-ascii?Q?aMmbANLcBej3OeyYbFTW722ldvMIgzAVyMT0vknaeedE+6zb4hEHs/3HOuxf?=
 =?us-ascii?Q?X1pxgZpZHONHbHuYHLB/OTbonKl5qqsiEIUdO1KpMdcO/0+sw1VmO7mA8SK0?=
 =?us-ascii?Q?BNQ/WN9xQhxaP8/mvtKBk+u62Bfnuuq4Tb5sOQ4DUT16XK7klC3wP5+u3yB8?=
 =?us-ascii?Q?cWTPI4eJQFVEqs9bd5BdQsB1g3yhrMsBF2l0A8SR7BlOtzk1S7nyK0bXlXOb?=
 =?us-ascii?Q?AychQdF6Wg0ivW5Al2fxpeVcv+2zAFq8+/YaQS92sKkp1qdJJvL4onTrac1i?=
 =?us-ascii?Q?KbM5QK/nwBk2qpwRiVmsSjHP5OhfrHeOUY1KY+0tkG1wSD70e0/HFVwcYDnA?=
 =?us-ascii?Q?Wm743bxawiSt+nqaDl8CVnQqj2A5365I/3TjCHsV3ObEPc8oz2r9cQd4adTl?=
 =?us-ascii?Q?szGjH4fBX/Wm5TGaK0/lvktXvuIjKf5TV3oCrYYYqFQpmqCPs5MiBlFBO3hr?=
 =?us-ascii?Q?be4kVuBMEmG+X7z+1z3cvXF63LYUsmrHHR85n+aqIEFWVl/jleEycOdGSzSC?=
 =?us-ascii?Q?TnYnxfiaTHse8036k88zZsZVuJCJwPz9rQeh1nyNWuq48JaYoBoZHLiM5u2f?=
 =?us-ascii?Q?dzFowVzq/e+07A/91GPnl7dhfvdtylfH9YOBouT22XU8NqGbE4zfxp0rcupk?=
 =?us-ascii?Q?hIBcKD71lzM9hNkSKI2Re7T208HYcodeReRnQWxZTEOR2FYFVfllgdei05mO?=
 =?us-ascii?Q?5G0HqIixEAStcDtlk2fckq6fh1YeN/hpUckp1+C5SzYPjTkmrAdL7Yb13lC0?=
 =?us-ascii?Q?esIZy192tXYd/bc=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:32:01.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d733ee3-3e14-45c1-a9e9-08dd68639db2
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6361

On 25-03-21 09:04:00, Marc Zyngier wrote:
> > On 25-03-20 09:36:37, Marc Zyngier wrote:
> > > Peter Chen <peter.chen@cixtech.com> wrote:
> > > >
> > > > +     pmu-a520 {
> > > > +             compatible = "arm,cortex-a520-pmu";
> > > > +             interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_partition0>;
> > > > +     };
> > > > +
> > > > +     pmu-a720 {
> > > > +             compatible = "arm,cortex-a720-pmu";
> > > > +             interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_partition1>;
> > > > +     };
> > > > +
> > > > +     pmu-spe {
> > > > +             compatible = "arm,statistical-profiling-extension-v1";
> > > > +             interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW 0>;
> > > > +     };
> > >
> > > SPE should follow the same model as the PMU, as each CPU has its own
> > > SPE implementation, exposing different micro-architectural details.
> > >
> >
> > Hi Marc,
> >
> > Thanks for your reply. But there is only one compatible string
> > "statistical-profiling-extension-v1" at drivers/perf/arm_spe_pmu.c,
> > how could differentiate pmu-spe-a720 and pmu-spe-a520, do I need
> > to change arm_spe_pmu.c as well?
> 
> I don't think there is a need to have different compatible. The driver
> can probe which CPU this is on, and work out the implemented
> subfeatures from the PMSIDR_EL1 register. New compatible strings are
> better avoided when there is a way to probe/discover the HW (and in
> most cases, there is).
> 
> Note that this equally applies to TRBE, which also explicitly deals
> with interrupt partitioning and yet only has a single compatible.
> Please consider adding TRBE support when you repost this series.
> 

Hi Marc,

Thanks for your comment, we need to discuss it internally. Since it
is very initial dts support for CIX sky1 SoC, I will delete pmu-spe
support at this time, and add better support for it when adding
more components next time.

-- 

Best regards,
Peter

