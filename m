Return-Path: <linux-kernel+bounces-240889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B16092743B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94981F249ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E0B1ABC53;
	Thu,  4 Jul 2024 10:42:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F015538C;
	Thu,  4 Jul 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089772; cv=none; b=qRWeKYzkX6fKK2MZEB9DCXjCOUr6ilJONNzqVdYQhr0aybMGjrxkVG6zI5S7OHFC5EEfb6Djdgy/socuOi3uWpwlAv1GxjrY2498B8F89ov3P9g7SvaykEuvBzQ3m2AGq0hHy3MkH/5ACWmvl8dAVdT8dupw2MYSbXm81bg1+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089772; c=relaxed/simple;
	bh=3lQCD0sgScVx+sCKPmOBwLlG++IGHQRJoGd6A52ReTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhBGsSc+9LoFVygAiB6kt8aaqw78YnPV3sINKC12BQJAIKPtYV7+nCHrTEW9tm4cp6ySxxmMmxJ+Rv4UTT8cuoHvpbvepyoS5u8WDEqWHOXOodnGTcEdJbQCk9AJjvbLtrYre6lssK4+drpg5F0+teSSUds/32RF9udFb3nK0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A66FA367;
	Thu,  4 Jul 2024 03:43:14 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1FE43F762;
	Thu,  4 Jul 2024 03:42:47 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:42:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Message-ID: <ZoZ8pfi5KZZGY1wd@bogus>
References: <20240703031715.379815-1-peng.fan@oss.nxp.com>
 <ZoZ7NCSaG0YRK-60@bogus>
 <AM6PR04MB5941A61736496B9850A3B52C88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5941A61736496B9850A3B52C88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>

On Thu, Jul 04, 2024 at 10:39:53AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
> > property mbox-rx-timeout-ms
> > 
> > On Wed, Jul 03, 2024 at 11:17:14AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > System Controller Management Interface(SCMI) firmwares might
> > have
> > > different designs by SCMI firmware developers. So the maximum
> > receive
> > > channel timeout value might also varies in the various designs.
> > >
> > > So introduce property mbox-rx-timeout-ms to let each platform could
> > > set its own timeout value in device tree.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > >  Drop defaults, update description.
> > >
> > >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6
> > ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git
> > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > index ebf384e76df1..dcac0b36c76f 100644
> > > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > @@ -121,6 +121,12 @@ properties:
> > >        atomic mode of operation, even if requested.
> > >      default: 0
> > >
> > > +  max-rx-timeout-ms:
> > > +    description:
> > > +      An optional time value, expressed in milliseconds, representing
> > the
> > > +      mailbox maximum timeout value for receive channel. The value
> > should
> > > +      be a non-zero value if set.
> > > +
> > 
> > IIRC, you had the min and max constraint in the earlier response. You
> > need to have rushed and posted another version before I could respond
> > with my preference.
> > 
> > So there is no rush, these are v6.12 material. Take time for respining
> > and give some time for the review.
> 
> Sure. I just not sure what the maximum should be set, so I drop
> the minimum and maximum from my previous email.
> 

Worst case we can just have min constraint to indicate it must be non-zero
value as you have mentioned above and drop that statement as it becomes
explicit with the constraint.

-- 
Regards,
Sudeep

