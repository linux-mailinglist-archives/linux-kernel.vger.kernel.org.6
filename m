Return-Path: <linux-kernel+bounces-551582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6BCA56E36
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F7189A4B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FACE21D5A4;
	Fri,  7 Mar 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XF17AYBF"
Received: from out.smtpout.orange.fr (out-14.smtpout.orange.fr [193.252.22.14])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2319259A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366097; cv=none; b=gxTRErUqua/gubN1g2Q0OBaOzso6pXWJMbfPka2KfKqh4Uv/BEznqEiTHEYTi69BckA1LgBC/EWcju55fBgYcBycTWytgBzLHWrYhftgicg7H0CoRNzNuRtQDyZRUxVwL+y21OIx6L4Mtsy7AA/9l1ge1YWaRiJxfWzrGDGsIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366097; c=relaxed/simple;
	bh=pr+yx1/i9wk+vnCXthUFlupCkDQ0S5PN+gS7o5ENYoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTn+u97irSoGjkeozOPExzfkQmgi8VP+ZUNw+mphJV9SJodFM4wqCGv4+tppM9glBvfE7DeNBsbhwpzyEwZe+Y0sPhIbIJfaO1KV99jBbPg/tUQb9IcJb9570Jj1tuWZzw9/OEeg0krOdN94T8b0MlwxmfIr7Tqwwe6WD3rf75M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XF17AYBF; arc=none smtp.client-ip=193.252.22.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qarctOjMqqRT1qargtKKLq; Fri, 07 Mar 2025 17:48:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741366092;
	bh=drBHi5mAYtcqc2m8LrQpmiPZvuUhLi3euWjk2l3OkIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XF17AYBFLJMiea4Q11qBZeG7cZbBV2tMZHIBbkPYznZOcKYLJyIBhxjreiJxMdBv4
	 Rv/wqhpz8uBWOgbmVqLASSBZyFD75ZiAaCNi0rq6sVo0mbqmYJ1WqU52DAF0YHQS7i
	 KevKfwRb0K06PXPpkbtvsAeonhAuVNGKqcssKPcndD/Xjus7QaECuVH1YjGSz9BMx7
	 5fPFKkqnyBLHiGvJ8hLzr1QzJ62sS/cP9ZMB+jnW0JHIu/+Rfb+P3eevxgkAsIkEBX
	 J8HTjbtFrZ2a/BvPOwLGZNhm1dJ1NNkVCbfe1rrkpOKPLTAisiXrQqZxoQZdXzhdu+
	 B9j04cW84kFhw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 Mar 2025 17:48:12 +0100
X-ME-IP: 124.33.176.97
Message-ID: <51232841-0de5-4f62-9223-d7f6dd35c0c3@wanadoo.fr>
Date: Sat, 8 Mar 2025 01:47:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] test_bits: add tests for BIT_U*()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
 David Laight <David.Laight@aculab.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-7-b443e9dcba63@wanadoo.fr>
 <Z8mfAQGUvm3z86kE@smile.fi.intel.com>
 <722e147b-fdd1-4098-8d60-48c83e36a7f7@wanadoo.fr>
 <Z8nhdz5FZIHYb4Yi@smile.fi.intel.com>
 <df371256-d981-433b-bcba-00a445e04c41@wanadoo.fr>
 <Z8sZs_Tfl4G8PoAM@smile.fi.intel.com>
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
In-Reply-To: <Z8sZs_Tfl4G8PoAM@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/03/2025 at 01:07, Andy Shevchenko wrote:
> On Fri, Mar 07, 2025 at 07:11:42PM +0900, Vincent Mailhol wrote:
>> On 07/03/2025 at 02:55, Andy Shevchenko wrote:
>>> On Fri, Mar 07, 2025 at 01:08:15AM +0900, Vincent Mailhol wrote:
>>>> On 06/03/2025 at 22:11, Andy Shevchenko wrote:
>>>>> On Thu, Mar 06, 2025 at 08:29:58PM +0900, Vincent Mailhol via B4 Relay wrote:
>>>>>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>>>>
>>>>>> Add some additional tests in lib/test_bits.c to cover the expected
>>>>>> results of the fixed type BIT_U*() macros.
>>>>>
>>>>> Still would be good to have a small assembly test case for GENMASK*() as they
>>>>> went split and it will be a good regression test in case somebody decides to
>>>>> unify both without much thinking..
>>>>
>>>> Let me confirm that I correctly understood your ask. Would something
>>>> like this meet your expectations?
>>>
>>> I believe it should be written in asm.
>>
>> I am not confident enough in my assembly skills to submit asm patches to
>> the kernel. So, I would rather take a pass on that one.
>>
>> Regardless, if somebody decides to unify both without much thinking as
>> you said, I am fully confident that the patch will get Nack-ed right
> 
> As I said above "would be good", if you think it's not feasible by you, perhaps
> a comment (FIXME: ?) in the Kunit test cases that we lack of / need an asm test
> as well.

Ack. I will add a FIXME message in v6.


Yours sincerely,
Vincent Mailhol


