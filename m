Return-Path: <linux-kernel+bounces-548535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC59A5462F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3B9188BAA2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D76220897B;
	Thu,  6 Mar 2025 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="d8X9p5/l"
Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12235199935
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253040; cv=none; b=uEhhZxrvq0kg8P0Va1DE5wmgq+FzZnDLZyjxFB0BsnTUW3hzHILzwavIT0guI+LG0aC66T4ksjq0JpsmFZNl5II1/fTzNkM0HtG5s9dyHYgVozKNTuMxevxle4M8sLMea+R8cI11GloX6SxSfwTFewN3fUNIz/amZuJ4rudRQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253040; c=relaxed/simple;
	bh=5e2fmORos6C6HvKMhLlvlFkaXB2rEVV78cjvr8xrXQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pT8QnGpa9rKZRerGIFtb7X1MD7nG3cDO7cPNx199HRfdl8WOH0G6NxUMg0sxYnnq8j9MXLVemV9HI+esOmxIqA5KJsHokQMny4JyYQbvNidOVp+5D3LXre6yOoEFZHDdKDAtXj/YRrB009wg2iYhObBijibm88lZSByyMP4PYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=d8X9p5/l; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id q7R4tKmaLiRGyq7R8t84Vt; Thu, 06 Mar 2025 10:22:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741252966;
	bh=q2o/LWxWZ/FiWcwTOy3Kk+fZSYKZjgmVPty3JZX4kG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=d8X9p5/lK/eLI2uTC2go9WHejeyDbcJjIh9pZd3ERhYgmAyCwKXsSz1KJ8m6vJJ4Y
	 NC935iRLnvmJoaxXEMMRaeosvywCQ4vzMqWcCYX3OYmN/+VI50rO1Snbo+1iu9SyIE
	 q1q+n2otbZF4YVs+jb+9Ee9Y1ft+fOeSIWxgvFFuSqcL3ahSk3iFQy6bwGNsKNU0sC
	 Vn8gYxrUxjxXoFgh0rRfF0lpYa8E9dRWa6S0BI+W9scA+sueA9yOYwvM/D/PG6wRI2
	 bWiS23SyxIpzd7OOwU+P//gxdSfxNN55BuZIUTGd9Da8Ykn0DkhYlKCYRgAioFTC0g
	 1P2n8SParFWEQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Mar 2025 10:22:46 +0100
X-ME-IP: 124.33.176.97
Message-ID: <7063c8b4-5869-457d-91b1-3185d9e1181e@wanadoo.fr>
Date: Thu, 6 Mar 2025 18:22:33 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] bits: introduce fixed-type genmasks
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
 <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>
 <Z8hx9AaUX_GvYq_A@thinkpad> <8301ecbc-d035-4257-9b04-c6ef9be4ce32@wanadoo.fr>
 <Z8ipvnURG_iejzSX@smile.fi.intel.com>
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
In-Reply-To: <Z8ipvnURG_iejzSX@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 at 04:45, Andy Shevchenko wrote:
>>> But GENMASK_U128() becomes a special case now.
>>> The 128-bit GENMASK is unsued, but it's exported in uapi. Is there any
>>> simple way to end up with a common implementation for all fixed-type
>>> GENMASKs?
>>
>> What bothers me is that the 128 bit types are not something available on
>> all architectures, c.f. the CONFIG_ARCH_SUPPORTS_INT128. So, I would
>> need a U128() equivalent to the ULL() but which does not break on
>> architectures which do not support 128 bits integers.
>>
>> This is where I am stuck. If someone can guide me on how to write a
>> robust U128() macro, then I think the common implementation could be
>> feasible.
> 
> I think we may leave that U128 stuff alone for now.

I found the solution! The trick is to use type_max() from overflow.h.

With this, GENMASK_TYPE() becomes:

  #define GENMASK_TYPE(t, h, l)					\
  	((t)(GENMASK_INPUT_CHECK(h, l) +			\
  	     (type_max(t) << (l) &				\
  	      type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))

and works with all the GENMASK variants, including the U128 one! The
unit tests under lib/test_bits.c are all green.

Of course, this does *not* work in assembly. But as explained before,
GENMASK_TYPE() is guarded by a #if !defined(__ASSEMBLY__), so all good!

The question raised by Yury on whether or not we should keep
__GENMASK_U128() in the uapi still remains. And in full honesty, I will
not touch that one. This is not in the scope of this series.


Yours sincerely,
Vincent Mailhol


