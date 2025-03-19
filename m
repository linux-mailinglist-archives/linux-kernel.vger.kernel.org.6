Return-Path: <linux-kernel+bounces-567332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B2A684A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864FA18980DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC7020C488;
	Wed, 19 Mar 2025 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Z8H33VCU"
Received: from out.smtpout.orange.fr (out-11.smtpout.orange.fr [193.252.22.11])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6F198A08
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742362767; cv=none; b=Dg8G3p2Ze3qim698R7t3pXOLtox7LThNDCjG+cvFXWjSJQTqx/Uxi2MUzl8c7K54WU4aS9C80jwwAWsgidrucSvXntyWG7XDl5JGJNuj1nOsISbhNCjpykrc13N0+nHPdSLaWc9KuTPR83i/PVXAxxkt/cBNRG9hKVaKzrO5IDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742362767; c=relaxed/simple;
	bh=sZREiiODBh9spKEv/Roh0kDITJAdKr+Boe9fkisGqt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WU88XzxEVrEaIQt8KD+1LovvGe3QNTOCxbFjhIZ/USfYWI6KJYto1hQBXqzumkcIgm98IDL7p0wts9bNYEGqY+wQDweKYsMV4cbxJ1W0Ivxdm/BnK9CVretdPsin7fsVQD3iMRQIeM/OgIEJp5Eq8+HK75j1Vrt0nhSDb9INUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Z8H33VCU; arc=none smtp.client-ip=193.252.22.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id um8utLdfOnwqeum8ytx8US; Wed, 19 Mar 2025 06:39:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742362756;
	bh=IpaEN+lSaaf3iXvbx9pvjpLuE5Y7yQM8JtA9F032OKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Z8H33VCU+I5tCl1JteiThZ4KyLDgdMjzyk4KVKBTaTn8iBV/E/4O0/qNiD08Ma7aa
	 +UzqtOIYhYxCyUEjwVw1ZOEPV4bEcAEFO5UrGp9KaqPzGblGUkfcmSiGKqa8Ydriq6
	 CtFsFVRUf3gekjXKC3nUZ+8e6CT/ts383YJnaJNvZZxcwaqmtLu+zVT+qV2KfTtzF7
	 LFYQspTzvdvZZKxAl4G0MmLRAnH459WWI5vZ3LpD7QFgfpv5J61oQepAhDkF+wqcQ9
	 Dr3zAxixzghRPBO7Fg97uzyMg+QfvmvEfaAXCNk1oeZVn3vAFqrD9cq003l48E5Jfm
	 AF8jaJvW5ZFNQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 19 Mar 2025 06:39:16 +0100
X-ME-IP: 124.33.176.97
Message-ID: <443027f0-08c9-449a-8ee0-db9b234483f4@wanadoo.fr>
Date: Wed, 19 Mar 2025 14:39:03 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] bits: introduce fixed-type genmasks
To: Yury Norov <yury.norov@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
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
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jani Nikula <jani.nikula@intel.com>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-2-f59315e73c29@wanadoo.fr>
 <Z9mjJ3gJoqLwjIFX@thinkpad>
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
In-Reply-To: <Z9mjJ3gJoqLwjIFX@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2025 at 01:45, Yury Norov wrote:
> On Sat, Mar 08, 2025 at 01:48:49AM +0900, Vincent Mailhol via B4 Relay wrote:
>> From: Yury Norov <yury.norov@gmail.com>

(...)

>> +#define GENMASK(h, l)		GENMASK_TYPE(unsigned long,  h, l)
>> +#define GENMASK_ULL(h, l)	GENMASK_TYPE(unsigned long long, h, l)
> 
> I like everything except this part. We switch GENMASK() from a well
> tested implementation, including an asm code, and we split uapi and
> non-uapi users, with no functionality changes.
> 
> Unification is a solid point, however.
> 
> Let's make it a 2-step procedure? Adding fixed-width GENMASKs is a
> non-questionable improvement. Switching an existing API from one
> implementation to another should be a separate patch, and probably
> even a separate series. And we should be very clear that __GENMASK()
> is uapi-only thing from now.
> 
> If we decide to switch GENMASK() in a separate series, we'll have some
> extra time to think about unification...

Ack. I started drafting the split. The two series would look like:

[Series #1] bits: Fixed-type GENMASK_U*() and BIT_U*()
    - bits: introduce fixed-type GENMASK_U*()
    - bits: introduce fixed-type BIT_U*()
    - drm/i915: Convert REG_GENMASK*() to fixed-width GENMASK_U*()
    - test_bits: add tests for GENMASK_U*()
    - test_bits: add tests for BIT_U*()

[Series #2] bits: Split asm and non-asm GENMASK*() and unify definitions
    - bits: split the definition of the asm and non-asm GENMASK*()
    - bits: unify the non-asm GENMASK*()
    - test_bits: add tests for __GENMASK() and __GENMASK_ULL()


Series #1 will leave GENMASK(), GENMASK_ULL() and GENMASK_128()
untouched. The final result after the Series #2 will be the exact same
code as of now.

I am thinking of sending the two series at the same time, and then, you
can decide what is the good timing to merge these (and eventually, start
a separate discussion on the second series).

Does this work for you?

On a side note, it did a lot of modifications to your original patch
which introduced the GENMASK_U*(). It is OK to tag myself as author and
you as co-author or do you still prefer to stay as the main author? Let
me know!


Yours sincerely,
Vincent Mailhol


