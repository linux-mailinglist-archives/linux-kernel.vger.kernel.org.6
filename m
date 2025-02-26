Return-Path: <linux-kernel+bounces-533657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA27A45D51
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03393189793B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FB7215776;
	Wed, 26 Feb 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="STfJiQHg"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB421517F;
	Wed, 26 Feb 2025 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569898; cv=none; b=Aii5L4Lp9MYjaNim++dwdCKQlZVeKN5wnVe7ykajT5xMXqIolNaX6z9JYbjD7ZXZkEj+I9gcKHS7dLJ2fKsxOhbe9VBYmGal5IDteXK+nnBUonNhZo1pKH79N5R4E4/8UQdlglbnhRtMw6S8agj0x5KlHUnCP4/Xk3J1E+7U7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569898; c=relaxed/simple;
	bh=OC6u0I256yrrESBhOFslOEcd+zrgD1H+lv2qPm5w/sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avMQWa2xuvcinRRGY39G7uQ9D+7JEWhKY7kbKb6f8L8YWtLDKezDEF87UoRqHKbLkBXA+ha/NQLWQ5gIHtgs1FAn6uJXsXX8Lhbha6c0ocx+LkjxlGv+SDb2YqJvjsd0EDk1DsnCPOV8046Vy/eDE9ntIVvCK9PTcRr6jRY2neQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=STfJiQHg; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740569894; bh=OC6u0I256yrrESBhOFslOEcd+zrgD1H+lv2qPm5w/sw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=STfJiQHgC6hJ+LaHlk0O1ozcv+cl8bK1nwWfTLKHA3PwLZ/Q6oGH2sQmoQHhnl2/Z
	 vUlhQhAOVPXQqrlLBnsz0CJwChcra5u5uxGj7rnBhBa/qDrzWMMOVz5RoQFLgM3y92
	 mNrlCFeNtyheLow9+ZPl/W8QtlKK3irfY/fhwCzw=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 0CDD220513B3;
	Wed, 26 Feb 2025 12:38:14 +0100 (CET)
Message-ID: <2d553652-18f8-472d-bdd0-664164d10a11@ralfj.de>
Date: Wed, 26 Feb 2025 12:38:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ventura Jack <venturajack85@gmail.com>,
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
 <20250224125805.GA5729@mit.edu>
 <CANiq72k-K3-Cbnm=0556sXAWs0kXBCB4oR67M4UtD=fq=kyp7A@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CANiq72k-K3-Cbnm=0556sXAWs0kXBCB4oR67M4UtD=fq=kyp7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

>> Hmm, I wonder if this is the reason of the persistent hostility that I
>> keep hearing about in the Rust community against alternate
>> implementations of the Rust compiler, such as the one being developed
>> using the GCC backend.  *Since* the aliasing model hasn't been
> 
> I guess you are referring to gccrs, i.e. the new GCC frontend
> developed within GCC (the other one, which is a backend,
> rustc_codegen_gcc, is part of the Rust project, so no hostility there
> I assume).
> 
> In any case, yes, there are some people out there that may not agree
> with the benefits/costs of implementing a new frontend in, say, GCC.
> But that does not imply everyone is hostile. In fact, as far as I
> understand, both Rust and gccrs are working together, e.g. see this
> recent blog post:
> 
>      https://blog.rust-lang.org/2024/11/07/gccrs-an-alternative-compiler-for-rust.html

Indeed I want to push back hard against the claim that the Rust community as a 
whole is "hostile" towards gcc-rs. There are a lot of people that do not share 
the opinion that an independent implementation is needed, and there is some (IMO 
justified) concern about the downsides of an independent implementation (mostly 
concerning the risk of a language split / ecosystem fragmentation). However, the 
gcc-rs folks have consistently stated that they are aware of this and intend 
gcc-rs to be fully compatible with rustc by not providing any custom language 
extensions / flags that could split the ecosystem, which has resolved all those 
concerns at least as far as I am concerned. :)

Kind regards,
Ralf


