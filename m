Return-Path: <linux-kernel+bounces-532582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39913A44F85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D953AE693
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0920E31E;
	Tue, 25 Feb 2025 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="cH9oo3rI"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB761C84A2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521055; cv=none; b=iblkRgH/8PjLnTcQlkGKuALkh3wUvsqpzi88xslCeOiboJ3V1wOhwuP00r+6J0VWRF4PiHbI0hvfG+K1ZtDVgr8Ix0iPNzWctoOfv7GckUXA8LOKYcolnTa4yX8dfOGv2iDmXj07SGA7zuJIKLKSgyYU4OHeMDlCzPgKVqMEcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521055; c=relaxed/simple;
	bh=E1WFXZ5M060RidnoHbaNnPS+Ry4dIrVralh5eVRwac8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqJhKnS+t+FhhyWKYpnRby4qGRupdvG+uFfQLJ4oJXO5s/O9fEvR2Eef2PVmV6A/QfSgNNs0c8DG658Zi6vHLmFI7XZXFH/24EFjn3zyu0VsvDWcgr5b3rBqF881kI8DwDd9wVW8T/xjOZvCrRX7k5cG6P0+zcPe5jnfUBC+F8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=cH9oo3rI; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=RaO592to9W7gWl/XuWjiz67LTCCDHdzr1MxJ208aT78=; b=cH9oo3rIWzq5DOmK
	Dh4VflC06nmGsh4xyQnrT+Pl3ny3r9RsC7F4qP85YqkuKrcU2QRECOAoOv4kcw38W8N70ulZKHpNK
	vwaNtlxUsuTFyRkmRAy+d2OAXHF3IKCH6288TnvuACe2DaMHLapA91ltsRaRE9jpEQLfR6m4ZiU1P
	wI3nbYtTc8l+93qa6hf5I0XzrWn3ONoaUBgfCiJI+3EbIRzBhnrZlGDGEPENK/0eAtOwk94staVF5
	VohVCHQarx0Hnh9kYcYi89hUv0FsJkfKhoNVtt7E4EJxxStVB+fbuQpXM8rNF2XiurZtVyrqWJwih
	NoYm2pFKVCuQGUYk/w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tn327-000qd1-2W;
	Tue, 25 Feb 2025 22:04:07 +0000
Date: Tue, 25 Feb 2025 22:04:07 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, david@rowetel.com
Subject: Re: users of drivers/misc/echo ?
Message-ID: <Z74-VwtwSa3k2E0m@gallifrey>
References: <Z7tZhYET41DAoHVf@gallifrey>
 <07afd3cb-3ab1-4dc9-b0c1-3fef2d52f60b@app.fastmail.com>
 <Z724l3DFJbGevtPF@nataraja>
 <Z72_EnXyHoDACRk5@gallifrey>
 <Z73MevharqkC5dt8@nataraja>
 <Z74OSsZqeboJml9c@gallifrey>
 <Z74VF1Uw5sRVbXhy@nataraja>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Z74VF1Uw5sRVbXhy@nataraja>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:52:48 up 293 days,  9:06,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Harald Welte (laforge@gnumonks.org) wrote:
> Hi Dave,
> 
> On Tue, Feb 25, 2025 at 06:39:06PM +0000, Dr. David Alan Gilbert wrote:
> > > Actually, looking at DAHDI, I really don't think anyone is still using
> > > the dahdi_echocan_oslec code.  It is disabled by default and only built
> > > if explicitly enabled by the user, and indeed if anyone did that it
> > > would fail to build for any kernels that have moved it out of staging.
> > 
> > It looks like Debian is including and enabling it in it's DKMS build:
> 
> thanks, I didn't realize that.  You could reach out to the Debian maintainer of the package
> if you'd want clarification.

Given that Debian build etc - what's your preference?   I'm happy to
grind a patch to remove the kernel copy if Debian is using their own copy.
Or do we leave it and fix up Debian to use it?

Dave

> -- 
> - Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
> ============================================================================
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. A6)
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

