Return-Path: <linux-kernel+bounces-536686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704BEA48303
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467DD3B5769
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C226B2D5;
	Thu, 27 Feb 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="H79bd2xU"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4625742F;
	Thu, 27 Feb 2025 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670337; cv=none; b=YlHP3fweS4k/qpGJMaaufQCH96qK6LZjyciYwzEsdhTlFkZ5QjJRW/qfsjaA4ap8xaKNjPydxeu+c8RIDOCLq7QR0wHgGk64WEOFCNgol+dewAoGBXGeEUb+65H6D3rDms63nERMhFc5i2txRmGCsjIkTjIjZowLQVCl/hwjCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670337; c=relaxed/simple;
	bh=4tvpGG2/rTSSeKadc3d4iKxqS1x8h4Q4lmIYmN9v9qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbMsHMB6XkP/qV+QjlENNVVBPOJb1exoG/72D2dGIzBdqAIHqvWzEjkr9RAGyiUyfItQNLxRSvbnaEYES3y78gXygx3uctoXNlZ7oo7QkA3fzZhFR3VSGJQO+kNQ0tJTgh2/URJMHO0ZFEGem3qCf78nhXIEhLE/I0jmGCYjHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=H79bd2xU; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740670332; bh=4tvpGG2/rTSSeKadc3d4iKxqS1x8h4Q4lmIYmN9v9qE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H79bd2xUSHByuvJHJN4KofFphHqiYPygCLqEAnJIZOuo0TSmKwfv53vEmfXm4fAzr
	 SKbBWus9gSnQMxDWBVqosa/fkLwfpMFWEmpWjVKyW/RkZ08xZdE4FAbp+M4qfsmqAQ
	 lC6UGWKl+ImWUTvFxyiVFnrtJEtIesQm/Hl1vytg=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 28CFE2052A91;
	Thu, 27 Feb 2025 16:32:12 +0100 (CET)
Message-ID: <43074b70-c421-411f-b0bd-969c45f01466@ralfj.de>
Date: Thu, 27 Feb 2025 16:32:08 +0100
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
 <6983015e-4d6a-44d4-9f2e-203688263018@ralfj.de>
 <CAFJgqgTJ+GBvdkZf4bPHPoUgJj5ZzENZaLzVV2bnDOEG+3OMtw@mail.gmail.com>
 <7ab2de35-8fc8-42cf-9464-81384e227dba@ralfj.de>
 <CAFJgqgTeq0Zer8b1Dk0D2Cvo3t5BUTqxh_7OF7eCkLtjmm8Mcg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAFJgqgTeq0Zer8b1Dk0D2Cvo3t5BUTqxh_7OF7eCkLtjmm8Mcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi VJ,

>> No, it does not use code from Miri, it is based on RustBelt -- my PhD thesis
>> where I formalized a (rather abstract) version of the borrow checker in Coq/Rocq
>> (i.e., in a tool for machine-checked proofs) and manually proved some pieces of
>> small but tricky unsafe code to be sound.
> 
> I see, the reason why I claimed it was because
> 
>      https://gitlab.mpi-sws.org/lgaeher/refinedrust-dev
>          "We currently re-use code from the following projects:
>          miri: https://github.com/rust-lang/miri (under the MIT license)"
> 
> but that code might be from RustBelt as you say, or maybe some
> less relevant code, I am guessing.

Ah, there might be some of the logic for getting the MIR out of rustc, or some 
test cases. But the "core parts" of Miri (the actual UB checking and Abstract 
Machine implementation) don't have anything to do with RefinedRust.

; Ralf


