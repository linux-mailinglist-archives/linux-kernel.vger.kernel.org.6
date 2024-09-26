Return-Path: <linux-kernel+bounces-340208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCFF986FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08560281B67
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AAF1AB51C;
	Thu, 26 Sep 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="cxHWJv+b"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70811A76C3;
	Thu, 26 Sep 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342475; cv=fail; b=MKQNvCZ4eXPwj1ZceYJ5y26V9kOxlJExPAUBiRYHuJzRgqZ9vY0CnHYAn5YU2y0mA/dIP5DjvmlFNNPQMGFunTxtMaC+uDXU2N3HY55WjwAvlDq2+CyvhA3Z6QDfZs6eZLm0y91MxGY2sx7GKPBA8DTzWnCFGK3+HnVC7GZQsds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342475; c=relaxed/simple;
	bh=YIJP/zMPYHHjCUOk4nlf5FlWxGHGwC0I7DIwJj9WtTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmqR/3R7gta+1sdPjbaIzqJUgfaTMcU0N2Mi313JBVY3wPQMvEbCH6csKyf3VNVuvYXD3n9f0UN587dsL33nwf9HPG3YjQT0aWNonaDuOmJwGzVb+++ZbWbqWcNKDeEO7Tu5f0ohC5XDopQMfkHcVptV5nsr73tPXsi4fGT1Rps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=cxHWJv+b; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q63iWU007227;
	Thu, 26 Sep 2024 09:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=kiZyaOD1JfRvEwMrXN4Ihj6s+b1K//Y
	lcOLg9thLxPw=; b=cxHWJv+bL/HpBFRSADLNf//TDjcOfUIofLLJZxolqF5yQh4
	VLuUXix5DP/y9lysg3PK+5WFemq88yhccFHZXGcJRgdYqYi0l4piarKaHGfbumQH
	jJ38kc3av7ufVIXWXJnWU+d4QdYgyVtp1gI85eOWe5eqTpOh2pADeoHIMgiI2Wvg
	JZU80cfCOomLeZN0F9pkcSDHvuC6rPmZpV/gX6yXNhPSi1O98k9tUhQyXFAH4f1P
	RfRbKoh22cn1miiXLOynJnt0fhU7nC16VIuGDPxSB4zwJFcFQZxBRm5QB5XmLIAE
	/ehfH0pxCZBA1mbyX7iVFSNv7+m0h03TyukqTKw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41snfycceh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 09:13:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5mebtcJhi5k4CgG4y6Y9sqReNqH7b/d50evSqFJ7Z3FTCnVmM21ebsk6WBZVcpEQDSEm0bX4MI2dQjFkj4HeshnCJ1ICJqFgBem4C8nuyNci5P+wmpSjktjDewodLc3mhFmjZcwHaWg0Gt0TjSJQ5TAFcBW5neXfDFbnSHUlCuMTb13y05L4CXvlZ4YY8pYSAjZF2vRzyBtO+nFKzRO6lLDxAR0tRsDcLrG5T0nORxBisZgV7/Ec3x5iTq8ZLl1/1CBqObH2084IV22D1xh7cYcyTu1xUKRW8sWhpvv+Fb7mC8cNmsw2q4kyho+4RRtRElYri/99SiI116Ex9su3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiZyaOD1JfRvEwMrXN4Ihj6s+b1K//YlcOLg9thLxPw=;
 b=gQyg6t0wPyDxzQ7PUIZCA6jq/X4MQ8XAAapqlRo9hrFjFzZS0hvotpeSEfvHw6AuTpdk3uyiVjm2anX4sZCfKF26asrlSyOCiAmCRP5cWfjM8FXBE2K/ddID/tJeluxRNi8joR0SJLBLgnEEmql3M78E2BL2X7njYgOEHD+xC4qqyn2N04VFQtzG9y7NN/UF7zP0smyiq1rd3+pFOcButpfvexTaeZHUs+gsl8tXHbJP7izjUZ8CXFxu23jhTBgJx35ToZeDWnTAD9SV8Hvpbx2Uq30sbq4MICWvHFCLkeejmUWnuJsWAWPzpcybPk/mMZUrF6Lmq80Ihm40/nG04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from BYAPR21CA0025.namprd21.prod.outlook.com (2603:10b6:a03:114::35)
 by MN2PR13MB3990.namprd13.prod.outlook.com (2603:10b6:208:26d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 09:13:30 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::47) by BYAPR21CA0025.outlook.office365.com
 (2603:10b6:a03:114::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.3 via Frontend
 Transport; Thu, 26 Sep 2024 09:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 09:13:28 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48Q9DRBq011675
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Sep 2024 17:13:27 +0800
Received: from mail.sony.com ([43.88.80.182])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48Q9DPfo008174;
	Thu, 26 Sep 2024 17:13:25 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 0C9D11BA9039; Thu, 26 Sep 2024 15:10:47 +0530 (IST)
Date: Thu, 26 Sep 2024 15:10:47 +0530
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        yoshihiro.toyama@sony.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: probe-control: add probe control driver
Message-ID: <ZvUsH07dnvvIUg76@NAB-HP-ProDesk-600sony.com>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <20240911142319.3435746-2-nayeemahmed.badebade@sony.com>
 <cd4ff3c1-ece5-4508-93f0-2806cc6e76ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd4ff3c1-ece5-4508-93f0-2806cc6e76ba@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MN2PR13MB3990:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4a4488-0b10-4e8c-c1b1-08dcde0b7c7a
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X2+XDq4h3BeV0jBhRj/zdF4ouRs+rQam1SFBaKfBUU5O2pa/vrjMEbjQ6lyA?=
 =?us-ascii?Q?zcBsah0n8Ez2WE3DXpLFc9KvXhlKfjqAjFuVpULMa/NoFK+fTjN8c+e93i6x?=
 =?us-ascii?Q?myoaMOgKoKwkXulHudlQg91RfWJcMDq0/j2yAJ9V34ussYjJzvLbLacJRICU?=
 =?us-ascii?Q?zJJr5r4UDG88ZksYp/8qwe0zXurD+fDdJvzxe9KcoBvNnmVCTnX86qqTaLfK?=
 =?us-ascii?Q?Co30RfsD700q6iMJ0+TVipwqY4rkLZrU3zqRvR2swd0L0g40sW7nHaZfFxoG?=
 =?us-ascii?Q?V53GaqNCdyXymC8E8TgIOYyrvEKkxyOVCT6x4FUn7z5j3vOv8+3VJWCvaZWn?=
 =?us-ascii?Q?sqtb9IXQFFelWnlqdxNG22wftNImlsnY8fm/VcMlcd04XJCGHJ+lUyn5bYAJ?=
 =?us-ascii?Q?FjYmjSBGL8X8TAazEepvUGAB2YtgzhIUerNApsZaDrlU9JVnFplH3scXIlBb?=
 =?us-ascii?Q?WKX4geKeNOKqbVREAqjWH9tMw8mBYtvYSLsbSIf193j8qgleWw11x38CeCoZ?=
 =?us-ascii?Q?WqnJX/+PdU/ntqQ31Un9xvXwg6+9nG8TjMbFJKIQKOdWu2rr8MAogu7g3/NQ?=
 =?us-ascii?Q?yru7DmK0ADs35iQKu7KL6XkUGKz6gEOsda4+4whUIFlBOLKLBr3rT3aVWoJd?=
 =?us-ascii?Q?wnIaXfAmbZT6l893PMXEQ4+WI0rd1Q4xVIYbPzV4mc+9/KTT9QNlqb698Wux?=
 =?us-ascii?Q?h3WbyNF4foVIk0r7dGXvemq8FukdstLMG4GhOh1DgB3cWX1KMl/GMKSV1a/R?=
 =?us-ascii?Q?NfPoYODk7dQaWofgJ8nT2s2PYMsp/8JwsMW8DySLqNit10/F1airCcFCRxdy?=
 =?us-ascii?Q?EJFl90EgSq97KjeYWeKFvopXosoaL8PSAyfENzOMmM1k1ruBowLg1XqX2Yrk?=
 =?us-ascii?Q?VQcAcSfO4ExE6RQPMURRADFJne3FjCNhGX6NgcFozXDy90yopD803Yr+Ix+r?=
 =?us-ascii?Q?5JCVO3rYpm8Wey7hueYr/raH64cqAtcxanwSZb+o3sZ0d6yVWDKUFEkwYean?=
 =?us-ascii?Q?qaOPqgWwPCrVoPD8HnUnOPGb3rb6Hmf1DuJ0MKjupybG80neTPA0MQgVvXwX?=
 =?us-ascii?Q?6qosAdxe+MQ97W8DGHxXW0fdHH32jXr8xPK8izlWIiRXN/ahbAjJfUTh/ay5?=
 =?us-ascii?Q?u7BAvUn56eg5cHU6Li4V/A978XNtjF1lsqUPg6t03XWcQLJ8lxdGLHhqtzRR?=
 =?us-ascii?Q?CdAOmFTRd7m570AWF+ocZFeccUP0KmzGRNNKLo41iNOtaMBCcLUosOBlSml9?=
 =?us-ascii?Q?2v11/Jv6tAytiaMFm1w5E3LTeuCr7CbeeHA3Sk5zcTMxITKLqJc28Xgy1A3c?=
 =?us-ascii?Q?4r839cZpxlDF7MY7MOxkf9QmizGAUzWn0PByLBleDqdK5G9x78RJaL5Y5sNb?=
 =?us-ascii?Q?gdxAXkMK6ex6lz7GzCNt0jGQPSJT?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BnfNXFm7Wy5lKS4y9VMjwNt816x9DmGE2S/yq81ystlTtgSpOyk9/CmTxJCNxQyGTRlXNpVy6IQMdoYvxYfB6/QMiAR16OrgGQQM2ri/5+mtlhHBohuzZJqj0CleUubczlcz200jpmSjUowtoxY6dQykaNi5TppSzgGMqDzHKqWtUtYlQoumKSY32GN6s2b74mDhs3rITZvnaYsUOi41oxv4lzHqeyFB86uyTmlkD3IYcbz1w7y6w1sjJWf+Pmz1onjNRv8BxrPeAVhubkUPDLMc9BErXjzE4OavoOJ0AkW3LlfQTEvVuq8Ha/7GUZkBYg97Zwe/hJFlySt0q71bO7bhM/vgfJkSxGTDstL6eV6SlJ+kzBB2aYXOF1uQVKLRgm+bMdLknhBXB2t4T4e7KyKjQIZ2oeWGWLOxOjqR7DWZJ/hnGZTc44QNGqt4NNIfZz2n4HJjxEoswzzTdWWtW9NMk1p+RyAZDGm/wagzybDAn7bpZueJKYuGV6IK4jocYuCUln719kCl5ulgIYSBYFNVq8Yl39bzznBjQetDgxkdzf2rTFWyxfEeZ2NM2GAOweP+vs4ZhBPXjAkK6iPxs7xLchdDvmm5wwMeO9nGzZfIPAX9PqJn0xyXrjtu2Sa0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:13:28.8881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4a4488-0b10-4e8c-c1b1-08dcde0b7c7a
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3990
X-Proofpoint-ORIG-GUID: NnZbjdTEBtvIS4w6zq46DBaXgRvReg_I
X-Proofpoint-GUID: NnZbjdTEBtvIS4w6zq46DBaXgRvReg_I
X-Sony-Outbound-GUID: NnZbjdTEBtvIS4w6zq46DBaXgRvReg_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_03,2024-09-26_01,2024-09-02_01

On Tue, Sep 17, 2024 at 11:00:23AM +0200, Krzysztof Kozlowski wrote:

Hi Krzysztof,

Sorry for the delay in our response. 
Thank you for checking our patchset and sharing your comments for it.
We appreciate your feedback.


> On 11/09/2024 16:23, Nayeemahmed Badebade wrote:
> > Device tree binding document for the probe-control driver
> 
> Describe the hardware, not driver...
> 
> > 
> > Signed-off-by: Toyama Yoshihiro <yoshihiro.toyama@sony.com>
> > Signed-off-by: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
> > ---
> >  .../probe-control/linux,probe-controller.yaml | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml b/Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml
> > new file mode 100644
> > index 000000000000..1945a7a5ab3c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2024 Sony Group Corporation
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/linux,probe-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Probe control device
> > +
> > +maintainers:
> > +  - Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
> > +  - Toyama Yoshihiro <yoshihiro.toyama@sony.com>
> > +
> > +description: |
> > +  This binding is for controlling the probes of a set of devices in the system.
> > +  Probe control device is a dummy device that can be used to control the probe
> > +  of a group of devices. To have finer control, the devices can further be
> > +  divided into multiple groups and for each group a probe control device can
> > +  be assigned. This way, individual groups can be managed independently.
> > +  For example, one group can be for pcie based devices and other can be
> > +  scsi or usb devices.
> > +  Probe control device is provider node and the devices whose probes need to be
> > +  controlled, are consumer nodes. To establish control over consumer device
> > +  probes, each consumer device node need to refer the probe control provider
> > +  node by the phandle.
> 
> So all this looks like not suitable for DT at all.
> 

We understand now that this approach is not suitable for DT.

> > +
> > +properties:
> > +  compatible:
> > +    const: linux,probe-control
> > +
> > +  probe-control-supply:
> > +    description:
> > +      Phandle to the probe control provider node.
> 
> I don't understand this. Regulator supply is not a provider node.
> 
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    // The node below defines a probe control device/provider node
> > +    prb_ctrl_dev_0: prb_ctrl_dev_0 {
> 
> No underscores in node names.

Got it.

> 
> > +        compatible = "linux,probe-control";
> 
> Where are the resources? It's empty?
>

Yes, this was a dummy device node for controlling probes of actual devices.
But we understand now that this approach is not right.
Thank you.

Regards,
Nayeem

