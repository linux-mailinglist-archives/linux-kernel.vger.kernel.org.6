Return-Path: <linux-kernel+bounces-216156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63A6909C0E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E975CB20FD1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CF6178398;
	Sun, 16 Jun 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RZExeNms"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCD03D6B;
	Sun, 16 Jun 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718522598; cv=none; b=Z3zxnei4xZyoOgVSFBuCIVEy3mqrhldSAEeORJbwnUq3mptMU7o2YGv+/6q6EVw69pEfzK7iPB31zRysUpqAUsHs+xwiyUIfGbDLP8D6k1/+NZcZbFp1ozYzEk4bqz8z3PPzDBCdm3UG2aSBfsCsT2atmtlum/R7FOtpU+VGx9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718522598; c=relaxed/simple;
	bh=+OZys9MJKjQjiTKcvx4NEmnpvqcjrD585Do8GvjtISA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1Vj2PaxaI+aEfKw0fTaa3+CRSPrB7nvYr50eGvFcQQkJ8HTbcduHD07q7oYmuQ37gLbZuHGVlvdLW8OVFpXNpE0hs3spkwWRK6ROD2baGiS6qxgBc2xDvZ18svfNpK9z5frBNDOdrd+C7KPa1IPqv9BXSxgmp8DyebevQI87dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RZExeNms; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id Ik5as8CMcevLqIk5bsMq50; Sun, 16 Jun 2024 09:14:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718522060;
	bh=YP7PkSksy9wMazSXjGajDue5tMT2K7r8fSa1XkSOCMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=RZExeNmsKlRnZQBILU4YjwXErTuEql+SaccL2uFBjA6xwDM4IK1gZWon0XfW41Rqm
	 u5MS1+gNoKQaor66VozQF1NM+QzzgBYrfVf64wPAlE46LIdXavKTwO2yd6BRghSbMV
	 eOa/MT3OuABzxJ4Sv0OxMrda82F8Sl2RQFQMe0HO8TtZMCo0azizFdYtlYG0Au1tc6
	 2hIpD3IL6C3lhz5ZqV9hPwUHK8B0tIk470L/qO6oLW703+W09Zwce5vl5sALEf76uE
	 2qKjo4YMTV1HmnLgyTc8EylS+rQG2AEtQrfQeaT1JZvs9QQ+dMjV2ZzFqqEXuC8+S/
	 0O4zOexyhTUqA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Jun 2024 09:14:20 +0200
X-ME-IP: 86.243.222.230
Message-ID: <de75c710-044a-45ff-9477-cf4d57f55ab1@wanadoo.fr>
Date: Sun, 16 Jun 2024 09:14:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-fiq: add missing MODULE_DESCRIPTION()
 macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240615-md-arm-sound-soc-fsl-v1-1-8ed731c2f073@quicinc.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240615-md-arm-sound-soc-fsl-v1-1-8ed731c2f073@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/06/2024 à 08:42, Jeff Johnson a écrit :
> With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/soc/fsl/imx-pcm-fiq.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   sound/soc/fsl/imx-pcm-fiq.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
> index 0d124002678e..5ea6dd4c89a1 100644
> --- a/sound/soc/fsl/imx-pcm-fiq.c
> +++ b/sound/soc/fsl/imx-pcm-fiq.c
> @@ -319,4 +319,5 @@ void imx_pcm_fiq_exit(struct platform_device *pdev)
>   }
>   EXPORT_SYMBOL_GPL(imx_pcm_fiq_exit);
>   
> +MODULE_DESCRIPTION("Freescle i.MX PCM FIQ handler");

Freescale? (missing 'a')

CJ

>   MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240615-md-arm-sound-soc-fsl-c598fb353e69
> 
> 
> 


