Return-Path: <linux-kernel+bounces-256502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B266C934F66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42891C2140E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB32142E85;
	Thu, 18 Jul 2024 14:52:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ACA13D8A3;
	Thu, 18 Jul 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314360; cv=none; b=aarbEfT7Y6t3A0jmr/rkC1ToWkl8SE/tX5cFpjjXWKd53IBtDO+tKAmXaboFH7dNZ6vGQzHibk86AxwpX4GnrqyF0KpciIfAAR19ZtyrOpRIXNR/H1wbcM52QCI7ogJ17vWAAqGQmBWJjFcFwkulPVllaXpH3gcWO+2yklPxCPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314360; c=relaxed/simple;
	bh=eRMIhpXx67jc5E7w+2lKxu/NNGDoKKCI036UvAuKGrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Juk+ymWY7Z4KVcFzzlSz//UOUa3KcX1syKh02S4dOnDf5619W62quP+BcT/2l+4cSqZGWqR/NMBsVSwaq0RpJbvw+umv+P698YN6bPuY+stgcKgR+A9LOX2PzzqAA8K2EVHnBfe5k2JgUG/Gd1dV5/dB3ekovv5R7B0pVmTuOIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 970C71063;
	Thu, 18 Jul 2024 07:53:02 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 873663F762;
	Thu, 18 Jul 2024 07:52:35 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:52:32 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>
Subject: Re: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support system
 power protocol
Message-ID: <ZpksMAYaAkemr9dd@bogus>
References: <20240628030309.1162012-1-peng.fan@oss.nxp.com>
 <ZoZ8Mxjv9cIzivtk@bogus>
 <AM6PR04MB59419639315434DBFF2F13B688DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <PAXPR04MB8459EB8FC25AFF6D7C912F2A88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459EB8FC25AFF6D7C912F2A88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Thu, Jul 18, 2024 at 12:15:20PM +0000, Peng Fan wrote:
> Hi Sudeep,
> 
> > Subject: RE: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support
> > system power protocol
> > 
> > > Subject: Re: [PATCH RESEND] dt-bindings: firmware: arm,scmi:
> > support
> > > system power protocol
> > >
> > > On Fri, Jun 28, 2024 at 11:03:09AM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Add SCMI System Power Protocol bindings, and the protocol id is
> > > 0x12.
> > > >
> > >
> > > I think we must have this node only if it has dedicated channel or any
> > > other required property.
> > 
> > I posted a patchset to support nodes not in device tree. And Cristian
> > gave some comments:
> > https://lore.kernel.org/all/Znv1p3FDiPSUNmBM@pluto/
> >
> 
> Please suggest what should I do to avoid the dtbs_check issue.
> 
> Should I switch back to 
> https://lore.kernel.org/all/Znv1p3FDiPSUNmBM@pluto/
> or else?
>

Sorry I need to discuss with Cristain and decide. I might have already
discussed but I can't recall the details or decision(if any) made after
that. He is away now, will get back once we discuss and see what is the
best approach.

--
Regards,
Sudeep

