Return-Path: <linux-kernel+bounces-330464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89259979ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED791F23BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85914E2C2;
	Mon, 16 Sep 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O4ETYETg"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4A14F9FB;
	Mon, 16 Sep 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480820; cv=none; b=be0fYYGMWP4S1TlW0/lMA2X948Vx8Ye7MyXfkK96OZQtqQdhFqNA4/Rwa4i40or6LIYi01ZAVu6LxZE5njYJEPvv2ike+t4vG9oAlLhazxPPBR5NqkRoalyj/oq0Zj0xCh+osCROVRvMyz5U5f+5qHv1Wb5dLEiGzbM1/6hh/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480820; c=relaxed/simple;
	bh=UkkJhVmPZRFzZAuAcyiy2i8RwGIpDoJ5oqfQ2KdcAd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMmU9wHiWdp+3HDsqKbgjH90SoxaYilwbtE8I37IVNwaI98euc+NOHFDBkveci5F1XCxbGGUd/HUq+YQF5YQis8K0sXsu9aZ+XgXBNIy3z2aKND1lc35IsimTrpZNH+yCIsvlgXqg3VUwvtpU2HIrJrKkuCNKQd0wGjHDhrZv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O4ETYETg; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF3B51BF208;
	Mon, 16 Sep 2024 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726480809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVcKgmtsHiY6zmy9L9WXJLjM0R6FE0qNoX99Did6GQM=;
	b=O4ETYETgxUUfpMvCpGK0TLhjTTodnCl3fjQh1P7pEW+3zQqfh8d6XdMLf9WLIoOYAS68RE
	vMc2GkAH78QTrgbizmeJyIw0nRLXkrhK2MMgfndA4tVpHq0lp4HEBiI4A/0JNbCknYfZDv
	2+9y994TBls8TJDXetU4jwuToRmSGKJ2rtMTnOd5sTvjDt93KM/JGppcR48QPpoGOGAsE7
	1dz3eHHhjdMhjGGQr+jYjzrQ6PqnzODM6CrU1LDkQcPRdGii1SzENOFIm5VY0hjAiKP11m
	CysVURAD7KhecdypD9YKtsvljbA33yR++yVQ4Gz/VEpKefuePHWjQoA6bWkMiA==
Date: Mon, 16 Sep 2024 12:00:06 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH 1/2] ASoC: atmel: atmel_ssc_dai: Add stream names
Message-ID: <20240916100006f2db7b06@mail.local>
References: <20240916085214.11083-1-andrei.simion@microchip.com>
 <20240916085214.11083-2-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916085214.11083-2-andrei.simion@microchip.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 16/09/2024 11:52:14+0300, Andrei Simion wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> Add required stream names for DPCM and future use-cases.
> 
> [andrei.simion@microchip.com: Adjust commit title. Reword commit message.]
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 3763454436c1..7047f17fe7a8 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -836,6 +836,7 @@ static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
>  
>  static struct snd_soc_dai_driver atmel_ssc_dai = {
>  		.playback = {
> +			.stream_name = "Playback",
>  			.channels_min = 1,
>  			.channels_max = 2,
>  			.rates = SNDRV_PCM_RATE_CONTINUOUS,
> @@ -843,6 +844,7 @@ static struct snd_soc_dai_driver atmel_ssc_dai = {
>  			.rate_max = 384000,
>  			.formats = ATMEL_SSC_FORMATS,},
>  		.capture = {
> +			.stream_name = "Capture",
>  			.channels_min = 1,
>  			.channels_max = 2,
>  			.rates = SNDRV_PCM_RATE_CONTINUOUS,
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

