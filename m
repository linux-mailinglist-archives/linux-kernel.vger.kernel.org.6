Return-Path: <linux-kernel+bounces-567292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5768DA6843B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035C318919E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DB820E339;
	Wed, 19 Mar 2025 04:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Sud1uwMU"
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1918C31
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742359142; cv=none; b=hVQCfakJmkRVP62qN+TTX5ne9F8QijQ1FXIn5Kyu6Z8QQgENUeKfHmY9i55MYRvuimGVP8+bH+CcIEVtiDRmLyWSJ59f4O9IvTKy6bCvJQtRy34NySJBU5PJbJlHXDNYrYB9z6vl0GAguKu8dmVkR9hxcrRNciNXw2ZobNAt1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742359142; c=relaxed/simple;
	bh=B9s0hRgVIJ/7l7vJyp0dvavFcfh21tfaShiqy4TsAy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cm9fBlD9uo4QXet0MQRX5wYKhz5X31JYuF2g0R8iU/VJgG3t32joMocB8Q2icsftNeM4nVIfMH7dORu+922S4MaecS0CZ9F47DjMVsv9QxpK/NAqV5bbC1bpUYB/LSTE+OmxFDtFFIJpWkpikUWBu1T3TD09lyAUYpsyVXI0b+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Sud1uwMU; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id ulBNtfpwMfuZZulBRtao7X; Wed, 19 Mar 2025 05:37:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742359066;
	bh=0VV/UtG/UDZ3bpNTeojrDmrZMrZ+qC1u4f7r2O6sak4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Sud1uwMUrmb/VgDg9o8K3hj8UGSE3pe+iPsWUs08o9YX88klI8CBGYgbivzcw+x9G
	 Gcso0XQnN56aGTJ4NPH2/9ZUv9Rgl1U1Yc7U93dRZRIECq8u0OZme2yqPgV1Jc7mYO
	 Ma6d5dm1AgEfE4i2/8hsrfzN3vGseKJgn6niyTMcuay96GuUyhWUYAcjVkVtf9usc4
	 +4y5P+9/s6wfFBZR1UbW0VHV7fwBQLuFxLs6d1Nsl2kRChFQ7k8tyJES6OXWNGD45K
	 6jTpRZn/qzK/wFJScoI+qPr04sdJMEmAZlAeVgVYExy71tr8PBXZfInQcfQHr9x+gN
	 6ShqyktgoutLw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 19 Mar 2025 05:37:46 +0100
X-ME-IP: 124.33.176.97
Message-ID: <f6885fdb-4361-428c-b6dd-54cd2ac7904d@wanadoo.fr>
Date: Wed, 19 Mar 2025 13:37:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] drm/i915: Convert REG_GENMASK*() to fixed-width
 GENMASK_U*()
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Yury Norov <yury.norov@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>,
 David Laight <David.Laight@aculab.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-4-f59315e73c29@wanadoo.fr>
 <Z9mqUZX4H-CzqbW4@thinkpad> <87ldt2c6lz.fsf@intel.com>
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
In-Reply-To: <87ldt2c6lz.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2025 at 07:32, Jani Nikula wrote:
> On Tue, 18 Mar 2025, Yury Norov <yury.norov@gmail.com> wrote:
>> On Sat, Mar 08, 2025 at 01:48:51AM +0900, Vincent Mailhol via B4 Relay wrote:
>>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>>>
>>> Now that include/linux/bits.h implements fixed-width GENMASK_U*(), use
>>> them to implement the i915/xe specific macros. Converting each driver
>>> to use the generic macros are left for later, when/if other
>>> driver-specific macros are also generalized.
>>>
>>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>> ---
>>> Changelog:
>>>
>>>   v5 -> v6:
>>>
>>>     - No changes.
>>>
>>>   v4 -> v5:
>>>
>>>     - Add braket to macro names in patch description,
>>>       e.g. 'REG_GENMASK*' -> 'REG_GENMASK*()'
>>>
>>>   v3 -> v4:
>>>
>>>     - Remove the prefixes in macro parameters,
>>>       e.g. 'REG_GENMASK(__high, __low)' -> 'REG_GENMASK(high, low)'
>>> ---
>>>  drivers/gpu/drm/i915/i915_reg_defs.h | 108 ++++-------------------------------
>>>  1 file changed, 11 insertions(+), 97 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_reg_defs.h b/drivers/gpu/drm/i915/i915_reg_defs.h
>>> index e251bcc0c89f5710125bc70f07851b2cb978c89c..39e5ed9511174b8757b9201bff735fa362651b34 100644
>>> --- a/drivers/gpu/drm/i915/i915_reg_defs.h
>>> +++ b/drivers/gpu/drm/i915/i915_reg_defs.h
>>> @@ -9,76 +9,19 @@
>>>  #include <linux/bitfield.h>
>>>  #include <linux/bits.h>
>>>  
>>> -/**
>>> - * REG_BIT() - Prepare a u32 bit value
>>> - * @__n: 0-based bit number
>>> - *
>>> - * Local wrapper for BIT() to force u32, with compile time checks.
>>> - *
>>> - * @return: Value with bit @__n set.
>>> +/*
>>> + * Wrappers over the generic BIT_* and GENMASK_* implementations,
>>> + * for compatibility reasons with previous implementation
>>>   */
>>> -#define REG_BIT(__n)							\
>>> -	((u32)(BIT(__n) +						\
>>> -	       BUILD_BUG_ON_ZERO(__is_constexpr(__n) &&		\
>>> -				 ((__n) < 0 || (__n) > 31))))
>>> +#define REG_GENMASK(high, low)		GENMASK_U32(high, low)
>>> +#define REG_GENMASK64(high, low)	GENMASK_U64(high, low)
>>> +#define REG_GENMASK16(high, low)	GENMASK_U16(high, low)
>>> +#define REG_GENMASK8(high, low)		GENMASK_U8(high, low)
>>
>> Nit. Maybe just
>>
>>  #define REG_GENMASK		GENMASK_U32
> 
> Please just keep it as it is for clarity.

I also prefer when the argument is clearly displayed. It shows at first
glance that this is a function-like macro and reminds of the correct
order of the argument without having to look at the definitions in
bits.h. It also allows for people to grep "#define REG_GENMASK(" in
order to find the macro definition.

To be honest, I don't have a strong opinion either, but because Jani
also prefers it this way, I will keep as-is.


Yours sincerely,
Vincent Mailhol


