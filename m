Return-Path: <linux-kernel+bounces-331441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C381197ACF3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80907284561
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2CD1531F9;
	Tue, 17 Sep 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="YxtbElDo"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B4BE4F;
	Tue, 17 Sep 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562393; cv=fail; b=jl4yum6iTiGHNcKHdQ67TfxOsKQKwA5tBiFgLY9tfbj/qtDcjEYJ7wd59V3RuXJe+LNZcMA3Q4RvZBpc5gHZQbTS6//Q7sNPbvU6Xf/pwUSsFYn4MZeYP5vpYJAydGgHuDXKp8mCTsFlBK0emTpyc7QHiUeYe+Ihzx/wCoQUkZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562393; c=relaxed/simple;
	bh=DY/Lm8YLCYRdU+RsRFNDJo927V3FpNMfNlqqHp2HlXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNIkOEkhTJfsuEQer1/g8+RN6RJhJIAU0vIIZJNqrGLbE/ofypIBSbUoxoQHxjtUxOzF8Bbms3jz/PSc7ekXPkhUonHONboKaLsk2mu5FaAaZ7J1ebyv0WTk0Fc5pOYP6dBaCOE92SR2f+Dhx5B2vhhxxrHUeFsvEnLqNk2QJ0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=YxtbElDo; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H2UlEW027050;
	Tue, 17 Sep 2024 08:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=szfxXrHC2aEjm/4yZ6F39wxs5zb+GtD
	Byb/FSyAZS8w=; b=YxtbElDoks5bblBkB91V0DUDPAf9iPo1HQ7gZ68AOA6ClRP
	NQ8jzHvdYZR0YEtpmWJjPYWnGM7mu8NuJMxu+13mFXYjqzZCBkLsrR3ddr03rqDh
	cHVs1Ye+kjDzjg6gOd0H3u5/0viakc+Ir+IEQ6aUkrCZb5eXVWCmGyXj9Tf0zjOX
	jCkCaxVNHfZbPP2KKkT4/z8GjSCIViDR+5GlZxCMY8T24cHYFWx9uD6qVF7IsfyD
	MVHjT1YK7yXHAv8mwTXsq8qpyyeFrnJxdUn9BL9DnwlYxQFXJIWuJ07UUSjSFTt1
	gPY0UVS3y9L9ihmmMrZhyWRZlHnHLRF9qFgJJqA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41n3g7j1yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 08:39:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/waAFRLcnl2CW3HzvIYR+VLB979H7irxdUcknZUHSwHGuOhZU3KRoUKWnPa+KYxl9TEAUVrSYRQATGFN66RtmzjKNla3IXTds9rsk5UDuiwXYhHxa8+afD8D7hsYyMQdzRnUETvZv7gkN4h5XrVtA/RRMbR5yobMTq3eM++NkqGa5gdASCCbnKG9lLnCwEc4B5PvQUD/vPEBZrdWCbz61U9P9a0MUNfxdyN9TkKWTn94vPaquLOc/ZCQn/TndGP+f3UySvywRZQEeqMTspkvcmm74/3kizagn7eOvY5y95ZM1NA4YMe4pBIUvGwhBb+2kBqlCXw7SrCoYiPbjIc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szfxXrHC2aEjm/4yZ6F39wxs5zb+GtDByb/FSyAZS8w=;
 b=vP0OPkbf0LIP0MbKxdko1ZvLGlzvT/tEebhIt+a0gLQYo0jtw5YACl1G/k73Xd3pEUT5d3hMUKORapsccUg2l9MHVJIC2qdqXTGnpVuOlUkMqkXjApGbm97es70G2TjN3x2OlM/QO+3ZRZfx6xwCQ58lLzTADQX65/hBKlIPBvxOZHFXilO8nTtfIlETs6Cu0uIkSbDbNzk8CeWQD21YK/vMPLzx+3x/klRRQz770ejpe1MKaOkJl+x91gULX44T5ohVyhsRnGMHhe9hswVFVJybgpsbYwKh3Sxi7lE4LcOtJ6/Wz1b/aAPm3gYVndU5QeiqxZf2M0aALI2+ykoZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from MN2PR11CA0012.namprd11.prod.outlook.com (2603:10b6:208:23b::17)
 by SJ0PR13MB5893.namprd13.prod.outlook.com (2603:10b6:a03:437::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 08:39:43 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::ec) by MN2PR11CA0012.outlook.office365.com
 (2603:10b6:208:23b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Tue, 17 Sep 2024 08:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 17 Sep 2024 08:39:41 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48H8ddVJ030970;
	Tue, 17 Sep 2024 16:39:39 +0800
Received: from mail.sony.com ([43.88.80.182])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48H8dctD027116;
	Tue, 17 Sep 2024 16:39:38 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 5195C1BA9034; Tue, 17 Sep 2024 14:36:55 +0530 (IST)
Date: Tue, 17 Sep 2024 14:36:55 +0530
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        rafael@kernel.org, yoshihiro.toyama@sony.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Add framework for user controlled driver probes
Message-ID: <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <2024091327-repacking-avatar-ec23@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091327-repacking-avatar-ec23@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ0PR13MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 52317e26-bade-4adc-1087-08dcd6f44680
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DIzOGnDj1xEynzHA26rOVQ8iJUz/oEYrFymGfWHuwkUqQq8cq64LXvObSB9o?=
 =?us-ascii?Q?YZ64Z1LOZMgUXQrypUwtKBkw4WHgyHuiJxhyWxtoDdnJcGbbIMh9e4oqL87Q?=
 =?us-ascii?Q?KzfiiT4ZGoWoAnWYkc/1JQSbJQwpjZdqFWBU6C0FJG8qN3gzidNLKtnZAh6l?=
 =?us-ascii?Q?AV/l+vAaoUyOra/El2w4P5MdU5sITMZcz8Hohly7YFYKJkQyDFgpkzP/5DgZ?=
 =?us-ascii?Q?yzNOWEGNbwGwc/9Oev1rhyNzYJfBFBBY/JbJXnuUwn+eGnH51REbar6CJdpn?=
 =?us-ascii?Q?dAT+ct1K79hxdTZSsYjornBUmgxq7uzfcqXKfS7j/seSV5/zLtmOg0NuGxPJ?=
 =?us-ascii?Q?bR4HPQAQj9F5OHbwPRxaNSt8meIEes0nDHoKgRRF2gi9DvBOJhauKLphMSeG?=
 =?us-ascii?Q?wlVmajQ1xi9qVSJ4diLIy/KkfL9y6V5MxDySR/lVEZQHBpzJHAChZvNgq7Z8?=
 =?us-ascii?Q?sIMtUCjy7Xt6wVJOldyWoipGmaXZDtBy631wZ6PUj23wGgIbdV/4Zlj9ajJM?=
 =?us-ascii?Q?aqLeRVwDyp5gvEfaik6hikTCeXNZEQ8PwT4THGyBAb9zsCy+vGH5D34Fc6kr?=
 =?us-ascii?Q?dvn0S8YMPL8UCvtRSYcqrjAvk9u/K+4ezrVVYrveizT40NZ6js73b+IZ+SHe?=
 =?us-ascii?Q?UeNN4YGFL+XP2I2yDfKvGl8xBz8Typ8VIT4rsp9/7N6E2r6o8FIMQeDIqSVX?=
 =?us-ascii?Q?V2VSXyK21hyzEwG9vQJ8lwLmmjdQPgVNzIw3M4vNdblbA02tj+hxIstPlCZd?=
 =?us-ascii?Q?VtU7yvGwNWqpbiSk5y73VrYYZTqmxzkJ7ytGmWMX4X91678zXC0PuKujtMJ3?=
 =?us-ascii?Q?/QG3hIzrg6sjhwxelkOwVaszjXxNJfosu+62dlrGrlJRzKWUOCLj4cYDredR?=
 =?us-ascii?Q?Cat6ZHDCiwv46XmS+/8oORYR1xnb1MLqWv/gxLoDjc132yPp5rTzGlJNBYls?=
 =?us-ascii?Q?HViHeSiowFl1eqwORM45CaEMXGtRPeOSvXiQp97FQAehbW8ZX6BeHVP8XxeQ?=
 =?us-ascii?Q?sW/+Z9KVBU811p5f8JbwtlJ0Rk9ZAJKOUSKhpmjNHZGkVdF8VFcJlRG9ppdF?=
 =?us-ascii?Q?Av+F7BucHxONDG3ldvRR+fOmLMsXwYi3fh7GwUK95TQV2QUe+h1glDKUJrlE?=
 =?us-ascii?Q?S/+mPXV9EqG7IzeEiiQF/5d0UrOuPC/eileEJagzAPuz2M/WBZJnAa5lqk+4?=
 =?us-ascii?Q?+En/8Sl6UvcNpS503ddHmFHRUhk19wdrRDUUdRTeuH76hvMO6anEc4J9R64P?=
 =?us-ascii?Q?eqxK65hW6A0k+H+ZkYN+zKB04eGr8NPBj1Xt8MCjf+qA24JrxrKTAEbkXQsJ?=
 =?us-ascii?Q?MCT8IghEfwVL8Ygi9Xj2yZDBbVhraSXi0/je8bOxoOzR+xKyG/+j8DsW+1z3?=
 =?us-ascii?Q?nKgWS2twA4c5lucd74BoTBmIusa9?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	in9Q1aM4MQwqmW8GIu8Xz1GCz1fp3E2WAYPLPVVIVeMzHP8nE6QJdgV0ksZLy0cNU+AhSmxxiyd7QS9SCXYzqGvbksrqhmWdtoNFpqY3V46OpvqOJ7JyU+ilsP2GCn9rr/56MJW88Rxxfsv0zElTe0Bw+pnoP3yPehZGYxm7l5TcBzEmcqT5GVW+48NjrARvGdTLftZYayOJ04W2GsRXpdvZnKnRkAaiBUcpRqKpgNfucB3CqdoxvGnybGwAhNa/sq4EsbRV0vEQAR+6blOEYqC5UwyfEa6XA2Ij4OarqSaS1OR18akoG5a7ru0V54XVvKkAamBOypEGOkkCG45n3A1y6GKuBjOytp3BKM0Hgs2zWmyP9qATHPCyp1ZrYIU7v+k1YrOAmfRUhwDadj9aiYqx0cdDfWZA0sUhq7NYncr+wQGkseCi1Uh9qGfV5cPEHaTLvpfTRsrjeazCv331Xstz6/k82lwQ/hTX20V8qQw+I8etNO9WId0E+zLYrMTFa+hbLCEiNlOHzeYgnOkpNZJWT5y5lGtcMYsc7JhbL/RRtPZ1rgOptgYCraQKEaGY0iuYN9IyRW92fziL585lfHtKf8bEgSQlcz3O4LoRiueLRpy9uLPMe+tFKf38RKwO
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 08:39:41.5898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52317e26-bade-4adc-1087-08dcd6f44680
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5893
X-Proofpoint-ORIG-GUID: SfXCqwWihAyV1kvG79CKmMpkGX9KPsiL
X-Proofpoint-GUID: SfXCqwWihAyV1kvG79CKmMpkGX9KPsiL
X-Sony-Outbound-GUID: SfXCqwWihAyV1kvG79CKmMpkGX9KPsiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01

Hi Greg,

Thank you for taking the time to check our patch and provide
valuable feedback. We appreciate your comments/suggestions.

Please find our reply to your comments.

On Fri, Sep 13, 2024 at 06:36:38AM +0200, Greg KH wrote:
> On Wed, Sep 11, 2024 at 07:53:17PM +0530, Nayeemahmed Badebade wrote:
> > Hi,
> 
> If Rob hadn't responded, I wouldn't have noticed these as they ended up
> in spam for some reason.  You might want to check your email settings...
> 

I have ensured standard settings which we have been using are used this
time, let me know if this email is received properly.

> > This patch series introduces a new framework in the form of a driver
> > probe-control, aimed at addressing the need for deferring the probes
> > from built-in drivers in kernels where modules are not used.
> 
> Wait, why?
>

We have a scenario where a driver cannot be built as a module and ends up
as a built-in driver. We don't want to probe this driver during boot as its
not required at the time of booting.
Example: drivers/pci/controller/dwc/pci-imx6.c
So the intention is to only postpone some driver probes similar to:
https://elinux.org/Deferred_Initcalls
But instead of delaying initcall execution(which requires initmem to be kept
and not freed during boot) we are trying to delay driver probes as this is
much simpler.
The proposed driver is a generic solution for managing such driver
probes.

> > In such scenario, delaying the initialization of certain devices such
> > as pcie based devices not needed during boot and giving user the control
> > on probing these devices post boot, can help reduce overall boot time.
> > This is achieved without modifying the driver code, simply by configuring
> > the platform device tree.
> 
> PCI devices should not be on the platform device tree.
>

You are right, we are referring to the pci host controller that will be
listed in device tree and skipping its probe during boot as an example
here.

> And what's wrong with async probing?  That was written for this very
> issue.
>

We have explored async probe as an option, but we noticed below:
1) Probe initiated via async
2) Boot continues with other setup.
3) Boot reaches stage where ip configuration is to be done via
   ip_auto_config() and 1) is still in progress, then boot waits for all
   async calls to be completed before proceeding with network setup.
   ip_auto_config()
    -> wait_for_devices()
      -> wait_for_device_probe()
         -> async_synchronize_full()
4) Similar thing happens with rootfs mount step in prepare_namespace()
   initcall

So to avoid getting blocked on these probes which are not required
during boot, we proposed this driver for managing such built-in driver
probes execution.

> > This patch series includes 2 patches:
> > 
> > 1) dt-binding document for the probe-control driver
> >    This document explains how device tree of a platform can be configured
> >    to use probe-control devices for deferring the probes of certain
> >    devices.
> 
> But what does that have to do with PCI devices?

As explained before, the driver is generic one and is for managing probes of
drivers that are built-in.

To delay such probes, in DT we add dummy devices managed by the proposed
driver. These dummy devices(probe control devices) will be setup as
supplier to the device nodes that we want to probe later.
dt-binding doc patch explains this process with pci controller node as
an example that needs to be probed later after the boot.

> 
> > 2) probe-control driver implementation
> >    This provides actual driver implementation along with relevant ABI
> >    documentation for the sys interfaces that driver provides to the user:
> >    /sys/kernel/probe_control/trigger - For triggering the probes
> 
> What's wrong with the existing userspace api to trigger a probe again?
> Why doesn't that work?
> 

The interface is specific to triggering probes of these dummy device
nodes(probe control devices) setup as supplier to device node we want
to probe later.
As multiple probe control devices can be setup in DT, this one common
interface allows triggering of specific probe control device or all
probe control devices.
The probes of these dummy device node return success only when they are
probed like this and existing kernel framework will then probe their
consumers automatically(these are the devices we wanted to probe later
after the boot).

> I think you need to explain and prove why the existing apis we have that
> were designed to resolve stuff like this don't work.
> 
> And if you all are abusing platform drivers and the bus there, well, I
> hate to say I told you so, but...
> 
> thanks,
> 
> greg k-h

We have explained the scenario for which this driver was written and why
existing options such as async probe may not work in such scenario.
Let us know your comments on this.

Thanks,
Nayeem

