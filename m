Return-Path: <linux-kernel+bounces-362763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48C999B91B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E751C20BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779613C67C;
	Sun, 13 Oct 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="C8FgZAg3"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0C288B5;
	Sun, 13 Oct 2024 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728816399; cv=none; b=iznHBysu4HYH5KGwFOlsvDI2PvbJa8AowBfsxIwOqYcmGaq1b2RDXZBKqrWYa9AeOROPUyIPZUOcJIdj4FKd4t9yTe6KWvhKVo3U1RtOzsCiWg1I9DAN3Ne8QXl2czHXdvHk7CnaUh21RI5zzO1Lq2AjwpfuS+XG+mf+tSm5O2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728816399; c=relaxed/simple;
	bh=JO3G57aFtiKogOgwN1c2bTr04nZGHEfjrvunRtlQSSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4jiUpbafr97DJ8smmuhUvh4f7MhCMma50i1yE9Gob/caoX6BpgZdO6VPn8xzKgHAPZPBmAVO5aL4k/W7FJdR9Hnmhny6vaiDxqA98H0Uh/dtcbo3FoRrfFTXl57dw6j9S7C/U/SezXhAuQu0KrhE8CIn0P8TOxIKlcFYV5SXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=C8FgZAg3; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728816387; x=1729421187; i=wahrenst@gmx.net;
	bh=JO3G57aFtiKogOgwN1c2bTr04nZGHEfjrvunRtlQSSQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C8FgZAg3XBZ43s+YCfBUUFzJafiQq79lDGVTDeaVxiP8HJp1PzMdkKbVnh7khtyD
	 5/unSgGvWykUZIiAwocBjQW6nnYFTHQLYc0GKLRFTRHEs97NVt9yBFA2nkPdYiThr
	 b+aF9Bq81obbgbI6V2rLnEfil3sEXvvQaxXGsPaJBQ1iTP6PsOn0MmT/loGaZSspm
	 3eHt6hzXXCC69GnymkxggAAyvpISsomp0uK+TAS1Bya9Gxl5Kai+aFGUWkxAby/w5
	 nHwsp5HpcU7Zo6wtgQQCzdTHKaW0a6S21IsBU8Ov9VaREQLnRvvkl2QJR8f8qhcJD
	 13LoX6B26/gfmgmd9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1tmBBD0tea-00iY7v; Sun, 13
 Oct 2024 12:46:27 +0200
Message-ID: <543a2103-5e7f-4def-ad32-a1b5171ea5a7@gmx.net>
Date: Sun, 13 Oct 2024 12:46:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] staging: vchiq_arm: Use devm_kzalloc for mgmt
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 kernel-list@raspberrypi.com
References: <20241013084529.377488-1-umang.jain@ideasonboard.com>
 <20241013084529.377488-3-umang.jain@ideasonboard.com>
 <50425e82-2a41-4a3b-a983-2560ab0ccab2@gmx.net>
 <bc535633-8489-4eb4-99ce-f9671eb054e1@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <bc535633-8489-4eb4-99ce-f9671eb054e1@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N2wB0FV26RN2dUIq6HS4z/UsLT1++9rUHs3yY5TtTsYotLDen6L
 C6QB3/PXIwMN3c3qb6xh2Xv91gNmFd/PGTZYdu84rHATG39sUzQ3SL/SGGEZzCXXaqfhNXi
 wyH74t53rhVhhtKSR1EBrO9CLV13kBx+PRpVP7hiPUZX7aKx63/+JS/IkDu8nHlAWquLMYF
 +ukagAY+1Ollex4jzqnwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fFiIc8b3DXU=;tl/0+GUrBrGicnYxNofFVbYLg2Q
 L15iOA0VXG00A9GMzEgZdfcd/g5ezj/VurxUiUYxQnmNStXQEnITm/CMTpyf/xYqz8e420jev
 G2IdSm7kH0uGZhmFms1fWT4+ciEEm48kuqx8rBOfP6/sbIksz1qII7aUD9i7rD/qKR+Icpcxc
 /L7JdUDCH2UB+i/kZmkD+9CPI1Ek6PTH/Tq6AWeWse0GXqvn3GtRj81vLYhbOcHC9WBV7p5RI
 JdvoqmLCmdKUWfkuCaSind71azcLIHgNQtW17lsGFGZ4F1KAOeBEsXtYSqo/SsT3duR/hlLcF
 w555QxC4GI4kei1O6v2gPkFZgeQXJ2s9ce3nl2eYzNZ3nhBviUYa2KicDqDoVt+RxtUZq1B9q
 AiTngRlSp35aPBCDtDcU1M+I7IILTA3nneordPUgIbDJ3YeSFieKdwLIQbzgc1xnwJkL968gJ
 VxEzQqbSTjh96w+3agvIcJB/qraszb/0ZU43iG8LXyzOiYOgJNtSHiKilwnh3LLhQCyTJ3YmW
 GG3o4Z6BwuofQxdPXcGEHUEbKTgxXW/4k5vXRybuD+Cy+qal/rl99TX9Ba/4glaI9k2Qjhkc7
 5p4tU1WeGfKUSbr/u+TnFHx5vG83GHkcbNZyQifmobR1U3/CEImX0iDLOyNQ6HwYcjeNiXnJk
 XGgwuJiugeR9oSQycXWdW2wZclNE+hs5qZba+FGGOJWaMejplCK1JMiUOl9wjgvpREHn4lRVw
 PT+Ez3IcLWIWWqMMwdkthhukq+ZLv+lZKzyZv8acbh0+Czk7SPOOn28wvFzRp3VHRJyH27PZ+
 SdkPjDk7Ro4Qer4cBZj0LTFg==

Am 13.10.24 um 12:36 schrieb Umang Jain:
>
>
> On 13/10/24 2:43 pm, Stefan Wahren wrote:
>> Hi Umang,
>>
>> Am 13.10.24 um 10:45 schrieb Umang Jain:
>>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> except of the missing commit message, this patch looks good to me. I
>> understand the concerns about devm_kzalloc, but I think this doesn't
>> apply in this case.
>
> That's what I was wondering as well, since I tried module unloading
> and with the cdev also goes away? So shouldn't be conern, right ?
AFAIU the problem would be if you bind the resources to the cdev, but
this isn't the case here. Btw I missed to mention that this is
considered as a fix and deserves a Fixes tag.
>
>>
>> Since this should be treated as RFC, is it already tested?
>
> yes, it was tested
>>
>> Regards
>>> ---
>>> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 +---
>>> =C2=A0 1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git
>>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> index e780ed714a14..334fb7037766 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> @@ -1345,7 +1345,7 @@ static int vchiq_probe(struct platform_device
>>> *pdev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 mgmt =3D kzalloc(sizeof(*mgmt), GFP_KERNEL);
>>> +=C2=A0=C2=A0=C2=A0 mgmt =3D devm_kzalloc(&pdev->dev, sizeof(*mgmt), G=
FP_KERNEL);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!mgmt)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>>
>>> @@ -1403,8 +1403,6 @@ static void vchiq_remove(struct
>>> platform_device *pdev)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm_state =3D vchiq_platform_get_arm_st=
ate(&mgmt->state);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kthread_stop(arm_state->ka_thread);
>>> -
>>> -=C2=A0=C2=A0=C2=A0 kfree(mgmt);
>>> =C2=A0 }
>>>
>>> =C2=A0 static struct platform_driver vchiq_driver =3D {
>>
>


