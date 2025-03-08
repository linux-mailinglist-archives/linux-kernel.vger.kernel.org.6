Return-Path: <linux-kernel+bounces-552428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA211A579CA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B983B3CBD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0531B043E;
	Sat,  8 Mar 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="H6SJPHuD"
Received: from out.smtpout.orange.fr (out-14.smtpout.orange.fr [193.252.22.14])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD12DDC5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741430422; cv=none; b=m8/5O/vsfkXR0wpk1DiLPeRNpcr0+IrY1CoSyLU4NNyujQZrQdoTvcOEYTuVTHgzTgKU2Xg3tO4ikn6pvOqzmX1EIPFgkEqTlV8auiBgLqKqsUB9tyt780zNeHEt1NvMtHok/kuPHpdrtYOApgq4eFV9Tlde8p/EsJXxq9DNf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741430422; c=relaxed/simple;
	bh=IksHSKTCTNLKygyUnDdNxGyDtq0DVMU3N+aq5BMFEFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmsGJzXoE/4KzKnnw9rSycZsWL9sVUXzqQl6C+TJENEzB0wqE4po4FPSTYkEjDspFsVwy3LqB9/nknzTK6JgxKA+8zYzZbLS1t3hB/R8oKozO4XWPzE9pHgFwXD1T03dDHw4JWgZopEogXCUbJsiqAYfxHOu1QkAj0CxSHUPg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=H6SJPHuD; arc=none smtp.client-ip=193.252.22.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qrb7twWi1ALzcqrbBtNgXo; Sat, 08 Mar 2025 11:40:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741430412;
	bh=/j8zMOSOfHLTeXM/zRrMNeAIVt8zB+gxs/PMQCLhw4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=H6SJPHuDoGPq2dPUXUS3W2Dq6vuvk2E8b4mngN2NeTNXKy7+gf0Hv/hgjW+mFrTcb
	 j3oea+6qJ3z2ra22KrIwsubNdo2RsuHjk1SoU/cOc31v7ku+pp72WJLv/4w5bCpHou
	 AnW+xmu1b7IPvDR+U7uR4/hcoD7r6kg0o/v3diXq7yh9U8QEPOUyuL9Swx1ZZXw41d
	 Y2zwIWX5skkrGProIw+pNrURBRXjX1DnjqMgppca6Y/W4RwRuDhW5lczwNJpdmEcb3
	 65yNdu2l4OQ8V0DwRTUtl6qtuEW/tpAsE+L/BmS9Gl+KVQYf9KcWu6Sr2rQ7RAIxC9
	 w7DE2e1/z/9xA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Mar 2025 11:40:12 +0100
X-ME-IP: 124.33.176.97
Message-ID: <1258559e-e23d-42db-910c-f5d84dda8218@wanadoo.fr>
Date: Sat, 8 Mar 2025 19:40:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] bits: Fixed-type GENMASK_U*() and BIT_U*()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Yury Norov <yury.norov@gmail.com>
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
 Jani Nikula <jani.nikula@intel.com>
References: <20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr>
 <Z8sqSpKZzfolKm8Q@thinkpad> <Z8swXUGf9rtTHw1o@smile.fi.intel.com>
 <Z8sxdOjk3LksG9ky@thinkpad> <Z8sx__SHALZI1NCx@smile.fi.intel.com>
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
In-Reply-To: <Z8sx__SHALZI1NCx@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2025 at 02:50, Andy Shevchenko wrote:
> On Fri, Mar 07, 2025 at 12:48:36PM -0500, Yury Norov wrote:
>> On Fri, Mar 07, 2025 at 07:43:57PM +0200, Andy Shevchenko wrote:
>>> On Fri, Mar 07, 2025 at 12:18:02PM -0500, Yury Norov wrote:
>>>> No rush, please allow your reviewers a week or two before submitting
>>>> a new iteration unless you want to disregard the previous version for
>>>> some reason, of course. This will not get into the upcoming merge
>>>> window, anyways.

Ack. I was not expecting this to go into the next merge windows either.

Most of the feedback was not on the actual code but just on the naming,
the code comments or the patch descriptions. I normally wait longer on
the first version of a series but I tend to do kick re-spin when
addressing the nitpicks.

But message taken! I will wait a couple of weeks before the next iteration.

>>>> So, what should I do? Go through the v5 and all discussions in there,
>>>> or just jump on this?

The code is the same between v5 and v6.

There is this message from David in which he suggested to make some
changes to the uapi __GENMASK() and __GENMASK_ULL() and to which I
commented that I was not confident doing such changes:

  https://lore.kernel.org/all/20250306192331.2701a029@pumpkin/t/#u

Aside from the above, you wouldn't miss much by directly jumping on this v6.

>>> There is also question to you. Are we going to leave with U128 variants or is
>>> it subject to remove? If the latter, can you issue a formal patch?
>>
>> I asked Anshuman about it as he's the only person interested in it. Will wait
>> for a _usual_ few weeks for reply before making any conclusions. If you know
>> anyone relevant in ARM or everywhere else, feel free to loop them.
> 
> I see, yep, we still have time for that, let's wait a bit.

Ack. Andy, I already addressed your last comments in my local tree. I
will now wait for others' feedback.


Yours sincerely,
Vincent Mailhol


