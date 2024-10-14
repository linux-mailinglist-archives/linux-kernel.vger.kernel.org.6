Return-Path: <linux-kernel+bounces-364469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31C99D505
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407B01C20CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF5B1B85D4;
	Mon, 14 Oct 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ll45HdTj"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD0219FC;
	Mon, 14 Oct 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924848; cv=none; b=VX23u1F5fjwL7sOR/wkfAgoH0Y1y8Oy5WEAJRm5j1F92u2mbdLiIjFHWsswn/iPqvxx2bSYozikylaDVOAExJk4Zzdcv3d/j3cEEBxjD7PiNamObxYNsb94xdu/3DAzF3ZG0HRXM/JxtdJbSkfzvVNrLB/lwr75Mqgz378aaALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924848; c=relaxed/simple;
	bh=GntukN9gDRPXTmeisyP74y7z6LltSrTz9S/wFMtlwio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjVbT5vgqXVESKDlT9EpON9eVomiw+OP6FERMKtnTsXCiqckH1X1hUSBDXiML+Zk714IquShxT3Q2HEEHWqAo3Lur2Mr/jxaHk4Zv1TdkYwUeHplk1/r4iJBYZpRqgfMPAz3Z/LMCVyc+jvtK85k089ZNc+S3CRnGw8Mqv8WOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ll45HdTj; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 0OKTtumRlRLhW0OKTtCfyc; Mon, 14 Oct 2024 18:53:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728924838;
	bh=MydJomuv8sawsgTL1H5vUNKrxRzEp6ayRw6BKpwqesU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Ll45HdTjdazn0SaQ7Jrwbynx8z7LxGGku73zp3xfrLj6HzQhH3RvPAE+f/rulwEUh
	 cvl7VEepgwkXaNY0QmeoAAtp1MYBdUs3/zgdyhM7zYOsvfzauyDOF33gATFJcIakVH
	 5QfwmL3br1NplNdo6V8gW+pj4KdAzUFgZ2pB3ymRSEIKrUsKqB0NwuQiHtIR7/Uvlf
	 WJt2HlWpn63Rr1nLIvyMo80LSrel/JVsb9DQp0BPCX7h0G8fk7RMA8WsWi4yRyVK25
	 D9/2qYNhucQA3BEpV/pHVCW99/VTKpHGX1VituO07JaEHMgYe8nIlFxztNsURGEvfE
	 5g1a0zFAJlPWw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 14 Oct 2024 18:53:58 +0200
X-ME-IP: 90.11.132.44
Message-ID: <1c421f69-7bad-4251-94dd-2ebde618be3c@wanadoo.fr>
Date: Mon, 14 Oct 2024 18:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rpmb: Remove usage of the deprecated ida_simple_xx()
 API
To: Jens Wiklander <jens.wiklander@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <df8bfbe2a603c596566a4f967e37d10d208bbc3f.1728507153.git.christophe.jaillet@wanadoo.fr>
 <CAHUa44GU=SR9MgBaXJi1yEbvg5Bb73FV4n8erGhN4s_qioKNCw@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAHUa44GU=SR9MgBaXJi1yEbvg5Bb73FV4n8erGhN4s_qioKNCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/10/2024 à 12:38, Jens Wiklander a écrit :
> On Wed, Oct 9, 2024 at 10:53 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> ida_alloc() and ida_free() should be preferred to the deprecated
>> ida_simple_get() and ida_simple_remove().
>>
>> This is less verbose.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> The ida_simple_get()/ida_simple_remove() API was close to be removed (see
>> [1]). A usage has been re-introduced with this new driver :(
>>
>> [1]: https://lore.kernel.org/all/cover.1722853349.git.christophe.jaillet@wanadoo.fr/
> 
> I'm picking up this for v6.13. I guess your patch set now depends on
> this patch. I can ack the patch instead and let you include it in your
> patch set if it's more convenient. Please let me know what you prefer
> to avoid potential conflicts.

Greg has already picked both patches in char-misc-testing. [1], [2].

Let it flow from his trees.

I'll wait the next cycle to resend my serie [3] or char-misc could take 
it as well. Both solution are fine with me.


Greg, if you prefer the later, I can resend the serie if more convenient 
to you.

CJ


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-testing&id=dfc881abca4247dcf453ce206f05fe09b51be158

[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-testing&id=3b0889f95789aa90b0f1a6921d5d6b151f2e53ae

[3]: 
https://lore.kernel.org/all/cover.1722853349.git.christophe.jaillet@wanadoo.fr/

> 
> Thanks,
> Jens
> 
>> ---
>>   drivers/misc/rpmb-core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
>> index bc68cde1a8bf..ad1b5c1a37fa 100644
>> --- a/drivers/misc/rpmb-core.c
>> +++ b/drivers/misc/rpmb-core.c
>> @@ -64,7 +64,7 @@ static void rpmb_dev_release(struct device *dev)
>>          struct rpmb_dev *rdev = to_rpmb_dev(dev);
>>
>>          mutex_lock(&rpmb_mutex);
>> -       ida_simple_remove(&rpmb_ida, rdev->id);
>> +       ida_free(&rpmb_ida, rdev->id);
>>          mutex_unlock(&rpmb_mutex);
>>          kfree(rdev->descr.dev_id);
>>          kfree(rdev);
>> @@ -176,7 +176,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
>>          }
>>
>>          mutex_lock(&rpmb_mutex);
>> -       ret = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
>> +       ret = ida_alloc(&rpmb_ida, GFP_KERNEL);
>>          mutex_unlock(&rpmb_mutex);
>>          if (ret < 0)
>>                  goto err_free_dev_id;
>> --
>> 2.46.2
>>
> 
> 


