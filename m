Return-Path: <linux-kernel+bounces-531843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D45A445CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227A03A8B66
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30109188736;
	Tue, 25 Feb 2025 16:15:46 +0000 (UTC)
Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49997154C0B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500145; cv=none; b=vGDPHjYXEY3USv4NzdyKIICbUuhDlC9A1oaycx5fCSgI4xkPCV9q/YT3/5eZ4ibMjU8QB2Ar1X41MG31z+I8N55tMlf1gC04bADr2cEwOuiPRvVLroOmFn4D/+Sqym0l37ygNARM2cGgGqiSiQXrslt6ETRfawpnrCmHRlN5mfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500145; c=relaxed/simple;
	bh=mxsQmfIhn93pEw/9XY2hrnwioBGgFkpJ4ON/rHhmhvM=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=dQotSjVJg9twSjTYHb+mgaVlUGz7jCnVTunxC2ubifsuE++alYpcHvg/Ns0hZ8EOPbvkxV3xaFrNu3kXQNALxx0C+60ZOpJaOF0RpCIPYCPGjCQvbyLSogRXm5AvGgklqOfNlacXwOIU78KXxeWQf9q8RAnLgB772nOVqIr2UWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 17375 invoked by uid 3782); 25 Feb 2025 17:15:39 +0100
Received: from muc.de (pd953a26d.dip0.t-ipconnect.de [217.83.162.109]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Tue, 25 Feb 2025 17:15:39 +0100
Received: (qmail 15041 invoked by uid 1000); 25 Feb 2025 16:15:38 -0000
Date: Tue, 25 Feb 2025 16:15:38 +0000
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Simona Vetter <simona@ffwll.ch>, linux-serial@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <Z73sqvjlbJ54FCtH@MAC.fritz.box>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
 <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
 <2025022355-peroxide-defacing-4fa4@gregkh>
 <Z7y4yHT0fNYYiPI8@MAC.fritz.box>
 <d5e05c61-d796-4e5c-9538-a1e068631bba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e05c61-d796-4e5c-9538-a1e068631bba@kernel.org>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

Hello, Jiri.

On Mon, Feb 24, 2025 at 21:08:50 +0100, Jiri Slaby wrote:
> On 24. 02. 25, 19:22, Alan Mackenzie wrote:
> > Hello, Greg.

> > On Sun, Feb 23, 2025 at 08:47:53 +0100, Greg Kroah-Hartman wrote:
> >> On Sat, Feb 22, 2025 at 03:36:12PM +0000, Alan Mackenzie wrote:
> >>> On Sat, Feb 22, 2025 at 09:48:32 +0100, Greg Kroah-Hartman wrote:

> > [ .... ]

> >>> But I think you are also asking why I use the console at all.  That's
> >>> a fair question which I'll try to answer.

> >> I'm not disputing using the console, it's the vt layer that I'm talking
> >> about.  The DRM developers have the long-term goal of getting rid of
> >> CONFIG_VT which will remove a ton of mess that we have overall.
> >> DRM-based consoles should provide the same functionality that a vt
> >> console does today.  If not, please let them know so that the remaining
> >> corner cases can be resolved.

> > Does a DRM based console exist at the moment?  I spent quite some time
> > looking for it yesterday, but found nothing.

> I didn't read the thread, but are you looking e.g. for kmscon?

No, I wasn't.  I was looking for a drm replacement for the drivers/tty/vt
code inside the kernel.  I may have misunderstood Greg when he referred
to a replacement which uses drm.

kmscon doesn't seem to be a suitable replacement for the Linux console.
According to Wikipedia, it stopped being maintained ~10 years ago.  Also,
it is a user level program, not a kernel level program, so will only become
active later in the boot process than the current console, which is not
a good thing.  It might well steal key sequences from application
programs, the way X and X window managers do, but maybe it doesn't.  On
Gentoo, kmscon is "masked", i.e. strongly recommended not to be
installed, and installable only after taking special measures.

> -- 
> js
> suse labs

-- 
Alan Mackenzie (Nuremberg, Germany).

