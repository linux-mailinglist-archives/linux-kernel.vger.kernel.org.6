Return-Path: <linux-kernel+bounces-335147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A1297E1D8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20772812C6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED602C80;
	Sun, 22 Sep 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AWLyKwlc"
Received: from msa.smtpout.orange.fr (smtp-69.smtpout.orange.fr [80.12.242.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0133C8;
	Sun, 22 Sep 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727011978; cv=none; b=IXC4Mq1d1vVq4C6iWyxWGRXVRpmzMiVtnSurW4neZUAX4xkbzpe+mFQ0X2vrrKlMkBABRJTP4ZW5Fb58CRXm/1HLxLPGUzp0XQs30gsV+SrjTaGduKNwKk7cOPMggr7vfGGsXYuU6GqfTWUV2ibiSXVNllgvT0KFCQKD0hGJ8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727011978; c=relaxed/simple;
	bh=BTV39BvXRe4Q9dyZ3cZlJKkTC0yCvDORysy/TuW5/F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAD7f2oVc3HHQL1u8Ev95h7ogNlB9cqJbKEW7ht/qstqMgyH7iVJKI5sGWYmBQEAr/RuAimU1hyv4sFjVgB+Ge3yaTESRxg83mp9S+i4uhOyeJmb1mb5nXJq1SHTihUaVcewlyP+L/UAkGCEF0iJM+0rCC5NTPT0N7nKurWoqJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AWLyKwlc; arc=none smtp.client-ip=80.12.242.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id sMhhsOPMb4kQdsMhhsijmG; Sun, 22 Sep 2024 15:32:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727011966;
	bh=Hc/5GzsW1xJcs7UHU11bj3aGOVWyL/D2rlrdgJ388GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AWLyKwlc59jv1UaqhedceGg+naKRi28GSP7099eWcgOQWDHBzuIGGTd/5US/Q+Bfk
	 2iFafxavDiKYAoAEH+flZp4OEL2MMJBji7Usu2wX5iE2nLLZjniahuOfO/8j6bA2y1
	 wmchyReHFD5lG2tAaftnctzcoAH9cykMnRWchCszmCv60mCcRkpbg17efgYY4xi7Ct
	 VwoF7asjv82lZdow5/9QRrNoLedn2bHWsJOBuMlV8peUsdMhCH8p3tgjSmS3H2noWu
	 YxEf5Qywo/EpMjqQ4ogjW9B65ECuLDovssUx1AJAEhsCf/VCH10TtQO3X+VSYLd0Mh
	 o81FVaUu2CZzg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 22 Sep 2024 15:32:46 +0200
X-ME-IP: 90.11.132.44
Message-ID: <053af1f0-546e-416b-b8bc-22837e908ae0@wanadoo.fr>
Date: Sun, 22 Sep 2024 15:32:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: ts-nbus: Fix an error handling path in
 ts_nbus_probe()
To: Linus Walleij <linus.walleij@linaro.org>,
 Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
 Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Sean Young <sean@mess.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <6c887c85434edb17d2217c5198c48018dfa97923.1710606677.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6c887c85434edb17d2217c5198c48018dfa97923.1710606677.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/03/2024 à 17:31, Christophe JAILLET a écrit :
> If of_platform_populate() fails, we must shutdown the FPGA, as already done
> in the remove function.
> 
> Fixes: 5b143d2a6ede ("bus: add driver for the Technologic Systems NBUS")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> This patch is speculative and based on the output of one of my scripts that
> tries to spot calls in .remove function that are not also in the error
> handling path of the probe. I'm not familiar with the pwm_ API.
> 
> I don't think that the locking in the remove function is needed here.
> 
> Review with care.
> ---
>   drivers/bus/ts-nbus.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
> index baf22a82c47a..fa1bb9b78446 100644
> --- a/drivers/bus/ts-nbus.c
> +++ b/drivers/bus/ts-nbus.c
> @@ -309,13 +309,19 @@ static int ts_nbus_probe(struct platform_device *pdev)
>   	dev_set_drvdata(dev, ts_nbus);
>   
>   	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> -	if (ret < 0)
> -		return dev_err_probe(dev, ret,
> -				     "failed to populate platform devices on bus\n");
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret,
> +			      "failed to populate platform devices on bus\n");
> +		goto err_disable_pwm;
> +	}
>   
>   	dev_info(dev, "initialized\n");
>   
>   	return 0;
> +
> +err_disable_pwm:
> +	pwm_disable(ts_nbus->pwm);
> +	return ret;
>   }
>   
>   static void ts_nbus_remove(struct platform_device *pdev)

Hi,

Polite reminder.

I sent this patch a few months ago, but it never got any feed-back.

Adding Uwe and Sean who touched this file in the last months.

CJ

