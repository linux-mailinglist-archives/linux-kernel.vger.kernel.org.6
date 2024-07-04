Return-Path: <linux-kernel+bounces-241175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAC89277CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07501C235A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8761AEFDB;
	Thu,  4 Jul 2024 14:09:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E691AED59;
	Thu,  4 Jul 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102151; cv=none; b=QSYBhKPVgTGfp9Ik/aPtZcFlW6Rq72OVZzZD3a2N0RasBEw86y7chNqN3IKaLeh4O+NGw7KPKIRXyrKdJpGXp4nFJnyuEu/MZTcGmcU6aCAjgtZOmkML3VuBQV/SPxlTGk1KkQgh7potD1T4VgJqxOdXQzCdc2QuS47KtdX4svU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102151; c=relaxed/simple;
	bh=pFRLn+y1mz1uVUqeKtVvQepYQ3kownJiUBKeIvxzUsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H78YXlDty1Vt9CtXoJViqK1XdaSewykr2twNXBpJtxNfBPkit7+OSq1gHMcpv32qP8EB1bZfRb2ZjyV0VJTmwcAeK3ITMo1SqEDCoF0uaXTxf4hp7QUHYBeepTO7/mT7GZ5PkE6Zu7H6SZO8hhdCZDtBSXPNsGtIg7DGU7LC79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F369367;
	Thu,  4 Jul 2024 07:09:33 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1D933F766;
	Thu,  4 Jul 2024 07:09:06 -0700 (PDT)
Date: Thu, 4 Jul 2024 15:09:04 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Message-ID: <ZoatADKjBfpRCeLz@pluto>
References: <20240703031715.379815-1-peng.fan@oss.nxp.com>
 <ZoZ7NCSaG0YRK-60@bogus>
 <AM6PR04MB5941A61736496B9850A3B52C88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <ZoZ8pfi5KZZGY1wd@bogus>
 <AM6PR04MB5941F61DFB15AFDA384C153A88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5941F61DFB15AFDA384C153A88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>

On Thu, Jul 04, 2024 at 12:33:09PM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
> > property mbox-rx-timeout-ms
> > 
> > On Thu, Jul 04, 2024 at 10:39:53AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi:
> > > > introduce property mbox-rx-timeout-ms
> > > >
> > > > On Wed, Jul 03, 2024 at 11:17:14AM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > System Controller Management Interface(SCMI) firmwares might
> > > > have
> > > > > different designs by SCMI firmware developers. So the maximum
> > > > receive
> > > > > channel timeout value might also varies in the various designs.
> > > > >
> > > > > So introduce property mbox-rx-timeout-ms to let each platform
> > > > > could set its own timeout value in device tree.
> > > > >
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > >
> > > > > V2:
> > > > >  Drop defaults, update description.
> > > > >
> > > > >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6
> > > > ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git
> > > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > index ebf384e76df1..dcac0b36c76f 100644
> > > > > ---
> > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > +++
> > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > @@ -121,6 +121,12 @@ properties:
> > > > >        atomic mode of operation, even if requested.
> > > > >      default: 0
> > > > >
> > > > > +  max-rx-timeout-ms:
> > > > > +    description:
> > > > > +      An optional time value, expressed in milliseconds,
> > > > > + representing
> > > > the
> > > > > +      mailbox maximum timeout value for receive channel. The
> > > > > + value
> > > > should
> > > > > +      be a non-zero value if set.
> > > > > +
> > > >
> > > > IIRC, you had the min and max constraint in the earlier response.
> > > > You need to have rushed and posted another version before I could
> > > > respond with my preference.
> > > >
> > > > So there is no rush, these are v6.12 material. Take time for
> > > > respining and give some time for the review.
> > >
> > > Sure. I just not sure what the maximum should be set, so I drop the
> > > minimum and maximum from my previous email.
> > >
> > 
> > Worst case we can just have min constraint to indicate it must be non-
> > zero value as you have mentioned above and drop that statement as it
> > becomes explicit with the constraint.
> 
> I'll use below in v3:
>   max-rx-timeout-ms:                                                                                
>     description:                                                                                    
>       An optional time value, expressed in milliseconds, representing the                           
>       mailbox maximum timeout value for receive channel. The value should                           
>       be a non-zero value if set.                                                                   
>     minimum: 1
> 
> Put the binding away, when you have time, please check
> whether the driver changes are good or not.
> BTW, since our Android team is waiting for this patchset
> got R-b or A-b, then the patches could be accepted by Google common
> kernel, we could support GKI in our release which is soon in near
> days. So I am being pushed :) 

Hi Peng,

once the bindings are accepted I wanted to fold also this series of
yours in my transport rework series.

Thanks,
Cristian

