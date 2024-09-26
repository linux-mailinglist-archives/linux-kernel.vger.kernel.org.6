Return-Path: <linux-kernel+bounces-340279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5229870CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7FC286A85
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1A1AC895;
	Thu, 26 Sep 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="jLpk6N5v"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2DD1AC44E;
	Thu, 26 Sep 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344516; cv=fail; b=lW6HZw4wm+Q5tasoxnjeIcWnK/W8nCyX8fXT0CLiA1qq1Uf6O7J2FwuHotFrwg9WhlBFCHZFLUVB+LuyuqHCa++PtzK6zJ8TuZARa9Z8MYJ/hb2pElfqgUoAvFZoS3dn68zPQQomlE+DdYvi+ULw213oqwa6jbTwYs10zt8i2tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344516; c=relaxed/simple;
	bh=vYWsoNhIDjJWGY31/ePArJEX5UGdLxsrLzrvLDUqe50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+4N8d8hcInTNYmoTh1E5K7jfPl2OLL2l3WekQjYRaQk28fWqVfEbu7xlX9nrQdXhiRFracF2mV9JOd3MOUi+xlYjqg14J82XpwmH/jQ/kqrwHhfmFYYP8MAje0CGiUOK1RBHKP0OJeGhqr9CmGIFn6sqN5okxZp4Y75zPR4s1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=jLpk6N5v; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q3aekg030585;
	Thu, 26 Sep 2024 09:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=tbCP5+xhTSXSlt0EZuKCGTUTlUvcgR0
	JQjNdJC/6Ecs=; b=jLpk6N5vDyFIb9AsevUmoHr2lxCCu8H9S8xzFOFeRl+ZuWn
	ll/xZtX1IJPGJRHLUoy+qEo1Ncng3YZ3JCsBFXFWDCHNzbnApMkHlFbHPcMezTr+
	gOb1I46kJ2R+oPfKIp11YQeTURwpPLdNfaudhFOEd1BHz/kkYMu8jAm9DT2QbPnx
	R8fgonw4rQ9AaO8RpYcygGVv6I8ZgGsh5veSwpDCqO5GPnOIvzMWuVRy6Lgxa37p
	d9Z95y5jhPzgOmIiFXJ35sB81exxfl86BORmt0mLvKgTzwVpp7sGDOTCJCCHTOiR
	QjrkrLwc2GSxD0GhKR01ssMHw89slM7BZyuzUOA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41smswmwmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 09:39:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T03u5HvjMWmXxCGed4GAJjOjW+nH/02FEuIat6E6xWEr2wQPoo7me2/6HZ56vor+5hshf2b0/i+G7HPXjYZj8FfB3W0z9A4bGIQxo4D+y9yAkOcOltvCo/kM3hjUTE1xU2SyaWNEMPS2zvR+SjWWUaC4xA7QoqPSSTYpU+Va3gpidfgsu4DNRv+GstVEw/R4YswwajX7eKRW42bqsPz21eJ9sLFBz6U2I5fsGwwu3ccz6Q70VNxg+oL7eBE6vstvHh3RUOc4sAIg8Fp3haBSXYFw1ONo1wvA6XrSxATl8vwLxWLkuR/Qqt0EfNNAEH0a6dhXe8Lgyj2hVWQYqIG0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbCP5+xhTSXSlt0EZuKCGTUTlUvcgR0JQjNdJC/6Ecs=;
 b=xUW6xev5CZek/M9rdCSY8hpE0x37/b+cBQ2QsDjCOM7o4Y9gTQCc9LwJbVAbOpK2NqSIzyf4ReTNV7uW7YGCtt43SoyWhL2dNA/EBRbvbntTVbOs2LRJV3u1ruY7tj5Aqiomk5+yTVtNJAsbIPax0QVs3PetNP3Jk1sJkRlHWvfj63zWw0x/BdN54xX2M/qnShvy+7k6QTeprx9F6iax+W7/h1eOpbOwOzUWrcj/Op+p3mg8sL3jnEGoVfImo0FODBP+wn1y8RsRxL7OxPIMHv3XflPxquGPEzFJ/V8zZSvg2hfZaJCgi/vspDXXTh/HGTMeNn9uXtmZJg11cU+w1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from BL0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:207:3d::34)
 by SA6PR13MB6904.namprd13.prod.outlook.com (2603:10b6:806:413::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 09:39:33 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::f1) by BL0PR02CA0057.outlook.office365.com
 (2603:10b6:207:3d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.19 via Frontend
 Transport; Thu, 26 Sep 2024 09:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 09:39:32 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48Q9dTrg020147
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Sep 2024 17:39:30 +0800
Received: from mail.sony.com ([43.88.80.182])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48Q9dSfa018684;
	Thu, 26 Sep 2024 17:39:28 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id E48081BA9039; Thu, 26 Sep 2024 15:36:49 +0530 (IST)
Date: Thu, 26 Sep 2024 15:36:49 +0530
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, yoshihiro.toyama@sony.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] driver: core: add probe control driver
Message-ID: <ZvUyObXxkU+LKjJD@NAB-HP-ProDesk-600sony.com>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <20240911142319.3435746-3-nayeemahmed.badebade@sony.com>
 <20240912204634.GA738361-robh@kernel.org>
 <ZulEFlDoRz4USTB8@NAB-HP-ProDesk-600sony.com>
 <20240918145516.GA1560032-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918145516.GA1560032-robh@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA6PR13MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b20ab9-397d-4853-ddc1-08dcde0f2050
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NVk+cPTHb1Q7vtTd/crn7/BO3c9RPzeeGIv3IxqEPYYeHb1OVimTFW4AiUZb?=
 =?us-ascii?Q?UVkdB+97tG2ENaGQ7HCxbD+iKKrJCRAGUV10GqXdOenFoibADXwy7M0MI9al?=
 =?us-ascii?Q?0FOcQ0muSZUAhi0loZb8pJcvmN8Y0n5h9d9hf2nTPJd27GKpYRkTwwdAoZUU?=
 =?us-ascii?Q?WG8wWhVYpMhxYvQqInD7qPmoWd7LGKhoifWA2nSPJEj9MDnaJp1kH+hdgnGV?=
 =?us-ascii?Q?AwUlqazPOUknaw/yfpdAGN3ePrf8n6NgqwhkiuR+s2G8ffF0Dft8OLlo3npp?=
 =?us-ascii?Q?B5e6UYGOr9TQtbGRUkgz6l9MbY3y3vaWb9oJdKXiXSWM/T6nVR7zngjQzF1H?=
 =?us-ascii?Q?iBRPj3wfYXPlhBSBl67XYg0c/Jv6IrlqLKQRlhXT1GZaiUjn7QoI2ENj2Ep4?=
 =?us-ascii?Q?JeSQJR8PTtRUEbt0JIfVLkRpO30UC1hGgVJUCyv2aasWElewZFuJBN6es5Sj?=
 =?us-ascii?Q?k6zzSXK8F2dT3gT/PrVBqdIwCnFqqASVqkg+3loXWWll/ZGWGSIVwqZIvWlT?=
 =?us-ascii?Q?SAJBTANqQmuwhktYGJ2YsPiWOCkzz6cdUvggelzOyVm4zSNp6Zuqz5ZDlYL8?=
 =?us-ascii?Q?wThHfdcwqwwh82x1kDcM5VLLgLzRX2H+I9MKOBTTOGrrTtpHwopos2yJ6feF?=
 =?us-ascii?Q?Q5dkY3SIHczRxP4ZTr6e1/vtpHm4a61bAGTZifmY14gVFLDakJDQJnoB9/l/?=
 =?us-ascii?Q?VSGTmNNh+/v02eSSdrIKh3iaSLNCY3scaI/1c7wb3EmezAPn2juCfmJz+KlL?=
 =?us-ascii?Q?rVc7tmg0+hfoaeGRccnyW4AfM0Y66BW64sAcroEndfbm0/BO/k0VYInXiDtp?=
 =?us-ascii?Q?IU6qjbH2dyOHH4W10aDXsis6jr+V/chCKYCrF+BqTFwaF9WMvORx40RAIepo?=
 =?us-ascii?Q?/nXUZx/hIkC7jSTdyRmOB4CH65D1zIfUBPazrSXTcwo6j8IFa08SQE7kjnrS?=
 =?us-ascii?Q?+tPEcFwqA2rCDUhbYFPo3pZFEt4dQcE0G60m+AD9tie7G1bZs2dR0dunJyvM?=
 =?us-ascii?Q?TfSeAyPxoIklex7mmAQY6rgyHPvelOj8YvOmqOkMJboe4lxnt/sgkoI35U8+?=
 =?us-ascii?Q?G3862b7wW4cxCgpS0OW40B0fVayGBw1Lq71HlDrKplgxLE/MQQ2Yezc/1EG5?=
 =?us-ascii?Q?TC2qSK/MPLSnBxNPHQwL3fL6xN/VjJ5VQxp6Htmbnac6xRahopHs7+QstOe0?=
 =?us-ascii?Q?hCfFEmkrz/cZPCgQz3soYeF5Lcmo0gGtpoFQVucbNsx9XhidvrEa78oIr35N?=
 =?us-ascii?Q?m0qAGNew1CQmzPP5oELc7Ey19iCi0skAqG5OfwTuo5bkvHgEwXLUIMpgnJu/?=
 =?us-ascii?Q?MuNKj1dLP+YV0eqEXGPiumY/rfXDTPhdT6b5noRoTiKmc2vrunbv7nKT/YmX?=
 =?us-ascii?Q?YMwsjE3evH1b77cHilrteNaU4ROj?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WKplcx3WiXr9vZFcb7AXpzpTO61049bKXHO8ERIduVTKHEFjK9ahLvC9hmP2SOXRKkRISxgXFVj4EQ3fkzQoKwnGP7o+KdaXmdbVKtoxKVQr/Ti2j+iRZZEYgYuckv6zydkgV4ojubur/iXSBcPFEgqxW1RetyMaMixUS0jIk6Q32RfVLMX0EGhbCDgponbazXhr4BBXLuCy2nzPkijWPz3xT5njAdvQTGOKnTrAPcdoWYKZN0oFFiB/HRrTAhNVd/qkOEUxizRhu7q/pXaf0Z9qEq60FhLe7mHtihuMbZovNrObJRlQeBcEUGcEqHi1+tOSyTce+tlLI0das+JGC+aLGm/5Zcjrwiacs83+NGQciiUGn1Tk81TxKg53eodmJnEDAtGrHydo3UbQK89nRj3AWW4XjePkR3YqEV3/nrrcYTEgmydDFkzhkX8iN8YIPYFXOtFDEKdTbx4tj4lrx2yzUMilhknk75PvOLq9WhXa+g9hWoFayWcaHiOwS7QaftgAWZ3jEmUEku7du6IPefwO53P9usZoVj46kxXGW4Gg8ncenfwdpuevCqO9Nu3YStboUmh1ERCmVEnSeiLN9soCcHX7ysa6lz83+IjOFpfKS3AMddUhzQb5DBKmzOLQ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:39:32.0782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b20ab9-397d-4853-ddc1-08dcde0f2050
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB6904
X-Proofpoint-ORIG-GUID: P4KlzaGOgCWdaVc6xJz_UVHM5xsbwdo7
X-Proofpoint-GUID: P4KlzaGOgCWdaVc6xJz_UVHM5xsbwdo7
X-Sony-Outbound-GUID: P4KlzaGOgCWdaVc6xJz_UVHM5xsbwdo7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_03,2024-09-26_01,2024-09-02_01

Hi Rob,

Sorry for the delay in our response. 
Please find our reply to your comments.

On Wed, Sep 18, 2024 at 09:55:16AM -0500, Rob Herring wrote:
> > On Thu, Sep 12, 2024 at 03:46:34PM -0500, Rob Herring wrote:
> > > On Wed, Sep 11, 2024 at 07:53:19PM +0530, Nayeemahmed Badebade wrote:
> > > > Probe control driver framework allows deferring the probes of a group of
> > > > devices to an arbitrary time, giving the user control to trigger the probes
> > > > after boot. This is useful for deferring probes from builtin drivers that
> > > > are not required during boot and probe when user wants after boot.
> > > 
> > > This seems like the wrong way around to me. Why not define what you want 
> > > to probe first or some priority order? I could see use for kernel to 
> > > probe whatever is the console device first. Or the rootfs device... You 
> > > don't need anything added to DT for those.
> > > 
> > > Of course, there's the issue that Linux probes are triggered bottom-up 
> > > rather than top-down.
> > > 
> > 
> > Our intention is to only postpone some driver probes not required during
> > boot, similar to https://elinux.org/Deferred_Initcalls. But instead of
> > delaying initcall execution(which requires initmem to be kept and not
> > freed during boot) we are trying to delay driver probes as this is much
> > simpler.
> > 
> > > 
> > > > This is achieved by adding a dummy device aka probe control device node
> > > > as provider to a group of devices(consumer nodes) in platform's device
> > > > tree. Consumers are the devices we want to probe after boot.
> > > 
> > > There's the obvious question of then why not make those devices modules 
> > > instead of built-in?
> > > 
> > 
> > Yes we can use modules for this, but there are drivers that cannot be
> > built as modules and this framework is specifically for such scenario.
> > Example: drivers/pci/controller/dwc/pci-imx6.c
> 
> Then fix the driver to work as a module. Or to use async probe which is 
> not the default and is opt-in per driver.
> 

Sure, we will try to fix the driver and also explore how async probe can be
used for this kind of scenario.

> > 
> > > > 
> > > > To establish control over consumer device probes, each consumer device node
> > > > need to refer the probe control provider node by the phandle.
> > > > 'probe-control-supply' property is used for this.
> > > > 
> > > > Example:
> > > >     // The node below defines a probe control device/provider node
> > > >     prb_ctrl_dev_0: prb_ctrl_dev_0 {
> > > >         compatible = "linux,probe-control";
> > > >     };
> > > > 
> > > >     // The node below is the consumer device node that refers to provider
> > > >     // node by its phandle and a result will not be probed until provider
> > > >     // node is probed.
> > > >     pcie@1ffc000 {
> > > >         reg = <0x01ffc000 0x04000>, <0x01f00000 0x80000>;
> > > >         #address-cells = <3>;
> > > >         #size-cells = <2>;
> > > >         device_type = "pci";
> > > >         ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>,
> > > >                  <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
> > > > 
> > > >         probe-control-supply = <&prb_ctrl_dev_0>;
> > > >     };
> > > 
> > > Sorry, but this isn't going to happen in DT.
> > > 
> > 
> > You mean we cannot add custom properties like this to an existing
> > device node in DT?
> 
> Sure, you can add properties. It happens all the time. This is too tied 
> to some OS implementation/behavior and therefore is not appropriate for 
> DT.
> 
> Rob

We understand now that this approach is not appropriate for DT.
Thank you for your feedback.

Regards,
Nayeem

