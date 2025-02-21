Return-Path: <linux-kernel+bounces-525733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DA6A3F3F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC0D17A6B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6536520A5EC;
	Fri, 21 Feb 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGoxfQ6l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857B155336;
	Fri, 21 Feb 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740140187; cv=none; b=uWbCO5GSuOmEFz8BPMtjH0dVFNSlTvYbtReNPQRRxyGa8mQCVi4/cbJKLKgN1+09iwZpc1gvgshJ12s57rhFd08Mpc4pa+1SXYrgUXwQcCkCd9hPM2yzfdEN7pB4ganZ3/VCDe4Go9pPpJxTzoRGYA3xaTwz2f1RXA5B1jQTNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740140187; c=relaxed/simple;
	bh=FcXDvJYEKyRapwRCxZsFoz/Xi48GMchrB8hzwuFfctU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbjMKzLuoLJS3x++xqmBLn6Mo9IQj02LWCQY6opWBckLA7EIcrhKS6y+26vP01C9rDIDCEIQ4zo2aknKNt6NaheMeStEkr0fiGP2jjroIFLs37fJ2Ol20aus3OUQ+QzDRIko48aTIUpuPGF4L5ntYYK52MRfWjG8d6fYXnWGxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGoxfQ6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D65C4CED6;
	Fri, 21 Feb 2025 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740140187;
	bh=FcXDvJYEKyRapwRCxZsFoz/Xi48GMchrB8hzwuFfctU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGoxfQ6ljvx0Qgt/e9/YI6OAtuKFODPGK5+oIM9C7oDT61Aa1kXunL8KhYNMYT/jW
	 llmTETlvg4U7bkil7IxbOWwBjWhS7LVrMFunU98PGNUrKa+zCbrNAotLiQgkbHHolw
	 mCHiN7W4OvPNR5Hza8FeaItxRiCnXoCztAM1+Lk/tt2KZIzztE5OTkt8etJ5iQJ2GG
	 8+4B9Sx1WVL1IcIac4YGvUX98mTRDCtXCl3SYEEv2MDNCNVgCBpObVCutY8x8t1HuG
	 i0MmFyL05Bsg3B7k19Mutzls+dm49W6SKPB7nkg7WJZDDPIWgToEpRvnZZJOObok0D
	 OsP/il6p5xSgQ==
Date: Fri, 21 Feb 2025 13:16:22 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z7hulnJ4fwslRILy@pollux>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <Z7bO1jT2onZFZwgH@infradead.org>
 <CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com>

On Thu, Feb 20, 2025 at 04:39:58PM -0800, Linus Torvalds wrote:
> Honestly, what you have been doing is basically saying "as a DMA
> maintainer I control what the DMA code is used for".
> 
> And that is not how *any* of this works.
> 
> What's next? Saying that particular drivers can't do DMA, because you
> don't like that device, and as a DMA maintainer you control who can
> use the DMA code?

[...]

> So let me be very clear: if you as a maintainer feel that you control
> who or what can use your code, YOU ARE WRONG.

When I added you to the original thread [1], it was exactly to get some
clarification on this specific point.

In my perception, a lot (if not all) of the subsequent discussions evolved
around different aspects, while this specific one is not even limited to Rust in
the kernel.

Hence, I'm happy to see this clarified from your side; it was still a remaining
concern from my side, regardless of whether the PR in question will make it or
not.

However, I also want to clarify that I think that maintainers *do* have a veto
when it comes to how the API they maintain is used in the kernel. For instance,
when an API is abused for things it has not been designed for, which may hurt
the kernel as a whole.

But as mentioned previously, I do not think that this veto can be justified with
personal preference, etc.

- Danilo

[1] https://lore.kernel.org/lkml/Z5qeoqRZKjiR1YAD@pollux/

