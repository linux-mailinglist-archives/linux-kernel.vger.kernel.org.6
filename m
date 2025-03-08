Return-Path: <linux-kernel+bounces-552427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93030A579C7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E74D1891CF4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0790A1B0412;
	Sat,  8 Mar 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cAUOkt0X"
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1A194A6C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741430189; cv=none; b=CMvzoVr/lFudmmiTyM4+g8eKPbbHcUwckJyAfBEiJ9BDkRyT/RBhCWMLU/jda6oj2RgyijuTeghVe66/k07gKxud5d99KaVi5jDg6mUiPSpAbqyO1S/jdrUn1VtIImx3r8gNK56z40Sxp+3k89IiWh/pRIrfEsWE1sbtlVXXcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741430189; c=relaxed/simple;
	bh=T3hEc+vebrKNFXfRZHg52cFOW8PoOAYo7LOHjFa2Zz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iv/kHT0iEuEOJk7LZuZcbneJg8bWS6KIB3bPjC9hInPsg8FU56n3q0+miepN6YzwDPq3McCDj9UOEbvGsZDTzjXk8LE1rlkbLdmn2uW/R91Eb3yFHyOQaYNLxF8WRPR/5hJzFqV2iXkGwgNr2JqQhNGeO9fxE8+Vj/0NXNcTDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cAUOkt0X; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qrXKto1FVACDNqrXPtbz9o; Sat, 08 Mar 2025 11:36:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741430178;
	bh=3r6CNq7c1UF1VpR9t/DNQ2vWkrvLhXco71nuRKB37ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=cAUOkt0XhKkPVCP7sPPdl6eDa5wXICtIPMZMYju5W72dV5z2SOjwLCcfuPLWAHk9n
	 2gTYHZXd0R4sI8KMvK3SXBwfJCDIS1b1K6HKf8bMbeNqk9FmIL5tMnOi1VgF9PRT3Y
	 nCpkIQgcXFRAYCNVi89hpt91TV94UknqNVbC2yysaRIeyZYrBIwrFnoCKROpKJ1+Ux
	 A4s6V8kF4TjX7zNe/m+EmBbeqY6E1yA7+p9nFMbg5UbUznxwaH978S2CA0bk2LuW3z
	 SW1iyANPCxfEo3SlDMTXHUprAnZ7bBGfVnUTD7p1WZniJ4R7/r1qpZ9IzolDgenoHP
	 8p0zl3mLtMCvQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Mar 2025 11:36:18 +0100
X-ME-IP: 124.33.176.97
Message-ID: <b34f0fbe-43e2-41c0-b47d-4c026432272b@wanadoo.fr>
Date: Sat, 8 Mar 2025 19:36:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] drm/i915: Convert REG_GENMASK*() to fixed-width
 GENMASK_U*()
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
 <20250308-fixed-type-genmasks-v6-4-f59315e73c29@wanadoo.fr>
 <Z8syw47cN0eEW7lO@smile.fi.intel.com>
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
In-Reply-To: <Z8syw47cN0eEW7lO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2025 at 02:54, Andy Shevchenko wrote:
> On Sat, Mar 08, 2025 at 01:48:51AM +0900, Vincent Mailhol via B4 Relay wrote:
>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> Now that include/linux/bits.h implements fixed-width GENMASK_U*(), use
>> them to implement the i915/xe specific macros. Converting each driver
>> to use the generic macros are left for later, when/if other
>> driver-specific macros are also generalized.
> 
> ...
> 
>> +/*
>> + * Wrappers over the generic BIT_* and GENMASK_* implementations,
> 
> BIT_U*(), GENMASK_U*() as far as I can see.
> 
> Also "...generic fixed-width...".

Ack. I will address both in next version.


Yours sincerely,
Vincent Mailhol


