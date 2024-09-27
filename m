Return-Path: <linux-kernel+bounces-341893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BE19887DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BE91F21CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000601C0DDC;
	Fri, 27 Sep 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="oRnFR1B7"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C613AD1C;
	Fri, 27 Sep 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449479; cv=fail; b=YLc8/WvzWIHttrQY7pc+ZaFnvCzp/HoJVOLxA0NMqeKSurAh2RxSkAZpMrPXrMeECsADfTefuc0kuwU/tFqV34oY32WTdEqahh/9KgIDnrY7P1mNVwqJEfbd43f+a9UC1iLqmQOShZX2JPXIF/Ur5iQqPOvKEWBRxDymOgDKNKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449479; c=relaxed/simple;
	bh=p8YV524RTjHjUbr5Q1tLpbRgXTloPXAL+KQR0WoOBLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN1FUF97sZxb6oG5M7F4urB0Kcka4rooUDj2+st/CcDoed4sAYK22fcE9JfYlrtJvbYjDsC+lDlk/VxNfAwcAyuaRBLBvk/h9kb+SbyWIHFe2umMQYDR5t0zBtwW7yjwp8BkLISkTg0cTKRa77qLxZaN1cweVCULA8BXdk9GGcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=oRnFR1B7; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48REYShb022060;
	Fri, 27 Sep 2024 15:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=xu+tC6jMqrDXMVQSE95cvUwYAop19uC
	1xdhQrWLDTpE=; b=oRnFR1B7jzgNliqftM+oncBOwS7ZiP0vZSRha8iBzJrlmqI
	WAXiM65tNCvvEbJsG2wrrR4j62ju6I98eKGyRgl9oAIaKAFVPKKv4UdOimV2iTxt
	ZqZUEos9pM9WpFtoIOI78ANOyBfagXt69i1LrZwFpW2KpkFaCYIslr+DBjbuPTaw
	cezaDZxzlLCTsaJR6xUKnGFHAQTt1qY34X9+ZRbRvQDsQ9sYLcQ9zTA0ub3gEwyC
	o7fEoh9emQyJAhvGbpZmXJ9iq521S+JmZYSo8sXz3hYRFiXq9r3LBDHZZuKJOqkh
	xa6nl6jaXtQ8EgdIxW3qGqoF57uzlYfV9Qx6FLQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41sn0y68hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 15:04:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEJNfD15WOCL05IHp8rYUqC3dkm8xzzPXxJ4GIP/0/M505Q3EkiMbbkbKHZs2Hd+1wAhDBTPoMMPzzDanlW8tFdrf6x1kT6LI86bzDSFz/REzmvluyTwAa8W9VC4hzpyOIW9v8OZLWF4i/dYrMNqh6C1Yk9WhGR1d9xt7dMCV63eFxWO9z3M9+v9IIKy7uFRCogNVNxGJgqKv/CSyCSymdyZuqDn1M13C7yioomcMlwl3oK8IcTVvgUtA5/8fyeuJdacGeMQPqDhb0B6vr5CPphCTHQCnhs5xI+SySpT/WQHHX3YwtqpQIbckCPnL+heDwqiXsp5FTZwFbWdt8/QOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu+tC6jMqrDXMVQSE95cvUwYAop19uC1xdhQrWLDTpE=;
 b=Ehbwqep+PkEbw7jGN2n4WTxV5y6Xge2VgM6kFltyrsd4Oi1EBRVV9hNPjRLeZvUu/hHpfAgGXkdyh075VclLJx2cN1oKG3GH3JVLVfLQDmm+5e6Fq7sGFiTstmMj+ruyFy1Q/hkdwl3AI1tGNfipVaWmHoZE0ReK1Sj61wgR2EZZI96sqlrQrOznBMrQ66kR4TiW/bPfQ7zDP2/2OLrdilXhyy6R13AgyoJBC4Elxb7YNxKTOnWWQ9+iMR20JsHGcJ2twXLwIz1GUOckvA5ArzWZvhYhixKS0gR1O+U2j0Ljs8jAeZQ3Rb5Ye4QR9UKRcJuFYf2m15ZCBEv09R3oGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from MW4PR04CA0389.namprd04.prod.outlook.com (2603:10b6:303:81::34)
 by SA0PR13MB4078.namprd13.prod.outlook.com (2603:10b6:806:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 15:04:22 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::ec) by MW4PR04CA0389.outlook.office365.com
 (2603:10b6:303:81::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21 via Frontend
 Transport; Fri, 27 Sep 2024 15:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 15:04:21 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48RF4Gji030673
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 27 Sep 2024 23:04:19 +0800
Received: from mail.sony.com ([43.88.80.182])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48RF4FJi014145;
	Fri, 27 Sep 2024 23:04:15 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id ABA131BA903B; Fri, 27 Sep 2024 21:01:37 +0530 (IST)
Date: Fri, 27 Sep 2024 21:01:37 +0530
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, yoshihiro.toyama@sony.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Add framework for user controlled driver probes
Message-ID: <ZvbP2e8nZzjXKfVK@NAB-HP-ProDesk-600sony.com>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <2024091327-repacking-avatar-ec23@gregkh>
 <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>
 <26fed82b-7c60-4fda-8951-b22654728743@kernel.org>
 <2024091747-monorail-unbutton-7ebd@gregkh>
 <ZvVAiVBlBjkMhHMY@NAB-HP-ProDesk-600sony.com>
 <43447165-37f9-4b35-ace6-8d32760f75a8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43447165-37f9-4b35-ace6-8d32760f75a8@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SA0PR13MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b0e181-4e70-462a-4431-08dcdf05ab01
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TbkiV435Kb45fbU4Y+3RZ9lL2DVj5mCEk/V3fAfMbiVnPA74ZwEU3Zi4Qc+Q?=
 =?us-ascii?Q?p+I5TmJXczJhmdmmqNJ6DGe6FHS5z7+1Koid4QRagXDN3n0E6gpdYiF9Xcqy?=
 =?us-ascii?Q?GD52FSbg65FS/aMXLkMSSidS0Y/PIek1yHcF2TJ8yZhOJ/JA7iPC9zK2VlbB?=
 =?us-ascii?Q?Fvq7zsTO2dwCyKEpDHyH/UVRoQRdwHZcI6U3ymyS92iPqJgAUcMajbuDYZGJ?=
 =?us-ascii?Q?/+lFnTh7dRQRKAZgiaJUtl1X3VdUtOP20bxUtS+FWuzSQlC4ExGZbB0vpWcv?=
 =?us-ascii?Q?DlTc7JLQFZxTbT4/ag/YDzu+f5XYLUEFbk4qmQOR95v6tXN22m90sOLWk+p1?=
 =?us-ascii?Q?ZgC9D8mcrwB2dkjRzfQB5Yi6Ej3SwBL5i5vga0C63udejGslfS+GkT1HsxnG?=
 =?us-ascii?Q?HjhGaYhNUkEtfWoFscRcwRcQG7gp6UwC7gSXiTDOyFKgzVAnVT0GcguW0xRe?=
 =?us-ascii?Q?HzEyJ92WCD1EwmxwJtskO8YlRVkGhBfF6iiYfGnZ7UIRxEXqbaWGMjTytdfU?=
 =?us-ascii?Q?tFEcPSQ1pyc2raXUIa4Kv2dUdgFkJhvcbSRj7spYfjKfJllim+45iJneV5Ip?=
 =?us-ascii?Q?vSg42Yj7PEBGkAtHEK24DzK6W8R//M8Weby1mOSWmyc5NjeXBIrfKwGTac5Q?=
 =?us-ascii?Q?BopFTcExLE6ISt+S6aThOOh4Z+iVX9qbG5Hfz5B/STdFJ7LvdSIXE2/hvKyc?=
 =?us-ascii?Q?LkAUSwTJEVT+Iyif2K9OH1PxuKI2cNrFlWH+tCCQzjOKeVFJg8k4qdXb690G?=
 =?us-ascii?Q?yGRvRfNVp3aJKXcoOaEz1CvCCJFeoYnjd0Y/303nfFPQI3v0lYIYIAgLgNdI?=
 =?us-ascii?Q?U4z8wlHkPop9LyrVWeVBNCg2T/HmJ7O54dAjAqvggz3XjuQQkywAZ1vCf4AH?=
 =?us-ascii?Q?f3pL4yxj+IH9VJvMjtEXJtzo4/gem/o9Qwd2VKv9Dc4q0HtNa0EAWpimAcg+?=
 =?us-ascii?Q?kESNmP247Xnu+FJERCRlLvYrR9iUbXh+p8Wqk9FKrTrwZ2WMA6PENPrUwssu?=
 =?us-ascii?Q?sS6O4eYl9ro2FKirRfRuSOTZn5avgCJ8iM+/82Qln65uCBDUb8A4gXtCqJpS?=
 =?us-ascii?Q?kgxRFmGWk+v0d3LAsq+yMEenIdtlGCvVotLOsXvKCeN/KK3SqIqNS1OGRb55?=
 =?us-ascii?Q?cUYaZBMPIfxGco5zUg8JmgdEh3jVSMtpdAY2Cy+3cy5UCy9meF2c7ZnnU8qB?=
 =?us-ascii?Q?pREefaS+9vhowpiU3UifDwAWVP2e9wNrQmZS4gFJecd9brEK6B+TxI2ohMzo?=
 =?us-ascii?Q?fn4thtHEhuViRebCIOQ4TjuK3DLCSALgKlEguJNGkgdqgWxTY77gj4Wq4AuL?=
 =?us-ascii?Q?UoXSldcNHB/lFzSVm8VC6EZuY1pNVbCiqXv6JV1ovACGq3U/FEz1bSxvor0K?=
 =?us-ascii?Q?+vNwsWqT4QpxgMDictMStTV1wITt?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TD7IMffA/1qQHRtcg+VjpEJ8h15jsEB8mZqaRMFz/xolO2g6bxl7kQXLY0Ov4S+E59ouO7XGYYp1dGNkSv3hWuk2FBwAiwCBAOI9ocfaIv5FvOI+nfPGwsTn7mKudZmrXFOOo6+w5wpQPwRw3IQLwb35FyeKNN3XdYZFcgGgr7N4tk4idCPs45rapzuyh6dZk9yVye4jrhr2MrWwE4DEuqWWIulyxS1gyux2n0kn6ajsxfwVF7nyLH5xK2gsy8T6iAAX95vc7dIVU2UyRwmtPg2Pm8C1ycpRkY39IEU7ocPGqiE1fRkeBI0UaaN4H31hdMBbw6wA9XLEyyfBTll1TLyGjGxpQKneMmRZTWkOKT2kixzrlQlt9K/uwCLgW65iHcOyvcGcF8jClfRb2/ZlOf1kwOduZy2S8peSE9z/l7hN28UqdMr/2MQImQng1YVZ6IRzESaCPb1zv/KKr7HA+zPFJYujZWTcpC6mJcI1jryoH40SlsjQfAPsqC8t2UU6/24y1ZI7sUnnTUWFRWrMoTZgo7XwuPwkNn7HYNZAYkb2u5kuTU+FSgHU7Hl1M5YsIKbX1ruA+0VtNQIznSRsLH+Q4hdKkiSCLgNmlbny5ku7aDeHBajf9x7urE695XEw
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:04:21.0803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b0e181-4e70-462a-4431-08dcdf05ab01
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4078
X-Proofpoint-GUID: HLXNxn7Y9R9mVunCNRCH8-AwsOVRVSbo
X-Proofpoint-ORIG-GUID: HLXNxn7Y9R9mVunCNRCH8-AwsOVRVSbo
X-Sony-Outbound-GUID: HLXNxn7Y9R9mVunCNRCH8-AwsOVRVSbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01

On Thu, Sep 26, 2024 at 02:34:26PM +0200, Krzysztof Kozlowski wrote:
> On 26/09/2024 13:07, Nayeemahmed Badebade wrote:
> >>
> >>>> not required at the time of booting.
> >>>> Example: drivers/pci/controller/dwc/pci-imx6.c
> >>
> >> Just this one?  I don't see anything obvious that can't turn that into a
> >> module, have you tried?  What went wrong?
> >>
> > 
> > Yes we have tried building it as a module.
> > This driver currently registers abort handler for pci using function
> > hook_fault_code() on arm. This function is not exported and marked with __init
> > tag. So we can't use it post boot.
> 
> Then this is something to fix.
> 
Thank you for the suggestion.
As per discussion in below link, its mentioned that hooks should be static and
should not change during runtime due to locking support not being there.
So its not safe to export this function to use in modules as per the comments
there.
We would appreciate any suggestions you might have on any possible
alternatives.
> > Also from past attempt made to modularize this driver in community, we saw the
> > hook is not safe to be used post boot.
> > Reference:
> >  https://lore.kernel.org/linux-arm-kernel/1454889644-27830-2-git-send-email-paul.gortmaker@windriver.com/T/#m8995c6dcc40c54baef0665a7ee16d4209cb59655
> 
> 
> Best regards,
> Krzysztof
> 

Thank you.

Regards,
Nayeem

