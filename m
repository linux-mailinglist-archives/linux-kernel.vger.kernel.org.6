Return-Path: <linux-kernel+bounces-341809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E419988682
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F511F24379
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD641BF316;
	Fri, 27 Sep 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="arewJ1Sp"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E81411E0;
	Fri, 27 Sep 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444864; cv=fail; b=V1CYC5Un5rZgM4Zja8vCqnc5KQyt6QaMCjUZ3AaDlcZYld6Gti5FKAQrRqW2fMZhsZ3vPKbJVQziOQGpA0IND7E2xr2dgNsT8IIyKJEfepYlv4k3fX7yBlKPCwAoNDFbQli+d+JlOkhEn2aePJHp1ijSi2Kr/8wqylNpw2lFMg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444864; c=relaxed/simple;
	bh=d5IqXDck2rUmJwU/vFwsS2BJHZPXxZQibDqhfU08RH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHXqGiUBDOgvi9u497ruyZey+fPqzfbhN2DhNegBrGHEPKZoc8I371iLV6stu362XVp7tefxyQD7g+fYXu4Jqkr0MNaUpSMxrA69uWcAYfklP7xjy1IYDIAobNfC4nOyaLK1JtAPcBUHWTk1dk1LXBeAZhOQGNT8Dp3whCm0FmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=arewJ1Sp; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R9Kiud016333;
	Fri, 27 Sep 2024 13:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=l6Po1c/leKWen0gLTunQbG9plwgpIgx
	tCvWeQM4wstA=; b=arewJ1SpF6cDQo/6rKa8efNmXgczKOGRlOgYRKcxMCBZLSI
	0jVkH8YLOIHPj8h6+siNyZZFTlvV2xExvV4SEtmxHxwOTpdNJKh9jeYBhNZIYJWb
	kPU7eMMiL/EC+hOT3B2/v0NKs3ny9c+QZGZG3+s0bp34+8UD7d/LYshMik2u9Y6d
	k4QeMXq4neO37OTdFVpi9EPQo5y+s6kwsPSIh4SA2PojzX2BCSaOaUciQaiGgNSN
	hLzi7h2WP53hGulPf7wHIwPqTDqgf6EX8RqxFxJsNiHJjPjb/wYrkxelaxJqLiSQ
	QDEaKs3AW2GW1L508SkPn5xIOnd9WA/MrL5kT6g==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41sphq5k1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 13:47:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7iESt53sOZXb6FGD941mvXaMPKo91pK2UYIlBuLIepjRTWMgWMCgGxQDIH0qfZwsdAOvC7PzYijRiyHPk6moKiKMrGrgFJnlX96EoOMQhRKPXi5DxndsK2olk/X/h6Zv6JJ7LscUbEY0n23mcfqLgsQl7JRH8jXTCE4IZkbDY1rwno8E4PnI7Qy5r2lTJf1r1Kqe8AmqafbYNtc2p62HkPtnenm/4KoNz4KLFAcxJ5U3JKhlieN8rVM2FFxdbzW7MXcZIxnVFABKCGQaINQS/h72TUCpJM5jsjsF8ptgW20ym64qZUfR2qqKkCBscShqx57cG/1/3hbhiOBQwSOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6Po1c/leKWen0gLTunQbG9plwgpIgxtCvWeQM4wstA=;
 b=QIxRVX9V3WzHd+btMS6Br3FxAXrCUpSbub3EljkcA1D5vklaI9ri5brYC+aRCyhb3rIM9AbQ5GR9CbwInKRfmTjglw0oDyGfxx416ssJkszxo7eNEbyaBNyi498cPss4Ron1cb2s2kug6aO41tV4RqQLI0E8ib2wKcdXOQnqXEh8zL9NScslUfyV305WfT8E2RM0YhNkA0c+wVR9pROUWYIk6KKZuxLyb3ooRxZHd59WUOREPeBI6Dc811abobsvT5znaxsdXnlqUBHAAGRvwaO1towxTVFFqrZLukqU5FS4EZLqnsmt2Eqd5hYlGn3+1BMsWcB4Mvl0khI3iTle9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from MN2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:23a::8)
 by IA2PR13MB6703.namprd13.prod.outlook.com (2603:10b6:208:4bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 13:47:20 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::b) by MN2PR03CA0003.outlook.office365.com
 (2603:10b6:208:23a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 13:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 13:47:19 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48RDlHRp018579;
	Fri, 27 Sep 2024 21:47:17 +0800
Received: from mail.sony.com ([43.88.80.182])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48RDlGSm013472;
	Fri, 27 Sep 2024 21:47:16 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id F121A1BA903B; Fri, 27 Sep 2024 19:44:37 +0530 (IST)
Date: Fri, 27 Sep 2024 19:44:37 +0530
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        rafael@kernel.org, yoshihiro.toyama@sony.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Add framework for user controlled driver probes
Message-ID: <Zva9zUY3DwEPeXwI@NAB-HP-ProDesk-600sony.com>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <2024091327-repacking-avatar-ec23@gregkh>
 <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>
 <2024091743-germinate-fructose-3ded@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091743-germinate-fructose-3ded@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA2PR13MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: dcca2898-51a9-4b6a-6b71-08dcdefae859
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7289dXdkjH64MfZpao8RAOaZ5d4wZVj4ViDhDh4E3uuHGqGa2TXww/AkUAvo?=
 =?us-ascii?Q?PU+t4IySmHxcOCqRncaGiJ6u8ynmiydoy+ZTMURIgzs25z0MATfY51WbzWxh?=
 =?us-ascii?Q?oGzByaLZPc6prD5Ug6u2rp87sNKQUs3aodCdVw1xoYVU2ygsPkOAsC0WFlHW?=
 =?us-ascii?Q?v/KSI3B0VVQMv1djUnzkCzfUYKMsgdwxxLslwcWeJNsjTtE2M34IAPaNYzsV?=
 =?us-ascii?Q?Hw3lgawrTXbeOmc99MRTqMVd7uMBDpcSwB6SIkNX0lNHMldZSdapebjYjcVo?=
 =?us-ascii?Q?2NjR6XJ7n31G4akMNsZY0gYXmtWPq/2eGbGBScRyoTvqMrd/Z0k6G4EBz/85?=
 =?us-ascii?Q?cQOhfybGLGyNldd7CpPua6SxNaHGEaX0qZVuGtmFnHcGEhHAOQPhb95DsyV8?=
 =?us-ascii?Q?0QkKP4wUeJ0MozWrkPEouh/sTOeOS3aCSO3GHLmIFI26Pvd6gN7VnbduOA5m?=
 =?us-ascii?Q?bHFtxn5CccQ+TYCvWX7h2HkPck+DeWJCidfnYVwYzYA1EVEYQ6gtdJvXpz0U?=
 =?us-ascii?Q?VR08xrRBAshwzDBvEfrx1UgUzKwqRXaRwDtCIbQmbraCYd4W7CyGoEMyCqGo?=
 =?us-ascii?Q?TZ8KAzNfoWgEeIbfq6/oMYI343byb5NpZWsK4HcbHVE2oFR6Fvz5ejpwLTRt?=
 =?us-ascii?Q?cnbQJ9FWdHnUrT2N58x6hyOOAxFKXl6EqC2kZMALLkgqGpzeA3ONsOthkgZn?=
 =?us-ascii?Q?jzAF9lr9MQcQ5NSVBbL5zL+smCn2fYBtcj94UYS2Su2gzPp/M+Lv24IYbPwy?=
 =?us-ascii?Q?cL5zT5GgUoENayGJr0RbuYtPOOIKJl9oYQwk6BDlrPMkh3Pijz/W25larzGL?=
 =?us-ascii?Q?qI74QYUokqonNZi6uY3IWepz447hM9iY8gcLe1+h/W0RdS0s5Cm/ZtBdXv8t?=
 =?us-ascii?Q?BTMr0rqs/XeOYO39JSQwVbdKhg4ILg++Vv0YmZzMoknEZeJExs9MncsnrAHm?=
 =?us-ascii?Q?WbbJ3YJtDODK2q9df2m4wQHLVmmCvfCN/s+7cL8z69ZYI8Ql/njP2cMWj/ap?=
 =?us-ascii?Q?uCR0cbLxSjdgp1bG3WL8nbY/Q3P9IDbShxN60vcQUMFw7EpCApm4QnXE7eQx?=
 =?us-ascii?Q?0MWaOwaX/A3yZIOWtna9nXm4p+KptbRj3QMI+GEd1BTxIQYR81HCFg5i17du?=
 =?us-ascii?Q?0E3O7AO3m8evYYW5T+f+ZCcYUtdkH2mt5Y/g5WiNkFasUAVu4Gd+TdkOXUP6?=
 =?us-ascii?Q?pA39gsiKYgV6KB6IzH5p6dl1cG7MUv7+bqdNiqK4PXsn3cZW4QUFmaSbBPeZ?=
 =?us-ascii?Q?z2r2MNk+ldWwXNrTxiI2jJncvy/NR8MPZ4nrk5XyUa/gJKHG7wF5L4cgXB37?=
 =?us-ascii?Q?AFzMt/xTLglswbsL1XEN0TfnyUxpm0ptppE+kltwxYWuyPBfHBS/+Vo37QKO?=
 =?us-ascii?Q?tF/vXpv1IKgW3OOqp4LBdwVyOjSa?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zFRtvbp77ACVCZf1I4QU0iOY/5BvmvNbk2Z7/CxwsuagpObOno2l7FZj+5PLu6L7J8PBvcwkDI+qjExwELcZI/e5mNHdXicD6dxF4GNjeJ+W/ovIdSGneOP8U52DPGQNEnFv/4KdpGmm11zt+EF5sbP3gASlw8lMv7tSQ8FiPWt1a1V5AuLB7URNQSePh6HFoHV/JL2Cg4/jFLOwBXMFSH0Ck40CY7GiO5qBBGfnjP3e1FVn3FmRCv0+WcyeerEh3F+l7iPpHWwVoVCSBA82kof4R/oxylGkL3nno68yHTa/EzUGLjh+9dLn9VeyUo+SRu0lfRp2KF+aoNkKXcYsB1Kx4+3j+a3KNSnqHY15CcCjIi2e0+VmOUT59SR3q4VsK5G5elpu2WBDNcbzpFQhIIGw6XoPhlQ0WxRTBZG6siOdvBKhbnA/vDEov8xAPoXx5RBKHcsnhllmbKdCgoPsWk8HSg1rqLCwmWTpNULFhitDAX6lqdt0/phJ+7oC2AmISPw7LrZlSs+1eJUncgJGb1xzQYuhZM09gMpNRV+YzRKFf9dR9Zb+2AlyhYYwvIoltpWpOl8TqZ+qXQSxGmRc9PKV2OdRevfwsS6OUI19GjFvK6OxElhWOYrevO6zUQU/
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:47:19.3944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcca2898-51a9-4b6a-6b71-08dcdefae859
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR13MB6703
X-Proofpoint-GUID: 1Kt2VX25IzvKHt0P7RqM_QegPkahuZhd
X-Proofpoint-ORIG-GUID: 1Kt2VX25IzvKHt0P7RqM_QegPkahuZhd
X-Sony-Outbound-GUID: 1Kt2VX25IzvKHt0P7RqM_QegPkahuZhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01

Hi Greg,

Sorry for the delay in our response.
Please find our reply to your comments:

On Tue, Sep 17, 2024 at 12:11:22PM +0200, Greg KH wrote:
> > On Fri, Sep 13, 2024 at 06:36:38AM +0200, Greg KH wrote:
> > > > This patch series introduces a new framework in the form of a driver
> > > > probe-control, aimed at addressing the need for deferring the probes
> > > > from built-in drivers in kernels where modules are not used.
> > > 
> > > Wait, why?
> > >
> > 
> > We have a scenario where a driver cannot be built as a module and ends up
> > as a built-in driver. We don't want to probe this driver during boot as its
> > not required at the time of booting.
> > Example: drivers/pci/controller/dwc/pci-imx6.c
> > So the intention is to only postpone some driver probes similar to:
> > https://elinux.org/Deferred_Initcalls
> > But instead of delaying initcall execution(which requires initmem to be kept
> > and not freed during boot) we are trying to delay driver probes as this is
> > much simpler.
> > The proposed driver is a generic solution for managing such driver
> > probes.
> 
> Again, please fix the drivers that are having problems with this, and
> build them as a module and load them when you need/want them and can be
> probed correctly.
> 

Sure, we will try to do that.

> > > > In such scenario, delaying the initialization of certain devices such
> > > > as pcie based devices not needed during boot and giving user the control
> > > > on probing these devices post boot, can help reduce overall boot time.
> > > > This is achieved without modifying the driver code, simply by configuring
> > > > the platform device tree.
> > > 
> > > PCI devices should not be on the platform device tree.
> > >
> > 
> > You are right, we are referring to the pci host controller that will be
> > listed in device tree and skipping its probe during boot as an example
> > here.
> 
> pci host controllers should really be availble at boot time, wow your
> hardware is b0rked, sorry.  Just make it a module and load it when you
> want/need it.
> 
> > > And what's wrong with async probing?  That was written for this very
> > > issue.
> > >
> > 
> > We have explored async probe as an option, but we noticed below:
> > 1) Probe initiated via async
> > 2) Boot continues with other setup.
> > 3) Boot reaches stage where ip configuration is to be done via
> >    ip_auto_config() and 1) is still in progress, then boot waits for all
> >    async calls to be completed before proceeding with network setup.
> >    ip_auto_config()
> >     -> wait_for_devices()
> >       -> wait_for_device_probe()
> >          -> async_synchronize_full()
> > 4) Similar thing happens with rootfs mount step in prepare_namespace()
> >    initcall
> 
> Again, if you make the problem driver as a module you should be ok,
> right?
> 

Yes.

> > So to avoid getting blocked on these probes which are not required
> > during boot, we proposed this driver for managing such built-in driver
> > probes execution.
> 
> Fix the broken drivers please :)
> 

Sure, we will do that.
Thank you for your feedback.

Regards,
Nayeem

