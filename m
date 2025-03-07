Return-Path: <linux-kernel+bounces-550813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC698A56470
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8377F3B45EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE320C47A;
	Fri,  7 Mar 2025 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dOcysyH6"
Received: from out.smtpout.orange.fr (out-14.smtpout.orange.fr [193.252.22.14])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2FF20C476
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341512; cv=none; b=Eo7djSWnQDa1K3NXGGyeEsqepqe8IHbGOJq3GvGeyYJNVtg2ygiJzoWZLOEa1ZidX8rYJg17JM2tNVefl192iNK0VGHONzO59NJaipg+hmA0g5m9QQPmi0fBgXOjtboMUPeDabyh6AVNUUplOGnEEslPQyfwEBo6I/bKCEQFbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341512; c=relaxed/simple;
	bh=z2856FJXESGplS9cF9pWXVmByXl8uYux+A8cFDsx6IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqNmGK3lwGBLZCWTEk2MM29l0V9dvF0aMGuYgxuWDVybdOwXGSpXecYcSdUwPsFjTkEgkMQEufKEObkN9WmowyuK7SgXXCvodszHgjsQNJv9P/VXG6TN/50DP5tLVd8ljt8d5Use9SmZkFY2zMdvaCbAcdLc20UxUpVoB3Mig2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dOcysyH6; arc=none smtp.client-ip=193.252.22.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qUT3ttclTLArrqUT8tnDZY; Fri, 07 Mar 2025 10:58:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741341501;
	bh=ec/4FFnWtkVOGJAjE0F14PO+sOMtcZNESadfGxpFl20=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dOcysyH6tA0paeZ31fP7jP/1Ol4ph/8eOVEiBrFVPt9RtkZ5khevSysUNVRYlq0IM
	 0Deeb0gvMgy5zUhy0+JhJbDrwVWiPhipvWUH1ZsTF06Ba70D0qJAJlAwU8frJOVwxW
	 dFeyqA0XT6le15Zf8Uh4LcfCMfBFaQbxzQbKSSKE/h+gJdwo4ZKdzFWkz05CuQgk9Y
	 sL9pusjhNhsldKs4V6yD4NWlY8P20IKAEob+fKQvY1K3blNC1rwhNCZpVVDxTuX1mE
	 2xJHTqrYKJdb8L4ec7a4DTEjH1/BiaL1f4b8rqRQAUfxssX2LKr6M1j7x61ZX5R1UL
	 JVx+35nAvYemw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 Mar 2025 10:58:21 +0100
X-ME-IP: 124.33.176.97
Message-ID: <bdce7d99-7f02-4667-acda-9ffc62c92af2@wanadoo.fr>
Date: Fri, 7 Mar 2025 18:58:08 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] bits: split the definition of the asm and non-asm
 GENMASK()
To: David Laight <david.laight.linux@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
 <20250306192331.2701a029@pumpkin>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250306192331.2701a029@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/03/2025 at 04:23, David Laight wrote:
> On Thu, 06 Mar 2025 20:29:52 +0900
> Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org> wrote:
> 
>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>
>> In an upcoming change, GENMASK() and its friends will indirectly
>> depend on sizeof() which is not available in asm.
>>
>> Instead of adding further complexity to __GENMASK() to make it work
>> for both asm and non asm, just split the definition of the two
>> variants.
> ...
>> +#else /* defined(__ASSEMBLY__) */
>> +
>> +#define GENMASK(h, l)		__GENMASK(h, l)
>> +#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
> 
> What do those actually expand to now?
> As I've said a few times both UL(0) and ULL(0) are just (0) for __ASSEMBLY__
> so the expansions of __GENMASK() and __GENMASK_ULL() contained the
> same numeric constants.

Indeed, in asm, the UL(0) and ULL(0) expands to the same thing: 0.

But the two macros still expand to something different on 32 bits
architectures:

  * __GENMASK:

      (((~(0)) << (l)) & (~(0) >> (32 - 1 - (h))))

  * __GENMASK_ULL:

      (((~(0)) << (l)) & (~(0) >> (64 - 1 - (h))))

On 64 bits architecture these are the same.

> This means they should be generating the same values.
> I don't know the correct 'sizeof (int_type)' for the shift right of ~0.
> My suspicion is that a 32bit assembler used 32bit signed integers and a
> 64bit one 64bit signed integers (but a 32bit asm on a 64bit host might
> be 64bit).
> So the asm versions need to avoid the right shift and only do left shifts.
> 
> Which probably means they need to be enirely separate from the C versions.
> And then the C ones can have all the ULL() removed.

In this v5, I already have the ULL() removed from the non-uapi C
version. And we are left with two distinct variants:

  - the uapi C & asm
  - the non-uapi C (including fix width)

For the uapi ones, I do not think we can modify it without a risk of
breaking some random userland. At least, this is not a risk I will take.
And if we have to keep the __GENMASK() and __GENMASK_ULL(), then I would
rather just reuse these for the asm variant instead of splitting further
more and finding ourselves with three variants:

  - the uapi C
  - the asm
  - the non-uapi C (including fix width)

If __GENMASK() and __GENMASK_ULL() were not in the uapi, I would have
agreed with you.

If you believe that the risk of modifying the uapi GENMASK*() is low
enough, then you can submit a patch. But I will definitely not touch
these myself.


Yours sincerely,
Vincent Mailhol


