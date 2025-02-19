Return-Path: <linux-kernel+bounces-521865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DB2A3C352
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A709189C0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F31F30BE;
	Wed, 19 Feb 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="h1gkU/6P"
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D61F4626;
	Wed, 19 Feb 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978104; cv=none; b=bxMRb01/Kqz8dfDJ+muc6LR3CmN8papfV2fs79/eiVfOmSplFD2uyvV1pcgOEbi34qf/Frvzqd/5D4/AnjEA+ZFFtA+BNOMCVTTCD1+Q4s8YhF5OD8dr1z6f9yhb5Fmfpvwbz6g0pNedJRfHahVP1rM6E3efHgwlsUH0VidTgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978104; c=relaxed/simple;
	bh=zGj7hu+zLCZompuYalV8jysWNLnJRDMfNL0hjXR8mHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MqnVebQvVVrOkb6GcNgy6QqSqVqNuUqPkU7PwgBsJLKqkMBQ5EiJYhlrDgetf/8SrpB1f/BqfEMmDxjPCIcFZrlwX9eccqy3RxqrZXTPZPhWbz9jyUxOLphuM16ucOOSX7qbTH0I3q4ZUzKtGAL1VnF1QHeN5byxeqzhbamgd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=h1gkU/6P; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1739978101;
	bh=zGj7hu+zLCZompuYalV8jysWNLnJRDMfNL0hjXR8mHw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=h1gkU/6Pnv60k8bZse2ZXnzth8pM3IcRFOFAAtZ3aJMB2eFI2+anlBLbgKSqFcc9s
	 Q/lpjJDKj07Iw1zxAXHlOw9zIWQcVHyznW9ZosdvmaXijGN1ssDGd1fq+WsNyYwi1/
	 w/vzYEspBNh/sCvksjpiw1oYG+df1h6wlXBp7yzc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 5F3491C0F81;
	Wed, 19 Feb 2025 10:15:01 -0500 (EST)
Message-ID: <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
Subject: Re: Rust kernel policy
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Christoph Hellwig
 <hch@infradead.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>,  linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Wed, 19 Feb 2025 10:15:00 -0500
In-Reply-To: <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
References: 
	<CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	 <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
	 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
	 <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-19 at 09:46 -0500, Martin K. Petersen wrote:
> 
> James,
> 
> > Could we possibly fix a lot of this by adopting the _cleanup_
> > annotations[1]? I've been working in systemd code recently and they
> > seem to make great use of this for error leg simplification.
> 
> We already have this:
> 
>   include/linux/cleanup.h
> 
> I like using cleanup attributes for some error handling. However, I'm
> finding that in many cases I want to do a bit more than a simple
> kfree(). And at that point things get syntactically messy in the
> variable declarations and harder to read than just doing a classic
> goto style unwind.

So the way systemd solves this is that they define a whole bunch of
_cleanup_<type>_ annotations which encode the additional logic.  It
does mean you need a globally defined function for each cleanup type,
but judicious use of cleanup types seems to mean they only have a few
dozen of these.

Regards,

James


