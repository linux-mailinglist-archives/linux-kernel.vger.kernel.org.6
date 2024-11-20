Return-Path: <linux-kernel+bounces-416284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E29D42C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E171F222A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA521C3F14;
	Wed, 20 Nov 2024 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="N7gpouy+"
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051021BBBED
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132464; cv=none; b=StDhy4Uf+250/zsTlssC+puXOfw+fRD2kp/6Pa69JSTYXybvLNiTuyamhbHLqlaFUvvtf7LtdAznRtnPKbU8+CrN6m4NTXTG/UumjA9iKEmGMczzOUekYtQRjo08JRhjyFfJRgOkO9crt6hJQbLp5BlqyKnmZ6ekt4gZ4nXRSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132464; c=relaxed/simple;
	bh=Z1UST9dyZvnnefvn1fbytVF4WRanCzx88qMsSR24xVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVZSpdYTNI+Hw4Qi6RkkxaZWBuUFjRUZoqkVSyPDYWTa/jqGi4G3RQgvTUj5KQHPvkzASUj50uML93vH7cGkGSdFjRHUezuxkmeRSV/jkMho2v4KFvdVe4WPTwIYPLlhmQFfqyDSw3ODFo4ZsKf6nby1QQB5TWA2AfTSqArFJkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=N7gpouy+; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1732132458; bh=Z1UST9dyZvnnefvn1fbytVF4WRanCzx88qMsSR24xVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N7gpouy+TbAyzT7TPgO/ATDPG7Af2oNjjptwxuW1WA6DDz6ZvvaT09g1eZ03qN+b0
	 i2/vAGEr9WZHqUFKVh0htPgEyD0J4r2bsd7C1zzwsEXbFcJSbJPIM/b9Su3lfwlxI3
	 CFB+rlc773ACGkknJ2xrIfXkyEi0QbcK6ZhZVruTNwpv9y0mhpge6BheD+8UWpvf22
	 UOrcjRJk9+sjBtuGBKF15BoBx0KABN1VbnDXDQqLgHws+5AD1G+601/F3xUh+U0Lhv
	 7gHXOvlsNawRHNam39bHuM4wC4827ixMlP566Vd9kEQrcB3ctlr1jkf38D0l9UDiOw
	 2AniAQia7dbN6QmTm7cvwG9bdn1m4vmtVZQFVlBK02aw8h6C4VF3n4do2O4GtpLhe+
	 xletOQ+1cakVwDuuSO8mpwgza8pLePI8fJI0PWJSHDVGkD9gpGByByQ/8AeQbG+sAP
	 h1ThIUvQt7d7ybotDmayxDMz9OM9FA7h/hBa6dFEKTUXrwSGJlwrOVKlzzeXo6c3QU
	 RpWHCgxojZzD2QsTeW5fMo88Z0DC+K8ouOdD4jTyUTtxLCmT1JWXsZB7pn+KWII/o6
	 H9/GP4DLkWB633Zf0TOyz5Kt6Djm3ojA4oRKT0xfBcleZJBeuKMJwMwFgc288QRWOI
	 SAfveP+v5OAbPTOxR4LQELpA=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 3177C18E0BB;
	Wed, 20 Nov 2024 20:54:18 +0100 (CET)
Message-ID: <6ca90e87-965a-4895-ba72-8144540f6e4c@ijzerbout.nl>
Date: Wed, 20 Nov 2024 20:54:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging:gpib: Fix a dereference before null check issue
To: Dan Carpenter <dan.carpenter@linaro.org>, Paolo Perego <pperego@suse.de>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Dave Penkler <dpenkler@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
References: <20241120144653.377795-1-pperego@suse.de>
 <a0807e04-b2c9-4261-9b3f-7660fe258f56@stanley.mountain>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <a0807e04-b2c9-4261-9b3f-7660fe258f56@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 20-11-2024 om 18:04 schreef Dan Carpenter:
> On Wed, Nov 20, 2024 at 03:46:53PM +0100, Paolo Perego wrote:
>> This commit fixes a dereference before null check issue discovered by
>> Coverity (CID 1601566).
>>
>> The check ad line 1450 suggests that a_priv can be NULL, however it has
>> been derefenced before, in the interface_to_usbdev() call.
>>
>> Signed-off-by: Paolo Perego <pperego@suse.de>
>> ---
> You need a Fixes tag.  But I'm pretty sure the correct fix is to remove the NULL
> check.
In the whole agilent_82357a.c module there is no consistency whether
board->private_data needs to be checked for a NULL or not.

If Dan is correct then it is better to drop the NULL check, not only here
but in a few more places as well. There are at least 10 functions were
there is no NULL check for private_data.

Run this command and you'll see what I mean
git grep -3 -e '->private_data' -- drivers/staging/gpib/agilent_82357a

>
> regards,
> dan carpenter
>


