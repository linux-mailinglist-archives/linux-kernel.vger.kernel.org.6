Return-Path: <linux-kernel+bounces-522492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B50A3CB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64003B81A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE62A257AE6;
	Wed, 19 Feb 2025 21:07:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD0253F17;
	Wed, 19 Feb 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999238; cv=none; b=In/g1moTsf3xwJF/tv5cPXDJMODhNnwC3mEG5BDdhdqkGCXXsiHJZ4Keq4JZWktPmWmeXbGqzeWeB/sQYVk8QDaLrENlootYTjZPOOWN0TEda6KjOb4pLUItER00g7OrKXKHkkh+CtgRKdC9R34HvvDpKqnZf2TXAouLcX70lUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999238; c=relaxed/simple;
	bh=q5Dno9KGE76iX8QZyfpoYdDtWmIYmkGZ/czzpbsuVfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjxyHRooWchCoihzMIvJCTuwk74ap1+TKxGp+7Q1Jc2Qt0HYzKnt6upvxtf2CrZnYrMXnGbgF4uFxC/DAbTxL0YbIoQL7DXIMN56gNz1Bn82/iN8mkfiK4wnr4wR0htu4mjqfazQHtUew+YhbK3zX3H4IHIjC0RVErvGwuwuF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3958C4CED1;
	Wed, 19 Feb 2025 21:07:16 +0000 (UTC)
Date: Wed, 19 Feb 2025 16:07:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kees Cook <kees@kernel.org>, Miguel
 Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Greg KH
 <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250219160740.52ad61d4@gandalf.local.home>
In-Reply-To: <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	<Z7SwcnUzjZYfuJ4-@infradead.org>
	<CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	<202502191026.8B6FD47A1@keescook>
	<20250219140821.27fa1e8a@gandalf.local.home>
	<202502191117.8E1BCD4615@keescook>
	<20250219202751.GA42073@nvidia.com>
	<20250219154610.30dc6223@gandalf.local.home>
	<97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 12:52:14 -0800
Bart Van Assche <bvanassche@acm.org> wrote:

> On 2/19/25 12:46 PM, Steven Rostedt wrote:
> > I do feel that new drivers written in Rust would help with the
> > vulnerabilities that new drivers usually add to the kernel.  
> 
> For driver developers it is easier to learn C than to learn Rust. I'm
> not sure that all driver developers, especially the "drive by"
> developers, have the skills to learn Rust.

That's a short term problem.

But it's not like we are going to ban C from all new drivers. But as Rust
becomes more popular, we should at the very least make it easy to support
Rust drivers.

-- Steve

