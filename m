Return-Path: <linux-kernel+bounces-329933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FB09797A5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 17:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557591C209D4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432BE1C9DCA;
	Sun, 15 Sep 2024 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qf42wedG"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C022083
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726415596; cv=none; b=EFQzAKZR+C9fOW7rQ/0XY5xf6mNZxWNGvONyOP5KIrDnIouYsIY4lc4+ueErFPBMZXJvfOCiQ3q3hWPI+S8SO33OLxEWqyNrahpcM+YGu1dHlTgXpqPhIIEtFc1aJTxzeV3i5g6uqWBOCpRfb/TRlXXTinfZdAI+hNeOzA0VmOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726415596; c=relaxed/simple;
	bh=zZZ9CIj83c9WwXhkqDCBJiA4UKr/k2goQE7wK2+M2h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzK+R6VficlLnxifd6PYCOLDK+2aSKl62ByxJoL4AF8XZsttTb3IIrQV1wCXtXDJ2Ge3ktqDAfgeJYDAzw8yWYn07uI/eAfl0s0eKCoaVYkOaZNyI2keG5ii0KhnKzrwhrgRub9pxTIO9ba3f4JGUCa7oE7RjSEK0K0uBG94vWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qf42wedG; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id prYYs6BmR3ZMyprYZs0nzU; Sun, 15 Sep 2024 17:53:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726415586;
	bh=KSYDJRtZaoanhLuQtq7LI7SUDsSKgA4E/cVvWnlxv1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=qf42wedGYCSlWLihJ3sLCkD1n7cjFA/Hvsx9ECeWdmtKoG4cAI3KQrBzeKBYKUtA7
	 jcEAiKtAZUJCjdg7AoR/3uQCHMzNUieXjBScACVGa1d32qt1JmyeSYaltW9CQLlLyR
	 k0307R59CSnGuz3uDVYIgdMyQ5F4Na+GYBxcUJned1HFFFeRUewR4FinIRjXg+t4Cq
	 Hkp5Rjmb3POsV6fJzV6ZpCXZ/x3HoCv42GTPUxCwYaKvBpUkDaTznzKndUOsY9xDkH
	 F5tSjyP7ivx/3YUwpJ3pWzMaT5NhVtczLpc4kWY9MnTLDlPguxkMbu1aw6jcRyiynj
	 TpHsX5E0eewrw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 15 Sep 2024 17:53:06 +0200
X-ME-IP: 90.11.132.44
Message-ID: <f4bcd1e2-6e46-4636-bc10-37f4adcdb868@wanadoo.fr>
Date: Sun, 15 Sep 2024 17:52:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 net-next 06/10] net: hibmcge: Implement
 .ndo_start_xmit function
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240912025127.3912972-1-shaojijie@huawei.com>
 <20240912025127.3912972-7-shaojijie@huawei.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240912025127.3912972-7-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 04:51, Jijie Shao a écrit :
> Implement .ndo_start_xmit function to fill the information of the packet
> to be transmitted into the tx descriptor, and then the hardware will
> transmit the packet using the information in the tx descriptor.
> In addition, we also implemented the tx_handler function to enable the
> tx descriptor to be reused, and .ndo_tx_timeout function to print some
> information when the hardware is busy.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

...

> +static int hbg_dma_map(struct hbg_buffer *buffer)
> +{
> +	struct hbg_priv *priv = buffer->priv;
> +
> +	buffer->skb_dma = dma_map_single(&priv->pdev->dev,
> +					 buffer->skb->data, buffer->skb_len,
> +					 buffer_to_dma_dir(buffer));
> +	if (unlikely(dma_mapping_error(&priv->pdev->dev, buffer->skb_dma)))

I don't think that the unlikely() is needed.

Maybe some other ones are also not needed when in slow path.

> +		return -ENOMEM;
> +
> +	return 0;
> +}

...

> +static int hbg_tx_ring_init(struct hbg_priv *priv)
> +{
> +	struct hbg_ring *tx_ring = &priv->tx_ring;
> +
> +	if (!tx_ring->tout_log_buf)
> +		tx_ring->tout_log_buf = devm_kzalloc(&priv->pdev->dev,
> +						     HBG_TX_TIMEOUT_BUF_LEN,
> +						     GFP_KERNEL);

Nitpick: devm_kmalloc() looks enough.
It is zeroed only the first time we get there anyway.

> +
> +	if (!tx_ring->tout_log_buf)
> +		return -ENOMEM;
> +
> +	return hbg_ring_init(priv, tx_ring, hbg_napi_tx_recycle, HBG_DIR_TX);
> +}

