Return-Path: <linux-kernel+bounces-569443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47DA6A30C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FC87B020D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98102222DE;
	Thu, 20 Mar 2025 09:57:26 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2115.outbound.protection.outlook.com [40.107.215.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D064A1D;
	Thu, 20 Mar 2025 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742464646; cv=fail; b=jwW4R0F8wtuXfbOrksJgLGWu2lgq4kgFhZLIrIGej6ABLkYLbxc6p1CxJw0JzCZNzQCb7NQAzUw2aVIHClQEyv1LkU6m7iG76Yzcow3JVBue5Xnv9M1cqvL4rNFVml+tERkCLWxRChJK/OwtcGrRLi3xcGFOi0l4o8eI50Qx8/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742464646; c=relaxed/simple;
	bh=d7UkPpeLn5Zm/sKj3abFB8LUSCw/4v6JECT+quVxliM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERxfIl++3B0L7WnYN5U4Td0geSrdVQNpgzi37y9e54mEqzfdI9BVbCVC0o+j0jEUQwYGqCKWX03/yr+xCf1uAw3fkfXLHeZ8ZGxPCkbIlWHND3bTzuOkH+/hVK7Sh6sRw8dxTfu1tQ/lkPqhdgGUWnp28/twXTTMIqr2xJ76U8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbsOApPpn7GHhEClZHIr1V+0SXIyQVVuV+e5ovPxL9fZDdovkmrDiSJYaz+dPP7x3QDPKNKXEPTXTfz+eZFfAXWAdSnFQzgDpOAHNrNZCrRapPH4jeIMeMwY9sOoL0D64ViYJFxgpzpHOwCIZymQTVQGKLvbiJZmESC7DTKpznDuo0xHYg3CMsTQOyUP3tf4PDFWJsdjPm6H0KbW2rxRPS2PtNEnc6TT3/B9wDOKbN9ZGAan73XASCG2l2hjYM9sWhA+NOjHsPsEzc7dseRGOIzUNtBeLP+SJMqvUGfEjiLImQAWOzAPA+ixnPSeQswXRFncHZY6kc4zyyZEVwz/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5kr2Tm0tZxd98Gq5KQ3KxEI/Hx3p+OotGqMxIH1g5I=;
 b=vCRpo3nr/nw6K2UwOs4jjvp1c7Sr8jS/2Z4MjsLge7YZjP9WhbaGSrJgTgfb/2rLE8H3EVSyT9TH0Ai7kdY78HzT4TxhigmgDXEWYLm0U6lB2kOffwB0HMkydEuvEqzrkPjebAkh/efL+eORo2Q4/tGXEEgUBBc0pyplrikzZ3/28MRTvWqGjjLaGjDDgxpyJSoVnM0bVl6UyrU2CzP/PTUFER1jluR+7bAkrZSQIaZ3naR7YZgQ4LSB74JGaKxWfTuiTXLwW7Ygpsxlmxz0ilkVVrrAPL3gL8Uf5YRNvOC9LDt5OkqWcaxwnTCMjxOG+aNjgFeRf3dBcLt2MA/CGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22) by
 KL1PR0601MB5727.apcprd06.prod.outlook.com (2603:1096:820:b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 20 Mar
 2025 09:57:19 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:b0:cafe::ad) by SGBP274CA0010.outlook.office365.com
 (2603:1096:4:b0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Thu,
 20 Mar 2025 09:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 09:57:18 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 117294160CA0;
	Thu, 20 Mar 2025 17:57:18 +0800 (CST)
Date: Thu, 20 Mar 2025 17:57:13 +0800
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
Message-ID: <Z9vmeTj68LmwinPD@nchen-desktop>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
 <20250305053823.2048217-6-peter.chen@cixtech.com>
 <86frj8m4be.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86frj8m4be.wl-maz@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|KL1PR0601MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ee90ac-8b72-4452-06eb-08dd67959a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b4tz9UPHHxvgnroxR/JoGz6b02mRgyOW3RwD+pTCmXRV2VTxm7HrKPoI5kR2?=
 =?us-ascii?Q?A1JBkfoyzRSAkoAAEBxkOiqAgzRU/Yp6X9pRjDoMK9RrVNoWVm8kSTgR8CrM?=
 =?us-ascii?Q?Yl3PCVn3zQONj8ATlnEP/niMLye6Lbm8vTUGfxryfDKw+wuskvHAF3J50CyS?=
 =?us-ascii?Q?jkQ7T1TTafHDuUiNCDZElWRWQ85Be8vfw+KbvWfQOTrdF/gnCZFdJh8UkSBP?=
 =?us-ascii?Q?oRlG6lkPGHykKxsHkn+1XaziqGfl8dEHVnNp/K9Oq0xjRqrCQu6MeReY2K0q?=
 =?us-ascii?Q?w8O5yCRqkqj/9wWGcOButAAa/Fd0OwGk422reupJORkFjufXdg34OUtbx3nS?=
 =?us-ascii?Q?gBYTTMM6PIT0MzcYHYmY73SbQqElgCgqdQF4isAJxU+zie+G7KQdUlVb2dSM?=
 =?us-ascii?Q?KMGBbZ+kP7tidxRGBG6EWeIn7C/EFmq7H9hkfN9n74ICPQUjGHm60EIWovHk?=
 =?us-ascii?Q?t67LgmJVUkqyZ6aLu+5r7dLcuUG7NfUf+fxrjaAzOM9IR/dT2mZy/LfTPYb9?=
 =?us-ascii?Q?u7GXoT2+vA/WFFwgUCf2cQ5gW6aL+vw1vY641DQejqOzj7nkwoYz9V70ylgt?=
 =?us-ascii?Q?aVFZYBzOCLlhYu0ljXymyjvBaB5uVxW0WHTy6nARem+nZy+zwKxkFWH2nK8k?=
 =?us-ascii?Q?N08Bd1aUMbqL3/Rc8r4zC9xlgg/p3/775agVNjCk8LkWLEq7BYYdc0iPHeIz?=
 =?us-ascii?Q?mPkNnew8uUXqm8mEzQxU96KOnry+cLFvG0oo5pRApCtCYRV+uHTW5F5SO6xn?=
 =?us-ascii?Q?gLILbbDaxfptAza7HR9HBxzm1GE6Kt6KRtr1bCZqgd2/RekWQcKLqSNKblgB?=
 =?us-ascii?Q?C6rsJ5ESKlcqJ5/eLWAShdj8HNx9jIEwOfcKOZ2mTm+J0FAKmn247RPuc4mU?=
 =?us-ascii?Q?7htpEzFpk5hjQg+sDggJ2qxgO4fke49Ffqtgq0XgjgPkmDdXRhUnG1dvAJ7o?=
 =?us-ascii?Q?WAMKDz2yZNcOBO1xOMsl3a5lbgpEFuvWQnm76wKGVG4KXdtfoZBzJpmHW7lW?=
 =?us-ascii?Q?oo6LHgqeDBwYfoUqAk8Zm/5EJ4PUi1ZzwORzshUiQJsflOujv+aMu5cNJpQf?=
 =?us-ascii?Q?5cTmeqGuLcDNweZyTvoKWoxBl1dFynNkQ32CzaSM39+aOis61Bq7fQZgu9Ym?=
 =?us-ascii?Q?Qr0S8n+HoFoBbOor0f4dvEDleGmCeUxJMC8boV1ZHs49Ks8RsFGwC9thwPCg?=
 =?us-ascii?Q?RY+I1oU42on/J7KeOa8jGu6vYQjjte4pAV6Qtp5uhaV5fZdR+1+FdviMPeiK?=
 =?us-ascii?Q?GpEL2p0pXdEzvdg/yK8fmEn7bOngqWZCQBqSoNK4p5QK0aETLY/iqdZKAQ1k?=
 =?us-ascii?Q?T/5SWB9tBFK6r6tt674WYYNcaH9x96JZfB1m9Gea/W+Rradh1DpBJdimFUWM?=
 =?us-ascii?Q?zgBqA0XBT/5ftuIBwrV2KIvhijxSOl4gJfR8kGIKLpdDHAaSMn9qDi5/KmcB?=
 =?us-ascii?Q?BwnAXncz+PaAexKawOP2VkifHf2P5n2UjvWiXuDgwa0OdMuThTkNg9RhG12F?=
 =?us-ascii?Q?n3WbvLbNdkHBbgI=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 09:57:18.8862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ee90ac-8b72-4452-06eb-08dd67959a28
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5727

On 25-03-20 09:36:37, Marc Zyngier wrote:
> Peter Chen <peter.chen@cixtech.com> wrote:
> >
> > +     pmu-a520 {
> > +             compatible = "arm,cortex-a520-pmu";
> > +             interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_partition0>;
> > +     };
> > +
> > +     pmu-a720 {
> > +             compatible = "arm,cortex-a720-pmu";
> > +             interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_partition1>;
> > +     };
> > +
> > +     pmu-spe {
> > +             compatible = "arm,statistical-profiling-extension-v1";
> > +             interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW 0>;
> > +     };
> 
> SPE should follow the same model as the PMU, as each CPU has its own
> SPE implementation, exposing different micro-architectural details.
> 

Hi Marc,

Thanks for your reply. But there is only one compatible string
"statistical-profiling-extension-v1" at drivers/perf/arm_spe_pmu.c,
how could differentiate pmu-spe-a720 and pmu-spe-a520, do I need
to change arm_spe_pmu.c as well?

-- 

Best regards,
Peter

