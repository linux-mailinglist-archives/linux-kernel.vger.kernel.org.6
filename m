Return-Path: <linux-kernel+bounces-329929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93997979A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 17:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD3E1C20BF8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE0198852;
	Sun, 15 Sep 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HvYklJb2"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE477DDAB
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726414680; cv=none; b=iX4z3mX2qHIcmYS6hWb3eluKo7dMLmK28gIFP+xWL71YtAYuZDfEgIl4FEbhtveOoC1VgodAYI7KK9UNg6y7GxvfIrlky9YKGInrlecGbEb2U2l2eMJeXKEeolJtgmYLhWOB2tS4e4pdDyvqfVjZHYSo1YPW45jr28E2EcbNBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726414680; c=relaxed/simple;
	bh=TvavoVxTcpHuNZpY/X8OtWPBmFhfji4jlJKXDs6Ge7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPLo0y6iLDtzZ+3grC1CSlVlKqrI24k5H658YyOnhwFPE2DDG1edV2Kq5mVy06mqw3YDvPiMoJ1CewSHbwQCsKPzM8VvxKJ4MKohiqyUDAAAWYI8VjcplM06OJ2liWdGOLpjDNZLDbGYYTIlxl88mSsd9fzlCjts2H82AelQ9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HvYklJb2; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id prIisqKg3v6omprIisdA9F; Sun, 15 Sep 2024 17:36:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726414604;
	bh=B5lxwA3RJVfpCMK7mrch/PuYhstLeGPB1Sq4dI+x91c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HvYklJb2laswsW+CVHnr5CMCBwKtRm/ZYFZi5d44Gfm2W7CGR4Nm40/A9Y5mxmRIx
	 lg7fbWp3ueNctPYIOXRwuhcWzHzFknaJJpEc7NblUQRF1pO/GcmXYxPDpiQLJo/dU5
	 IP+YsnLwrkR7lZjMviDq2acqZLMGoZJ268/MHcUmOnCOHTO/gZIx0ugxc50NeMNGv3
	 6D6jiZOox0L6PKWEO7TLBXOhq4uVSEAuihE5NrkGmufoa7oXAFJfGyJgJLAMvXWygD
	 WCtGIGu8C2ARZRh8CZlwtFNydUZF13lHjdvL5al0SU6xWfqaa43GfMMMHxR8kV3BuW
	 97B1SB3K1kIQQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 15 Sep 2024 17:36:44 +0200
X-ME-IP: 90.11.132.44
Message-ID: <19edbeff-7658-4302-9d40-d3cf5a1a64b3@wanadoo.fr>
Date: Sun, 15 Sep 2024 17:36:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 net-next 03/10] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240912025127.3912972-1-shaojijie@huawei.com>
 <20240912025127.3912972-4-shaojijie@huawei.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240912025127.3912972-4-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 04:51, Jijie Shao a écrit :
> Implements the C22 read and write PHY registers interfaces.
> 
> Some hardware interfaces related to the PHY are also implemented
> in this patch.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Hi,

a few nitpick, should there be a v11.

> +static void hbg_hw_init_transmit_control(struct hbg_priv *priv)
> +{
> +	u32 control = 0;
> +
> +	control |= FIELD_PREP(HBG_REG_TRANSMIT_CONTROL_AN_EN_B, HBG_STATUS_ENABLE);
> +	control |= FIELD_PREP(HBG_REG_TRANSMIT_CONTROL_CRC_ADD_B, HBG_STATUS_ENABLE);
> +	control |= FIELD_PREP(HBG_REG_TRANSMIT_CONTROL_PAD_EN_B, HBG_STATUS_ENABLE);
> +
> +	hbg_reg_write(priv, HBG_REG_TRANSMIT_CONTROL_ADDR, control);
> +}
> +
> +static void hbg_hw_init_rx_ctrl(struct hbg_priv *priv)
> +{
> +	u32 ctrl = 0;

Nitpick: the same kind of variable is called 'control' just above.
Same in the function name.

Having the same pattern everywhere would look more consistent.

> +
> +	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_RX_GET_ADDR_MODE_B, HBG_STATUS_ENABLE);
> +	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_TIME_INF_EN_B, HBG_STATUS_DISABLE);
> +	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE_M, HBG_RX_SKIP1);
> +	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE2_M, HBG_RX_SKIP2);
> +	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_RX_ALIGN_NUM_M, NET_IP_ALIGN);
> +	ctrl |= FIELD_PREP(HBG_REG_RX_CTRL_PORT_NUM, priv->dev_specs.mac_id);
> +
> +	hbg_reg_write(priv, HBG_REG_RX_CTRL_ADDR, ctrl);
> +}

...

> +static int hbg_mdio_init_hw(struct hbg_priv *priv)

Nitpick: This could return void.

> +{
> +	u32 freq = priv->dev_specs.mdio_frequency;
> +	struct hbg_mac *mac = &priv->mac;
> +	u32 cmd = 0;
> +
> +	cmd |= FIELD_PREP(HBG_REG_MDIO_COMMAND_ST_M, HBG_MDIO_C22_MODE);
> +	cmd |= FIELD_PREP(HBG_REG_MDIO_COMMAND_AUTO_SCAN_B, HBG_STATUS_DISABLE);
> +
> +	/* freq use two bits, which are stored in clk_sel and clk_sel_exp */
> +	cmd |= FIELD_PREP(HBG_REG_MDIO_COMMAND_CLK_SEL_B, freq & 0x1);
> +	cmd |= FIELD_PREP(HBG_REG_MDIO_COMMAND_CLK_SEL_EXP_B, (freq >> 1) & 0x1);
> +
> +	hbg_mdio_set_command(mac, cmd);
> +	return 0;
> +}

...

CJ


