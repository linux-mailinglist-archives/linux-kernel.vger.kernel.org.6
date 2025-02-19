Return-Path: <linux-kernel+bounces-521966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE1A3C46D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA79A173B03
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D9F1FE44B;
	Wed, 19 Feb 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jIEjzIXX"
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE91F941B;
	Wed, 19 Feb 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981012; cv=none; b=eg59Nw8JfrPBLJBEgv3Omm1XN68ZbNBnPeVvGUpg+jQKl5WY/gINGYP9lzivrwbBKl3cu/Dicc2+HIPKzFTecTMVNRBT6zCsQ64w/VK/E6+wmeLD8xibUjKgNbnsD0j9kazr/v2075JRCSCgTrZQs7xa2980WiPbdlYpy+fcJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981012; c=relaxed/simple;
	bh=eDaowLk9u711gWU4IoVBOR9PiROZhzla/cX3KdS4Nx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkPV/FzL/JzmDHRQPD+DcnUH1l9Xpv174KkdKcVFD25Nhh/rU4CS+bed/xrtTgtH1VMJX2BNfRuxfH19OA7M/D9sZp8u08yZMnUHVvcIvdoQyiT3Qsf/E+wJ28CNS9lBwvTAG+1kD66LWCABeAvz2v28qHuND8GbPIVMQTsnZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=jIEjzIXX; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1739981009;
	bh=eDaowLk9u711gWU4IoVBOR9PiROZhzla/cX3KdS4Nx4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=jIEjzIXXjbrpZ7YD8W7UnpaaD+KA6QHhlbN3c7nqYUK/B/gv+khxhrApCJQ8B0CGr
	 R+pBakMnX/5yrbTg671aGpdi6fxwwD2jvGmdKGpIi5Vae1xqAfjlt2piAEpaufhaw2
	 oedd0TpmZfeegB7/hNAHSJr+UR3sXG6j+ye8Z4dY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 409001C254A;
	Wed, 19 Feb 2025 11:03:29 -0500 (EST)
Message-ID: <a627845f73f2f7bedc7a820cfdf476be9993e30f.camel@HansenPartnership.com>
Subject: Re: Rust kernel policy
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>,  Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>,  linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Wed, 19 Feb 2025 11:03:28 -0500
In-Reply-To: <CANiq72nnnOsGZDrPDm8iWxYn2FL=wJqx-P8aS63dFYez3_FEOg@mail.gmail.com>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <b0a8ee53b767b7684de91eeb6924ecdf5929d31e.camel@HansenPartnership.com>
	 <CANiq72nnnOsGZDrPDm8iWxYn2FL=wJqx-P8aS63dFYez3_FEOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-19 at 16:08 +0100, Miguel ol9 wrote:
> On Wed, Feb 19, 2025 at 3:05 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > So here's a proposal to fix this: could we not annotate the C
> > headers with the API information in such a way that a much improved
> > rust bindgen can simply generate the whole cloth API binding from
> > the C code?  We would also need an enhanced sparse like tool for C
> > that checked the annotations and made sure they got updated. 
> > Something like this wouldn't solve every unintentional rust build
> > break, but it would fix quite a few of them.  And more to the
> > point, it would allow non-rust developers to update the kernel API
> > with much less fear of breaking rust.
> 
> This has come up a few times, and we indeed would like to have some
> annotations in the C headers so that we can generate more (and to
> keep the information local).
> 
> For instance, it would be nice to have bindgen's `__opaque` near the
> C items, or being able to mark functions as `__safe`, or to have
> other `enum`s-related annotations, or even custom attributes, as well
> as "formatted-formally-enough" docs so that can be rendered properly
> on the Rust side, or even references/lifetimes with an eventual "Safe
> C"-like approach, and so on and so forth.
> 
> However, even if we automate more and even reach a point where most C
> APIs are e.g. "safe" (which would be great),

I wouldn't say C API safety would be the main goal, although it might
be a nice add on feature.

>  it wouldn't prevent breakage -- the C APIs would still need to be
> stable enough so that you don't break callers,

Just so we're on the same page, kernel API stability can't be the goal.
We can debate how valuable the current API instability is, but it's a
fact of life.  The point of the proposal is not to stabilise the C API
but to allow the instability to propagate more easily to the rust side.

>  including C ones. It would still be great to have that information
> formally expressed, though, of course, and it would help maintain the
> Rust sid

This very much depends on how the callers are coded, I think.  When I
looked at Wedson's ideas on this, the C API contracts were encoded in
the headers, so mostly only the headers not the body of the code had to
change (so the headers needed updating when the C API contract
changed). If the enhanced bindgen produces new headers then code like
this will just update without breaking (I admit not all code will work
like that, but it's still a useful property).

> We have also discussed at times is documenting the C side more, e.g.
> the pre/post/invariants we use on the Rust side. That would be useful
> for the C side to know something is being relied upon from Rust (and
> other C callers) and for the Rust side to document why something is
> sound. Of course, it is a lot of work, and the more we can express as
> code instead of as documentation, the better.

So I do think this feeds into the documentation project as well.  We've
already decided that the best way to document an API is in the code for
it, so adding annotations that can be checked is better than adding
docbook that not many people check; although hopefully we could still
generate documentation from the annotations.

Regards,

James


