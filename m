Return-Path: <linux-kernel+bounces-174246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556D8C0C12
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5BE282A0A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283551494D9;
	Thu,  9 May 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="eE3M+19/"
Received: from smtpcmd04132.aruba.it (smtpcmd04132.aruba.it [62.149.158.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53C624
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240701; cv=none; b=I23GTZRO0CrPYBYRd7RiscG4QyP3xSxVucny1HuHXvPqGypUuNMT3W4WAqSIABO8+20+neK36M8jxY24Uv1b/ZY8a1IPo76DpZqsny2mYkkiBHEBGqrU8TYfbUUuDiNV0VVl4hTiV6wNQaKorEeopU2jM2CHEAt+W04rKkAynZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240701; c=relaxed/simple;
	bh=ThdJPds+LGQXbpgqD3ptkuRAzIs3behnp7rruMXvtaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7T5sQIYFTqcjWDbG1YLHM0WTa4EsoMQF99Y4Q/nmVelmvDEKqjpdloKcNpYNMgBjWeLnWG8ToP7V5vyWIjlX5tGbKBpf1XtLAg3Z2gIhsTuKzSc7ggAcCuCGiR5JdeIgXDLP/kPIphNZhD3EiJDFKDVZgavZtWzwh1yetbeUvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=eE3M+19/; arc=none smtp.client-ip=62.149.158.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.59] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 4yPTs3d6JF8HI4yPTs9FrL; Thu, 09 May 2024 09:41:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1715240507; bh=ThdJPds+LGQXbpgqD3ptkuRAzIs3behnp7rruMXvtaY=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=eE3M+19/MwvIfRLw8ifNyYfLh0dTkxp0706Ni9gKt+SpFxZVDxsbP3lXsq9WGt/BJ
	 g4UfW4nY477LorhI9Ts7QahrAxO0XxqAkTTEoBnHViK1YP7qLgOfP+tVLA63DhgQRf
	 sHaShD1NK6TmszN+e+KBvXs02NkBGdB6QC3ZKkXbpjEGQDLRLdSqesyFEJ1vGFTgVu
	 FwX+M7/+zAp+SEQHuiPWmhfst/1j39+n8/SmTbgMgiS/j391Kkg20eFUh1uRBwz7t2
	 Fs8ZLxO2EUoo/x2qGE3X+iwZ47VnmUNBfHXeMSS4I/vUaV9j7I47MjatRXs/wOmrbq
	 1/b4/j99XM7Tg==
Message-ID: <bd4799ab-9456-421a-8294-de6481543ad1@enneenne.com>
Date: Thu, 9 May 2024 09:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: clients: gpio: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <f4b9402af72e5f285c8b0f068076a76418f653f5.1709886922.git.u.kleine-koenig@pengutronix.de>
 <6d73b0a4-34e6-44ce-8757-4f4931c3da85@enneenne.com>
 <4iii7uxyfovs6ntm7hs2w546k3upbhkepgzxarjk4wnlqmeern@sh6gkyuiqpjs>
 <v7sefhmq42ro2dfpxgipxxajxpuh3xy46c77uibmypyp34duqs@5vw5ava4ns7d>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <v7sefhmq42ro2dfpxgipxxajxpuh3xy46c77uibmypyp34duqs@5vw5ava4ns7d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFjOI/fdUmqGp2cAhacTpHu609kgQxiNzVpfZWqAH4XJ/MMIhvXD3+YHLx+DGn4zSE9nMrNvwkIy22WcwC7puXayUOSq0mOc8+tpb5fu0V3XnpyiNT0F
 wWF4riGXs9D+f2kifMQcOq2CIA699qlXT6a+fAkkh/Q5aUEzsPyJctkwrf2pQrzMFoOX0uvEUtvLpg4BiPbLG3gMxXnSku+wWIELxhBvQiMf9cuBNXa547cD
 UqMXZ97b3bTGN9XO6UdroVyoEHGmsT+VrJ2ido279Rc=

On 08/05/24 15:57, Uwe Kleine-König wrote:
> On Fri, Apr 12, 2024 at 02:26:48PM +0200, Uwe Kleine-König wrote:
>> [Cc: += linuxpps@ml.enneenne.com]
>>
>> On Fri, Mar 08, 2024 at 09:57:29AM +0100, Rodolfo Giometti wrote:
>>> On 08/03/24 09:51, Uwe Kleine-König wrote:
>>>> The .remove() callback for a platform driver returns an int which makes
>>>> many driver authors wrongly assume it's possible to do error handling by
>>>> returning an error code. However the value returned is ignored (apart
>>>> from emitting a warning) and this typically results in resource leaks.
>>>>
>>>> To improve here there is a quest to make the remove callback return
>>>> void. In the first step of this quest all drivers are converted to
>>>> .remove_new(), which already returns void. Eventually after all drivers
>>>> are converted, .remove_new() will be renamed to .remove().
>>>>
>>>> Trivially convert this driver from always returning zero in the remove
>>>> callback to the void returning variant.
>>>>
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>
>>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>>
>> The MAINTAINERS entry for drivers/pps lists you as single maintainer.
>> Who is expected to pick up this patch given that you "only" send an ack
>> but didn't pick up the patch? (Or only picked it up in a tree not
>> included in next.)
> 
> In the meantime you sent an Ack to my patch. Does that mean I can/should
> include this patch in the series changing struct platform_driver that I
> intend to send to Greg after the upcoming merge window closes?

Yes.

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


