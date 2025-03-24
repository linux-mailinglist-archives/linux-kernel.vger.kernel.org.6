Return-Path: <linux-kernel+bounces-573309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A11FDA6D584
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AB716A3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530D25A2BC;
	Mon, 24 Mar 2025 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sdI268tj"
Received: from out.smtpout.orange.fr (out-65.smtpout.orange.fr [193.252.22.65])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02AC13B797
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802847; cv=none; b=Ne2Kbl7DsZSQo0AA2lLm4/B2uvVIKtvCbdj65oErp6Xu9vlNOFv9ciSRVw+ADppm/uTHAwtrJmAjvPVj8VJW3ce/xNJPYM6rzbBngMa6Pi1n5fQqbH9SBJGNIAjyJDBe6PxVk4woMmIyPEFl638Gy0Rcb2VN9O8+9IEmdYhWv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802847; c=relaxed/simple;
	bh=tvAIIuR1iPe/70LBC/XK+o9+54IQoWvVHvcnYdC+BSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGr/0+NFfbPYw+t9lUdkx9iufbg47YrMvEXpGuuV/8h9LZSmoYSaOTNUZQaOsi62za4n7taYIhMm2URexPY0Cp2sichwL259/exE/BEk8hk2VcHyKcQAkwUtOrC8VQfTkfWEgfb3ktpy+JJigrnDEaFe1xi7tGhnv8vwG2tPfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sdI268tj; arc=none smtp.client-ip=193.252.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id wcU2tGWSCo3Z8wcU6tISto; Mon, 24 Mar 2025 08:44:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742802281;
	bh=XsGk3ixhSurfkLIH5o1CSD/Ev7zogu3EYa8+C/nPa0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=sdI268tj5lyVJtO3fEwynmKPbQg09PuOecq2JJCSdjSp7N1NgJ6fcy6XKYbjGhr/1
	 2gk2XM/VMpWoxAKiiAcbhewU0pEJZB6nFv5S2ZlayCpKZ18kjNF05DGW9vwRi6bIcz
	 z3ul2hSwmRTaF10207d/yfQSpK0HTU8rrtuJjS1jHE0+UHG38ESd4ian45uXMWsPxj
	 KymUZv00SMfq99I4IgfJQJjFAQJ0EUxtmscmuGjmFOjH0YeShHtWdQ/rPkGEvecps8
	 CUFUtHhORoskiP35auEhZb9UakXJ6ypJq3LVyLDwRigo50w+Z7LRWCyAlaZpmWdz9O
	 j0TF2QXUwzPnw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Mar 2025 08:44:41 +0100
X-ME-IP: 124.33.176.97
Message-ID: <202c97b2-e99e-4b88-9ac5-171db244b7d0@wanadoo.fr>
Date: Mon, 24 Mar 2025 16:44:29 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] bits: introduce fixed-type GENMASK_U*()
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
 David Laight <David.Laight@aculab.com>, Jani Nikula <jani.nikula@intel.com>
References: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>
 <20250322-fixed-type-genmasks-v7-1-da380ff1c5b9@wanadoo.fr>
 <Z-EIHBCkUiBh63JE@smile.fi.intel.com>
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
In-Reply-To: <Z-EIHBCkUiBh63JE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/03/2025 at 16:22, Andy Shevchenko wrote:
> On Sat, Mar 22, 2025 at 06:23:12PM +0900, Vincent Mailhol via B4 Relay wrote:
>>
>> Add GENMASK_TYPE() which generalizes __GENMASK() to support different
>> types, and implement fixed-types versions of GENMASK() based on it.
>> The fixed-type version allows more strict checks to the min/max values
>> accepted, which is useful for defining registers like implemented by
>> i915 and xe drivers with their REG_GENMASK*() macros.
>>
>> The strict checks rely on shift-count-overflow compiler check to fail
>> the build if a number outside of the range allowed is passed.
>> Example:
>>
>>   #define FOO_MASK GENMASK_U32(33, 4)
>>
>> will generate a warning like:
>>
>>   include/linux/bits.h:51:27: error: right shift count >= width of type [-Werror=shift-count-overflow]
>>      51 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
>>         |                           ^~
>>
>> While GENMASK_TYPE() is crafted to cover all variants, including the
>> already existing GENMASK(), GENMASK_ULL() and GENMASK_U128(), for the
>> moment, only use it for the newly introduced GENMASK_U*(). The
>> consolidation will be done in a separate change.
> 
> ...
> 
>>  #if !defined(__ASSEMBLY__)
>> +
> 
>> -#else
> 
>> +#else /* defined(__ASSEMBLY__) */
> 
>> -#endif
>> +
>> +#endif /* !defined(__ASSEMBLY__) */
> 
> Up to you, but if new version is needed or maintainer require, I would move the
> above changes either to a separate patch (prerequisite) or dropped them at all.
> These are not big but unneeded churn,

I do not want to drop this. After all the changes, there is a lot of
scrolling between the #if, #else and #endif, and the comments helps to
keep track of which context we are in.

As for putting this into another patch, OK but only if there is a need
for new version for other reasons.


Yours sincerely,
Vincent Mailhol


