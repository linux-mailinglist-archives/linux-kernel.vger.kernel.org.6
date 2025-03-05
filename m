Return-Path: <linux-kernel+bounces-547080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA41FA502D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03631889D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F0524EAB2;
	Wed,  5 Mar 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oQcqbkBE"
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710024E01A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186174; cv=none; b=Ezla9qRtt8a4mpvqo7Gn/+O+SY2iFSrEbjfnM90ypZ1KeFjywbXqMIsmL9MsV8AT3xW7udWzw+EZEyxZVwUVtbmb26Tt9RV47NETSn/1iwzncgyCAHWJHCp5PXITvdKLl4VmPiA3Yf0j8SGGw+irQsJCiu/Z3v8RKCe0J9OjpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186174; c=relaxed/simple;
	bh=CdZEXDdmycGNnqgioi99HXlao+olh8It264ntQrW6VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6Et1f+HQ3c27tiCeMi8LT5LfjzmG6DC319jNh1TsRMFdajjjlTUiua6QINQ+nWpf6FMjqCd60z4pD7FwPEwHUlQBnuNVbBUinVp5SlJiGiaPhR30c7I3AYq0roj0LZ2LwSG+nqsjfSPTucIuQgH3J4gHVu3RtdwFCGvUBwbvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oQcqbkBE; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id pq2dtPvcTgWbapq2htQk0O; Wed, 05 Mar 2025 15:48:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741186102;
	bh=3RcUUtJiVQIxZzOfKMrWa4tzRtxjWdXUh2HCxF6cfvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=oQcqbkBEl+UgQi3Rr0ez6Ckv1SOIbEYh7API3Jf6hBUllX0xuBTJh6r8Cf9qGqd/u
	 aS8Fbd2QKZImx/ILnJHSjpW3GuB9NAG/OfXXiNisriLhgcsNFE/4IRvuOjTL94XsAZ
	 luNP+vlrQkN2DrSL2CD+alqysspVK2wC7QsaBEjY932I+CplGBHlr3218gx6GpEwya
	 ilVUXKiOtsSoZ5cCeoH+VNzVZ5hJoo9ej6TMpHJoo9UVvvax9m4YrR8cgpD+8HHFBk
	 FU6JChb2VY1Gc1e5vaf0op62DUYeL/yFOeG0gtOy4sQ7mlcq99zjgBTB60KkzqZKO+
	 SKXWpnYX6mUnA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 05 Mar 2025 15:48:22 +0100
X-ME-IP: 124.33.176.97
Message-ID: <d7f3150d-0167-44be-90b2-17f8a050687c@wanadoo.fr>
Date: Wed, 5 Mar 2025 23:48:10 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] bits: introduce fixed-type BIT
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jani Nikula <jani.nikula@intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-4-1873dcdf6723@wanadoo.fr>
 <Z8hgqOB5Ym-GGykS@smile.fi.intel.com>
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
In-Reply-To: <Z8hgqOB5Ym-GGykS@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2025 at 23:33, Andy Shevchenko wrote:
> On Wed, Mar 05, 2025 at 10:00:16PM +0900, Vincent Mailhol via B4 Relay wrote:
>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> Implement fixed-type BIT to help drivers add stricter checks, like was
> 
> Here and in the Subject I would use BIT_Uxx().
> 
>> done for GENMASK().
> 
> ...
> 
>> +/*
>> + * Fixed-type variants of BIT(), with additional checks like GENMASK_t(). The
> 
> GENMASK_t() is not a well named macro.

Ack. I will rename to GENMASK_TYPE().

>> + * following examples generate compiler warnings due to shift-count-overflow:
>> + *
>> + * - BIT_U8(8)
>> + * - BIT_U32(-1)
>> + * - BIT_U32(40)
>> + */
>> +#define BIT_INPUT_CHECK(type, b) \
>> +	BUILD_BUG_ON_ZERO(const_true((b) >= BITS_PER_TYPE(type)))
>> +
>> +#define BIT_U8(b) (BIT_INPUT_CHECK(u8, b) + (unsigned int)BIT(b))
>> +#define BIT_U16(b) (BIT_INPUT_CHECK(u16, b) + (unsigned int)BIT(b))
> 
> Why not u8 and u16? This inconsistency needs to be well justified.

Because of the C integer promotion rules, if casted to u8 or u16, the
expression will immediately become a signed integer as soon as it is get
used. For example, if casted to u8

  BIT_U8(0) + BIT_U8(1)

would be a signed integer. And that may surprise people.

David also pointed this in the v3:

https://lore.kernel.org/intel-xe/d42dc197a15649e69d459362849a37f2@AcuMS.aculab.com/

and I agree with his comment.

I explained this in the changelog below the --- cutter, but it is
probably better to make the explanation more visible. I will add a
comment in the code to explain this.

>> +#define BIT_U32(b) (BIT_INPUT_CHECK(u32, b) + (u32)BIT(b))
>> +#define BIT_U64(b) (BIT_INPUT_CHECK(u64, b) + (u64)BIT_ULL(b))
> 
> Can you also use a TAB between the parentheses for better readability?
> E.g.,
> 
> #define BIT_U64(b)r	(BIT_INPUT_CHECK(u64, b) + (u64)BIT_ULL(b))

Sure. I prefer it with space, but no strong opinion. I will put tab in v5.

Yours sincerely,
Vincent Mailhol


