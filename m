Return-Path: <linux-kernel+bounces-545627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37186A4EF5F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC0C1728E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CD5200B99;
	Tue,  4 Mar 2025 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="F/htZXuH"
Received: from smtp.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D97DA93;
	Tue,  4 Mar 2025 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123836; cv=none; b=GJyWIMEymD2W1liLkf01MEFYRhlbs1YOUlzrJz9rT/foJjAYtgPbYKz3sa+OBqp3UKVhlJNRMBpKJEk+2ZmYZRMvkQTpWM2DSn2kfzsiCV2Pq5s09HVCjl3i4UJvacdoZRilAs2aNaNimUY9G+8JwtfHmi4hngPgwSYjSxvc5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123836; c=relaxed/simple;
	bh=uU2YbbMZxvg5eLRNvxP4W3qaFK4o/G15pdl3NZqtIgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LGwsKty5viPem81dlb3S5/pvYhFoSji9HlzJneU0MwBTGq2b2233wKuzJo6I/5iDf4jCmnpa7IyqiIZCKGMLumQP7g5dJ9/Wfedj9nta7QbT97ppMErSGNMsSqr4zAq6lvCeInsf/Uofo/7XyAvMb982uz4diWo1Kzmp8Sq1F/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=F/htZXuH; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id pZhEtjoYlf1j1pZhItMWBa; Tue, 04 Mar 2025 22:21:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741123273;
	bh=K+h7jsWHv3eIxLPH5dNajezN+xQFTDwe/w8/eZdR268=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=F/htZXuHwOLqrOg37Ie4xDkEu5dSoXycvKds+QJgKpHM4TF1OfVT4PgIZuJDeGsrB
	 7qx9+ZmsUoXQ9CxklHemGcceTvS3H7LKNkR9LpBbJPyxeMj4+OhOJVX/dIbM51l0ea
	 mSFuiORCumZyYWbbq5vwhFzOK/bETgw1Bhn9ORtyVf6YLnqItZ94mJAK5qh0IDCT51
	 /Tw545tJjZPj9yLKoj7O2JntYzLwJiLtZvYykbYpMVGXLVw8Lt4yzIapdyNsw6aXKJ
	 6BHl6lQXZd3Ia8praMr/qD7YfmQ0mg6MIWWvafegftXVEwL42f7yq+x1VOGvchNrqC
	 ggVLi8D6df4mQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 04 Mar 2025 22:21:13 +0100
X-ME-IP: 90.11.132.44
Message-ID: <7ef88ec2-24a5-4aa7-a601-d605a12768ba@wanadoo.fr>
Date: Tue, 4 Mar 2025 22:20:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, derek.kiernan@amd.com, dragan.cvetic@amd.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-4-kevin_chen@aspeedtech.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250304104434.481429-4-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/03/2025 à 11:44, Kevin Chen a écrit :
> Add LPC PCC controller driver to support POST code capture.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>

Hi,

> +	init_waitqueue_head(&pcc->wq);
> +
> +	pcc->mdev_id = ida_alloc(&aspeed_pcc_ida, GFP_KERNEL);

Missing ida_free() in therror handling path and in the rmove function?

> +	if (pcc->mdev_id < 0) {
> +		dev_err(dev, "Couldn't allocate ID\n");
> +		return pcc->mdev_id;
> +	}
> +
> +	pcc->mdev.parent = dev;
> +	pcc->mdev.minor = MISC_DYNAMIC_MINOR;
> +	pcc->mdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME,
> +					pcc->mdev_id);
> +	pcc->mdev.fops = &pcc_fops;
> +	rc = misc_register(&pcc->mdev);
> +	if (rc) {
> +		dev_err(dev, "Couldn't register misc device\n");
> +		goto err_free_kfifo;
> +	}
> +
> +	rc = aspeed_pcc_enable(pcc, dev);
> +	if (rc) {
> +		dev_err(dev, "Couldn't enable PCC\n");
> +		goto err_dereg_mdev;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, pcc);
> +
> +	return 0;
> +
> +err_dereg_mdev:
> +	misc_deregister(&pcc->mdev);
> +
> +err_free_kfifo:
> +	kfifo_free(&pcc->fifo);
> +
> +	return rc;
> +}
> +
> +static void aspeed_pcc_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct aspeed_pcc_ctrl *pcc = dev_get_drvdata(dev);
> +
> +	kfifo_free(&pcc->fifo);
> +	misc_deregister(&pcc->mdev);
> +}
> +
> +static const struct of_device_id aspeed_pcc_table[] = {
> +	{ .compatible = "aspeed,ast2600-lpc-pcc" },
> +	{ },

Unneeded trailing comma after a terminator.

> +};
> +
> +static struct platform_driver aspeed_pcc_driver = {
> +	.driver = {
> +		.name = "aspeed-pcc",
> +		.of_match_table = aspeed_pcc_table,
> +	},
> +	.probe = aspeed_pcc_probe,
> +	.remove = aspeed_pcc_remove,
> +};

...

CJ

