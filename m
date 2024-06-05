Return-Path: <linux-kernel+bounces-201949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392088FC5BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7931C20E67
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407F4964A;
	Wed,  5 Jun 2024 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nmiZY0Iq"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885B49627;
	Wed,  5 Jun 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575222; cv=none; b=YSD6/+f83Ns5UjdBzeF67cZwy6dtVFEtwtCU/ehpjiMHZyWjV4f7LqcN1Vnblpvf3aGDqoeF4EkjWAE1Pouq7LpDwkwOUD13LmrY/B/otVjEeEbBtzY/96677bM/ZCVKQ0dTsip4VQWZ+6NjCrRqi5phoa2AR75C3MtPdNP3aQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575222; c=relaxed/simple;
	bh=b8B4Rrop9tzX9BsWtef8R0dWMFOYKVgtgHR1l03f4Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sode8RVmMhFfnTcr9WD21FTwUXbgdL6cp7jMzKypcDfg2iB7xgc6mVw2EJFXQg7wrq3Nqea4dBeQKQg9kE7W9rN1lERdV8TZJbOeYuUtL1xbOKzhFu+DOlBgOuyePlNG1oG1iJLNYMVS/CFF3JWRKyfsDt+5nYDrMWRxJNIojBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nmiZY0Iq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2689FC0016;
	Wed,  5 Jun 2024 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717575211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFaCgtWjGrzAsn767vWcD/AZ37FCocgz3r5B8D9v36Y=;
	b=nmiZY0IqJVyla3CZ2JgyuRmDZxbMw05xiNi+wYbGHMXaSAxpvSS2hy11HSxLlsCebnWt9Q
	wQ1E7ft/nhylODVFhRqZb7R0ejyZyD6hqTzxkMaBI1+2jqvhDgIhEUlLrYwcm/iqSQUzmC
	vrOsXHJqG6wyrRViVInLwpLbOYWEmIUYXPwajZemi2uxxC0QLySLTGSO81+f0i5M4Cm+Ig
	Y96vPo5Ie5Z5cNV6aJn1B2Qe0DBh+XrGHBjjJHnrXUx71m8MgtZEp02pl5xciah1LVA+DM
	1m1QkQfdAgtKjHXPpBBZ5TXj7Ierz60mXKokPUxFlU26rfmP7n7UNo7x7AKukQ==
Date: Wed, 5 Jun 2024 10:13:23 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Alibek Omarov <a1ba.omarov@gmail.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner
 <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rockchip: i2s-tdm: Fix trcm mode by setting clock
 on right mclk
Message-ID: <20240605101323.60d7abbc@booty>
In-Reply-To: <20240604184752.697313-1-a1ba.omarov@gmail.com>
References: <20240604184752.697313-1-a1ba.omarov@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Alibek,

On Tue,  4 Jun 2024 21:47:52 +0300
Alibek Omarov <a1ba.omarov@gmail.com> wrote:

> When TRCM mode is enabled, I2S RX and TX clocks are synchronized through
> selected clock source. Without this fix BCLK and LRCK might get parented
> to an uninitialized MCLK and the DAI will receive data at wrong pace.
> 
> However, unlike in original i2s-tdm driver, there is no need to manually
> synchronize mclk_rx and mclk_tx, as only one gets used anyway.
> 
> Tested on a board with RK3568 SoC and Silergy SY24145S codec with enabled and
> disabled TRCM mode.
> 
> Fixes: 9e2ab4b18ebd ("ASoC: rockchip: i2s-tdm: Fix inaccurate sampling rates")
> Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
> ---
>  sound/soc/rockchip/rockchip_i2s_tdm.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
> index 9fa020ef7eab..ee517d7b5b7b 100644
> --- a/sound/soc/rockchip/rockchip_i2s_tdm.c
> +++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
> @@ -655,8 +655,17 @@ static int rockchip_i2s_tdm_hw_params(struct snd_pcm_substream *substream,
>  	int err;
>  
>  	if (i2s_tdm->is_master_mode) {
> -		struct clk *mclk = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
> -			i2s_tdm->mclk_tx : i2s_tdm->mclk_rx;
> +		struct clk *mclk;
> +
> +		if (i2s_tdm->clk_trcm == TRCM_TX) {
> +			mclk = i2s_tdm->mclk_tx;
> +		} else if (i2s_tdm->clk_trcm == TRCM_RX) {
> +			mclk = i2s_tdm->mclk_rx;
> +		} else if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			mclk = i2s_tdm->mclk_tx;
> +		} else {
> +			mclk = i2s_tdm->mclk_rx;
> +		}

I cannot test right now, but it definitely looks correct.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

