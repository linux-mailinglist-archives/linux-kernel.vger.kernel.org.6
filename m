Return-Path: <linux-kernel+bounces-524157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E75A3DFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3BA1890175
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9664820B211;
	Thu, 20 Feb 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="fem/tkIR"
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EED1DC991;
	Thu, 20 Feb 2025 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067421; cv=none; b=uIej/negK31jHPMsFj/24Foj001ugKa+/8ZwWS7dHtWOuiJwhCtZk1qI83ErzXYGzYcENBTHXOozYuJhqOHeH1OLRWSL/CBBQdJAsjCuJd8XAQh/I8lEmyjB4t4SGFxwhjGy5AlqupxRld+bM1wibl3T2PoTgxUjdOPfHrLp2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067421; c=relaxed/simple;
	bh=ro4kNEdLmwWwoOfMDzBcN7y74iOwt6nS2HgCSF1aJpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NnQ1Z1zKijDgyH7WgZ/Dj8iQ9rvcrMbfn7t7MVoCWvYpJRb4j77ad9XTz6E+F/9z5oTb2aYv3u1SqHS09D+ZrfB7kNAY/hPwsQbeJP/kvvNemzp6AxhswQOByJ+J885RpPXde80eMNyrrln/sekrsrkyGNyNSJVOOWvHs8uGsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=fem/tkIR; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740067417;
	bh=ro4kNEdLmwWwoOfMDzBcN7y74iOwt6nS2HgCSF1aJpc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=fem/tkIRLWTaf3ad4Tef6xfw+ZJPKBCoGCnZdcYksMoYizPfxM54hrAA/IhMwFa/l
	 bDneokAUDCKLaA2qY5XH1ghD1AiPcjdRJUDECyxsmRHBuX2OrdUlzKHj/2r5C2nQk4
	 GCue+72yN3+5YJpekWVyQi2PWQ58SG1FpmljiHKo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 9FDE31C256F;
	Thu, 20 Feb 2025 11:03:37 -0500 (EST)
Message-ID: <f7b44799a3feeab3b255f3b0fc4dc164aa72a6d7.camel@HansenPartnership.com>
Subject: Re: Rust kernel policy
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>,  Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>,  linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Thu, 20 Feb 2025 11:03:36 -0500
In-Reply-To: <CANiq72m5KB-X1zck1E43yffXOTeD4xRmZgDx_oUiNwR941ce0w@mail.gmail.com>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <b0a8ee53b767b7684de91eeb6924ecdf5929d31e.camel@HansenPartnership.com>
	 <CANiq72nnnOsGZDrPDm8iWxYn2FL=wJqx-P8aS63dFYez3_FEOg@mail.gmail.com>
	 <a627845f73f2f7bedc7a820cfdf476be9993e30f.camel@HansenPartnership.com>
	 <CANiq72m5KB-X1zck1E43yffXOTeD4xRmZgDx_oUiNwR941ce0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-19 at 17:44 +0100, Miguel Ojeda wrote:
> On Wed, Feb 19, 2025 at 5:03 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > This very much depends on how the callers are coded, I think.  When
> > I looked at Wedson's ideas on this, the C API contracts were
> > encoded in the headers, so mostly only the headers not the body of
> > the code had to change (so the headers needed updating when the C
> > API contract changed). If the enhanced bindgen produces new headers
> > then code like this will just update without breaking (I admit not
> > all code will work like that, but it's still a useful property).
> 
> Hmm... I am not sure exactly what you mean here. Are you referring to
> Wedson's FS slides from LSF/MM/BPF? i.e are you referring to Rust
> signatures?

OK, this is just a terminology difference.  I think of bindings as the
glue that sits between two pieces of code trying to interact.  In your
terms that's both the abstractions and the bindgen bindings.

> If yes, those signatures are manually written, they are not the
> generated bindings. We typically refer to those as "abstractions", to
> differentiate from the generated stuff.

I understand, but it's the manual generation of the abstractions that's
causing the huge pain when the C API changes because they have to be
updated manually by someone.

> The Rust callers (i.e. the users of those abstractions) definitely do
> not need to change if the C APIs change (unless they change in a
> major way that you need to redesign your Rust abstractions layer, of
> course).
> 
> So, for instance, if your C API gains a parameter, then you should
> update all your C callers as usual, plus the Rust abstraction that
> calls C (which could be just a single call). But you don't need to
> update all the Rust modules that call Rust abstractions.

You say that like it's easy ... I think most people who work in the
kernel wouldn't know how to do this.

> In other words, we do not call C directly from Rust modules, in fact,
> we forbid it (modulo exceptional/justified cases). There is a bit
> more on that here, with a diagram:
> 
>    
> https://docs.kernel.org/rust/general-information.html#abstractions-vs-bindings
> 
> In summary, those abstractions give you several things: the ability
> to provide safe APIs for Rust modules (instead of unsafe calls
> everywhere), the ability to write idiomatic Rust in your callers
> (instead of FFI) and the ability to reduce breaks like I think you
> are suggesting.
> 
> Now, generating those safe abstractions automatically would be quite
> an achievement, and it would require more than just a few simple
> annotations in the header. Typically, it requires understanding the C
> implementation, and even then, it is hard for a human to do, i.e. we
> are talking about an open problem.

I'm under no illusion that this would be easy, but if there were a way
of having all the information required in the C code in such a way that
something like an extended sparse could check it (so if you got the
annotations wrong you'd notice) and an extended bindgen could generate
both the bindings and the abstractions from it, it would dramatically
reduce the friction the abstractions cause in kernel API updates.

> Perhaps you could approximate it with an AI that you give the C
> implementation, plus the C headers, plus the C headers and
> implementations that those call, and so on, up to some layer. Even
> then, it is a problem that typically has many different valid
> solutions, i.e. you can design your safe Rust API in different ways
> and with different tradeoffs.
> 
> I hope that clarifies.

Yes, I think it does, thanks.

Regards,

James


