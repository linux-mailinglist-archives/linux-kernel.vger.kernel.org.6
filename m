Return-Path: <linux-kernel+bounces-267738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EAE9414EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA9D282F89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BD11A2577;
	Tue, 30 Jul 2024 14:57:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120B1CA6B;
	Tue, 30 Jul 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351420; cv=none; b=oktr+CQ7oCz8P/Mq1y+z1Ri7KoHy1O5ArIMH6//vNpGyLdVT91jmZ/0zfN4AKEFEpgwwNEK7kdLNlWhqkve3tT0taYDKm2j6S+PIc4Cpm/QT1D2YTkqNWQRsm7YbZJ4pfPTYR0SCIOrrnyDANW5a4K45MRU4rYaO09WpH1KmuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351420; c=relaxed/simple;
	bh=VsBH3rXK2CS3G7G2pQ+b11aJQVl/XnQ5tZ2MibiEpB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8v1Wt9rVN8eoyWQPgSPbH16KmYsFajFBr2aB9wlTmCzbttG6ML/KEPY8BJ12dInS3f3Cnl4gYuvgmMHJaubft8VPLZ3gV6YeUjC1SLOCLXBDEvoVkhTL1gIkXSrLAO6m7RhPdmOgW3P/rcMg9u9smaXXVn93R9yv99hgXijUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E315F1007;
	Tue, 30 Jul 2024 07:57:23 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89E9A3F5A1;
	Tue, 30 Jul 2024 07:56:56 -0700 (PDT)
Date: Tue, 30 Jul 2024 15:56:32 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout value
 from device tree
Message-ID: <Zqj_ILnsWRHmSWaQ@pluto>
References: <20240709140957.3171255-1-peng.fan@oss.nxp.com>
 <20240709140957.3171255-2-peng.fan@oss.nxp.com>
 <PAXPR04MB84594F4271F68D9072BA0C0D88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <ZqjPGvTgtosWQTzM@pluto>
 <DB9PR04MB84613EEEC8EA13469757FF8B88B02@DB9PR04MB8461.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB84613EEEC8EA13469757FF8B88B02@DB9PR04MB8461.eurprd04.prod.outlook.com>

On Tue, Jul 30, 2024 at 02:24:17PM +0000, Peng Fan wrote:
> Hi Cristian,
> 
> > Subject: Re: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout
> > value from device tree
> > 
> > On Thu, Jul 18, 2024 at 02:24:15AM +0000, Peng Fan wrote:
> > > Hi Cristian,
> > >
> > 
> > Hi Peng,
> > 
> > > > Subject: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout
> > > > value from device tree
> > >
> > > The binding has got R-b from Rob, will you pick this patch in your
> > > next Patchset?
> > >
> > 
> > I am going to post a new transport_drivers_V3 and, as a separate series
> > on top of that, your latest "max-rx-timeuout" DT patch as reviewed by
> > Rob, plus the related new logic based on transport_drivers_V3 and a
> > few more similar changes as requested by Nikunj.
> 
> Ok, so your V3 not include this patchset. Do you have time to give
> a look on the 2nd patch? We are still waiting this got R-b to land
> this in Google GKI kernel.
> 

As said above, your max-rx-timeout-ms DT patch (with Rob R-b) and more is 
included in this small series (just posted):

https://lore.kernel.org/linux-arm-kernel/20240730144707.1647025-1-cristian.marussi@arm.com/T/#t

based on top of transport_drivers_V3.

Thanks,
Cristian

