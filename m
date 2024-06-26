Return-Path: <linux-kernel+bounces-230907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10B19183A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35F31C20F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3BB18413F;
	Wed, 26 Jun 2024 14:07:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28191E52A;
	Wed, 26 Jun 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410838; cv=none; b=ggAFXrT3hE8RKUrqC13beraKMCncsIu2CKFZz4bHGoOuGfWr8JPj81oCT7kZ4BM1gTvcla2RCCl0ma/p5zzE6gXGNFZothsdozHGR1C+C6El5s/wwPZEyixzfMghj40N/QcBE5CnX8bYnXxEjypzQYvpdDHUK4vYEMMpZ6FxgD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410838; c=relaxed/simple;
	bh=+eeeSrMZ6VJCbxP9YfY650vMv9XvlESKex0KGtJ72H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axeQzRXXfffElycQ7nzUyg0wkbn1pYFUG1LNXzAa/2wL8Uk41w4OSZ4GLV0vmwseCY+kFJOHOiW6mvGiPU82NSZTMbRRS7Kl/eRh2/IcL2dxgE8Q7Ck1O0VTbvsX5h4ApTmoa+E6XDcOpQTKVcKLV4tTbwDErpf0BeWTamZy5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C02E7339;
	Wed, 26 Jun 2024 07:07:39 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEE273F766;
	Wed, 26 Jun 2024 07:07:13 -0700 (PDT)
Date: Wed, 26 Jun 2024 15:07:11 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] firmware: arm_scmi: create scmi devices for
 protocols that not have of_node
Message-ID: <Znwgj9fNi9ZNB48t@pluto>
References: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>
 <Znv1p3FDiPSUNmBM@pluto>
 <AM6PR04MB5941549618EEC4A7890D9DF488D62@AM6PR04MB5941.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5941549618EEC4A7890D9DF488D62@AM6PR04MB5941.eurprd04.prod.outlook.com>

On Wed, Jun 26, 2024 at 11:50:26AM +0000, Peng Fan wrote:
> Hi Cristian,
> 
> > Subject: Re: [PATCH 0/2] firmware: arm_scmi: create scmi devices for
> > protocols that not have of_node
> > 
> > On Wed, Jun 26, 2024 at 02:58:38PM +0800, Peng Fan (OSS) wrote:
> > > Per
> > 
> > Hi,
> > 
> > >
> 
> ...
> > >
> > > i.MX95 SCMI firmware not have dedicated channel for 0x12, and no
> > need
> > > of_node. This patchset is to support protocol 0x12 without the
> > > procotol node in device tree.
> > >
> > 
> > With this patch you change a bit of the core logic to allow for protocols
> > not explicitly described in the DT to be instantiated, and you use a
> > static builtin array to list such protocols...so any future change or any
> > downstream vendor protocols that want to use this, we will have to
> > patch and extend such protocols[] array.
> > 
> > Moreover, if anyone DO want to use a per-protocol channel in the
> > future on some of these protocols, it will work fine with your solution
> > on the code side, BUT you will still have anyway a DT binding check
> > error when you try to add that 0x12 node to contain a channel
> > description, right ?
> 
> Right.
> 
> > ... because in that case you will have re-added a (supposedly) empty
> > protocol node in order to containn the channels definitions and that
> > wont be yaml-compliant, am I right ?
> > 
> > IOW this solves your issue in the immediate, while adding complexity
> > to the core code and changing the core behaviour around protocols,
> > but it wont stand any future addition or different usage.
> > 
> > For these reasons, I still think that the cleanest solution is to just let
> > protocol nodes to exist even if not referenced anywhere from the DT
> > (your original patch to add protocol0x12 I think) simply because we
> > allow per-protocol channel definitions and so any empty unreferenced
> > protocol node could be needed in the future for this reason.
> 
> You mean this one [1], right?
> 
> I could rebase and send out it again.
> 
> > 
> > In this way we'll also keep treating protocols in an uniform way.
> > 
> > Just my opinion, though, I'll settle with what is finally decided anyway.
> 
> From reading the previous discussion as listed in cover letter,
> I thought there was an agreement that for non consumers, no per
> protocol channel node, we should not add it in device tree.
> But indeed binding is needed in case the channel has its own channel.
> 
> This patchset could be dropped if Sudeep and you both agree with [1]
>  

Yes indeed, not sure what at the end Sudeep thinks about this after
reading that thread again....that's why I specified that was just my opinion :P

Moreover, regarding this series, I wonder if, in general, allowing
protocol devices without an underlyng DT node could not be asking for
trouble in the future...in the sense that these devices are used by SCMI
drivers and can be used by them as they wish, including using them to
register with other subsytems, subsystems that can have assumnptions on
the fact the device has a valid underlying of_node... I maybe overthinking...

Anyway let's see if Sudeep prefers to go down this way I will post some
more comments on specifically how this series works..

Thanks,
Cristian

