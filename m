Return-Path: <linux-kernel+bounces-549175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73150A54E90
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5137A34DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036891DDA35;
	Thu,  6 Mar 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mt8RZlBl"
Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD32E634
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273681; cv=none; b=qo3jsVXFNQcXHnkVvDghb8Vk+mGfU2ecxPQk9nZ8lElRiqY7k6Y2RHsstU1B/JZXeX1cMWKDIib/0U+414W/sMxWXOs/j/fgmmbpsBDlJH1OC1GgMLoFvB+bD2IHdzQTFnPW/UqGxvHwNJmJQO3aNZdn253wH6rb8y2ftCT0jGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273681; c=relaxed/simple;
	bh=ci1jQEDAAE+FFPvP0HiXEl7jmMUZOAZTyMhlmxsahzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qxdooy3zsZCqqqbRZh1hg0coKVlMs9v9Zv7W1HySX6xiP5WvYv8hnA4XacJxSLWl1Z7lSgwXSJObMFHIGMjhEG9XYQ/Ajw3s0uMLPlT0w5vsrl8D19lHI93u45OlV+wISs0TA31RmIhGl+7Tc4wOqv4hd7dJMUvnJEMqc15YRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mt8RZlBl; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qCp8tfVrzYqvfqCpCtQNCR; Thu, 06 Mar 2025 16:07:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741273677;
	bh=AtOARcm7etY/CYGaI1Zh2dF1obFKsR0z+sX6jBAouw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mt8RZlBlKrrvCMNSwkYDS+KCzpYJJxQZSrDmvOkGDkNdM4kTJbuY9R7tCqh45ziVk
	 uNJMpGecfHrF1CywkDRiAzWtB7jZOpEem/Lckaerkc2fgA0wuys+A1kBXjmAJACHoW
	 MK+NCg+/qpx2inKG+ihiI0G1aNlzsv58fjH79YOG7B6YiR3PusbtPHHVUeCxWjB4VE
	 Qh3aRjjFaSUwBeHxj4fuB3hEC3Jwx0EgieImUpvshjwotUsZ/fnh0NZwmVRa6sWJMX
	 RYby6COMUSG6BZ4sR1ltucLokXCb/KBKcUoh0oumyRFS4i18Q/G8o2S9YjueL6260H
	 MIlr+gkolPdVA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Mar 2025 16:07:57 +0100
X-ME-IP: 124.33.176.97
Message-ID: <84abfaef-0fb9-4fd4-a657-0cc80eb1de0f@wanadoo.fr>
Date: Fri, 7 Mar 2025 00:07:45 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] bits: split the definition of the asm and non-asm
 GENMASK()
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
 <20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
 <Z8mdk3z7t42CWfmZ@smile.fi.intel.com>
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
In-Reply-To: <Z8mdk3z7t42CWfmZ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 at 22:05, Andy Shevchenko wrote:
> On Thu, Mar 06, 2025 at 08:29:52PM +0900, Vincent Mailhol via B4 Relay wrote:
>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>
>> In an upcoming change, GENMASK() and its friends will indirectly
>> depend on sizeof() which is not available in asm.
>>
>> Instead of adding further complexity to __GENMASK() to make it work
>> for both asm and non asm, just split the definition of the two
>> variants.
> 
> ...
> 
>> -/*
>> - * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
>> - * disable the input check if that is the case.
>> - */
> 
> I believe this comment is still valid...
> 
>> +#else /* defined(__ASSEMBLY__) */
> 
> 
> ...here.
> 
> Otherwise justify its removal in the commit message.

OK. I will restore the comment in v6, but will move it to the #else
branch, like this:

  #else /* defined(__ASSEMBLY__) */

  /*
   * BUILD_BUG_ON_ZERO is not available in h files included from asm
   * files, so no input checks in assembly.
   */
  #define GENMASK(h, l)		__GENMASK(h, l)
  #define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)

  #endif /* !defined(__ASSEMBLY__) */

>> +#define GENMASK(h, l)		__GENMASK(h, l)
>> +#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
>> +
>> +#endif /* !defined(__ASSEMBLY__) */
> 

Yours sincerely,
Vincent Mailhol


