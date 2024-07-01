Return-Path: <linux-kernel+bounces-235898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C896491DB0A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F9DB213E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F319F84D12;
	Mon,  1 Jul 2024 09:06:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF445C614;
	Mon,  1 Jul 2024 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824769; cv=none; b=fbu6zEErh/mhtFL0ezM7IDwz6KtGIDnb+xb50v7//OjKaswAEF4O1mXOk6TH8beSbbFQkKW7CrXN9vbN0q/R5UhLN/OOP2nrUP8njrIEpuKCwrPf3e5cEOB9n6PCmi26CEUGNx5ci8xwBiOO8fvJibqBGySF4nn/O4E8xcBjzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824769; c=relaxed/simple;
	bh=Fi10tkzUGz0fvpYCWE6tHxTsJkVRF2+Ox7u6M/6vt4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmVzVezZ2o7npokWxfGU/8ktDeQoaqaVX6cTQxFaJ60KjyUEj3AbPq7pQ5GLgIMnpfTsG7goItcsI75rAkxa/8Ph30PphEtq/aIoE1iS6d8i8dyzzQNFbhN8BJAUjf8CmGrQsQR36lK0Ohx4An+Rlq8zEdUIBasRH2hgj+U8IVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8627C339;
	Mon,  1 Jul 2024 02:06:31 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25783F766;
	Mon,  1 Jul 2024 02:06:04 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:06:00 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: introduce property
 mbox-rx-timeout-ms
Message-ID: <ZoJxeFxErmM8Gec3@bogus>
References: <20240621-scmi-mailbox-v1-v1-0-8ed450735f46@nxp.com>
 <20240621-scmi-mailbox-v1-v1-1-8ed450735f46@nxp.com>
 <20240627214645.GA614300-robh@kernel.org>
 <AM6PR04MB59415F7793F4D15CCCB7388B88D72@AM6PR04MB5941.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB59415F7793F4D15CCCB7388B88D72@AM6PR04MB5941.eurprd04.prod.outlook.com>

On Thu, Jun 27, 2024 at 11:17:49PM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: introduce
> > property mbox-rx-timeout-ms
> >
> > On Fri, Jun 21, 2024 at 08:46:57PM +0800, Peng Fan (OSS) wrote:
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
> > >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6
> > ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git
> > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > index 4d823f3b1f0e..d6cc2bf4c819 100644
> > > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > @@ -121,6 +121,12 @@ properties:
> > >        atomic mode of operation, even if requested.
> > >      default: 0
> > >
> > > +  max-rx-timeout-ms:
> > > +    description:
> > > +      An optional time value, expressed in milliseconds, representing,
> > on this
> > > +      platform, the mailbox maximum timeout value for receive
> > channel.
> >
> > "on this platform"? Doesn't every property apply to the given platform?
>
> Yeah, apply to all the use mailbox.
>
> >
> > > +    default: 0
> >
> > 0 means no timeout or response is instant?
>
> I should use 30ms same as what the driver currently use.
>

That sounds very wrong to me. The binding is independent of current driver
behaviour. How the driver handles the case of default 0 value is different
from what the default value in the DT means IMO. You can't just set a default
value in the DT binding based on the current driver setting.

We can always say since it is optional, absence of it is what driver handles
as 30ms. 0ms is impossible or incorrect value as transport involves some
delay even if it is in terms of uS. So I prefer to set a value of > 0 in DT
and make that a requirement.

--
Regards,
Sudeep

