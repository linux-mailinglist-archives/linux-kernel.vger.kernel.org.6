Return-Path: <linux-kernel+bounces-512657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C38A33C30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809E81684C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D692212FA8;
	Thu, 13 Feb 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Esk0eTJx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544820DD72;
	Thu, 13 Feb 2025 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441492; cv=none; b=PAAMmFWK9u7B5nqadjhptq+38poVxuc15UGrLMJi8zusncQoHyGqp4nG1pYJqke/pVzLVnz+66yLGxIkQuAumqRs+ICPZ5Fwf1ogtf15hwdZnpIlprahwCg46sOad7sz8/kChwiTJoIb+zGukTS66Pt5Spur1w+N2jF/fEYRH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441492; c=relaxed/simple;
	bh=e65N9TKu11IkRIhXe6iLKZRtrhHqv/Yn7JxdieTK06U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2aWTnQlejq+zfWLV3m5GjRC2t7P/O+G+VRPwLVtDbmmul8vcmXx1dls/thJtvr7Uuu0Gw3Mj7lrJE18OiHTsDxoj6iyg5f9x+m8uQQyBjbrEvVmm6Km17pZlzfYQ+q5KSInW08eIbYFilTcePGaucUD2uujFxqk2/vfZI6Oexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Esk0eTJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA2FC4CED1;
	Thu, 13 Feb 2025 10:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739441491;
	bh=e65N9TKu11IkRIhXe6iLKZRtrhHqv/Yn7JxdieTK06U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Esk0eTJxTieq3Y1P9SUnNzPOBoXL+FPPJttxBWHqnf0Sm44a4c/fjI+bMlwLnir39
	 2utlIMx/myKUJTF6GkLHjuFFI8/LxNuQOaUDCVe5YNPyiCLPs4jHgrsxQXwt6nGgNX
	 cjCFhSyt5Pge2dyEmQf2oY7VIENvwxDJzedSh95k=
Date: Thu, 13 Feb 2025 11:11:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: better interrupt name
Message-ID: <2025021302-malformed-captivity-e862@gregkh>
References: <20250213-max33359-irq-name-v1-1-1900da7a1e79@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213-max33359-irq-name-v1-1-1900da7a1e79@linaro.org>

On Thu, Feb 13, 2025 at 09:37:54AM +0000, André Draszik wrote:
> This changes the output of /proc/interrupts from the non-descriptive:
>     1-0025
> (or similar) to a more descriptive:
>     1-0025-max33359
> 
> This makes it easier to find the device, in particular if there are
> multiple i2c devices, as one doesn't have to remember (or lookup) where
> it is located.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index fd1b80593367..46fc626589db 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -420,12 +420,14 @@ static irqreturn_t max_tcpci_isr(int irq, void *dev_id)
>  	return IRQ_WAKE_THREAD;
>  }
>  
> -static int max_tcpci_init_alert(struct max_tcpci_chip *chip, struct i2c_client *client)
> +static int max_tcpci_init_alert(struct max_tcpci_chip *chip,
> +				struct i2c_client *client,
> +				const char *name)
>  {
>  	int ret;
>  
>  	ret = devm_request_threaded_irq(chip->dev, client->irq, max_tcpci_isr, max_tcpci_irq,
> -					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
> +					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), name,
>  					chip);
>  
>  	if (ret < 0)
> @@ -485,6 +487,7 @@ static int max_tcpci_probe(struct i2c_client *client)
>  	int ret;
>  	struct max_tcpci_chip *chip;
>  	u8 power_status;
> +	const char *name;
>  
>  	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
> @@ -531,7 +534,11 @@ static int max_tcpci_probe(struct i2c_client *client)
>  
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
>  
> -	ret = max_tcpci_init_alert(chip, client);
> +	name = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%s",
> +			      dev_name(&client->dev), client->name);
> +	if (!name)
> +		return -ENOMEM;

Please always test your code before sending it out.  You just leaked a
bunch of stuff here :(

thanks,

greg k-h

