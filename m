Return-Path: <linux-kernel+bounces-264193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ACF93E009
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06384282345
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F4C183083;
	Sat, 27 Jul 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cZQv4tzp"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3D218306E;
	Sat, 27 Jul 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722095955; cv=none; b=hHMtMlevmHMXQc2q5Cvwt7/jNT50gwVAf2DLrHj9VyjZ6Wl+veTMaMVGW1QsARK5qspS7PFirMnfcC4JpwGXzy1ntlBDdDRKbVpZksg7OzwFrsZATClL4NpfG0pN3bUaSdaqJkh3QpOrWJtwF30fvu+BjKhCXpW9JDZqDq3n1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722095955; c=relaxed/simple;
	bh=6vwcJuOB4KVdMAQ/1aKOPlYVS7ZP64lFMnUf8KW9kHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M9gdgBFniKsV5Qg60enqMwvoMkymsQT72s+coX9hzzEC9a2QL/O6iJqt9aRi8Eo3qa8FHHdiV46SrtaYVEVwlPVmRl+Wlj3nM1n9gIc+GLy+ciPIZhy5bJ5yk3oBL/AIio0K2qUYlWKHCGF8zSwKPBRkkTVVfU7FX0mfZQnb9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cZQv4tzp; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WWTng0hGhz9sm3;
	Sat, 27 Jul 2024 17:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1722095943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRbPI/sAI27QQGBkDCfudHOZf3T1P5DgGJ/f1Yp3z+0=;
	b=cZQv4tzpD/ctvPtalJy0BHo+k1cA4fqoX0ecm1U+Ci+Q7pZsSFwV1c2bbVRKQ+RmfyX1TI
	Bt5CI04JRP1+0oRzJAJt14QoGk+SVqsDviKgzHyXdcBGsTwswDyhg6SEGzoqeTBM6Z5hz4
	IRUtq8B5tWe7hHk0cuWh2sZ5TnhpOP82ZJ+etRgzOsgfx+NfzAch4hrmVmBu7eYP6bneac
	Y3SWR5syFb5N7YREim2RYwUX1dKl6xR1FWfY8Av3wZQeMW+PUqMn0//n4M9FcjzwsjO1WV
	EiJrjST3QAymCSHb8FtLpOzQjbtUJoIvh/QY9/iF+6HZAQgsB8L7uUt26MKiLw==
Message-ID: <9e23b67e-96b7-4060-9dfd-c7c78f881d63@mailbox.org>
Date: Sat, 27 Jul 2024 08:58:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] rust: Implement the smart pointer `InPlaceInit` for
 `Arc`
To: Benno Lossin <benno.lossin@proton.me>, ojeda@kernel.org,
 alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com,
 aliceryhl@google.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240719192234.330341-1-alexmantel93@mailbox.org>
 <27dad59c-ba8a-43c4-a288-870cf29fa131@proton.me>
Content-Language: en-US, de-DE
From: Alex Mantel <alexmantel93@mailbox.org>
In-Reply-To: <27dad59c-ba8a-43c4-a288-870cf29fa131@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4817bd81541e132a7a7
X-MBO-RS-META: gj1ouj8pzssw3gitfukycwu964bkkdaw

Submitted v3:

https://lore.kernel.org/rust-for-linux/20240727042442.682109-1-alexmantel93@mailbox.org/

Thanks for the feedback!

On 25.07.24 11:06, Benno Lossin wrote:
> On 19.07.24 21:22, Alex Mantel wrote:
>> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
>> index 68605b633..46f50cf12 100644
>> --- a/rust/kernel/init.rs
>> +++ b/rust/kernel/init.rs
>> @@ -213,6 +213,7 @@
>>   use crate::{
>>       alloc::{box_ext::BoxExt, AllocError, Flags},
>>       error::{self, Error},
>> +    sync::Arc,
>>       sync::UniqueArc,
>>       types::{Opaque, ScopeGuard},
>>   };
>> @@ -1112,11 +1113,15 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
>>
>>   /// Smart pointer that can initialize memory in-place.
>>   pub trait InPlaceInit<T>: Sized {
>> +    /// A type might be pinned implicitly. An addtional `Pin<ImplicitlyPinned>` is useless. In
>> +    /// doubt, the type can just be set to `Pin<Self>`.
> 
> This comment should better describe the purpose of this associated type,
> the first line could be "Pinned version of `Self`" then (with an empty
> line in between) you could write more explanatory stuff. I would also
> rephrase what you have above, for example: "If a type already implicitly
> pins its pointee, `Pin<Self>` is unnecessary. In this case use `Self`,
> otherwise just use `Pin<Self>`.".
> 
>> +    type PinnedResult;
> 
> I don't really like the name for this, since it is not a result. What do
> you think of `PinnedSelf`?
> 
> Otherwise this looks good!
> 
> ---
> Cheers,
> Benno
> 
>> +
>>       /// Use the given pin-initializer to pin-initialize a `T` inside of a new smart pointer of this
>>       /// type.
>>       ///
>>       /// If `T: !Unpin` it will not be able to move afterwards.
>> -    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
>> +    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedResult, E>
>>       where
>>           E: From<AllocError>;
>>
> 
> 

