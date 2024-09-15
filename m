Return-Path: <linux-kernel+bounces-329931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465FB97979F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 17:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1973328257D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA40A1C7B94;
	Sun, 15 Sep 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OXvKJUbF"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E642065
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726414879; cv=none; b=hxAaDhKONs7s7VuL8atgsX9wWt7530kJY9d+Hix08JrnuFT+y/q3Kp3pTkjnX7uYlI4eVQnedaM2LqUzLEKYYlIiBct8BOD7MvqYtS/jyAkXyA9DBJGC7xvB8MSJSMhEvBs1VQn0+Lb9/AyFEjX1nrVM5E4n724nJa6JbYJPZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726414879; c=relaxed/simple;
	bh=BeyS+tk5Zf40wMqQsXSeSOQMQMqnR5ZzpFuNrLtr7Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qawj0H63F5oI9IN7u2zDau1qMQ1/tXToC1cgWy4520J3/dwuhTHWW8vm+e/OrvJDmM3CLs/Vv16uNBU5UNPITdQluiy2/N2RHUxnq0/PxfdNBujdZvhVw+h22PiiDUwAk9Lajm8sQ3cFuALLq/WOIwhlvXUz+aLOiFGH+9xHdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OXvKJUbF; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id prM0sfopIeifvprM1shktz; Sun, 15 Sep 2024 17:40:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726414806;
	bh=4ioHhzxkrNreKRBL7gG4sHspiKXpbvEfNMmDFy6/DYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OXvKJUbFm7HIuASktbOvz3TjORxqsX0HThMfzQiRLZCMrnlZHr5FvMskmJvfnGZDO
	 BmxiD2IYN6Pq2/nrbyGJ02ImwkKaJxOeLvvRFwa5MZ7nTfkNLYrEeVNspLnYH689wA
	 3SuU0xGWGQjStnWnsciCOpzCQEw9y1DhJHZ4LMB3t7dw7i/VTZrC5tIIe1M+FXi1fr
	 lWL4bT9LlsIgWsAJzVAb4gA8bDh6K93M1GrLkiVhLEs0TFsEOqmGknUE/XBJLMiHVi
	 YZE40if5sSvnzNcm1JAOr3qwjOjkFM0ir5y/yGmLrdB9/HIrnw74bE5GFStaNWO5uy
	 1r2M5v6ObU6PQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 15 Sep 2024 17:40:06 +0200
X-ME-IP: 90.11.132.44
Message-ID: <820029d2-2989-412f-b026-676e97a9dd5c@wanadoo.fr>
Date: Sun, 15 Sep 2024 17:40:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 net-next 04/10] net: hibmcge: Add interrupt supported
 in this module
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240912025127.3912972-1-shaojijie@huawei.com>
 <20240912025127.3912972-5-shaojijie@huawei.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240912025127.3912972-5-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/09/2024 à 04:51, Jijie Shao a écrit :
> The driver supports four interrupts: TX interrupt, RX interrupt,
> mdio interrupt, and error interrupt.
> 
> Actually, the driver does not use the mdio interrupt.
> Therefore, the driver does not request the mdio interrupt.
> 
> The error interrupt distinguishes different error information
> by using different masks. To distinguish different errors,
> the statistics count is added for each error.
> 
> To ensure the consistency of the code process, masks are added for the
> TX interrupt and RX interrupt.
> 
> This patch implements interrupt request, and provides a
> unified entry for the interrupt handler function. However,
> the specific interrupt handler function of each interrupt
> is not implemented currently.
> 
> Because of pcim_enable_device(), the interrupt vector
> is already device managed and does not need to be free actively.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

...

> +int hbg_irq_init(struct hbg_priv *priv)
> +{
> +	struct hbg_vector *vectors = &priv->vectors;
> +	struct device *dev = &priv->pdev->dev;
> +	int ret, id;
> +	u32 i;
> +
> +	/* used pcim_enable_device(),  so the vectors become device managed */
> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to allocate MSI vectors\n");
> +
> +	if (ret != HBG_VECTOR_NUM)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "requested %u MSI, but allocated %d MSI\n",
> +				     HBG_VECTOR_NUM, ret);
> +
> +	/* mdio irq not request, so the number of requested interrupts

Nitpick: "mdio irq not requested"?

> +	 * is HBG_VECTOR_NUM - 1.
> +	 */
> +	for (i = 0; i < HBG_VECTOR_NUM - 1; i++) {
> +		id = pci_irq_vector(priv->pdev, i);

...

