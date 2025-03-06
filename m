Return-Path: <linux-kernel+bounces-549275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6547A55036
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D88B16F612
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1BE21019C;
	Thu,  6 Mar 2025 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QqBDPvgZ"
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F4145A0B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277303; cv=none; b=nAi53PIYedhPr4KiUG1hPK+3kpdc2xblBNsQpqPIfpeq/mphaTdcJFV15pfyLZU7O5ZC9nJp3HDiv/IMcMYp78zjTW3qAh7Ejh1nk8loBS8vnQ6STZZOXS9kkefTGJCUSp8yKA436Pdi6E5Emnk1H0dvOhd8oGMJtdbLo8fGsIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277303; c=relaxed/simple;
	bh=wfuL0NI3ln1SFNoNbNrwAarM/fTbiMbvPzenoLmIWuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOttPkLuCIChmHjjMoXg8vC9/IAuPG4AEnEiDnstHla8iCLwxjJhG4W237sCleeFukY8jjOeKtDLgaoMTkjK1n1St0bvCpIKS3QkmuDgOgDSDAfHURfZvHpMNRDYdsfX12sdRt6CE6pIgo7IexLYbYun2fQfiFNOWBbt4GUahrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QqBDPvgZ; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qDlStMikP0ogTqDlWtO2V5; Thu, 06 Mar 2025 17:08:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741277293;
	bh=ntx+3nq4V7yi7gEdsBrCg2/MKlVb0jJAsXsOG3Q1Q6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QqBDPvgZfeQKlj94cL0sLp7HN6qdX0lxzBcAuLquQCqlcZScYqlaxcOpgUIPpFgUp
	 k41xxGMRz/ZRLYlQG5bJ6sU0X6XJHLEOZ98LRRRU31fF8VUg/9C336KQynoG4qFxv1
	 39WxtLBfHS91vmpl1YNkx/t60jrmEZF3S95ER+TVUxAW+awdR4Gs8cfRQuE59JhRDD
	 k18bdAgpV4QKuNpnBhGwZtPIqiiUsOjf2KWJ/pYROamSIVakkdfIHvA7Z40W/T0hkF
	 yFeyFGDl7y9fvuijVn0o2ZoAz+EGXm+Apie5YeJzg25q1xVNPATfvLbFNnkCy5CRdy
	 2zUn3aft7Bztw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Mar 2025 17:08:13 +0100
X-ME-IP: 124.33.176.97
Message-ID: <1c081c07-2833-4fa9-96fb-88a7295d2c14@wanadoo.fr>
Date: Fri, 7 Mar 2025 01:08:01 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] bits: introduce fixed-type genmasks
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
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-2-b443e9dcba63@wanadoo.fr>
 <Z8meY7NS65_d14og@smile.fi.intel.com>
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
In-Reply-To: <Z8meY7NS65_d14og@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2025 à 22:08, Andy Shevchenko wrote:
> On Thu, Mar 06, 2025 at 08:29:53PM +0900, Vincent Mailhol via B4 Relay wrote:
>> From: Yury Norov <yury.norov@gmail.com>
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
> 
> Code LGTM

Does this mean I get your Reviewed-by tag? Or will you wait the v6 to
formally give it?

> but just to be sure: you prepared your series using histogram
> diff algo, right?

No, I never used the histogram diff. My git config is extremely boring.
Mostly vanilla.

I remember that Linus even commented on this:

https://lore.kernel.org/all/CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com/

But he made it clear this was *not* a requirement, so I just left the
diff algorithm to the default. Or did I miss any communication that
contributors should now use histogram diff?

Regardless, I do not mind activating it. I just did a:

  git config diff.algorithm histogram

The v6 will have histogram diffs.


Yours sincerely,
Vincent Mailhol


