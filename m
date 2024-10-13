Return-Path: <linux-kernel+bounces-362746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DCC99B8E9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CC71C20C39
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4813AD2A;
	Sun, 13 Oct 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="d+6+9evX"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD95139E;
	Sun, 13 Oct 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728810846; cv=none; b=Go280DJZEsahm6Zf8fLUtQwRRq6Y2zZdU8SU7tzLa17oAGfpCGo4cHdi19oAOv46UlX9x2U+rR2p/kpDSKVJiYOUYhMhCytczTLLuXgKSpkrjWeXXK+GHl4prZHXapwqEHVOg8FgyNYXhuHCZCD74PJL1+OGuebugsn4tFcoxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728810846; c=relaxed/simple;
	bh=1o7iMamMCrsZrEcXMcRKASpSB4EQTsxME4lcLBIFuSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+9gokwFggo8/pOF9Gy0Ug3WMi5geQ0rTfyA3/qzEs6wqP2VB9QLZS3/HMupSnwlIESi8VU3u8mikVcKYOXswDKecqCtYgT2ljrtTLiOWqpQDSBEyAazBVV6CfpvddIVNt+e246wEBA37fuNApUPMEbIrGvvb8z6RzXXnAsRug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=d+6+9evX; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728810835; x=1729415635; i=wahrenst@gmx.net;
	bh=3f5st3SI8g7riNop+IV34A1PUOHxIKWQrT/BtOSwtH8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=d+6+9evXf7Rg7xFwTEpC7i39O/UGb4rF/NFD3wDOQxFUk5+ohqfEydfluvjTVIMu
	 LK1WQ85bcGoef/OYPzko9xhfPOBcKLi4UAgJyvEMRw3pE9xWGZLOY0Wz9F4JcD1cE
	 6q4fjp16d9MVWNtm2MVm2N/YSynR2/izmnvlDF6YRCgIIZm0EA1UDQFOHIF9/zYDb
	 HBuDsBmQlkcntCk+YoVd8Wpbgxo9owSOorx/KiYwodaUzlugXzTTvguTLm6zv6trZ
	 b3vHNyk4f4blEioQbVigZfwjAKV1KErRVyXrPr0WVQdbAFCkpwdH2m/iMiuoNbvUm
	 3eGLOfw2u8ZFhRgpEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1tHa311M3s-00Llin; Sun, 13
 Oct 2024 11:13:55 +0200
Message-ID: <50425e82-2a41-4a3b-a983-2560ab0ccab2@gmx.net>
Date: Sun, 13 Oct 2024 11:13:51 +0200
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
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241013084529.377488-3-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mSxpv6OUZVJICGtqE2ZRqmKOeGyL014blcjFiWj3/0YWUEeoOdE
 +AnssgLEFaY2nB0Ul7+3v0OlrmK+S0MN0GLyl5NUbQEVbDoTjPj5ZmpeK75yjEIOZt9gSMJ
 XnOPFZ4yNeKEMi7/ycf60vxYEWnOt8mlpYPJnebsC8NFoqytPGwfFevPglTtRnWRuaXABQq
 lbB1gqpa0pIPPmSV1qpCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oLRW5sPinvw=;HuMOyxa8dwLEXLUuJaRtmfhkWP1
 hSqcTo8qtDohQyfEBQHaNA9KaJ7//gZokvPkxHR1Q14nmwB2VZt2jIQOQAhxHTc9xlMvoQxgg
 cJt2AQyG3abrwtX3O5+lmAJVXHAq1sqnLf/qRUGJYz53Hcp8elhcXrvNI1gbAjEbF2OJOwPBq
 CDCFTAHPsMye3UcjOlQCYnR1JR9GKYC3VrDnkLmxzVjZA7Kg0DJMi/96LpLRYSCvzW43O4sBc
 NCKOcZEiFAJsgkDGrCywKXtvi0+bs+UjMCK2YIunY9tc4rkMV8a8Slo20CLp2xjWOS+ZrzNpj
 FrT5jDX7OJ5tr0pEQF34rRNyzNz8t7rYLTGeEOa4PTmf6Z/RSLIG6Vm0YlOH5dQjGsxj3mPDC
 AQB0HLHXtyWbp3XkbLPrXlH+zuF3YxhIS9Bu/9vIw9IjsuGD4/th9AdpV5g/en2b1S7KgGjzs
 jZerwEoxPIIWL/EKm9lrU+Qz7rIxuGytICslWyGhVXYN9B9lJ4haslKM/8X2bO8/EKCA07JKL
 kQZSl6+cy14Aa5D64nTmt2tmkjh9XEOWgxB++0RNjkNPrddRwmw13e2a01xNAlcm/9444SyMo
 RKdlu5bLOvFwLDW6yP7AhFmEUco69RxZ4vaNkA1InDHRE94fTp8iNR0Wbw47Xtt2siZM+9ZZ5
 cX/CvgD384MWi5ofGuXFtMAds5Z7X5w2c5a8J0vACIjsufHFW+iHgHwDtgFdvKo1QGuUpDjEp
 MRBN7D9OcWK8DOFfwvwKrMxJSLpVtFoDpYoW1hhKCYQropQLqr6l1lNA8htKLzuGLXlhfpsk9
 /f2zlxfJgnzuo6usANAeEx/w==

Hi Umang,

Am 13.10.24 um 10:45 schrieb Umang Jain:
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
except of the missing commit message, this patch looks good to me. I
understand the concerns about devm_kzalloc, but I think this doesn't
apply in this case.

Since this should be treated as RFC, is it already tested?

Regards
> ---
>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index e780ed714a14..334fb7037766 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1345,7 +1345,7 @@ static int vchiq_probe(struct platform_device *pde=
v)
>   		return -ENOENT;
>   	}
>
> -	mgmt =3D kzalloc(sizeof(*mgmt), GFP_KERNEL);
> +	mgmt =3D devm_kzalloc(&pdev->dev, sizeof(*mgmt), GFP_KERNEL);
>   	if (!mgmt)
>   		return -ENOMEM;
>
> @@ -1403,8 +1403,6 @@ static void vchiq_remove(struct platform_device *p=
dev)
>
>   	arm_state =3D vchiq_platform_get_arm_state(&mgmt->state);
>   	kthread_stop(arm_state->ka_thread);
> -
> -	kfree(mgmt);
>   }
>
>   static struct platform_driver vchiq_driver =3D {


