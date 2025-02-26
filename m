Return-Path: <linux-kernel+bounces-534390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EB0A46627
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7D27AA8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754AB21CC79;
	Wed, 26 Feb 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="r49qTxEW"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725821ABBD;
	Wed, 26 Feb 2025 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585991; cv=none; b=SCFHdRhNAf9nG4IhZUEr0T/tlzLUCndWXm3Yu3rdz0wF5CYdXahQNXXY5zjnoTQcOIeWQbFdRaOf3pNvz0cIJTn/oCZcIuZkVV4e9f2Oe1KUyAlA4JjoAuAWqWjTTl8CV6LDghR34BHdfaqdABvR6r1qV2t7yx32rqS6RHyyfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585991; c=relaxed/simple;
	bh=4viyFuVZHkdMCNHw0eRVdUTSQsdaaabV2jcJ1qRQrQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKge/uBNnNvMixIOPH+xwiebj/4WIEFgdOTQUbv0l2XTtuMhfx5CUW1btqHror1a5xpJxNTDPpdt12M9q1OK+L5sCJ+rOxMyw8HPQO7PxY1fEyF0eAe0nD57vEhXyIgpHh+3llO9D0ClTlf+0CJleuxU7nXKNllgN6xixJ/uydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=r49qTxEW; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740585988; bh=4viyFuVZHkdMCNHw0eRVdUTSQsdaaabV2jcJ1qRQrQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r49qTxEWOsUdjC3BUNykb5g31fYhNVk9oHuB9UBRxdrvn9YUCXe/AnqoaNMZOCx8N
	 GQkpxItgLy8ebk2rQwMC9JLfZY1frnLwy/RBeRrkrT+NSBuWK9FICRuByYN2AOUSR9
	 VOIYTc6oqZu/FUZcj2mjUuNzQ3wSgbQJiyTaTeMA=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 2026A2052D08;
	Wed, 26 Feb 2025 17:06:28 +0100 (CET)
Message-ID: <54b3b2b1-3a0f-4e39-9661-4d1b947663f3@ralfj.de>
Date: Wed, 26 Feb 2025 17:06:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <CAFJgqgRxfTVxrWja=ZW=mTj1ShPE5s-atAqxzMOq5poajMh=4A@mail.gmail.com>
 <CANiq72mA4Pbx1BeCZdg7Os3FtGkrwx6T8_+=+-=-o9+TOMv+EA@mail.gmail.com>
 <CAFJgqgSzqGKdeT88fJzrFOex7i-yvVte3NiQDdgXeWEFtnq=9A@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAFJgqgSzqGKdeT88fJzrFOex7i-yvVte3NiQDdgXeWEFtnq=9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

> You are right that I should have written "currently tied", not "tied", and
> I do hope and assume that the work with aliasing will result
> in some sorts of specifications.
> 
> The language reference directly referring to LLVM's aliasing rules,
> and that the preprint paper also refers to LLVM, does indicate a tie-in,
> even if that tie-in is incidental and not desired. With more than one
> major compiler, such tie-ins are easier to avoid.
> 
>      https://doc.rust-lang.org/stable/reference/behavior-considered-undefined.html
>          "Breaking the pointer aliasing rules
>          http://llvm.org/docs/LangRef.html#pointer-aliasing-rules
>          . Box<T>, &mut T and &T follow LLVM’s scoped noalias
>          http://llvm.org/docs/LangRef.html#noalias
>          model, except if the &T contains an UnsafeCell<U>.
>          References and boxes must not be dangling while they are
>          live. The exact liveness duration is not specified, but some
>          bounds exist:"

The papers mention LLVM since LLVM places a key constraint on the Rust model: 
every program that is well-defined in Rust must also be well-defined in 
LLVM+noalias. We could design our models completely in empty space and come up 
with something theoretically beautiful, but the fact of the matter is that Rust 
wants LLVM's noalias-based optimizations, and so a model that cannot justify 
those is pretty much dead at arrival.
Not sure if that qualifies as us "tying" ourselves to LLVM -- mostly it just 
ensures that in our papers we don't come up with a nonsense model that's useless 
in practice. :)

The only real tie that exists is that LLVM is the main codegen backend for Rust, 
so we strongly care about what it takes to get LLVM to generate good code. We 
are aware of this as a potential concern for over-fitting the model, and are 
trying to take that into account. So far, the main cases of over-fitting we are 
having is that we often make something allowed (not UB) in Rust "because we 
can", because it is not UB in LLVM -- and that is a challenge for gcc-rs 
whenever C has more UB than LLVM, and GCC follows C (some cases where this 
occurs: comparing dead/dangling pointers with "==", comparing entirely unrelated 
pointers with "<", doing memcpy with a size of 0 [but C is allowing this soon so 
GCC will have to adjust anyway], creating but never using an out-of-bounds 
pointer with `wrapping_offset`). But I think that's fine (for gcc-rs to work, it 
puts pressure on GCC to support these operations efficiently without UB, which I 
don't think is a bad thing); it gets concerning only once we make *more* things 
UB than we would otherwise for no good reason other than "LLVM says so". I don't 
think we are doing that. I think what we did in the aliasing model is entirely 
reasonable and can be justified based on optimization benefits and the structure 
of how Rust lifetimes and function scopes interact, but this is a subjective 
judgment calls and reasonable people could disagree on this.

The bigger problem is people doing interesting memory management shenanigans via 
FFI, and it being not clear whether and how LLVM has considered those 
shenanigans in their model, so on the Rust side we can't tell users "this is 
fine" until we have an "ok" from the LLVM side -- and meanwhile people do use 
those same patterns in C without worrying about it. It can then take a while 
until we have convinced LLVM to officially give us (and clang) the guarantees 
that clang users have been assuming already for a while.

Kind regards,
Ralf


