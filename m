Return-Path: <linux-kernel+bounces-340334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32729871BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94574289783
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548991AD9C9;
	Thu, 26 Sep 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="CZgjPXh6"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49A193408;
	Thu, 26 Sep 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347246; cv=fail; b=AjRtW2DJVPPs3mpiDNAh4zNCbL2NKBp2j2C/ukpqmTvX2Ip88WaSW9htVXRZLSJAmAWaAP774wpVuBmU4eZyTib/5xDLBnAgoDbdql3CHxEcG69Un0JwWMbClt9O4mbk8y+ZB6dNdZdBkQljeli9RQiBUHIG20zBjttrBdCXP+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347246; c=relaxed/simple;
	bh=J+r8PuZoY6A1e6gvx99iZtxnXXnhzfPraC7X90/0Ltw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5AULZSNSZogFTfYkZvX7F9o3V0lJxQszWEvbx37yoFtlRdtVHvlICQXNIWiV84nqzub3KfCBZ10ukNc7LjhjV+Zu8HTgV/ALTfgyBM38inFKBpxdh6cSkDIDNe2zIwp9vCLnplmkYd+98UMlUbyPoAeMclgHmJkqHvaQRozkO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=CZgjPXh6; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q5vWoB019755;
	Thu, 26 Sep 2024 10:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=srY28thbvcXX+JtQfJhYA0Qjqs+EYzM
	/SP2Voph/5F0=; b=CZgjPXh6owGnZlhfnQxmsqipB1/PjdJL4uc4PGL4ipHOGPa
	b/wm1km/yMfegolKh9cWTcXhR0rvXyrSmuMUIWapWho1+HV4cawMJPc4vRRpXq8k
	ChteNkScu+Aps95omNPukCpL0ZIlJop5TdrwRGKmBszC2vWl6Jv9Vz3ZWZwkbKE/
	kBM8oCAQeiuQKy8MXaVgtPTDbkCJz/FSPe1q0NdzVvc1tbJ6FFTx2VeXN8yglJkH
	klQxBIEKrE6vBmOMpM66edGaWErsFDYpuoW2wfW6puIHQaI1rkewDVOzlmPEFnrm
	xUlpnVdsUBosCuZ0/A4KqX5zoR1VUT2m3m76low==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41smswmygv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 10:40:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pf+iZwiD6SvfidVnBGqXLnl8qUyPQNs657k7OMqB6qu83i56sQzYv4xR1S50CT/FK9AD6rutRsNNLX/jhbJ5o3AlKyq48+hOe57DE7BL+EoKzfjohVxrct1GjQYaJoAfRKXrrXURtTK3CFCCqtXWuqorX2m3sKKjyPfaWRLzUHEto/KLViKvroLCP9FbMUAiWLdmoag3dMhgm5FDxKSTZQlt0ZpJE93LZUNmdIaLxIttPX8okTSRuGzBXpYrB9+v6f6CEd0wtmvXoVobt+6r+lhq3f6ZfmazX1kuiRpXI33mvoCNKq4Tmz/ePff0Lo9NLAbx0wVZs5TII5WMyzi4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srY28thbvcXX+JtQfJhYA0Qjqs+EYzM/SP2Voph/5F0=;
 b=GjWUJFXWZqkpnhwEee9b5Dpa/Bi4cXydDcKTb62BiOa5lch4DzmGYKN16h6MuMmBacFFKIqUT0T+KVwIeMgH/FNButM+JDRbAkx4igaZ2+fzHLh2rza2ht+ibxB/Vzs+GFvJ2QOs6f8prHNgtW/lgpYTk4bIeb4ytMDO7w5Z2wP2MJ0LoWrHRMVpeBPgpxudKon397hwXroJLFIumKVHo00iX9Qm7ClysqQnxcyi8qeVtWXO+jMDYmTARHF7QcW7BmhYb575SBDgK+paUW2YGBfc/chuUuMvVOzo70VxcabwuCCXWWkesMsxG5Pt1VWBqwcmZQulXSxCXQXvaqibuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from CH0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:610:77::33)
 by BY1PR13MB6689.namprd13.prod.outlook.com (2603:10b6:a03:4a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 10:40:37 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:77:cafe::77) by CH0PR04CA0058.outlook.office365.com
 (2603:10b6:610:77::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Thu, 26 Sep 2024 10:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.0 via Frontend Transport; Thu, 26 Sep 2024 10:40:36 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48QAeXRI029707;
	Thu, 26 Sep 2024 18:40:34 +0800
Received: from mail.sony.com ([43.88.80.182])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48QAeWpR000905;
	Thu, 26 Sep 2024 18:40:32 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id DD6FE1BA9039; Thu, 26 Sep 2024 16:37:53 +0530 (IST)
Date: Thu, 26 Sep 2024 16:37:53 +0530
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        rafael@kernel.org, yoshihiro.toyama@sony.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Add framework for user controlled driver probes
Message-ID: <ZvVAiVBlBjkMhHMY@NAB-HP-ProDesk-600sony.com>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <2024091327-repacking-avatar-ec23@gregkh>
 <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>
 <26fed82b-7c60-4fda-8951-b22654728743@kernel.org>
 <2024091747-monorail-unbutton-7ebd@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091747-monorail-unbutton-7ebd@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|BY1PR13MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f13dbd5-ed54-4590-88c2-08dcde17a83e
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NxOpRE/0QY0oIUWnl3Bf4D4KituZkS7ZerQstk1JmePjcvKZcS315mwD2kEx?=
 =?us-ascii?Q?bXlzy4P7JQa83ECl5wkgtWK1+qSe63vRDhSv6JYoSOthJM5/xcqad/IFxviV?=
 =?us-ascii?Q?T4ayBn5l47spsaXuFJALWrKH8zozfR0EPP8M5tKN4WZtVXJdt5/YmxzYCurO?=
 =?us-ascii?Q?sC9lU6n3NVN3K1h6Q6HsQT2z2qCv8KtfSmKUkFIufkMcFCouw0rMVK7E3RId?=
 =?us-ascii?Q?3M/Or/Vq7Ygt+Oxm/3tK2FieCaEVA34Kio0PIFlzzVUU5ix6WU+WYHkswLeX?=
 =?us-ascii?Q?N7aC8TO24YI21bl0CzVGbG8fvkt6iSNTABWEZJdqRtn1/L7MZ2o1gTH7Xw6U?=
 =?us-ascii?Q?gYgUPMuoyTJZk/+C4+8b/nBmtqlrTm7cY0/fvyKJEipDvrMGLzz9wWLlA5DB?=
 =?us-ascii?Q?o8xjpM/QQDHcfVcHvNIS2BM4HW1/ZsjceyWvcI3jOvrl4u0V1+uijeihqaJJ?=
 =?us-ascii?Q?gMQ6GLgg5NIwBja9WoZdiF18lom+ymLjeOOfXhLrM45EwpNey8p4m0TNjukn?=
 =?us-ascii?Q?QjR7EQsrmkbMTJc0n+SoSPzCXZZfBqLXbhpur4aZdeJ4nbWRjj01PA9ud+yl?=
 =?us-ascii?Q?qPwFOzNPxpCMYgEtzClj1Ud6aW9/IbJM8oU+o2ceqOAGIlEs+kVgYJG+KYW5?=
 =?us-ascii?Q?jvOtYT2a+nVsUSXfBFiUS0JmDBESehroX9dfVYeD/C+0eR6M9I2gsr/BoeGt?=
 =?us-ascii?Q?EbCUz8b1Yvow4eRy9ZCc8wKH9j+cCqjiMmtUAQdE2dUltn2nGOg7yQqfsL74?=
 =?us-ascii?Q?2ZOX0P5kkYorIq8fLIoVzkzYxJTKYqPQwZbW20ugtvyrpGq1DuBAflRj0NCC?=
 =?us-ascii?Q?sXuXP6Bs0tC/c+Tgk5uta2qsC5Zrx7Onw1RfjWXO2MErDt2GuoI2yYrHlJ8D?=
 =?us-ascii?Q?jf76V/TrgEjfraAQOO9mKMe6Mbsfeg3rI6Ync6m9SeYmkS2YFDIbA/7312Pe?=
 =?us-ascii?Q?k/5NjOz5UCnytu0GBlCXwCldt308bw5WvY9YHmKZs9m+c+HgOZJvk4oY7SQV?=
 =?us-ascii?Q?H03TnbQ35U9Y3R0z9Jf/94E6XqWLGDkQuCaZoeGsmBTGl18PniIjepc4c4h6?=
 =?us-ascii?Q?qMWMeEma5fWahj1IPLoh0UQM+j4BbtViSmlCrUuw+v7CM91m2TdZD4D02WF3?=
 =?us-ascii?Q?nerZ2QrSYTc9mNXEx1ehm+OUDshaeLrAoUM4Cw1Wr/aXS7aDB6aXAQyAHsEq?=
 =?us-ascii?Q?67PJ8MNf4Rdydm9BhIRqCDavH2WoTbW0D387tQ7wuR591gPPPS7XH7oF4+1v?=
 =?us-ascii?Q?L58y1BA57I93GVmpKHQLi4BJYWlMl13mE4azQ/hxvx2j8DpYzV/X5nUQWkE6?=
 =?us-ascii?Q?pzEwGJOT5Gv93bgukNVYULZHDZxNpWTzJAbhxliIXFODV8hsmAz5o2Zwjph0?=
 =?us-ascii?Q?VDQBfAognT4SGOciYDnky052yLmI?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zLuGZUo4J6B4+uvBQdqFi/OmRYfR1iicsc5scCMts/lC1Zu+fXPePzWsjY7mHldJH7ttEYcAyXuL14/QdAUOm+sYX/qCkmojS7RL5/Xl9y6hxfoneNQT20wac0Xbmk1ghmL/ORn1BZnkw9enx3K/dsaOC2povWzyvnIJ9+18fbd+WX/T8sds3tJaqSH+3sDeWgwXTmdlnQwEoNxdpvOLWy6gLW2LazvulEAjc8fEJwUkY+NYewRye638It/dUw6LfbHGJIMsna/lTo184H0KT6bwKif7Fh7jSMB72eGCZQjRcPiEHMTsRCIeUhIQ1rnsBseLHbmvWshnF0XbKZlb/edWKSx3mdifefCLtvkfDy87ZtN/LZ5SEJbgPsqxlLK5dgdfnCbGECHdl/AurgmT3SkZGUozGVOe9OKiQOzwRmApZSaEvyKOcUXLrKAQrBmXh+vFZoCy54MaMYRIud9QQxIPZtpiY/EWqldAkP/dMWqEPtH5bZM9c2xexIbAJ3gL+hq8uE4xgGa8M3yekgwA4Na0ehm3KoBqaEt4Jb3tDnjfeg1h3MtDBtRnIDUumpvxHvktftAXIRIXHRH03A8Q8aeBjTtBdUX/pebQmEuE9huKVmKJffXPitm5dGLy91xc
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:40:36.0708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f13dbd5-ed54-4590-88c2-08dcde17a83e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6689
X-Proofpoint-ORIG-GUID: JOBSiAzd5EFwepCrUJ8jT5H9Wr4DDYpO
X-Proofpoint-GUID: JOBSiAzd5EFwepCrUJ8jT5H9Wr4DDYpO
X-Sony-Outbound-GUID: JOBSiAzd5EFwepCrUJ8jT5H9Wr4DDYpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01

Hi,

Sorry for the delay in our response.
Please find our reply to your comments:

On Tue, Sep 17, 2024 at 11:21:32AM +0200, Greg KH wrote:
> On Tue, Sep 17, 2024 at 11:03:14AM +0200, Krzysztof Kozlowski wrote:
> > On 17/09/2024 11:06, Nayeemahmed Badebade wrote:
> > > Hi Greg,
> > > 
> > > Thank you for taking the time to check our patch and provide
> > > valuable feedback. We appreciate your comments/suggestions.
> > > 
> > > Please find our reply to your comments.
> > > 
> > > On Fri, Sep 13, 2024 at 06:36:38AM +0200, Greg KH wrote:
> > >> On Wed, Sep 11, 2024 at 07:53:17PM +0530, Nayeemahmed Badebade wrote:
> > >>> Hi,
> > >>
> > >> If Rob hadn't responded, I wouldn't have noticed these as they ended up
> > >> in spam for some reason.  You might want to check your email settings...
> > >>
> > > 
> > > I have ensured standard settings which we have been using are used this
> > > time, let me know if this email is received properly.
> > > 
> > >>> This patch series introduces a new framework in the form of a driver
> > >>> probe-control, aimed at addressing the need for deferring the probes
> > >>> from built-in drivers in kernels where modules are not used.
> > >>
> > >> Wait, why?
> > >>
> > > 
> > > We have a scenario where a driver cannot be built as a module and ends up
> > > as a built-in driver. We don't want to probe this driver during boot as its
> > 
> > Fix this instead.
> 
> Agreed, that should be much simpler to do instead of adding core driver
> code that will affect all drivers/devices because just one driver
> doesn't seem to be able to be fixed?
> 
> What driver is this that is causing the problem?
> 
> > > not required at the time of booting.
> > > Example: drivers/pci/controller/dwc/pci-imx6.c
> 
> Just this one?  I don't see anything obvious that can't turn that into a
> module, have you tried?  What went wrong?
> 

Yes we have tried building it as a module.
This driver currently registers abort handler for pci using function
hook_fault_code() on arm. This function is not exported and marked with __init
tag. So we can't use it post boot.
Also from past attempt made to modularize this driver in community, we saw the
hook is not safe to be used post boot.
Reference:
 https://lore.kernel.org/linux-arm-kernel/1454889644-27830-2-git-send-email-paul.gortmaker@windriver.com/T/#m8995c6dcc40c54baef0665a7ee16d4209cb59655

We will further check this.
Thank you for your feedback.

Regards,
Nayeem

