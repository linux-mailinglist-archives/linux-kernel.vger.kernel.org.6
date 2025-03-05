Return-Path: <linux-kernel+bounces-547209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39BA50432
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9C53A71DF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94068250BE7;
	Wed,  5 Mar 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="N4mfkdbA"
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93024A06B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191004; cv=none; b=Wh86NZzDyYYeJvitLGv5QeetyXwoO0wiNbE5/4q0gNAJKrY/uTXnoRYomH8ewDMYY2Y7mNKRnYhB2308czywKc7hadNBX1mdqQSedQixlaO+j5Bu2YRNaQumc0Geh1kSzhdNhb+1jsurMnT15nteVQBAYjxWBupXeRP0bPRs/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191004; c=relaxed/simple;
	bh=/XdLhst/UlGkGuvJVNVFYn2gImvo8zDlbOMaI1uafMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZ49dc/xcOOnwtyaOdUcj17he6XHptPuTWjz4d46BiV76+XmDPVe5PAvQgpQAqrt3tu2K+Bw1p9/fzKCxLzm9YyL/CQ12SJZxmJJTnQDlvEPnw18Wt+6yl7igNesAIxy6t0VbDsP1F2PEHrjRTw5jX8VdB3KOdsZnYkFEzpYdDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=N4mfkdbA; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id prJbtTSCG63luprJgtW8On; Wed, 05 Mar 2025 17:09:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741190998;
	bh=LTODso3brupSi75LN9uPUwVb2HT7RIhBdq3edv94tdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=N4mfkdbAtJy+mCNmLhDTAuUHv+MDNbHXuyqOBrVje9lFDIziAi9MrRApsAtV+dvKD
	 ZKQY4dH0JyH/yPrz2GTdgZFNdzIkC3bgguZofcw8lmWrt92kS0L2vSMh4g3MIK60na
	 FTuFiFzl05NTipThGQFMte6V8ABRFrNafM73qfF8vpQr/F7oObAcUDxGfubyiEoZdF
	 He7IkhSmMVC19kKy5Ztg8xbxG3HmUjgkt1JQZbeGwujPNXmmHN0ozBf0G3brSfN4Eb
	 0PGT6grJ5i+RZufkP7B64mLothI4/wo5IzomQkAWUq+pOfoExhgb/RH6n9EhLQu3Yr
	 cxM4Y9+7caunw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 05 Mar 2025 17:09:58 +0100
X-ME-IP: 124.33.176.97
Message-ID: <a4195c42-7912-40c6-8b46-a718843c4a1d@wanadoo.fr>
Date: Thu, 6 Mar 2025 01:09:46 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] bits: fix typo 'unsigned __init128' -> 'unsigned
 __int128'
To: Yury Norov <yury.norov@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-1-1873dcdf6723@wanadoo.fr>
 <Z8hf_MNL3MeoXW5O@thinkpad> <Z8hhXHporoJ6Y39X@smile.fi.intel.com>
 <Z8hh6BZgD3lmyBKp@thinkpad>
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
In-Reply-To: <Z8hh6BZgD3lmyBKp@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2025 at 23:38, Yury Norov wrote:
> On Wed, Mar 05, 2025 at 04:36:12PM +0200, Andy Shevchenko wrote:
>> On Wed, Mar 05, 2025 at 09:30:20AM -0500, Yury Norov wrote:
>>> On Wed, Mar 05, 2025 at 10:00:13PM +0900, Vincent Mailhol via B4 Relay wrote:
>>>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>>
>>>> "int" was misspelled as "init" in GENMASK_U128() comments. Fix the typo.
>>>
>>> Thanks for respinning the series. I'll take this fix in bitmap-for-next, so
>>> if you need v2, you'll not have to bear this thing too.
>>
>> Before doing that, please read my comment first.
> 
> Already did. Yes, you're right.
> 
> Vincent, can you send the fix separately, so I'll move it in the
> upcoming merge window?

Here it is:
https://lore.kernel.org/all/20250305-fix_init128_typo-v1-1-cbe5b8e54e7d@wanadoo.fr/

As requested, I will exclude this from the v5.


Yours sincerely,
Vincent Mailhol


