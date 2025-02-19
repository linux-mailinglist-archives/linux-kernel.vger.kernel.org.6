Return-Path: <linux-kernel+bounces-521976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046C5A3C47C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB9016E229
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9D21FE471;
	Wed, 19 Feb 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lEB9CPIw"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C31FDE10;
	Wed, 19 Feb 2025 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981262; cv=none; b=X/vQTCHScxggychgSRWC0dvmwRAZ4jIV5CuV1vQw+ZIj1E4hdbSL8pgX9TYzuo8se4vEoXTqTXkvfboGpZehAyuaK7pDal5k+uEPbtmUUskXG6/WLWWLWtUrcH+Uz+3o3jCtZ1XVD/bHlo2joYwNqK0pi6c7ydnFYqKIuFG/QKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981262; c=relaxed/simple;
	bh=0ffD3GzZEOQ9UcQ1u0TFG+RKGkt81ixRU8Ke58Kp3pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZvpCrhBvuyYs8AkqnTnsWqDo5GL/10ZU5OT7XgYnwAp6hhnXcNEYYBMV1jwT/g3aPaWnxCMmWZN3ZC7EbEAbltDvRxfXePPR2rjcl/8qfzWQ+OYr2KitgfW4fjsaMjdL3+/70dUw0uUHfD++W9rtjg64RA9DMY8DhoI3Oh4z9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lEB9CPIw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D97EB514;
	Wed, 19 Feb 2025 17:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739981176;
	bh=0ffD3GzZEOQ9UcQ1u0TFG+RKGkt81ixRU8Ke58Kp3pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEB9CPIwWCNavSqqJCBHsF2FoGzZhlEk6bUDb+QtTFFhdqbFoyC/Ho/Ve48HYU+Fq
	 vkVqV5oeKKwFSKnUaLPailKVUKoF1KlYxLOG/iTCuFCuHkzMH/CHqmKa7wKCdoi3MX
	 uKr171qBRa+hPk7yqkLuRsfjcnNbgaDxdpMJzxZI=
Date: Wed, 19 Feb 2025 18:07:23 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Willy Tarreau <w@1wt.eu>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Christoph Hellwig <hch@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250219160723.GB11480@pendragon.ideasonboard.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
 <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
 <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
 <20250219153350.GG19203@1wt.eu>
 <e42e8e79a539849419e475ef8041e87b3bccbbfe.camel@HansenPartnership.com>
 <20250219155617.GH19203@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219155617.GH19203@1wt.eu>

On Wed, Feb 19, 2025 at 04:56:17PM +0100, Willy Tarreau wrote:
> On Wed, Feb 19, 2025 at 10:46:03AM -0500, James Bottomley wrote:
> > > > > I like using cleanup attributes for some error handling. However,
> > > > > I'm finding that in many cases I want to do a bit more than a
> > > > > simple kfree(). And at that point things get syntactically messy
> > > > > in the variable declarations and harder to read than just doing a
> > > > > classic goto style unwind.
> > > > 
> > > > So the way systemd solves this is that they define a whole bunch of
> > > > _cleanup_<type>_ annotations which encode the additional logic.  It
> > > > does mean you need a globally defined function for each cleanup
> > > > type, but judicious use of cleanup types seems to mean they only
> > > > have a few dozen of these.
> > > 
> > > I may be missing something obvious, but this seems super dangerous to
> > > me to perform lightly without reference counting, as it increases the
> > > risks of use-after-free and double-free in case one of the allocated
> > > objects in question can sometimes be returned.
> > 
> > Who said anything about not reference counting?
> 
> Nobody, but it was not said either that they were used at all!
> 
> >  One the things the
> > _cleanup_X annotations can do is drop references (or even locks).
> 
> OK then!
> 
> > >  Users of such mechanisms must be extremely cautious never to ever
> > > return a pointer derivated from a variable tagged as such, or to
> > > properly NULL-assign the original object for it not to double-free.
> > > So it might in the end require to be careful about null-setting on
> > > return instead of explicitly freeing what was explicitly allocated.
> > > I'm not sure about the overall benefit.
> > > Also I suspect it encourages to multiply the return points, which
> > > makes it even more difficult to possibly fix what needs to be fixed
> > > without coming from a locally allocated variable (e.g. restore a
> > > state in a parser etc). Maybe it's just me not seeing the whole
> > > picture, but as a general case I prefer to forget a free() call
> > > (worst case: memory leak) than forget a foo=NULL that may result in a
> > > double free, and the description here makes me think the latter might
> > > more easily happen.
> > 
> > Well we could all speculate about the mess we'll make with any new
> > tool.  All I'm saying is that another project with a large code base
> > (systemd), which you can go an look at, managed to use these
> > annotations very successfully to simplify their error legs. Perhaps
> > there are reasons why the kernel can't be as successful, but I think
> > assuming failure from the outset isn't the best way to flush these
> > reasons out.
> 
> I'm not trying to assume failure or anything, just saying that it's
> probably not always as simple as calling kfree() on anything locally
> allocated for error paths to be magically cleaned, and it actually is
> more subtle (and Laurent confirmed my concerns illustrating that this
> case is precisely covered in glib using transfer of ownership).
> 
> And the temptation to return from everywhere since it's the only
> required statement (instead of a goto to a collecting place) becomes
> great and should sometimes be resisted to.
> 
> Regardless I do understand how these cleanups can help in a number of
> case, at least to avoid some code duplication.

They're particularly useful to "destroy" local variables that don't need
to be returned. This allows implementing scope guards, to facilitate
lock handling for instance. Once a mutex guard is instantiated, the
mutex is locked, and it will be guaranteed to be unlocked in every
return path.

-- 
Regards,

Laurent Pinchart

