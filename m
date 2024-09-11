Return-Path: <linux-kernel+bounces-325375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B009758D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51405B26A35
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64C21B1509;
	Wed, 11 Sep 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="p0oRs4e/"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3371AC451
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073710; cv=none; b=AfvC4OltzrNND5hUs0+QZEgLtTBSWPIdFpxSwqWaukMNlJFoZBVtfVNXZ3cB8JTiNegK1I7ad9Kf6+QPvYxadcf2fe20oAVAgZ15BCvE5w93Gmv//thMrOzLFc+5YnkG+RpQeLQ+au2k/lJU3XhefDenXedY+uoSLNVgwoqPtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073710; c=relaxed/simple;
	bh=9dcc6fkzl8d+j8O7Bw9HalFyhrgYU4oAOwS94xlH1sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXOSYW2rrx51YAIymBCiTgFnoxQ7pgV3pGCdrqlHu+GN0z8FLSTqLWTL5JgXw1u04MfmaLtadyeQRDhJXjp9iH4yH/LCI1NGd/2F7oh1Ewsj2v1zD3jKnm6i8yviowOGKmBZSuUeO7mhg4f0uWNOhv6u5uT+2UlrPBC3zF5CZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=p0oRs4e/; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id oQcIs05NoeJiWoQcJsyQpz; Wed, 11 Sep 2024 18:55:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726073700;
	bh=XjhHU3LuhocUqb+TAqSulXBB+7sRbtrotXKds67f2kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=p0oRs4e/QLmXuTMehacYdeVnWDcE7igWHAZZFt7s3VVmkRF1SWdGS+tjAeuwK5pCu
	 UTa4xpdDJHATcEWfOJhaFDGOMzu8DILpTju8DvE8NuXTlQmeo+loGXBsPvvhUVZZ4R
	 ljsxkgzJyF2rgzq4pwn7Tc79F10da6dBFEaMLtofeBQjYSF148W5Thopnej++KI+FQ
	 DWrawxPWAu0fyKWpFn6WGmnZPLmypc21a6K0z5Jaj222QJz1fbBvKC56TvpTTVzjF+
	 4Erqbqho9ZLrFnBzC1FDEi0xu05jXilafqMQ5JQ4SwlIMga4sC2UOUeIEZ8R1hD3xS
	 xLzXP7Tfrx22A==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 11 Sep 2024 18:55:00 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c93c4fe2-e3bb-4ee9-be17-ca8cb9206386@wanadoo.fr>
Date: Wed, 11 Sep 2024 18:54:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 2/5] net: lan743x: Add support to
 software-nodes for sfp
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, rdunlap@infradead.org, andrew@lunn.ch,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 linux-kernel@vger.kernel.org
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/09/2024 à 18:10, Raju Lakkaraju a écrit :
> Register software nodes and define the device properties.
> software-node contains following properties.
>    - gpio pin details
>    - i2c bus information
>    - sfp signals
>    - phylink mode
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

Hi,

...

> +static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
> +{
> +	struct pci1xxxx_i2c *i2c_drvdata;
> +
> +	i2c_drvdata = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_I2C_ID);
> +	if (!i2c_drvdata)
> +		return -EPROBE_DEFER;
> +
> +	adapter->i2c_adap = &i2c_drvdata->adap;
> +	snprintf(adapter->nodes->i2c_name, sizeof(adapter->nodes->i2c_name),
> +		 adapter->i2c_adap->name);

strscpy() ?

> +	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
> +		  adapter->i2c_adap->name);
> +
> +	return 0;
> +}
> +
> +static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
> +{
> +	struct aux_bus_device *aux_bus;
> +	struct device *gpio_dev;
> +
> +	aux_bus = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_GPIO_ID);
> +	if (!aux_bus)
> +		return -EPROBE_DEFER;
> +
> +	gpio_dev = &aux_bus->aux_device_wrapper[1]->aux_dev.dev;
> +	snprintf(adapter->nodes->gpio_name, sizeof(adapter->nodes->gpio_name),
> +		 dev_name(gpio_dev));

strscpy() ?

> +	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
> +		  adapter->nodes->gpio_name);
> +	return 0;
> +}
> +

...

