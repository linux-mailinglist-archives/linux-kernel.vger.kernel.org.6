Return-Path: <linux-kernel+bounces-324797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B15D19750F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7110D285BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B42187FFF;
	Wed, 11 Sep 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gbocc47i";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Ug8XaR41"
Received: from a7-33.smtp-out.eu-west-1.amazonses.com (a7-33.smtp-out.eu-west-1.amazonses.com [54.240.7.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CA187347;
	Wed, 11 Sep 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054914; cv=none; b=hp3B0wXTey6SmWfGg0l5Q+ixYF7rpWMIsR7JFQrw/CHRhZ5wS7mIasGKo0jGnXhoNO0/X3JXryv3LsPjn2z3n9pC29G6TyCrSNWx0rEeZBus5n7rUfTY9QDCdsmulsjDJFwCObaWrSjWe80w1ooDRwpVXzhoyHAm9zWcB2uydgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054914; c=relaxed/simple;
	bh=Rk5q3BmBtUat5/52EX4J8IbXZHZ0jpHHNiGHCN+/zfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEQh0v9aN31CBBphw13vhoV4Ks9buxzugWqJ8R6a31OE2yTKqx3WoqVELF0WRa72/9lU0jA1H5Pyazqtco4isMSKnG9Eu1QP7FdVscR9qY/rLTV1BcN39gQeBrT4VrKoIm0FQzq85Hrr0wl4BoygwApZ9MLdEQZV0okIKoQi8Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gbocc47i; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Ug8XaR41; arc=none smtp.client-ip=54.240.7.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726054911;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Rk5q3BmBtUat5/52EX4J8IbXZHZ0jpHHNiGHCN+/zfY=;
	b=gbocc47iLMfz7pURQWEuqEhhvrQRUpwmfDoYCYnsFDaT/oTyHa3D5U3Od/CLnYFR
	/afVBd0vmN5svggiJjvWVsXKJQbQKGJgPjoFgUpNpsnOH+MosMiUYTi40cMoQJsvC+D
	xPXAL9TlGwy9COUDj6gLTU3ICVwNVLuIl/OTWt0Nm66PypIVpp4Ed2A/Q5nc89gxlu0
	GqmeYJ8K3R5e4x1q71hBEZUI2zngHbOypDC1ba4p5dyLyfIomjs190UoJgnMj4mPzOW
	bB/QTPjWfHUEX3gfG25P/90/yFj9KACyiJJlG150c0vi/bQinWzTOWlRw4NWxXrWlQD
	V+FYRzqidQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726054911;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=Rk5q3BmBtUat5/52EX4J8IbXZHZ0jpHHNiGHCN+/zfY=;
	b=Ug8XaR417Kv4VWAWRhaOaPCKdY/Cblr531aJfmZjGh5UQtpHoBGpcpLjle98WZG1
	7JPT+wutVV6JXv0mLiDsuuZ6sZ/hgw15b7/dW/cK7NQMi+rfIICEFXO/g9Xt7itCPga
	fDr8jb9075hUkOEjUzXOLFcyxrTdwHnEDeVEkzmw=
Message-ID: <01020191e0e3cb9f-833b6cb7-1233-4b4d-9b48-bdf446d0ab70-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 11:41:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoc: mediatek: mt8365: Print the ret value
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, 
	Nicolas Belin <nbelin@baylibre.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240911111917.4091809-1-usama.anjum@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911111917.4091809-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.33

Il 11/09/24 13:19, Muhammad Usama Anjum ha scritto:
> Print the ret value otherwise it is just being set without ever getting
> used. The author may have missed printing it.
> 
> Fixes: 1bf6dbd75f76 ("ASoc: mediatek: mt8365: Add a specific soundcard for EVK")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> If it isn't useful, the ret value assignment statement can be removed.

Nah, please just remove the ret assignment... and while you're at it, can you also
change that dev_warn() to dev_info()?

That print is actually expected to be seen on some boards, and it may, or may not,
be something to be warned about; this is because some the states are optional, or
actually the only requirement is to have at least one pin group muxed to audio but
not forcefully a specific one (so you may have i2s0 on a board, i2s1 on the other).

Cheers,
Angelo


> ---
>   sound/soc/mediatek/mt8365/mt8365-mt6357.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8365/mt8365-mt6357.c b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
> index fef76118f8010..412f5fdd8fc52 100644
> --- a/sound/soc/mediatek/mt8365/mt8365-mt6357.c
> +++ b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
> @@ -258,8 +258,8 @@ static int mt8365_mt6357_gpio_probe(struct snd_soc_card *card)
>   							   mt8365_mt6357_pin_str[i]);
>   		if (IS_ERR(priv->pin_states[i])) {
>   			ret = PTR_ERR(priv->pin_states[i]);
> -			dev_warn(card->dev, "No pin state for %s\n",
> -				 mt8365_mt6357_pin_str[i]);
> +			dev_warn(card->dev, "No pin state(%d) for %s\n",
> +				 ret, mt8365_mt6357_pin_str[i]);
>   		} else {
>   			ret = pinctrl_select_state(priv->pinctrl,
>   						   priv->pin_states[i]);



