Return-Path: <linux-kernel+bounces-319205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A312D96F943
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88F71C21D70
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F81D3649;
	Fri,  6 Sep 2024 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AgHDkBtA"
Received: from msa.smtpout.orange.fr (smtp-68.smtpout.orange.fr [80.12.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C82374F1;
	Fri,  6 Sep 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640101; cv=none; b=rSk3G82sB2jh3acf+92eGlULGf5rl44CX4surEGKjrFJ3KJ4V5C/1PfkMRLKscIGQdvn+0vSSL+q6aX4ANegfHaeULToR/Qh/obxbJSJw2+mn8NGcC+GUYIyfuVicss7M5PI0KXhgpt2LhQskiPtGw26yrii34EcoLqgnICoAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640101; c=relaxed/simple;
	bh=b0VV0agxdK7kNv2w4D7ckU/4BMjajGPF7X6zVBfpQVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuELlxvGh8at4cmLxhv3YZkG2TUbV5gKUURPWBq40Bd7LklDO0rLyh+lnNqC93xbjEh0Jkj6iUjGAS1L4OQT6CECGBeNGsDkkDIL4zNWZUfsTCYeggjauqaWh+H2F6mjlgw9zRIuSIN2lAY0JDOk7yLeOALeKVkpUw6KbGmoXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AgHDkBtA; arc=none smtp.client-ip=80.12.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id mbH2sLOaOZ40ambH2sBW7E; Fri, 06 Sep 2024 17:53:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725638006;
	bh=ZKNUuo4mgLBUYM3wMqwKTxkByTeR/Fq2vXEUhA0RRME=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AgHDkBtAbVhpVJXwRd5tzaBY3RmjcWAX74XDlSYoLSqk5jlzBE9BvpqKgS3CIosza
	 nMLKmmcbhyn3w6r00XXEtwKAwQ45DOEJmkEdfoc0KK891ZJ2ZoOqisp+Es1qA8aTo6
	 T5ITQSoFY7Ma77cHksliitBIidLh13p+/NvOo3zdkQzwsqdCzc7xHwQGsbz69Qusa1
	 JLPGrwcY/TgvmHmgA1PJ/GKGdNPZzMWbBioRjdaiKzua5CslJ4af1myJJxS13VvW58
	 O/CcclJWnTjq00GzJ267ahtt5pyQOXHCA0Tuh3yKiIV6t9qgMYHWCu5PcuCfGp7eRo
	 6bu/geQQFiD7Q==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 06 Sep 2024 17:53:26 +0200
X-ME-IP: 90.11.132.44
Message-ID: <770f7eee-113d-414c-b4c7-91d6b705eb78@wanadoo.fr>
Date: Fri, 6 Sep 2024 17:53:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: codecs: Use devm_clk_get_enabled() helpers
To: ying zuxin <yingzuxin@vivo.com>, Herve Codina <herve.codina@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "moderated list:INFINEON PEB2466 ASoC CODEC" <alsa-devel@alsa-project.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: opensource.kernel@vivo.com, yang.yang@vivo.com,
 ying zuxin <11154159@vivo.com>
References: <20240906084841.19248-1-yingzuxin@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240906084841.19248-1-yingzuxin@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/09/2024 à 10:48, ying zuxin a écrit :
> From: ying zuxin <11154159@vivo.com>
> 
> The devm_clk_get_enabled() helpers:
>      - call devm_clk_get()
>      - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> Signed-off-by: ying zuxin <11154159@vivo.com>
> ---
>   sound/soc/codecs/peb2466.c | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/sound/soc/codecs/peb2466.c b/sound/soc/codecs/peb2466.c
> index 76ee7e3f4d9b..b67cfad4fc32 100644
> --- a/sound/soc/codecs/peb2466.c
> +++ b/sound/soc/codecs/peb2466.c
> @@ -1975,12 +1975,9 @@ static int peb2466_spi_probe(struct spi_device *spi)
>   	if (IS_ERR(peb2466->reset_gpio))
>   		return PTR_ERR(peb2466->reset_gpio);
>   
> -	peb2466->mclk = devm_clk_get(&peb2466->spi->dev, "mclk");
> +	peb2466->mclk = devm_clk_get_enabled(&peb2466->spi->dev, "mclk");
>   	if (IS_ERR(peb2466->mclk))
>   		return PTR_ERR(peb2466->mclk);
> -	ret = clk_prepare_enable(peb2466->mclk);
> -	if (ret)
> -		return ret;
>   
>   	if (peb2466->reset_gpio) {
>   		gpiod_set_value_cansleep(peb2466->reset_gpio, 1);
> @@ -2031,17 +2028,9 @@ static int peb2466_spi_probe(struct spi_device *spi)
>   	return 0;
>   
>   failed:
> -	clk_disable_unprepare(peb2466->mclk);
>   	return ret;

Hi,

so the 'failed' label is now mostly useless and direct returns could be 
used instead.

CJ

>   }
>   
> -static void peb2466_spi_remove(struct spi_device *spi)
> -{
> -	struct peb2466 *peb2466 = spi_get_drvdata(spi);
> -
> -	clk_disable_unprepare(peb2466->mclk);
> -}
> -
>   static const struct of_device_id peb2466_of_match[] = {
>   	{ .compatible = "infineon,peb2466", },
>   	{ }
> @@ -2061,7 +2050,6 @@ static struct spi_driver peb2466_spi_driver = {
>   	},
>   	.id_table = peb2466_id_table,
>   	.probe  = peb2466_spi_probe,
> -	.remove = peb2466_spi_remove,
>   };
>   
>   module_spi_driver(peb2466_spi_driver);


