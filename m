Return-Path: <linux-kernel+bounces-537965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1768A492FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA45F3B9B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9B1E131B;
	Fri, 28 Feb 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="Q+fkLti2"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D071E105E;
	Fri, 28 Feb 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730086; cv=none; b=JYPBzpgCi+VLMLiat4mWxv9Aaa3VlwTJA+aWkde01nIiceRT/iWxDmk5PGsaAgOc8uxXUs3nXNvTyTLsHu+5GCoMJjUz2OrY3blbrpfozX3tBNxx3zCAz2nXmB4fBNNX2tyEM1amS8wkD/O4KTdOgK/cn7vV3Y2xvxVv64iEEZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730086; c=relaxed/simple;
	bh=Kf6mHkEL85gIyEws5lZxaWedBsN87cXo523g7xgNLnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FD2P9KJ2Iq5A7oUtJZg1MJl4CTqfDqgKhKilV9mQtDYuxgwoAh/P6nPtbDCmP/PipaTglH0/War6LWJEl1/lsugCEPF0vU1hafYHQqHrPcfa7rIym8+e/RJ/nNYsy/azWiBsDM8x7ql6jaDgs1UpahTZBQ8zDIh50FKD9EDCCw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=Q+fkLti2; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740730083; bh=Kf6mHkEL85gIyEws5lZxaWedBsN87cXo523g7xgNLnA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q+fkLti2A7ioxWs8LjmxnZ/b6C178ZqZJnKlcfVeROTZUsOe0/s9RokbAcs6ZEniG
	 P6PdVUcFIxYt/mvBFW5qRFQ5RJ3g+08o45VJF2nmTHqteivBrz1evyRCB/Hlv42/dj
	 wTzdN50pkENNO/7KM2aj7vchJQJZpxJqxZRCK8vA=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 72E7D2052A86;
	Fri, 28 Feb 2025 09:08:03 +0100 (CET)
Message-ID: <59c7a1aa-7ff8-4ed1-a83f-5db43094d3a8@ralfj.de>
Date: Fri, 28 Feb 2025 09:08:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Martin Uecker <uecker@tugraz.at>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Ventura Jack
 <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com,
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> The reason? The standards people wanted to describe the memory model
>> not at a "this is what the program does" level, but at the "this is
>> the type system and the syntactic rules" level. So the RCU accesses
>> had to be defined in terms of the type system, but the actual language
>> rules for the RCU accesses are about how the data is then used after
>> the load.
> 
> If your point is that this should be phrased in terms of atomic
> accesses instead of accesses to atomic objects, then I absolutely
> agree with you.  This is something I tried to get fixed, but it
> is difficult. The concurrency work mostly happens in WG21
> and not WG14.
> 
> But still, the fundamental definition of the model is in terms
> of accesses and when those become visible to other threads, and
> not in terms of syntax and types.

The underlying C++ memory model is already fully defined in terms of "this is 
what the program does", and it works in terms of atomic accesses, not atomic 
objects. The atomic objects are a thin layer that the C++ type system puts on 
top, and it can be ignored -- that's how we do it in Rust.

(From a different email)
> It sounds you want to see the semantics strengthened in case
> of a data race from there being UB to having either the old
> or new value being visible to another thread, where at some
> point this could change but needs to be consistent for a
> single access as expressed in the source code.

This would definitely impact optimizations of purely sequential code. Maybe that 
is a price worth paying, but one of the goals of the C++ model was that if you 
don't use threads, you shouldn't pay for them. Disallowing rematerialization in 
entirely sequential code (just one of the likely many consequences of making 
data races not UB) contradicts that goal. Given that even in highly concurrent 
programs, most accesses are entirely sequential, it doesn't seem unreasonable to 
say that the exceptional case needs to be marked in the program (especially if 
you have a type system which helps ensure that you don't forget to do so).

Kind regards,
Ralf


