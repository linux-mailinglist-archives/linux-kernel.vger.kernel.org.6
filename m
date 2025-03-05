Return-Path: <linux-kernel+bounces-545861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B884A4F2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A64168EAE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0D9210FB;
	Wed,  5 Mar 2025 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FHfCmAIR"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BA17579;
	Wed,  5 Mar 2025 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134572; cv=none; b=e4HcSJzdTYbq2TsrsFudIlqu/J7Laf+7vEq+bly/c6SsMWYnoYLfVRLMs2nE4yP9m9RYfH8XdV9D45HN1HPmiFeoxB0RzVSXNkcAzzN49/dxL+sKfov5AhGbmajowWQdyDxaBdjpRunGlZJv7R05AlyZqvwpXUbfvHZS+WgVSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134572; c=relaxed/simple;
	bh=ll7RRmYem5Y1GrzMRxIhpfncsuiytDg1O9oFC71uxG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jbZ1CThF0g38TeRGdKHCKEzD//tkPCjOYkRqHRbb9txtzOJB3+fCFLTxdneZG+oxKxKObHRhl2nSpi5G61++RIDuQkyW/gjEKlY1OyBUxGBuip35507YHqEobwDVmnmHfIdzHI7l6jkwtMObjiONIMB9h8PHM6NILtYnfFWkTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FHfCmAIR; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741134567; x=1741739367; i=w_armin@gmx.de;
	bh=86aR1VeqAwIPLf53I3/MJ3n0rRnYudftjP6rX3IfOZc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FHfCmAIRKOMK8yQ9FDYTOt4cENvdDr7F0AmgrtAxywDjqLoOonMgZ6nBwN1bfpDH
	 NOHdTf+5/7E3O+jZ2vFlKG9gDbIZ0AnzTzuy8lT5K7bnlOhdxIRWObSwwDC5ctGSl
	 LskIVTXYVKHEs1WeCRTdt6I8AxosN+FbDbBEJntF7QoxfXCItsBQIH6x8WSbaxKay
	 mLAr1h4qL8vAx0ogGB+efYiYH40mDWUr/zL71onTdDlF1pihsviaXl2Pcn7bCAqV6
	 LwjopJYdKee+cNbL4frSuzdcMEf8y/QokhzBevtYdmH1Q2ExPDtjS47tqVkqsJS0j
	 Z7rtaPYho3Q56n5PMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1tEACk3nYG-00qrhD; Wed, 05
 Mar 2025 01:29:27 +0100
Message-ID: <3f779992-1a3b-475b-b07b-3a4ca02f5b35@gmx.de>
Date: Wed, 5 Mar 2025 01:29:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: samsung-galaxybook: Fix block_recording
 not supported logic
To: Joshua Grisham <josh@joshuagrisham.com>, thomas@t-8ch.de,
 kuurtb@gmail.com, ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250303132433.348653-1-josh@joshuagrisham.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250303132433.348653-1-josh@joshuagrisham.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4fbc+RRPLpTjkPe2SlLqdjyFuK9KYbtHnM4aFnnHbkSROCchJdx
 1zyuZDiN2pV87sU8wsxg4Qg13eYwJdmuNWxCsK3iCckxcJ01GhuCNQkvnMQ27q6qLH7IAHA
 rLAZalJNJlKEAqyIX3hAvmsSveizDE5hGRCHuPOHB1+FUpCrgqfiXikWswld2phFpX7vs/1
 ke5kZrlhsrFwyECAZg9tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oP7IkrN8iJA=;xeGJpYCYCb0hpKT3M9R3IwXwcOA
 KaRn++YhunMpZHkLoW7+YilONW1llI2FmT/qOPq/1e8TEgib7vBxV8k8BABZ5ISda2A/fg11f
 ImBI0KJ4/lVS3Ntiul1MJUy9NlF3tOfcdI6PZZF/wKZX76RbC+ZHynv8Hfj27gBBlPnOigDOw
 SiSI9OIG9xtnaH5gpoM2HaecfKmU3qpPw6JB/zxhNXkrY0b5Jy9Yp8tXcnxOJcMEcoPF1H0bv
 ZT9OMJjFsHekqz0BMAGF9/9xGKItkCisgdZ6ljp7gMomL/8H/0ewrCsFYjndOv+dTibmjH1bD
 XA8GoPbFz8OdmBLwQzFnlhEpPEyaiwnoOnMS2+M+H8VsgKOAbyVyxFMmGSLyqmIdYrP7a1RlD
 zClJDHssz6c/Kz4eP5lJELT/qlj8/jzMDur6BF+3D2GBs7cGXhbAJaVep5gzu1Alv56Qil/Y+
 xksuKy9UtQuTPvDomziSiQu5zv3p24JMXn3tY4yxVQsk1uRIWGsQ3vzwtPVnnhdBHhBv8Kl5x
 yNcqGVnAvjqAUr/AuhDo49vTY90L5InwnrH4ceNnJn9f8pjJeG0ZYL7wzTrHiiTUJ5ZtKPj4k
 cxPjiHcoTGiJSa/DMHJa/ZmUjKz6iDH3zKieK0/NBD8WDaHNhOHUURTzg+ypz3ein7xHmgb5K
 lPwUmFE4AhtqXLB+5XXmtiXBRoPUrmF3VVsh4Gms3UC+KpkRblrqJAzQdJ6Sq49Nmnim6MoO7
 0dPLA81+ADZvSfAnPfzxxbR2TU+cJwFd8VFinNgEbxQFwvctoafjSo2aAji1JSSL5XB7Mw6wy
 CztB9W4zmAdKVobgO7zSELr8iosXNjpN8oZN2ffd3vZkJaSglSr0Ju0XSW5QEis9XIvcY6vjS
 hWn/k1tXA+5PuztJ4j5UZzXHTe1fzW1oLBTKJM7r2+tSAsdgAdGw6Gym6ShUqB2weUI8sUWyT
 P3Awv6RlSc46xGbZ9SkQKloNP0tvZdh++BFwIadjPxnLUxyrwtEnpDpOBbRopYTGPLXNtg88W
 vjT3eMLyK6oeS8+COSU7PwLLSWPcMf08PmjS9MqWzc2cvFhQdIVQIGwK1u57Hwtlb1Ld9jePO
 6TzlgQKSmOEKIAXXAm7P5qi7XGUGcrCh1Paf1pxL8uVflatGgsCa3nqwzGXSVOWWLFrPeHszy
 hTA3nckFH+yEfZ1TtY8Kzpfo/2ODkotEOCYgES0R4s/r19oOpSDOPDaT29UUPdSLELWPH0Pzo
 0JrxOKLTqrgfZynnxUluiC0+iyLi4XKsfNIGVwOuNPbmpjr3WdeGg8iFHGR3wj9yKDo9QMw36
 p5zI886GVb4YodzZMPe8xMTD5HuWUgEibY2bm+TTO9popTxiTIkLfpsCLes0unRdTqezp2X2k
 K6BlRzahtKf0KnFWyQY3gYBbmj2Ks2Cc55BHCet0pKBW8Vs1WnvcFmYz9n

Am 03.03.25 um 14:24 schrieb Joshua Grisham:

> Fixes logic error when block_recording is not supported but the fw attr =
was
> being added anyway (reported by GitHub user bbregeault).
>
> Tested myself on a Samsung Galaxy Book2 Pro (has block_recording) and by
> bbregeault on a Galaxy Book2 Business (does not have block_recording).

For the future you can use Tested-by tags to indicate who tested this patc=
h.
For now:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Fixes: 56f529ce4370 ("platform/x86: samsung-galaxybook: Add samsung-gala=
xybook driver")
>
> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
>
> ---
> v1->v2:
> - Add Fixes tag with prior commit (thanks Ilpo for catching!)
> ---
>   drivers/platform/x86/samsung-galaxybook.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platfor=
m/x86/samsung-galaxybook.c
> index de1ed2dc6..5878a3519 100644
> --- a/drivers/platform/x86/samsung-galaxybook.c
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -1100,11 +1100,13 @@ static int galaxybook_fw_attrs_init(struct samsu=
ng_galaxybook *galaxybook)
>   	}
>
>   	err =3D galaxybook_block_recording_init(galaxybook);
> -	if (!err)
> -		galaxybook->has_block_recording =3D true;
> -	else if (err !=3D GB_NOT_SUPPORTED)
> +	if (err =3D=3D GB_NOT_SUPPORTED)
> +		return 0;
> +	else if (err)
>   		return err;
>
> +	galaxybook->has_block_recording =3D true;
> +
>   	return galaxybook_fw_attr_init(galaxybook,
>   				       GB_ATTR_BLOCK_RECORDING,
>   				       &block_recording_acpi_get,

