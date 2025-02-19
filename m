Return-Path: <linux-kernel+bounces-521998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68BA3C4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E12176FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C161FE474;
	Wed, 19 Feb 2025 16:15:59 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81451FE44B;
	Wed, 19 Feb 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981759; cv=none; b=PORKhE7hvzPWbjw10xr6rTcsnkKKW7a2e+w+Mw6QToqHAcuO3F+7z3It9Bjj2nISLoBLoNfkiLEGzV5JGxpsXV+/30+NLX/f8Mnp9RtncJjDIAITDfne+9hTC6y4sxXRpi+8vv2yAKER/hSV4qRwxo18t3Hiw/VEXheZczHQDYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981759; c=relaxed/simple;
	bh=5IKvBpIY6ht3t9ENjPzgnAa57QSsV7Y4M9VTaj8tbjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MevOGphl4eS7NYsCty7NroTpt7sywbXB1i3k29DlBqiiPmMwS6qtfW7KU+JbAb+GFVwoeSAmneubZpWhPTXM/baA9UR4YRBxESMvGNaR54JKEhqLOkGNKlVfCXlSUZJxtH30JmFT8rYvUEQt7Lv/RYuo0mrUjXvqXVLxSSN/RzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51JGFhqM023043;
	Wed, 19 Feb 2025 17:15:43 +0100
Date: Wed, 19 Feb 2025 17:15:43 +0100
From: Willy Tarreau <w@1wt.eu>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250219161543.GI19203@1wt.eu>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
 <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
 <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
 <20250219153350.GG19203@1wt.eu>
 <e42e8e79a539849419e475ef8041e87b3bccbbfe.camel@HansenPartnership.com>
 <20250219155617.GH19203@1wt.eu>
 <20250219160723.GB11480@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219160723.GB11480@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 19, 2025 at 06:07:23PM +0200, Laurent Pinchart wrote:

> > Regardless I do understand how these cleanups can help in a number of
> > case, at least to avoid some code duplication.
> 
> They're particularly useful to "destroy" local variables that don't need
> to be returned. This allows implementing scope guards, to facilitate
> lock handling for instance. Once a mutex guard is instantiated, the
> mutex is locked, and it will be guaranteed to be unlocked in every
> return path.

Yeah absolutely. However I remember having faced code in the past where
developers had abused this "unlock on return" concept resulting in locks
lazily being kept way too long after an operation. I don't think this
will happen in the kernel thanks to reviews, but typically all the stuff
that's done after a locked retrieval was done normally is down outside
of the lock, while here for the sake of not dealing with unlocks, quite
a few lines were still covered by the lock for no purpose. Anyway
there's no perfect solution.

Ideally when a compiler is smart enough to say "I would have cleaned
up here", it could be cool to just have a warning so that the developer
decides where to perform it. The problem is that it'd quickly becomes
a mess since the compiler cannot guess that you've done your own cleanup
before (without yet other anotations), which precisely is the point of
doing it unconditionally when leaving scope.

Willy

