Return-Path: <linux-kernel+bounces-534395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C19A46690
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB941425FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F3D21CC67;
	Wed, 26 Feb 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="Wn+KczOZ"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C92218ACA;
	Wed, 26 Feb 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586253; cv=none; b=QCYWHLmw5x5awzR5FwAUFY0p343QBXZ1srrGFzP8LCLFrMvtOW7r8upP2eNLSgjGMSgMhfOJHFI/0+jUNyjYW7FrzYV1n6l4/DkHqPWcM6lAoJyMFia/9V9cogdBtZAPD4GoGhqZyd3yIiWZb/XmMpWQ8C7jXiIrQlUTD+/cq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586253; c=relaxed/simple;
	bh=Sh654BeCHVU+iFhxxMO6lVNtnSopA0tl8/OEVey77ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyx9neWAVuk0qultHdE4Nf9nNPc4lxCOLWRnGOBvWjb0JwIKQe4EuBTUjAfXpeMZMajItPZl01TaOMRfPDY8CMReEtFTlCh53yI8wJmzqqxUjHO1dUZeWVqUi8Kn+BOaAgNV6c5IZTxlARLjCUWM7OVuNDQxC3N97riM2aIR3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=Wn+KczOZ; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740586250; bh=Sh654BeCHVU+iFhxxMO6lVNtnSopA0tl8/OEVey77ig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wn+KczOZrYKVjRn3aRSmjZmCnB1ZJqx1LAo17jSD/OrwiaxU6Ek0olkA8e2zlvXfv
	 VThbkFO4/EvQIznrKVYuSIixZPPcq0J5ZvBqNihy6KGk2qLFllrM5/X+v0NQGh6A/i
	 +FiFcIwY7+E1qA85n3XQdU01pNJEO28+nBFB/fPc=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id F38692052D08;
	Wed, 26 Feb 2025 17:10:49 +0100 (CET)
Message-ID: <6983015e-4d6a-44d4-9f2e-203688263018@ralfj.de>
Date: Wed, 26 Feb 2025 17:10:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
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
 <91dbba64-ade3-4e46-854e-87cd9ecaa689@ralfj.de>
 <CAFJgqgTTgy=yae68AE29oJQc7Bi+NvkgsrBtOkVUvRt1O0GzSQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAFJgqgTTgy=yae68AE29oJQc7Bi+NvkgsrBtOkVUvRt1O0GzSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> [Omitted] (However, verification tools are
>> in the works as well, and thanks to Miri we have a very good idea of what
>> exactly it is that these tools have to check for.) [Omitted]
> 
> Verification as in static verification? That is some interesting and
> exciting stuff if so.

Yes. There's various projects, from bounded model checkers (Kani) that can 
"only" statically guarantee "all executions that run loops at most N times are 
fine" to full-fledged static verification tools (Gillian-Rust, VeriFast, Verus, 
Prusti, RefinedRust -- just to mention the ones that support unsafe code). None 
of the latter tools is production-ready yet, and some will always stay research 
prototypes, but there's a lot of work going on, and having a precise model of 
the entire Abstract Machine that is blessed by the compiler devs (i.e., Miri) is 
a key part for this to work. It'll be even better when this Abstract Machine 
exists not just implicitly in Miri but explicitly in a Rust Specification, and 
is subject to stability guarantees -- and we'll get there, but it'll take some 
more time. :)

Kind regards,
Ralf


