Return-Path: <linux-kernel+bounces-558808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8999CA5EB7E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01ED23B81FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995231FAC4F;
	Thu, 13 Mar 2025 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gbD6LNT6"
Received: from out.smtpout.orange.fr (out-17.smtpout.orange.fr [193.252.22.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B978F4A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846005; cv=none; b=rvQ8bm9gL7pQqfKLeUX90wvOAWJxsAa2j/57p8StX2xu2ipcpi1QX5U3+WZZ9EfZ8T8mlZXF9cNhg91KCl+pg2BjENK/Jg15iZ/Zo6lxdMabCMQon0naBcyaQlaodg7XJodJ+kqEPsvotuW9eaxwcCVYzldD3do3J7UOTTa/NJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846005; c=relaxed/simple;
	bh=6pGkTxf2Rt46dPmTVpKmVjib8aRhzy8GiiNiPmv7fRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrnMz/7CvG/6YmA/IrcWJehZ2zuvoLSlskGMV52Jp1goKFLzu2679EU8AwEJynjfntoEfJz38XsKF3UqC3qPxuis3ddqbcBUPximhsgTpLk/qQlyI+R2X+V5lfbN1/4mGkvvezItH1fDcs3KhLSM4YlRRq/Vnvjq1ve/a+KEUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gbD6LNT6; arc=none smtp.client-ip=193.252.22.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id sbi2tLA2w0ADxsbi7tMG0F; Thu, 13 Mar 2025 07:06:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741845994;
	bh=2oniw6k2sn98vbQt2aw5i7vqcVTdpGoRjopQlxSX4SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=gbD6LNT6mkFqfrcvs8R9s26SScVFc9LjdXARA7aRpAGhGOGDFXV17XZT5C6Rid6Qm
	 rThptj9ItZvc3WO6JkOq7crmLRSfN/9eJ1sklke+zbMBqwoAsaYtvaQH+K5FIrwSQ5
	 cUnlmmsC3dxDk5xgK2yKfIbV0j545/aS0G7wtVj5HhDXpHyG+hXWhpcu1uEQAa7GJ/
	 XtGAeJiW2ybUsDuIXvWpAD6IK7+E5nBBkJYcfbE7DWQh8lDw16FhYzAgA2C6peWYTO
	 ko7Ww4vAhMdroP8tMEgDzg2RdGh/KnML65BsnCJC5Rl86y98zOXTl7B1UVPoN1AcHN
	 EE3EkSxMXl9vA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 13 Mar 2025 07:06:34 +0100
X-ME-IP: 124.33.176.97
Message-ID: <881f6c55-da87-44db-b1fa-ff38a19f0914@wanadoo.fr>
Date: Thu, 13 Mar 2025 15:06:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] bits: split the definition of the asm and non-asm
 GENMASK()
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>,
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
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
 <fao7tp2y66f7nuep4nl6kz5zenfpzswp3hwqiw325uitgu6u6u@7dipwr3vjui7>
 <f15eac8c-567c-4ae5-bf9b-bb3964c83846@wanadoo.fr>
 <72jcyshw2tp7tu3toxpjmm6rc673o6ai3tlryp6vkayheoe4ow@k25nln2qajh3>
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
In-Reply-To: <72jcyshw2tp7tu3toxpjmm6rc673o6ai3tlryp6vkayheoe4ow@k25nln2qajh3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/03/2025 at 13:16, Lucas De Marchi wrote:
> On Fri, Mar 07, 2025 at 02:10:28AM +0900, Vincent Mailhol wrote:
>> On 06/03/2025 at 23:34, Lucas De Marchi wrote:
>>> On Thu, Mar 06, 2025 at 08:29:52PM +0900, Vincent Mailhol via B4 Relay
>>> wrote:
>>
>> (...)
>>
>>> it seems we now have 1 inconsistency that we comment why
>>> GENMASK_U128() is not available in asm, but we don't comment why
>>> GENMASK_INPUT_CHECK() is not available there. Maybe move this comment on
>>> top of GENMASK_INPUT_CHECK().
>>
>> I will restore the comment in v6 and put it next to the asm definition,
>> c.f. my reply to Andy.
>>
>>> Anyway,
>>>
>>>     Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> Is this only valid for the first patch or for the full series? If this
>> is for the full series, would you mind replying to the cover letter with
>> your review tag?
> 
> only for this patch. I'm the author of some of the patches and also add
> my s-o-b in others. I'm not sure what b4 is going to do with those - it
> would be weird if it added a r-b on my own patch.

Because I added some modification since, I think it wouldn't be so
problematic. But it also makes sense to just add your review on the new
patches. So let do as you suggested.

> Now I added r-b in some and comments in another.

Thanks! I applied the tags locally and answered your comment.


Yours sincerely,
Vincent Mailhol


