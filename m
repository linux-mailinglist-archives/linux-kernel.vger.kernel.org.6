Return-Path: <linux-kernel+bounces-331486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A544B97AD67
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FDC1F21EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBC115C14D;
	Tue, 17 Sep 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="gSXFJCJu"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3F157485;
	Tue, 17 Sep 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563354; cv=fail; b=CNHSdUJisgWpK0akKvphImkzMM5Pd2Fl5ShNq97WL3k/4MVVqcZjlCTzRONXJ10d1HDTisJs1mrHyq710cjTLE+yBxclbW1jJpd0t5IlEA2ZjOXjkpiwWlVoDlIn9BpDCyY3F+d0gpvGIYuw/Qq54CCus+auv4syJ9WB6tJrUR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563354; c=relaxed/simple;
	bh=TjIv55c+GXxJpZuuSO6WbbOm72/lffgYXrHDrp7e1hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXXJ2pacSmXKVl4b+tb2tvYOF6M1GOGWMqcBJ7Rd7ZK6A4l/FdO/iKJQ+WFXyf0KTnotf1EvEIrFMI79OtxHiSkiC7YBhgXYVwmfIaRZT5Fl2ugue1XgnLubEDcjJ9DBdultMn0uWVuEGid9vWrD4LWheS1ixo1Ot3tQg/j2Rtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=gSXFJCJu; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H6qEm8005537;
	Tue, 17 Sep 2024 08:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=OZGDK86JVJ3rwfCI16CpHdsDgMbhbbt
	zK3Cu6aBs6eg=; b=gSXFJCJuCzKyo/aYNPvY8EV6pIVHyN3uksMCK7BhGoVvruR
	KtqhNin3Db5R7jizSsS2lDsCIWtF7toFp4BmHnvlpHj6CQSEtoOgJA/KhFythZF9
	Evs93RYXJ5tbo5Xumf6p5FHdQXaJfe0lrZ8u5g1ph0V/U9/8dDL3ekFk1WLWCpF/
	ZdbDN9G3JzHPhyyq3q2nBnEFdZzCNzgETk5v9C90F0vzelp8x56IifF/AvOVTC0I
	3OyYlLuT9IIMSXckCRyKptJgC/y4LspTYWZDSeYIYkg9udSM+S12IW1WfiXscIGH
	lvvhyO9n5crgLx36fz1BNs1MOM+uJm13kDKe8WA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41n3deaauw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 08:55:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0cdWkB+YwzpP/zJySSoMrkNJ0mwgfXo4Tt8MOTV1LK2Z69qNRy6nqmWEdtv4dEmrrOf8dbqjjvBuRojzqxl/ecgB1msFp0WBYmPYb0OCtvwLe/J/qrdvVWIVyE6QK2AlxiaOgjc/eOGEuhWEW4FnE2SpHEz00jkqOgA00o35S2gWVDD9sWWClmPrgGOYCFA8Zdb5DGoHJp0HqkDAQuBhMf8jm0TTHYpw38YnrQM+/1IPMTcLxxLsrx2wyHcFaX+cQKJx7f8T/xgQ55nuc7Qf41Hcb0iZ3xpRcSMHSVmh40aDiXa6xDB0OvZ3oE/aGkz20ieKNkhQWcMaaz02UXypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZGDK86JVJ3rwfCI16CpHdsDgMbhbbtzK3Cu6aBs6eg=;
 b=sD1bASej2ihFy4omiq9H2UReRipIJZGCGhb4b9lu6Zjld7VJXUQ1qSPRphzwWNEepobRqt9SjLsOtBVyb4v1yD/3wBbagGNBSTsq7yFSPRMAEZ5TRg27E5zRo4sopRDn0J03NbQd04IAm5W4KOnNe9A34YdoeadOBqoO1prslOpCi8u3LIG5Ua7/WcdifvsAk1sMR9zwDCQ2Nknch3DvZNCmyvHQZVBIEN0J6EqElloaX+VinDQ9QImYeyiCA2aPqWjMrA6gnRb6UQEYT3roUUBOb1t+0GJzKG5nKzxlF8Fzfw2hBKg5WBReorWLM61ivFZ0pObNwzR3yyG2HYp1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from SJ0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:a03:3a1::25)
 by PH0PR13MB5424.namprd13.prod.outlook.com (2603:10b6:510:12b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 08:55:38 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::d2) by SJ0PR03CA0380.outlook.office365.com
 (2603:10b6:a03:3a1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Tue, 17 Sep 2024 08:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 17 Sep 2024 08:55:37 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48H8tZVP000484
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 17 Sep 2024 16:55:35 +0800
Received: from mail.sony.com ([43.88.80.182])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48H8tYCO009762;
	Tue, 17 Sep 2024 16:55:34 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 5B95F1BA9034; Tue, 17 Sep 2024 14:52:51 +0530 (IST)
Date: Tue, 17 Sep 2024 14:52:51 +0530
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        rafael@kernel.org, yoshihiro.toyama@sony.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] driver: core: add probe control driver
Message-ID: <ZulKazNUcO9IiaVg@NAB-HP-ProDesk-600sony.com>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <20240911142319.3435746-3-nayeemahmed.badebade@sony.com>
 <2024091334-unsterile-blitz-efde@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091334-unsterile-blitz-efde@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|PH0PR13MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a35e66-a98a-4148-318a-08dcd6f6803b
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Asnm2LoqVVr0Yf2jvrC+TdCvvLQ365aNxgNWTacMk5tv2l+pTfosQxVW/4JB?=
 =?us-ascii?Q?S5Ql98KNVAyse6S3e8j8PqzyN7HpIdzvHm0rrIl3rnKDLYd9/k7PwJiTzU5S?=
 =?us-ascii?Q?V9rDS2VIeW6tscY6sppSdyopbULggH0kFwMbFpOPHWJDEBkrpt/GXpxKhwqV?=
 =?us-ascii?Q?22Yj3ZHj3peFjxeND4KyQDtUdqRnU1B17QhWzMI4l/xrKqhEAdKgrHJpnzq9?=
 =?us-ascii?Q?qp7SxtRTzMysP6iTlI48a7Grro1ShfTCbzKSbdoWESXFIXPUbbUjaVT+co8I?=
 =?us-ascii?Q?sFsVcmPsaqjS/NX+Ww+vOndqEhlkSn7midQisdPU03SKb8NHVQuD6pmS1bmo?=
 =?us-ascii?Q?jnbotoof3Mf1Um/K6jMck9cDxCyOCEPlBs0jSmGQrvi7DMRRvXk9YXcWmNHu?=
 =?us-ascii?Q?7236u65he/X47O4M0c/PhSlc0JQySsoJzl3ytydyGoEFHjW7eC1sTDe79YVQ?=
 =?us-ascii?Q?vo+tPFxnKcX9zv0TJjsYuiY4kcsQNf/4otD9pJbtbUbLKQwOnyGH9HNp4Yro?=
 =?us-ascii?Q?aYYP1ijnkb9bkk+pu4OC5tKSv7VuvFmKt+zh+3Gx2bWwN1QHBN4ZFd7ebRH3?=
 =?us-ascii?Q?dB148KCtTie0MGXer21Sl+Nq0klxDKaFGn+++ztxPg0GGtxT/tJomBuiI7AL?=
 =?us-ascii?Q?B02obs07LlN3WIhrnQ6jTOz3BDKDYZ3xuoPqGZU4AQDSPQtim52L3h0vUGfn?=
 =?us-ascii?Q?f5ArWNleGv5AG5KDYaj3s2IsWDEOqc9C1a0+fJ+q3gE7mRcHeiqttxPm5zkT?=
 =?us-ascii?Q?P1aBb11c5CFamOo5EmUoHZ1nl4k3tU5KC1zCGuBiklD5z6RpD1ZEJaGRI8bK?=
 =?us-ascii?Q?OGT0kJrUkylBCNjtszQdMXLah9Eh5qOIPtxaIwBDfET0N5YW/3EcjvBSdIFO?=
 =?us-ascii?Q?kEHTymVIDxoAsGIcqZrnif3Hghd/y12wuR6Deg2VtRrKx+eEu3J2V0DBxeCG?=
 =?us-ascii?Q?5FSLAujsBAUG7xH9TCFUbGLfgtY962XBqGvEUq7Rz3XGacLNw9PdVfyv9mO+?=
 =?us-ascii?Q?kIFwNzCKA7IGIGYgOvo6sp6hUNImjgqE6H9Xll3rYynA3kmoV84KINU3mXF7?=
 =?us-ascii?Q?06S4KT2HMdHLC/jPKAHo2gXbLNXK2S5hnajC2RXWWdmLruEy1WHXVRyVGYiP?=
 =?us-ascii?Q?pSEzIo1HDDJl4Jl6iHaxreZMGsx1yR3LD/CNeHQtDVP5itCO/rb4Y0E3IXDl?=
 =?us-ascii?Q?7S2jjs3TQ9wTl/lbAyXPxo+kJzSBhFonPrd79yesophMGWUIuh0UOdbNbqRK?=
 =?us-ascii?Q?WNs1uDgrcFRTSAduUE7USf52L0/p5dKo85rADSM+XMOkutf7iqO82ur2z3Mr?=
 =?us-ascii?Q?fym6Ca/sPUQh9TAtvbLPwYMZG3z7dezpchf0P3n14tVRCjlLqPqnA9aAHaDT?=
 =?us-ascii?Q?Ihh1dzjzILotvqwkx+0gGQ11Gt9t?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zKmlFtNLjn1PAi3L3Vu/1hqm0TbPww+kL5PTRlEmPkXAxj2CgpFm/RauOVGLTm6vA7fxdo+RnLE4kjwaqfUaPpaxL7hXHg/dHxmhl7kOnOlhvf1T7FP7kIGyJP7o0JLNGZksgO6LVU6r1Ohx6GqND2VKIgtSP9gHQl3rHrtnnAYc1KGOlwuN+MD7DlBJepXxMm0FEEp9Ms7DVXulcwI3LlyM5sSqDW0BKiId1OmmfPWZBg+vLx6VrzGgYFikUnHMzKzDoJIPGEclgPeOraU8w4bRNP2QgfiGEjWYf8QYPC1P36MLOAY0iD7dzIXQrgEXFqpwHUl7UJdMhHIcfIJB30GJ7ygPzCcakbbDxDIVNxqCSPRolbiKYTbgF5rspb69XMAixz1FhnpbqO4AJ3f+OYh9A4NEKSOxOjrsBwuMGGmqj85d0ihwotOvL5Y2EDYDEfFjj5RWChniecUYTfyYD/bJ+AVsaKGv1V1VlPqtYv4BkH+jw4Rhlx+jRj6fN6/Mw2tI8kgHqVdJ7BsbpcU59PPIZxm02wQsWhj5Nh9s7q2KougSDVv4l2UKAu4TwDsC9sjWY7vCj5yUjQ4z1wf9WNCk+5ukacQo6hJa7JSUoIUCrbV2O9LEnUZsjTl7/ENP
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 08:55:37.5960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a35e66-a98a-4148-318a-08dcd6f6803b
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5424
X-Proofpoint-GUID: 872yqvlrMmbphD_cgvXUAnXBB5V4Hmbo
X-Proofpoint-ORIG-GUID: 872yqvlrMmbphD_cgvXUAnXBB5V4Hmbo
X-Sony-Outbound-GUID: 872yqvlrMmbphD_cgvXUAnXBB5V4Hmbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01

On Fri, Sep 13, 2024 at 06:37:59AM +0200, Greg KH wrote:
> On Wed, Sep 11, 2024 at 07:53:19PM +0530, Nayeemahmed Badebade wrote:
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/debugfs-probe-control
> > @@ -0,0 +1,14 @@
> > +What:		/sys/kernel/debug/probe_control_status
> > +Date:		September 2024
> > +KernelVersion:	6.11.0
> 
> Minor nit, there's no way this can go into 6.11, you all know that :(
>

Thank you for checking the patch and pointing this out.
We will update this in next iteration based on feedback for the
proposed patchset.

Thanks,
Nayeem

