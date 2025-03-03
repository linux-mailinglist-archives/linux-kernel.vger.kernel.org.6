Return-Path: <linux-kernel+bounces-545199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EAFA4EBE3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF13885699
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663424EA86;
	Tue,  4 Mar 2025 17:34:10 +0000 (UTC)
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C414291F92
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109649; cv=fail; b=NyzV2hqfFEKHF+YSKlNlhVPopKWOWOUHvM775Mk8+oGb08B0xZQTT2sfj0tqNjWp4gdtSCOT1Cxgas0YYBwIc5y3FSGOy1YDeLSjlbZZHbpPA378fZkIQsvj8dxbj9CpNvbsA5CsAOjFXt5w+9OGa3ZhP1kauBUwNEFPAHkBNNY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109649; c=relaxed/simple;
	bh=c4uvAFUWqB5BF6k8Y8MkOwv2YpytcmWbxq7PRSclyzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMC/L8diYJNZmjDiBQDGYZjqOh9bqr3f4r6UN0M1wJxP/twPFlxE07jcDnvGrPYe/2ygfWAv5vBHoFO0BzLpQbdEDJA70Ej8vFPRiPl28U5ynoZHOWFDbIipCyfsOC7p7K5fh+sGAZQnl2Pjih6GCKKCCgsIj6g8YM8DvYdl3BM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=fail smtp.client-ip=40.107.117.99; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 0349240D0C8F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:34:05 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g0k0sL4zG16L
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:42:14 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 091A94275C; Tue,  4 Mar 2025 18:41:59 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541604-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 8A9904226C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:39:28 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 7CFE4305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:39:27 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BCD7A7D5A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB30200BBC;
	Mon,  3 Mar 2025 11:39:05 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2099.outbound.protection.outlook.com [40.107.117.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F421FFC75;
	Mon,  3 Mar 2025 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001942; cv=fail; b=ktJGYLVxVG4t2DGK+MJBpWJ1T//gcluBiVWTOFZqXM2oFx4v1USr0uUyoG06nsKuvtymJ1fGPKNxJZSs+QEM91CGmjyYVC7arPbq9babGtc2Z/iT6C8ZPnMIecrEYJdPaM5mnRqpDuiUxiOXHfV0k8owt8BD1FcANowuEXSQ6Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001942; c=relaxed/simple;
	bh=c4uvAFUWqB5BF6k8Y8MkOwv2YpytcmWbxq7PRSclyzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5psTSNizBskqqmQDBZx9LIx7G1h8iU97OMXSenJxFktStzTOlYOJt+snzDlF2kJrGuNQr3jB5ZafK0u3qwQqfQ1N/GUFXnxVEJ6uGqjZcugkUQJXALfgBc4Q2SgxbKVIp4wEr/o91T8b+/gGA4Q2lCd0zToBMXfgrkwzeBmxd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRJfWIU+AK23XwSO2O3mImVzh4dBw+RXI/2EV9x4azPf/YM0SJQSBaoCRAKiXrEeJjrUHPZhbyHcVxAShsB9mGuyxrmjeJYHinzVQnjgbR5Gk5kNbrhDDwulpmtwkaLd2ArJywdZLPhhefho26EJdt/rtzVqK8F77DyHj2IFDD7l8/jkTnLkcdJ2eHoWkky1hcHFL0ztVf4oAZRWSDC9vTFLyTURVvybhH1zokIiDtM6fA3lnH60qS7u3w0Bu2lByoVBS6UAwqQAlmjz+FRyxGk3Zlw9WohfBpqNnmyIMGoJ+ZsVVXBw4evCqFLm5YBJl8gpi1Ui3knh6BFejkrZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAJ0Bhx/WxqnugD9Zk8bagbD0Hw1q3BfZGs5+RvZjNw=;
 b=ovJAIpuOM6MXsBOKrYxwHtBeY2uyXCG2iqsMDjOHdGlMwcc0zSVKc+0EO0uM7O3PUKMbFxZzZ4FEmSnXnnIF8/qhOP030kIQCa3+A3wHCF2uboB34YI1f1KqkzsJZVP6Ay1m0kjv7soCUp5ZJMObI2IjzkIUKjNuO8F5PrmlLN/mGoW/T8ogoadh9WGoKFX0VNc4BJ3n3BvnR/5qccykCN5Ylc2/8FG3kodKsSMpiXWMcYmNVZ1fZYm1OrErdcvUPVcvqStgaUMsxzwuXVNYuHpACkT2W1UhWeSbhilid1tfmEoWidKRuINerElOx21DhF6AolZS8Tue6M0/6MB+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR04CA0190.apcprd04.prod.outlook.com (2603:1096:4:14::28) by
 TYSPR06MB6647.apcprd06.prod.outlook.com (2603:1096:400:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 11:38:54 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:14:cafe::6a) by SG2PR04CA0190.outlook.office365.com
 (2603:1096:4:14::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 11:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 11:38:53 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 54C6240A5BFC;
	Mon,  3 Mar 2025 19:38:52 +0800 (CST)
Date: Mon, 3 Mar 2025 19:38:47 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Marc Zyngier <maz@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts
 support
Message-ID: <Z8WUxyJT1fdHKo67@nchen-desktop>
References: <20250227120619.1741431-1-peter.chen@cixtech.com>
 <20250227120619.1741431-7-peter.chen@cixtech.com>
 <86r03ip0kf.wl-maz@kernel.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r03ip0kf.wl-maz@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|TYSPR06MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 38389ff4-3c56-4d03-e7f7-08dd5a47f9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SdA8uY2gjwXo/aZ1jwwMgu+Vk3jkEzwxtzluTze/XAyYBdCu7HBrt++Ky89N?=
 =?us-ascii?Q?BXmTipKnZFwgCwWhG5tE9Pt9t68YxS9S8u7dRrqtFVthUpJ9Q8zbyH8+Qgne?=
 =?us-ascii?Q?UgQrzAXfeCLR1A6/c1sIZksYEpCn43km5VGyRPpFSR2MGmX8oQlPLix2xFCK?=
 =?us-ascii?Q?gu6uFd3FS4vQSjqDlL5wmcGSGRKqr/X8TlomoVCZfuQZwrkLnPFYjN8Q8OYV?=
 =?us-ascii?Q?n0Rxq7BTNK/VthT5Tkzgbj82KIa7epLRlTwIp4gSQ8jv8fykelEGQRm59PzA?=
 =?us-ascii?Q?rQRZsCzLpIvozh/FCJodR89OKcCCs2A15CNkQjf4zJgb8oaZX4xqS6RWUkS9?=
 =?us-ascii?Q?8K4N+a1JwxPS/JeZ85AvJMNDTiJnxW3YJcT6SIFt608E1o4JsJelnr9ITJxX?=
 =?us-ascii?Q?lP/WBAAa+Nv/7OXvkNDt9b5g4S0kB5VrEfXXVEwbC8G9FZXShFb/xV5JIztS?=
 =?us-ascii?Q?9eD+yCVdfUBU3e+XMQBVRgFldrBm9FqzdnG5QFIBrp9BY3jLgFbOIv+vM13G?=
 =?us-ascii?Q?zf6ar4wPa1/h0iP4QvMVwDlg5t4/qOLZlwIats7LROviYfFTNc4LPNcCqE9/?=
 =?us-ascii?Q?8IFgJg3TNJK9Q/Os3uLgGi5uKBpvxWPVp03gSfAXqjgPM5ilc1m74lJtW+dY?=
 =?us-ascii?Q?FhxrX3CX7hrWytCGDj5hW+1FAc2ojB7PAY0nGXKa+18E4unueczgelNUIYrY?=
 =?us-ascii?Q?/I0BUzSCgH1J37WNN2qfsuZq/KM/9vXwc0PtsLJjELSUUAl5BJuLo2TYAV9z?=
 =?us-ascii?Q?ZSPajlPtPMhF+ntVn9Rm/vBE3ZqjUqEsozaIgUcl2EVA9ZaZwvGfKUv7Y84d?=
 =?us-ascii?Q?qEDaTKGi5VUjYiSUVV2nzeJML0aqMSMn7l8ySgqpJfBr+BFyT0E3Va2PlSGv?=
 =?us-ascii?Q?7eXmoEiXv7fru+zKij31G+vJ2vqQyN9HMFaIX4qGgYgJhFuAT3ueut+k8vK5?=
 =?us-ascii?Q?EyjqIbO0e67YCon1P6KjqgyjqxqRVTMXvi73q5S5BZuFFdJa/i0fPyeZ9guk?=
 =?us-ascii?Q?YqyWhPSq/pD/7QmScSN+J3oGlZTDy4rxXz0iyjmKjpAqe3TBukHgSfloEQHh?=
 =?us-ascii?Q?I5/T3KoxBhoSpClvfaYh+zlDi6O554jxKqRQ0Pn67coCCv8kLrUQiuhp5xtB?=
 =?us-ascii?Q?RkRufAN8UCRhKQgQ7UYnS1Ro2hB1lMtOAAW7J6ess82AEB13Lj82VkRF0B05?=
 =?us-ascii?Q?2eFLeIze2TL7ufVqaD2Zs1ODYtoHGqkyTbeaSuWhIcVGLSP7mduYLzH7mozf?=
 =?us-ascii?Q?Hk4qY9o8h6S6PFGYsvxYiVjXeHpCq0gWGeIUOBKZb1wdYm6mdGif6qqD+z60?=
 =?us-ascii?Q?qjUUjDt8+on+i6asxnj+kIbeZF5jc/O2eERNthoPmreSWDQ4MA/VMii+SE0H?=
 =?us-ascii?Q?JJaWggnSVYfA/s1q1Nh6M2KNNX0PCfIdoOLH8JFsIV6EnpYsmF/ar4G5QKTL?=
 =?us-ascii?Q?P3RsK371Q6AYBMXWQZ3oeBw3kNX7SYNke7Uf4HpcdR+Bh2TrtNf56bd+CmNN?=
 =?us-ascii?Q?7VuREbaBkrvemq0=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:38:53.3032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38389ff4-3c56-4d03-e7f7-08dd5a47f9b2
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6647
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g0k0sL4zG16L
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714336.39571@TfCr8H+BnO6gaf6cEPsTvg
X-ITU-MailScanner-SpamCheck: not spam

On 25-02-28 15:10:24, Marc Zyngier wrote:

Hi Marc,

Thanks for your detail review.

> > +
> > +             cpu10: cpu@a00 {
> > +                     compatible = "arm,cortex-a720";
> > +                     enable-method = "psci";
> > +                     reg = <0x0 0xa00>;
> > +                     device_type = "cpu";
> > +                     capacity-dmips-mhz = <1024>;
> > +             };
> > +
> > +             cpu11: cpu@b00 {
> > +                     compatible = "arm,cortex-a720";
> > +                     enable-method = "psci";
> > +                     reg = <0x0 0xb00>;
> > +                     device_type = "cpu";
> > +                     capacity-dmips-mhz = <1024>;
> > +             };
> 
> Given that half the A720s are advertised with lower clock speed, how
> comes they all have the same capacity?

According to Documentation/devicetree/bindings/cpu/cpu-capacity.txt
"capacity-dmips-mhz" is u32 value representing CPU capacity expressed
in normalized DMIPS/MHz, it means CPU capability per MHz. For sky1
SoC, both middle and big cores are A720, so their capability per MHz
are the same.

> > +
> > +     pmu-a520 {
> > +             compatible = "arm,cortex-a520-pmu";
> > +             interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > +     };
> > +
> > +     pmu-a720 {
> > +             compatible = "arm,cortex-a720-pmu";
> > +             interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > +     };
> 
> This is wrong. The default configuration for PPIs is to expose the
> *same* device on all CPUs. You must use PPI affinities for your PMUs.
> Please see the GICv3 binding for the details.

We have discussed internally, we have not seen the benefits routing
different PPI interrupt to dedicated CPUs. Any use cases?

I prefer changing pmu nodes as one generic Armv8 PMU node. Is it accepted?
Or must I keep both pmu for A520 and A720, and add PPI affinities to
describe hardware well?

> 
> > +
> > +     pmu-spe {
> > +             compatible = "arm,statistical-profiling-extension-v1";
> > +             interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW>;
> > +     };
> > +
> > +     psci {
> > +             compatible = "arm,psci-1.0";
> > +             method = "smc";
> > +     };
> > +
> > +     soc@0 {
> > +             compatible = "simple-bus";
> > +             ranges = <0 0 0 0 0x20 0>;
> > +             dma-ranges;
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +
> > +             gic: interrupt-controller@e010000 {
> > +                     compatible = "arm,gic-v3";
> > +                     reg = <0x0 0x0e010000 0 0x10000>,       /* GICD */
> > +                           <0x0 0x0e090000 0 0x300000>;       /* GICR * 12 */
> > +                     interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> > +                     #interrupt-cells = <3>;
> 
> This will need to be bumped up to 4, and all the interrupt specifiers adjusted.

Depends on if PPI affinities is must.

> 
> > +                     interrupt-controller;
> > +                     #redistributor-regions = <1>;
> 
> Drop this, this is useless. It is pretty obvious that there is a
> single RD region, and 1 is the default.
> 
> > +                     redistributor-stride = <0 0x40000>;
> 
> Drop this. This is a standard GIC700 that doesn't need any help
> computing the stride as it obeys the architecture.

Will drop above two properties.

> 
> > +                     #address-cells = <2>;
> > +                     #size-cells = <2>;
> 
> I don't understand why you repeat this on every sub-nodes.

Because there is a child node for gic_its below

> 
> > +                     ranges;
> > +
> > +                     gic_its: msi-controller@e050000 {
> > +                             compatible = "arm,gic-v3-its";
> > +                             reg = <0x0 0x0e050000 0x0 0x30000>;
> > +                             msi-controller;
> > +                             #msi-cells = <1>;
> > +                     };
> > +             };
> > +     };
> > +
> > +     timer {
> > +             compatible = "arm,armv8-timer";
> > +             interrupt-names = "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
> > +             interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> > +                          <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> > +                          <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> > +                          <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
> > +                          <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
> > +             clock-frequency = <1000000000>;
> 
> Drop this. The firmware already sets CNTFRQ_EL0 to the correct value,
> it seems. And if it doesn't, please fix the firmware.

Yes, you are right, firmware configures it, I will delete it at next
version.

> 
> > +             arm,no-tick-in-suspend;
> 
> Why do you need this? Is the HW so broken that you have implemented
> the global counter in a power domain that isn't always on?
> 

Not hardware broken, just arch timer will be powered off at cpu idle
and system suspend due to power consumption reason.

-- 

Best regards,
Peter


