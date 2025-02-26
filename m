Return-Path: <linux-kernel+bounces-534045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CBDA4620B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080B23AED6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924E5221726;
	Wed, 26 Feb 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="llSTqnGU"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042F221711;
	Wed, 26 Feb 2025 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579299; cv=none; b=kMrGt3A6X3R86Fj9yyYY+eiI26CQhjLeaUp52a3ZXHfsEkrIxGLxP8kAoqjrE+ICZORdsZ+Dhf1MkbSVuSsbUipueqE4wS3T8Djc5lyh4xWQPKZ/BPbzz5j8D5m9VZSpUqkx1t+dlWbDYABa529v9jiuYCKzoIm0YAY1K5wOAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579299; c=relaxed/simple;
	bh=coG8/tZzBytDDxqJEp/NCjNfmWL8rr4syevp4nIuyog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4H9bwFwSQIOwWsEIbR626tLoBA+nM11cbzkmQ5dwUjefW4Vr8NcMm09z6xG7LY7O46/WYwn1pb21DzUTWk0UsPsOrcLB/UIcIW1fqkfhcppteyztOSwjJa0EbpU/25ioIBGMDrhya+TCFsyXKEY7dCYzb+ez/lkLK2aeVNMAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=llSTqnGU; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740579295; bh=coG8/tZzBytDDxqJEp/NCjNfmWL8rr4syevp4nIuyog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=llSTqnGUL8JOeW6QfSLsCl03gTTqLIZz82DepLZdR+nn7sAt7g4Cen28sIAZS/V5H
	 eOJpe6LTsfrFGFvG54aFdb7Mofc2v6HRBfdsLAwpbXbOSTinySEbp0EGvxs/8YmqCw
	 KOVs0mpWCx835aZLAZJ0OuaVf0q1Ix7pmHIM5haQ=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 805572052D08;
	Wed, 26 Feb 2025 15:14:55 +0100 (CET)
Message-ID: <91dbba64-ade3-4e46-854e-87cd9ecaa689@ralfj.de>
Date: Wed, 26 Feb 2025 15:14:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAFJgqgRxfTVxrWja=ZW=mTj1ShPE5s-atAqxzMOq5poajMh=4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

> Tree borrows is, as far as I can tell, the successor to stacked borrows.
> 
>      https://perso.crans.org/vanille/treebor/
>          "Tree Borrows is a proposed alternative to Stacked Borrows that
>          fulfills the same role: to analyse the execution of Rust code at
>          runtime and define the precise requirements of the aliasing
>          constraints."
> 
> In a preprint paper, both stacked borrows and tree burrows are as
> far as I can tell described as having false positives.
> 
>      https://perso.crans.org/vanille/treebor/aux/preprint.pdf
>          "This overcomes the aforementioned limitations: our evaluation
>          on the 30 000 most widely used Rust crates shows that Tree
>          Borrows rejects 54% fewer test cases than Stacked Borrows does."
> 
> That paper also refers specifically to LLVM.
> 
>      https://perso.crans.org/vanille/treebor/aux/preprint.pdf
>          "Tree Borrows (like Stacked Borrows) was designed with this in
>          mind, so that a Rust program that complies with the rules of Tree
>          Borrows should translate into an LLVM IR program that satisfies
>          all the assumptions implied by noalias."
> 
> Are you sure that both stacked borrows and tree borrows are
> meant to be full models with no false positives and false negatives,
> and no uncertainty, if I understand you correctly?

Speaking as an author of both models: yes. These models are candidates for the 
*definition* of which programs are correct and which are not. In that sense, 
once adopted, the model *becomes* the baseline, and by definition has no false 
negative or false positives.


> It should be
> noted that they are both works in progress.
> 
> MIRI is also used a lot like a sanitizer, and that means that MIRI
> cannot in general ensure that a program has no undefined
> behavior/memory safety bugs, only at most that a given test run
> did not violate the model. So if the test runs do not cover all
> possible runs, UB may still hide.

That is true: if coverage is incomplete or there is non-determinism, Miri can 
miss bugs. Miri does testing, not verification. (However, verification tools are 
in the works as well, and thanks to Miri we have a very good idea of what 
exactly it is that these tools have to check for.)
However, unlike sanitizers, Miri can at least catch every UB that arises *in a 
given execution*, since it does model the *entire* Abstract Machine of Rust.
And since we are part of the Rust project, we are doing everything we can to 
ensure that this is the *same* Abstract machine as what the compiler implements.

This is the big difference to C, where the standard is too ambiguous to uniquely 
give rise to a single Abstract Machine, and where we are very far from having a 
tool that fully implements the Abstract Machine of C in a way that is consistent 
with a widely-used compiler, and that can be practically used to test real-world 
code.


Kind regards,
Ralf


