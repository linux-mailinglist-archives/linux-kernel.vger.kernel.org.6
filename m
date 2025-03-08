Return-Path: <linux-kernel+bounces-552382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FCBA57962
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1283B3976
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725621AB528;
	Sat,  8 Mar 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SQWCd5DA"
Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450C199FDE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741425048; cv=none; b=dnXlCjjWiup3QvQ/ICWM9SdF+IMkJ0Rjhz2j2zcdopCVTwIZP5KNjqbGt3KTv2Y6BDW/KTwCFjYtd/5eqLV3lb6TfKSh4zglcacD5NsTFhnjn8H8CRQ/kVJzKHXt2R6JFnHEZMPKLjwz0xlmNF+yhGcME1GNfgqVN+Yr69CS7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741425048; c=relaxed/simple;
	bh=Uu4cQsge2YxpGX/V4rOIRLSS3NPeyDSm+oHLiLACNpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utBtdhGHAnVVHUrc6be3y5L+uNj8odpLR9WwMNVyLJF/9PAvFPKwnazYvo72J1rzHaHjFDXhIV34YGr9TGQTgn0UpFXMCwzRtrN8z2+BuQHT1Sd1B4R3bxC4RFx9p5gNgJnVDUaieKcdX+NpqQmpZInsskv8OXPGlG8hgJi/ydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SQWCd5DA; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qqCQtqwNeYqvfqqCUtBgr2; Sat, 08 Mar 2025 10:10:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741425037;
	bh=sDmVVrbuw2qJC5u1bi0SxxAKyqryPSSZxqocdiLHLHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=SQWCd5DAbRFHl0B03KVDVCbGcjTvXX2EKNDLVk7U8bJ3Dgqd6ha2lshZT8XsYDJfi
	 pj0nZjBK51PGcwMOUvqU4ho8Y1hchT+dvynfvpW0xDgoZNP4xpBnkVPFvfFoR/YPjE
	 igtkGwSk4xSkdZZzDfl0OW6TrRDcd90r8Hir2zw4GROUBOhCpyMeeXKhieUwTtDqNO
	 C9+R/3s4Zg827Q+QBSTK2ef7gWP3ejbKXcf3gDv8WNBNFa6bf4UDYpkb8FMKwXQV0N
	 I85yTH9vxiYYrSdvqjyVoD9dBByZnPqOjZF6XMi7qvmUGbAMexOBUb6tRMhTdujxRC
	 N75A35LEB79kA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Mar 2025 10:10:37 +0100
X-ME-IP: 124.33.176.97
Message-ID: <85639227-68ed-4a8a-8084-1ae0ffcaa638@wanadoo.fr>
Date: Sat, 8 Mar 2025 18:10:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] bits: split the definition of the asm and non-asm
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
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <20250308-fixed-type-genmasks-v6-1-f59315e73c29@wanadoo.fr>
 <Z8swIt7fqpVAp2P8@smile.fi.intel.com>
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
In-Reply-To: <Z8swIt7fqpVAp2P8@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2025 at 02:42, Andy Shevchenko wrote:
> On Sat, Mar 08, 2025 at 01:48:48AM +0900, Vincent Mailhol via B4 Relay wrote:
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
>> +/*
>> + * BUILD_BUG_ON_ZERO() is not available in h files included from asm files, so
>> + * no input checks in assembly.
>> + */
> 
> In case of a new version I would reformat this as
> 
> /*
>  * BUILD_BUG_ON_ZERO() is not available in h files included from asm files,
>  * so no input checks in assembly.
>  */
> 
> It makes easier to review the changes and see that the first line is kept
> the same.

Not fully convinced, but why not. I staged this change locally, it will
be in v7.


Yours sincerely,
Vincent Mailhol


