Return-Path: <linux-kernel+bounces-545345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E1BA4ED22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930058E2070
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C9259CB0;
	Tue,  4 Mar 2025 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="Ek3d5AEn"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F82777F4;
	Tue,  4 Mar 2025 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112659; cv=none; b=sVo3R/WnML4EPI2fkqz7E45o5eAawCTI4GngeXIothtE0rxnI7NgjOUgh3sI16+Vpl52rKH+RX7MaC6BrufAzsVmkrbLQkGbriy1XXRDtLuYdIaysGMKPrt9+6pdSNFy0fgZy091WB9SFPl8cvLB6+MKAMQvgZSZFyVRvvcvdyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112659; c=relaxed/simple;
	bh=aRrdrLOf2kIT4ORfOYXW5hYLJW9ANt36zFUYL88XoR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdpxgD0Zh4lo1A3rgCEPXQ0mWWj5vyzwH0GFn82A4HadfVVDJtA3O4YqeEV5Re6/+N9oLF3v3kYPxTmXLNOS8LlliFTXxXbRskLpsMYdxe1hjtHmeEXxkdBvE1ZyM0Z3U4LZSOM5AQnHCJVDF84Yf7h3kCTW+QVzW7CKLKS9wRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=Ek3d5AEn; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1741112655; bh=aRrdrLOf2kIT4ORfOYXW5hYLJW9ANt36zFUYL88XoR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ek3d5AEn9ZSdmiVKJwAt61WVz86wtURGUckvR85lznKbN8jUMpWjLfs6XcphJxd7G
	 SFfmHuj4a5nAkRdDzaApZtUPBIioqQ0A6Haizinno81NH+IsrmyazjiG1mDRcZcZ/L
	 lt2IwEQc6eOBeOsGiV4B3SPsNWBbcL3YOtASla6c=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 84AAD2052D09;
	Tue,  4 Mar 2025 19:24:15 +0100 (CET)
Message-ID: <aab4312f-67dc-4fc8-ae5a-59b5933aa220@ralfj.de>
Date: Tue, 4 Mar 2025 19:24:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>,
 torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com,
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
 <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
 <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
 <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
 <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de>
 <CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
 <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de>
 <CAFJgqgRFEvsyf9Hej-gccSdC-Ce8DbO5DgHatLoJ-aYi1_ZcyA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAFJgqgRFEvsyf9Hej-gccSdC-Ce8DbO5DgHatLoJ-aYi1_ZcyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

>>> The time crate breaking example above does not
>>> seem nice.
>>
>> The time issue is like the biggest such issue we had ever, and indeed that did
>> not go well. We should have given the ecosystem more time to update to newer
>> versions of the time crate, which would have largely mitigated the impact of
>> this. A mistake was made, and a *lot* of internal discussion followed to
>> minimize the chance of this happening again. I hope you don't take that accident
>> as being representative of regular Rust development.
> 
> Was it an accident? I thought the breakage was intentional,
> and in line with Rust's guarantees on backwards
> compatibility, since it was related to type inference,
> and Rust is allowed to do breaking changes for that
> according to its guarantees as I understand it.
> Or do you mean that it was an accident that better
> mitigation was not done in advance, like you describe
> with giving the ecosystem more time to update?

It was an accident. We have an established process for making such changes while 
keeping the ecosystem impact to a minimum, but mistakes were made and so the 
ecosystem impact was beyond what we'd be willing to accept.

The key to understand here that there's a big difference between "we do a 
breaking change but hardly anyone notices" and "we do a breaking change and 
everyone hears about it". The accident wasn't that some code broke, the accident 
was that so much code broke. As you say, we have minor breaking changes fairly 
regularly, and yet all the examples you presented of people being upset were 
from this one case where we screwed up. I think that shows that generally, the 
process works: we can do minor breaking changes without disrupting the 
ecosystem, and we can generally predict pretty well whether a change will 
disrupt the ecosystem. (In this case, we actually got the prediction and it was 
right! It predicted significant ecosystem breakage. But then diffusion of 
responsibility happened and nobody acted on that data.)

And yes, *technically* that change was permitted as there's an exception in the 
stability RFC for such type ambiguity changes. However, we're not trying to be 
"technically right", we're trying to do the right thing for the ecosystem, and 
the way this went, we clearly didn't do the right thing. If we had just waited 
another 3 or 4 Rust releases before rolling out this change, the impact would 
have been a lot smaller, and you likely would never have heard about this.

(I'm saying "we" here since I am, to an extent, representing the Rust project in 
this discussion. I can't actually speak for the Rust project, so these opinions 
are my own. I also was not involved in any part of the "time" debacle.)

> Another concern I have is with Rust editions. It is
> a well defined way of having language "versions",
> and it does have automated conversion tools,
> and Rust libraries choose themselves which
> edition of Rust that they are using, independent
> of the version of the compiler.
> 
> However, there are still some significant changes
> to the language between editions, and that means
> that to determine the correctness of Rust code, you
> must know which edition it is written for.

There exist corner cases where that is true, yes. They are quite rare. Congrats 
on finding one! But you hardly ever see such examples in practice. As above, 
it's important to think of these things quantitatively, not qualitatively.

Kind regards,
Ralf

> 
> For instance, does this code have a deadlock?
> 
>      fn f(value: &RwLock<Option<bool>>) {
>          if let Some(x) = *value.read().unwrap() {
>              println!("value is {x}");
>          } else {
>              let mut v = value.write().unwrap();
>              if v.is_none() {
>                  *v = Some(true);
>              }
>          }
>      }
> 
> The answer is that it depends on whether it is
> interpreted as being in Rust edition 2021 or
> Rust edition 2024. This is not as such an
> issue for upgrading, since there are automated
> conversion tools. But having semantic
> changes like this means that programmers must
> be aware of the edition that code is written in, and
> when applicable, know the different semantics of
> multiple editions. Rust editions are published every 3
> years, containing new semantic changes typically.
> 
> There are editions Rust 2015, Rust 2018, Rust 2021,
> Rust 2024.
> 
> Best, VJ.


