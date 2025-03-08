Return-Path: <linux-kernel+bounces-552390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85519A5797D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592887A7979
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E5A18C32C;
	Sat,  8 Mar 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EKQhso65"
Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBF1ACECF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426211; cv=none; b=GXzRQ6N7jdrEqoIGw7bWP60Qf8+hPb9kS/fcXtIgjEGWRR0Fk7pOlkk5MEJuzoLDpTHfXdDFf0UVnxv+oLJXQ1xBEGzbxp7Gp4dWnCJHda5J+XdvD8QrhQAbs0nE2mOOS2zN9hvfzN6U2Jg+8ChyCD0WknKk0d9SsTpq2glojxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426211; c=relaxed/simple;
	bh=hOM1AnDjbz539EZArXs5/K5EKEx6uI6kVasHNkBQXhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTG8phABnM9+ZT7QJ69DLWZPnAMmnYrD9Gt/u2oosHsLGUo1Kzr4PsBa3XDLVE1yrCS37fkc/ayKo2QLIf8IRaIEKI5iJA2e8Rn8PsgC0kZoj+7OBkN1cc6rMofEQctwZNQBzKHM+q7Cpr1Uqw5doOqiOVUiNbjFmTVOek54ofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EKQhso65; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qqU9t7io2tsZCqqUEtgNFH; Sat, 08 Mar 2025 10:28:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741426136;
	bh=m49a0jOVCmNE3wfZMyztyNQxUtYwR04X0isyiXi3D1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=EKQhso65r/NfiTcR03z6k7EbF04rfLahKWHfYTIjfBBF6F2ag6/H7ZzGv6V64O1ik
	 qj1E1Dm/QHxwSUs6URxLjEOahiARr+CH29kr7UkVZwmHZAWZdJbyiCL+AL+jjoEJ4E
	 DRbT7PSxPqHp1AOWaJoRbz8U9akzpeQWdoSK76+rOOAPYC9NO3cv2THl5ueVXXC5Pu
	 s4BbiB0nfM9BkvO95RFTTJvaRIqV0b9244jwmTteG8czT5ePu4C32rc1SDwqOaE9QU
	 Ias8s3L+XRwQq27nzu0Hx9qqcV4QRB2lDC6PBnMjeyXGjEzIOLamQARng5+qlxm12S
	 2mh8ow1eSWcTA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Mar 2025 10:28:56 +0100
X-ME-IP: 124.33.176.97
Message-ID: <0ddca27b-894b-42f8-b0ac-d862b9463733@wanadoo.fr>
Date: Sat, 8 Mar 2025 18:28:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] bits: introduce fixed-type BIT_U*()
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
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-3-f59315e73c29@wanadoo.fr>
 <Z8sxUTR-5j5XmZnO@smile.fi.intel.com> <Z8sxsCR0KxqZWltB@smile.fi.intel.com>
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
In-Reply-To: <Z8sxsCR0KxqZWltB@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2025 at 02:49, Andy Shevchenko wrote:
> On Fri, Mar 07, 2025 at 07:48:01PM +0200, Andy Shevchenko wrote:
>> On Sat, Mar 08, 2025 at 01:48:50AM +0900, Vincent Mailhol via B4 Relay wrote:
> 
> ...
> 
>>>  /*
>>>   * Missing asm support
>>>   *
>>> - * GENMASK_U*() depends on BITS_PER_TYPE() which relies on sizeof(),
>>> - * something not available in asm. Nethertheless, fixed width integers
>>> - * is a C concept. Assembly code can rely on the long and long long
>>> - * versions instead.
>>> + * GENMASK_U*() and BIT_U*() depend on BITS_PER_TYPE() which relies on
>>> + * sizeof(), something not available in asm. Nethertheless, fixed
>>> + * width integers is a C concept. Assembly code can rely on the long
>>> + * and long long versions instead.
>>>   */
>>
>> I don't like this hunk. You just introduced a message which is rewritten
>> completely in the immediate followup. Can you come up in a better text
>> here and/or there so it will give only + LoCs (or minimizes - to 1:ish)?

OK. I will add an artificial early new line in the previous patch so
that the diff is only one line.

> And also note, that using up to 90 characters in the comments most likely fine
> here. At least I don't see a problem with that.

I re-wrapped the text to the 80 column and it now fits on three lines.
90 column wouldn't reduce the line count, so I am keeping it to 80.


Yours sincerely,
Vincent Mailhol


