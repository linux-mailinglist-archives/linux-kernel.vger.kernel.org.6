Return-Path: <linux-kernel+bounces-550834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5148A564B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC4B3A76EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C7B20DD79;
	Fri,  7 Mar 2025 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jj7l/xSy"
Received: from out.smtpout.orange.fr (out-11.smtpout.orange.fr [193.252.22.11])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D020C481
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342325; cv=none; b=C7tlfixPvfa4F8CBIdPEwND+MzvvkdHgJZCBdH1XR3i+6MNuU0mINlji3C65+Xg78o5WZURvaF+N+mlXe0gqLJvJ8cLHcr8IffIbD0zCCNufQosQcNoVaEy0nUO2uXcA1JNKuoXTWvYWpqWmw/GKunoQg9YD0EUpn9vY8uXB9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342325; c=relaxed/simple;
	bh=9KTiwlamWgrnz754D6QMpyTlVZ+npgEDiQrm5M+j+jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3oDYQCkcVPKLasRsi+yrzHjbFepqDEJwh3pQSzZV7uwq6aJuKSVfiIlfZWGMnJfBxjIQm+WWAuyzM+2W2Rt28K7uWyTqx12do9yD1pqWBQAhdqXWvKhQhP/S5jsUmvd6GBFGE6SiHvxRy0usdMajH0XefiqWeHk5PuAG8hBZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jj7l/xSy; arc=none smtp.client-ip=193.252.22.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qUg1tfGVlO34bqUg5t6MfF; Fri, 07 Mar 2025 11:11:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741342305;
	bh=rxZFizxQTBf57y6b0wCquCkeYusfLguu3ogCv2zWKsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jj7l/xSyo97Ssu9r2QJlDbaqbyLHkqd/3QAVQh6ZefmhIl7zELC8scJwkVdToCRO4
	 Rf/5kwAwqAlxlMXxiz8x22GyZljZWIGiQWSyFah2YGdHDfTCicGKRDzCCTFJhGmhgR
	 sgksIUCET9ynUU4EXxt2Isstw/rKj+73nCf06orE1FHTVVhFBxiT2wINbBr1rsvmqY
	 bqMdVKwzgpixlO61UWINpm5Mp7/GAwTQlg3Id1YeCmx2kOpmd5TNuoAK1DD5jYosmO
	 faOAemypUs4zm0vt3rAo2x/Bt6fhdWIPU3BTvCK3KOBXb+cjbBBoSAyQ4Ap/HQ5xMM
	 q0WmYATRxQVMg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 Mar 2025 11:11:45 +0100
X-ME-IP: 124.33.176.97
Message-ID: <df371256-d981-433b-bcba-00a445e04c41@wanadoo.fr>
Date: Fri, 7 Mar 2025 19:11:42 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] test_bits: add tests for BIT_U*()
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
 <20250306-fixed-type-genmasks-v5-7-b443e9dcba63@wanadoo.fr>
 <Z8mfAQGUvm3z86kE@smile.fi.intel.com>
 <722e147b-fdd1-4098-8d60-48c83e36a7f7@wanadoo.fr>
 <Z8nhdz5FZIHYb4Yi@smile.fi.intel.com>
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
In-Reply-To: <Z8nhdz5FZIHYb4Yi@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/03/2025 at 02:55, Andy Shevchenko wrote:
> On Fri, Mar 07, 2025 at 01:08:15AM +0900, Vincent Mailhol wrote:
>> On 06/03/2025 at 22:11, Andy Shevchenko wrote:
>>> On Thu, Mar 06, 2025 at 08:29:58PM +0900, Vincent Mailhol via B4 Relay wrote:
>>>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>>
>>>> Add some additional tests in lib/test_bits.c to cover the expected
>>>> results of the fixed type BIT_U*() macros.
>>>
>>> Still would be good to have a small assembly test case for GENMASK*() as they
>>> went split and it will be a good regression test in case somebody decides to
>>> unify both without much thinking..
>>
>> Let me confirm that I correctly understood your ask. Would something
>> like this meet your expectations?
> 
> I believe it should be written in asm.

I am not confident enough in my assembly skills to submit asm patches to
the kernel. So, I would rather take a pass on that one.

Regardless, if somebody decides to unify both without much thinking as
you said, I am fully confident that the patch will get Nack-ed right
away. So, I do not have any concerns.


Yours sincerely,
Vincent Mailhol


