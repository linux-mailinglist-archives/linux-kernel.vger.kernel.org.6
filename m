Return-Path: <linux-kernel+bounces-521937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D9A3C40C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2706A1888390
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ABE1FCCF5;
	Wed, 19 Feb 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="L0c7Udeg"
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D281DED60;
	Wed, 19 Feb 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979967; cv=none; b=gclQ+NGTMFM3AH/u5yHRU/iCAUddtXF79m+yjjXP6jO5GiLRsqzY/K7FfQFSaQRjz54WXPSrgwvOgh39h1CNNS4Xg8ZLdXVniLqtGdGJE/NVv78RRKEr/zEYoUjb8UN3OZLV7BnUYFJZ+hiRYzyiN1vKFg4iylj/P8VhKOfxRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979967; c=relaxed/simple;
	bh=RqI0JA5FgqUOxHarAvBLw/YqP/VpJw/aQXdXfcn93Is=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t5G7v5cCAjzdX9lZcjTHg20PdUoGq/N0iBJ8hltrzlKZ24nholrdCqNE1Dm+7ZyOaApGC0+Uf1ksTdLPyNGSXctwt3qcwkxWOh/ngIdQdp8Iq/WilhB2ezG8PFvmBz3KDGBBS9HFFMWRV4f91XLANO0v/Wg9z3++A5q+kh8fIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=L0c7Udeg; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1739979964;
	bh=RqI0JA5FgqUOxHarAvBLw/YqP/VpJw/aQXdXfcn93Is=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=L0c7UdegbdgcogmoCV5GSSsLAyagEPrkFOFCnWGQGMfl6RMBywvl/QJshDhIcdb/t
	 0xPYPoMw/kxeF4gLa89PJwbYA91Qgwgg1gLMlJpod8V9l1ni/YGEadSw8xJFSnTJaz
	 hiotL2hDJye04J1hpfhBYusfeXFjmwJbP4Z6FzVI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 7E5971C0F22;
	Wed, 19 Feb 2025 10:46:04 -0500 (EST)
Message-ID: <e42e8e79a539849419e475ef8041e87b3bccbbfe.camel@HansenPartnership.com>
Subject: Re: Rust kernel policy
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Willy Tarreau <w@1wt.eu>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Christoph Hellwig <hch@infradead.org>, Miguel
 Ojeda <miguel.ojeda.sandonis@gmail.com>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>,  Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>,  linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Wed, 19 Feb 2025 10:46:03 -0500
In-Reply-To: <20250219153350.GG19203@1wt.eu>
References: 
	<CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	 <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
	 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
	 <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
	 <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
	 <20250219153350.GG19203@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-19 at 16:33 +0100, Willy Tarreau wrote:
> Hi James,
> 
> On Wed, Feb 19, 2025 at 10:15:00AM -0500, James Bottomley wrote:
> > On Wed, 2025-02-19 at 09:46 -0500, Martin K. Petersen wrote:
> > > 
> > > James,
> > > 
> > > > Could we possibly fix a lot of this by adopting the _cleanup_
> > > > annotations[1]? I've been working in systemd code recently and
> > > > they seem to make great use of this for error leg
> > > > simplification.
> > > 
> > > We already have this:
> > > 
> > >   include/linux/cleanup.h
> > > 
> > > I like using cleanup attributes for some error handling. However,
> > > I'm finding that in many cases I want to do a bit more than a
> > > simple kfree(). And at that point things get syntactically messy
> > > in the variable declarations and harder to read than just doing a
> > > classic goto style unwind.
> > 
> > So the way systemd solves this is that they define a whole bunch of
> > _cleanup_<type>_ annotations which encode the additional logic.  It
> > does mean you need a globally defined function for each cleanup
> > type, but judicious use of cleanup types seems to mean they only
> > have a few dozen of these.
> 
> I may be missing something obvious, but this seems super dangerous to
> me to perform lightly without reference counting, as it increases the
> risks of use-after-free and double-free in case one of the allocated
> objects in question can sometimes be returned.

Who said anything about not reference counting?  One the things the
_cleanup_X annotations can do is drop references (or even locks).

>  Users of such mechanisms must be extremely cautious never to ever
> return a pointer derivated from a variable tagged as such, or to
> properly NULL-assign the original object for it not to double-free.
> So it might in the end require to be careful about null-setting on
> return instead of explicitly freeing what was explicitly allocated.
> I'm not sure about the overall benefit.
> Also I suspect it encourages to multiply the return points, which
> makes it even more difficult to possibly fix what needs to be fixed
> without coming from a locally allocated variable (e.g. restore a
> state in a parser etc). Maybe it's just me not seeing the whole
> picture, but as a general case I prefer to forget a free() call
> (worst case: memory leak) than forget a foo=NULL that may result in a
> double free, and the description here makes me think the latter might
> more easily happen.

Well we could all speculate about the mess we'll make with any new
tool.  All I'm saying is that another project with a large code base
(systemd), which you can go an look at, managed to use these
annotations very successfully to simplify their error legs. Perhaps
there are reasons why the kernel can't be as successful, but I think
assuming failure from the outset isn't the best way to flush these
reasons out.

Regards,

James




