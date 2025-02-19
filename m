Return-Path: <linux-kernel+bounces-522033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62058A3C515
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819BB16AF28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9001D1FE45B;
	Wed, 19 Feb 2025 16:33:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36D19F103;
	Wed, 19 Feb 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982789; cv=none; b=BjyaInXl8HLgfOCwgVpa6NkW59DLsccfGSGzwlIB3bD91yn3OYowAgiK3Y1L9dJEq1CexU9WiLFOACTeAdm0/+kjbLexlNEVVu8VQpDeANqSivD/Vk5i8NgyHQXCDBnbqSoIjakY+sBHdx9pamLiv9TtCUPlUxvJSGnPdYCdbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982789; c=relaxed/simple;
	bh=HJvtIisUYTgX8+6LT5bI9lDoiz0eya4NKhLzbXJW+o4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIaosg8/fdKmKGv0NCISBHEa8E0dR8DcwE7I8kBYcY+Pv0tuZVWz8XOX/iluCTVqucjE+BlXbjFkLHfw1L4ZEJQaQiM0bLRdjNdATOM9xqt6YlJ0Wo8hXu5ZJbMZYDUvxJWsopSbPhdRX6onbGP70tqjllXxdiafMjHsXpWz6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D09DC4CED1;
	Wed, 19 Feb 2025 16:33:07 +0000 (UTC)
Date: Wed, 19 Feb 2025 11:33:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, James Bottomley
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250219113331.17f014f4@gandalf.local.home>
In-Reply-To: <20250219161543.GI19203@1wt.eu>
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
	<20250219161543.GI19203@1wt.eu>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 17:15:43 +0100
Willy Tarreau <w@1wt.eu> wrote:

> Yeah absolutely. However I remember having faced code in the past where
> developers had abused this "unlock on return" concept resulting in locks
> lazily being kept way too long after an operation. I don't think this
> will happen in the kernel thanks to reviews, but typically all the stuff
> that's done after a locked retrieval was done normally is down outside
> of the lock, while here for the sake of not dealing with unlocks, quite
> a few lines were still covered by the lock for no purpose. Anyway
> there's no perfect solution.

This was one of my concerns, and it does creep up slightly (even in my own
use cases where I implemented them!).

But we should be encouraging the use of:

	scoped_guard(mutex)(&my_mutex) {
		/* Do the work needed for for my_mutex */
	}

Which does work out very well. And the fact that the code guarded by the
mutex is now also indented, it makes it easier to review.

-- Steve

