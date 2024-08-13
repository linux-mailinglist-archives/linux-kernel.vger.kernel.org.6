Return-Path: <linux-kernel+bounces-284900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9941095068E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91959B2333E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047D919B5A3;
	Tue, 13 Aug 2024 13:33:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213E919AD56;
	Tue, 13 Aug 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556029; cv=none; b=XRTnUtSA+WCPDa4ID9BNEKxfdj7zacHBoubsJUoFIXAxaAvJAHPDEpUf+EjcbuMCDRrv0QXQBVskmD+em1P+OWovLShPwA9rA1QKZ3i+dxFzUw1py2yaXrf28hR5QPRfuT1RpAe2XbTXZlsddyRcXdr3uyfFfduWgcnq0JUNojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556029; c=relaxed/simple;
	bh=Z1ZsCp/XO1iuTEc+GAwxMtnVpWs/xmuGXWBt8klgSnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuxc11KurOYxc/rcBVbCZbx5js71jVWYmKzZDZUbVUTISrQDgO/70UfMoNdDFaG65PX2VTa4AQ2eHc9TDJKR9WNgpJ6h66qFEwIAM2cYUdwvnpr/FhiJqbhexn/yRh+/PKtoRwgpTCcypen9YHNdJL0hqK0CZUL9XbAyp38HWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A0C812FC;
	Tue, 13 Aug 2024 06:34:12 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28A173F6A8;
	Tue, 13 Aug 2024 06:33:45 -0700 (PDT)
Date: Tue, 13 Aug 2024 14:33:42 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: Update various protocols versions
Message-ID: <Zrtgtu9FF4um7kit@pluto>
References: <20240812174027.3931160-1-cristian.marussi@arm.com>
 <20240813112237.drwgvhor3eisaj6t@lcpd911>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813112237.drwgvhor3eisaj6t@lcpd911>

On Tue, Aug 13, 2024 at 04:52:37PM +0530, Dhruva Gole wrote:
> On Aug 12, 2024 at 18:40:27 +0100, Cristian Marussi wrote:
> > A few protocol versions had been increased with SCMI v3.2.
> > Update accordingly the supported version define in the kernel stack, since
> > all the mandatory Base commands are indeed already supported.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/base.c    | 2 +-
> 
> I assume this patch supersedes [1] ?
> 
> [1] https://lore.kernel.org/arm-scmi/ZrZMLZq_-b9EFRgn@pluto/T/#t
> 

Oh Yes, I replied to myself on that saying that I spotted more versions
ro fix.

> >  drivers/firmware/arm_scmi/power.c   | 2 +-
> >  drivers/firmware/arm_scmi/reset.c   | 2 +-
> >  drivers/firmware/arm_scmi/sensors.c | 2 +-
> >  drivers/firmware/arm_scmi/system.c  | 2 +-
> >  drivers/firmware/arm_scmi/voltage.c | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> > index 97254de35ab0..9939b1d84b7a 100644
> > --- a/drivers/firmware/arm_scmi/base.c
> > +++ b/drivers/firmware/arm_scmi/base.c
> > @@ -14,7 +14,7 @@
> >  #include "notify.h"
> >  
> >  /* Updated only after ALL the mandatory features for that version are merged */
> > -#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
> > +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20001
> 
> Just curious, in upstream master TF-A I see 0x20000 still? [1]
> 
> [1] https://github.com/ARM-software/arm-trusted-firmware/blob/master/drivers/scmi-msg/base.h#L12
> 

So, the thig goes like this.

This patch fixes the version of the maximum supported version in the kernel SCMI
stack, since it was wrongly left to the old version...wrongly becase we really
support already all the mandatory feats for those versions..it ws just
that the minor was not bumped properly...my bad.

What happens, Kernel side, is that the we support all the SCMI versions up to
the declared supported version above and, if we detect an OLDER version on the
platform we will just silently backdrop to the older version as advertised by
the platform, WHILE if we detect a NEWER unsupported platform version for a
protocol, we will try a NEGOTIATE_PROTOCOL to ask the platform to use an older
known-to-us version (difficult that a platform suppors multiple vers) and then
we'll go using our newest protocol vwersion stack against this even more
new platform protocol implementation.... best effort with a WARNING.

This patch is just bumping that minors, since all the feats are really
supported already (as said), but without this, it if it happened that we
encountered a platform advertising the latest version we would have
complained (as above specified) even though we really suppported that
version.

Having said that, TF-A and SCP can certainly still not have been updated
(and maybe some protocols will never be updated..,) but that is not an
issue from the Linux agent persepctive (as said above)

> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> 

Thanks for having a look.
Cristian

