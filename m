Return-Path: <linux-kernel+bounces-211244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E71904EED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB141C214E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E8816D9B8;
	Wed, 12 Jun 2024 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="3S+1CtwM"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E922F03;
	Wed, 12 Jun 2024 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183757; cv=none; b=UF1kL3vYs9YPFSvX4VALgKmM0rOcHjf0QfsdLCpKc96eUjkQn6JYgboIQVlGvzNfT0E79bD3lbP4qaFrp6fn5z98bkW9wkT5jXe/VVXYlC6ymw493TjtsjVYoUK+t1o52zvs9tVZxyVROLO8CKselhzuNnFCGm8+4rHmbDZxh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183757; c=relaxed/simple;
	bh=GWE5vzhby5amhtINrAuKD6JzalyCfL/7n0EHOqXonuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7T0yFmH+mwLRNuD1jgJO0IJN27g05yIhdzcHbyiIp9ZMZ/W/NOwstTzZrLCnh3dbn2dmAmmShkxxHfRQOVjcv1RGph/7HNvoFpPJ9rYzzfiqb3aPQhKHvQkmMHtT4GmG9tYnOrzqWBU+4LRdd+PwYqNjc0NKyOGewnLdxldsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=3S+1CtwM; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=JRvA94wC/Ln8bnzFmy6UZICx3X6OwE+oVvnKJStYJSQ=; t=1718183754;
	x=1718615754; b=3S+1CtwMp3D8CowBNXQl6dzkZCC9J/ubK6D5vnu5sUx69+INM3+W//Hj4bNEg
	Ut2I0jjI182rYXCwVsooZmWpTTXk1p8KaCz5URc4d/wjo8dxpFMdWSjSdjQuupT5OgQ8Q8j8B/l+7
	V6wZDnIpZA3mJxjr6UsoKk7VmSCiNmxkM65z7zWv+569i1l5Vv2xzfsiBYY7doh1UZiWFfZtTymQ0
	e+2wFBdsYgPtUpoIPkkTbiDugmeuLBIMBHfivcC3i2u2qn+jh2sRQI4DRLosJsIZVegGqcB+kw4Th
	31EEWWN5jejqmhXhpnPl7kKAcmJWU1Z4Y6CwDqusOFX5qjHjlw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sHK53-00089h-Pj; Wed, 12 Jun 2024 11:15:45 +0200
Message-ID: <390652ca-a383-4953-aa39-8c4ac92f2e3d@leemhuis.info>
Date: Wed, 12 Jun 2024 11:15:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] checkpatch: check for missing Fixes tags
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
 Sasha Levin <sashal@kernel.org>, Tom Gall <tom.gall@linaro.org>,
 kernel-janitors@vger.kernel.org
References: <ZmhUgZBKeF_8ixA6@moroto>
 <20240611113855.b63a6015b26a0dad49d9f2a7@linux-foundation.org>
 <b3baa059-b433-42da-96c0-588312b5a4ac@leemhuis.info>
 <6825db9f-be27-4096-9723-6ad65342a59e@moroto.mountain>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <6825db9f-be27-4096-9723-6ad65342a59e@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1718183754;a4595a40;
X-HE-SMSGID: 1sHK53-00089h-Pj

On 12.06.24 10:49, Dan Carpenter wrote:
> On Wed, Jun 12, 2024 at 08:46:24AM +0200, Thorsten Leemhuis wrote:
>> On 11.06.24 20:38, Andrew Morton wrote:
>>> On Tue, 11 Jun 2024 16:43:29 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>>
>>>> This check looks for common words that probably indicate a patch
>>>> is a fix.  For now the regex is:
>>>>
>>>> 	(?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller)/)
>>>>
>>>> Why are stable patches encouraged to have a fixes tag?  Some people mark
>>>> their stable patches as "# 5.10" etc.  This is useful but a Fixes tag is
>>>> still a good idea.
>>>
>>> I'd say that "# 5.10" is lame
>>
>> Documentation/process/stable-kernel-rules.rst documents this use to
>> "Point out kernel version prerequisites".
> 
> No, the 5.10 means that the fix is required for everything after 5.10.
> Here is how you reference pre-requisites.
> 
>     Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
>     Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
>     Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic

That format according to the docs is to "Specify any additional patch
prerequisites for cherry picking", but cherry picking might not be what
the maintainer wants.

Anyway, I won't commit on this further and from here will leave this to
Greg, that's best at this point, it's his domain.

> But as a distro maintainer it's much nicer to have a Fixes:
> 123412341234 ("Add new wifi driver").

I see your point and agree that it would be nice to have. At the same
time I've seen people on the lists that don't like to use the Fixes: tag
when nothing is "fixed". And it would be an additional burden for
developers to look the commit-id up. So it could contribute to the
"checkpatch is asking too much here and not worth the trouble" stance
I've seen a few times (to which I contributed myself... :-/ ).

Ciao, Thorsten

