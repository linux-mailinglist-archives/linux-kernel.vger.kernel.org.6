Return-Path: <linux-kernel+bounces-304886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1B96263E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43A91F23AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B93171E5F;
	Wed, 28 Aug 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="r+1CcVZZ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8516C869;
	Wed, 28 Aug 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845461; cv=none; b=mL7HS0jiS3PZaGM7L1a6mSiLJYSyI/e4aFoDyCsiCCUS6jmATZPrmkmcs1K6wRFQxvS0fHtT3J3OlxYqR/Mh5fHkThEx76NdQ/0DxkepMj0F64wVYLTFDJIeV4iSGzDAK2YD1kYasoaR7iqhr8/14OmSbgrL18f+x98yWtf1ydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845461; c=relaxed/simple;
	bh=gxHxrfYxqX1u3uuADVLNaJEbVWOXzW5afjkBypbztBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj2MB18EYpMOt7fc0C+SU6Q2fRA5G6JbVcuoQJAagemsbc0QaE63XKiiULoY9aHg7ydgBYPxMsrrk0pr7r1ukSCypaQpwzRMhrrazc1CERzUSC/HCInMVUI1bC0BNUmhCBJE4JKsugvtGBg9n5IFWlrB3x+u+Tfpy2sibesGZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=r+1CcVZZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6776B21356;
	Wed, 28 Aug 2024 13:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724845451;
	bh=rPl7PStARyUjVVEgqBNeslu57i2IKQ9Gm0DF8M4LKvs=; h=From:To:Subject;
	b=r+1CcVZZYG1ahMnjDBwJtC7wzUyvDQB/sXMkV3o2Qo7h0OJ0NwdpqNNVQah4WDs69
	 LxysegptqkdT0C0cjyxB/9DT8dg/UFzwEnzzMfQ0gYb78/nhbgMKKt74mu4u1K5x8N
	 oCSoMOE6SdIAqMTSsKYAHOlRDlx0COjfZV+0ZVtgvrMYJtK4HJqx8CR3THHqp+wxdH
	 Bgh6XGHVBSIIReiRWqDb6RN+WlogjEOIqF5Do62uqInWoAt7NaAdOo1SjGTKTLMplG
	 +uWI7XcY41sLOdKQbLcxvA/1nq9Ox6TIrM7GU4PMp9n/OFBzgzQQ5uceYGx9LW1+zY
	 59ZlSmgeobjlw==
Date: Wed, 28 Aug 2024 13:44:06 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Parth Pancholi <parth105105@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Parth Pancholi <parth.pancholi@toradex.com>
Subject: Re: [PATCH] usb: typec: tcpci: support edge irq
Message-ID: <20240828114406.GA27965@francesco-nb>
References: <20240828112058.479753-1-parth105105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828112058.479753-1-parth105105@gmail.com>

On Wed, Aug 28, 2024 at 01:20:58PM +0200, Parth Pancholi wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> TCPCI USB PHY - PTN5110 could be used with SOCs that only support
> the edge-triggered GPIO interrupts such as TI's K3 device AM69.
> Move the interrupt configuration to the firmware which would
> allow to accommodate edge triggered interrupts for such SOCs.
> In order to support the edge interrupts, register irq line in advance
> and keep track of occurrence during port registering.
> 
> When the edge interrupts are used, it is observed that some of the
> interrupts are missed when tcpci_irq() is serving the current
> interrupt. Therefore, check the status register at the end of
> tcpci_irq() and re-run the function if the status is not clear
> i.e. pending interrupt.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index a2651a2a7f2e..4537c1d97e8f 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
...

> @@ -915,18 +923,24 @@ static int tcpci_probe(struct i2c_client *client)
>  
>  	chip->data.set_orientation = err;
>  
> -	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
> -	if (IS_ERR(chip->tcpci))
> -		return PTR_ERR(chip->tcpci);
> -
>  	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>  					_tcpci_irq,
> -					IRQF_SHARED | IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +					IRQF_SHARED | IRQF_ONESHOT,
>  					dev_name(&client->dev), chip);
> -	if (err < 0) {
> -		tcpci_unregister_port(chip->tcpci);
> +	if (err < 0)
>  		return err;
> -	}
> +
> +	/*
> +	 * Disable irq while registering port. If irq is configured as an edge
> +	 * irq this allow to keep track and process the irq as soon as it is enabled.
> +	 */
> +	disable_irq(client->irq);
> +
> +	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
> +	if (IS_ERR(chip->tcpci))
> +		return PTR_ERR(chip->tcpci);
> +
> +	enable_irq(client->irq);

If I undestand this correctly, if tcpci_register_port() fails the irq
stays disabled.

disable_irq(client->irq);
chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
enable_irq(client->irq);

return PTR_ERR_OR_ZERO(chip->tcpci);

maybe?

Francesco


