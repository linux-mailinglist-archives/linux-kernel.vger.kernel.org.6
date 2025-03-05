Return-Path: <linux-kernel+bounces-547358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC76A5063B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F9816A5B5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B106819E806;
	Wed,  5 Mar 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="N12n9sYK"
Received: from out.smtpout.orange.fr (out-11.smtpout.orange.fr [193.252.22.11])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EC567D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195124; cv=none; b=JUjvFHVOMHKf9MM8FDtm8y/6qiZ2faEOkkut6z82uNk8FVWyEf9FK02aBFsvSs75fvoimkMfla6bjlQdhmSMlEcrSCkxdr4nyEcJPToLyKuGTdcpYgh6gndFF2zhnjAjFMi2M/MlnLboOOwOqXAs9ZHvjUaTxnrMHfS2YHKfcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195124; c=relaxed/simple;
	bh=S4c+Zjbnc/RFWyEaa7V9IsOeL7RkBBVUWBlY4CuP05M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+LyLicGwwyaU8C/++vXUiq61QJvH6UwOw4kiHWMN/rNIKTOZDHP4ZQfj19Tbrkj4SLs+Nshl6EynzDijqvZOO6lo4MuI6qeuhsR8zdigjoial24zyUiMw5NqyS2gLyx6gBrLZFDlcN//CHOKUWdaMP3I+Cl0p71icmBYTVJN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=N12n9sYK; arc=none smtp.client-ip=193.252.22.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id psMxtJc0ArlYrpsN1tsZVO; Wed, 05 Mar 2025 18:17:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741195052;
	bh=mjKe+ryvw34j4ffHLP7uzkbmqMNR5Softa/w5p2heeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=N12n9sYK2XIy4AYRo4rRhIwr7fT5AxTN7msq3Aa/Puc4i5eGtI5VqdUd571MJ2Rok
	 Bw1jd+GZgxVoRYcSEIhIiKYzoeTJVuOpHjqTP1J1Ks8OD+CpPMWJ7Kqc354mmcOoAc
	 Bx/0vzUcS3zi4rwzji5ULu5KS4DIkpsf1q7SwDTLBkHTvCeYwvQbymkdhldUZj6d/o
	 y+WI5YV1t2qCsElAqFsSKbekM/RhApTwKMPbvIWrZdw+3zKW+DeFl/jN2C/psOxBmd
	 7XzifnbrXUq+xwoSIbcw0OTn6crTlcUFnGUzDzE5jGPlcpjZuqyuHu+y1XR18noflQ
	 bsof5v0HxwwqA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 05 Mar 2025 18:17:32 +0100
X-ME-IP: 124.33.176.97
Message-ID: <824dc1d1-14f0-433e-aa3f-679527b87077@wanadoo.fr>
Date: Thu, 6 Mar 2025 02:17:18 +0900
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
 <d7f3150d-0167-44be-90b2-17f8a050687c@wanadoo.fr>
 <Z8hyNXVZxLzhEzNy@smile.fi.intel.com>
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
In-Reply-To: <Z8hyNXVZxLzhEzNy@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2025 at 00:48, Andy Shevchenko wrote:
> On Wed, Mar 05, 2025 at 11:48:10PM +0900, Vincent Mailhol wrote:
>> On 05/03/2025 at 23:33, Andy Shevchenko wrote:
>>> On Wed, Mar 05, 2025 at 10:00:16PM +0900, Vincent Mailhol via B4 Relay wrote:
> 
> ...
> 
>>>> +#define BIT_U8(b) (BIT_INPUT_CHECK(u8, b) + (unsigned int)BIT(b))
>>>> +#define BIT_U16(b) (BIT_INPUT_CHECK(u16, b) + (unsigned int)BIT(b))
>>>
>>> Why not u8 and u16? This inconsistency needs to be well justified.
>>
>> Because of the C integer promotion rules, if casted to u8 or u16, the
>> expression will immediately become a signed integer as soon as it is get
>> used. For example, if casted to u8
>>
>>   BIT_U8(0) + BIT_U8(1)
>>
>> would be a signed integer. And that may surprise people.
> 
> Yes, but wouldn't be better to put it more explicitly like
> 
> #define BIT_U8(b)	(BIT_INPUT_CHECK(u8, b) + (u8)BIT(b) + 0 + UL(0)) // + ULL(0) ?

OK, the final result would be unsigned. But, I do not follow how this is
more explicit.

Also, why doing:

  (u8)BIT(b) + 0 + UL(0)

and not just:

  (u8)BIT(b) + UL(0)

?

What is that intermediary '+ 0' for?

I am sorry, but I am having a hard time understanding how casting to u8
and then doing an addition with an unsigned long is more explicit than
directly doing a cast to the desired type.

As I mentioned in my answer to Yuri, I have a slight preference for the
unsigned int cast, but I am OK to go back to the u8/u16 cast as it was
in v3.

However, I really do not see how that '+ 0 + UL(0)' would be an improvement.

> Also, BIT_Uxx() gives different type at the end, shouldn't they all be promoted
> to unsigned long long at the end? Probably it won't work in real assembly.
> Can you add test cases which are written in assembly? (Yes, I understand that it will
> be architecture dependent, but still.)

No. I purposely guarded the definition of the BIT_Uxx() by a

  #if !defined(__ASSEMBLY__)

so that these are never visible in assembly. I actually put a comment to
explain why the GENMASK_U*() are not available in assembly. I can copy
paste the same comment to explain why why BIT_U*() are not made
available either:

  /*
   * Missing asm support
   *
   * BIT_U*() depends on BITS_PER_TYPE() which would not work in the asm
   * code as BITS_PER_TYPE() relies on sizeof(), something not available
   * in asm.  Nethertheless, the concept of fixed width integers is a C
   * thing which does not apply to assembly code.
   */

I really believe that it would be a mistake to make the GENMASK_U*() or
the BIT_U*() available to assembly.

>> David also pointed this in the v3:
>>
>> https://lore.kernel.org/intel-xe/d42dc197a15649e69d459362849a37f2@AcuMS.aculab.com/
>>
>> and I agree with his comment.
>>
>> I explained this in the changelog below the --- cutter, but it is
>> probably better to make the explanation more visible. I will add a
>> comment in the code to explain this.
>>
>>>> +#define BIT_U32(b) (BIT_INPUT_CHECK(u32, b) + (u32)BIT(b))
>>>> +#define BIT_U64(b) (BIT_INPUT_CHECK(u64, b) + (u64)BIT_ULL(b))
> 

Yours sincerely,
Vincent Mailhol


