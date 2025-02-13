Return-Path: <linux-kernel+bounces-512861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E384FA33E85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD23A5E68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C466221D3E8;
	Thu, 13 Feb 2025 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IQ0eR4Qt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3A207679;
	Thu, 13 Feb 2025 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447774; cv=none; b=etCpj4LrbuIc1qLMuH45JcQYpVTeaXwHfDK1Ft/tdKEwMf/t30MrQGnkNJJO6kl0eO/ClEC2vgFWGVJWPeDiwbidJfz+AAPcaeXUeXaVbfFees+NHr7be837DchuDsTkjLwyCLgs9cAuPicWDO6fGh/buXxiB6CELImV+dOLb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447774; c=relaxed/simple;
	bh=h2/9FXUw0ygkMlVgwW3euHLMiNbdaiRO2pEdaQZrhtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOYBHMb9e/DUpk4NHATlU1qiDMBtN+2yB+TOEsnZQaV0mqPCg9doqA4hsdEGQc3z7JlE7yXXjX1i3eRJn63PV1/mfKZl1Jo1cdyPUN6T944kJJgtqipqaElkOfYCfxWNJmbY8cGvug5OpHgyvR8Sx2h0Lzv4tUbD/3cXSOQDpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IQ0eR4Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE6AC4CED1;
	Thu, 13 Feb 2025 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739447773;
	bh=h2/9FXUw0ygkMlVgwW3euHLMiNbdaiRO2pEdaQZrhtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQ0eR4QtoVHxQF2UTWuHJZ8lfiCze4TKzY0LBuf6h8gUgLuc/8PsJv/B5j8efhRAL
	 cBrgqmyGKXofGNx0rvOQO6sdoQ1/amIOgYp0WP3PUWuri/dxjMyCvxtQ8wsV/J5UwM
	 H5kATtNtYJDj2m/HuX6D7aud73KlOtm/2ylKH1Qc=
Date: Thu, 13 Feb 2025 12:56:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: better interrupt name
Message-ID: <2025021323-opponent-strategic-a27f@gregkh>
References: <20250213-max33359-irq-name-v1-1-1900da7a1e79@linaro.org>
 <2025021302-malformed-captivity-e862@gregkh>
 <58af4b607adbe74725d4869f8f5a09cd5d3be2d3.camel@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58af4b607adbe74725d4869f8f5a09cd5d3be2d3.camel@linaro.org>

On Thu, Feb 13, 2025 at 11:44:59AM +0000, André Draszik wrote:
> Hi Greg,
> 
> On Thu, 2025-02-13 at 11:11 +0100, Greg Kroah-Hartman wrote:
> > On Thu, Feb 13, 2025 at 09:37:54AM +0000, André Draszik wrote:
> > > This changes the output of /proc/interrupts from the non-descriptive:
> > >     1-0025
> > > (or similar) to a more descriptive:
> > >     1-0025-max33359
> > > 
> > > This makes it easier to find the device, in particular if there are
> > > multiple i2c devices, as one doesn't have to remember (or lookup) where
> > > it is located.
> > > 
> > > Signed-off-by: André Draszik <andre.draszik@linaro.org>
> > > ---
> > >  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> > > index fd1b80593367..46fc626589db 100644
> > > --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> > > +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> > > @@ -420,12 +420,14 @@ static irqreturn_t max_tcpci_isr(int irq, void *dev_id)
> > >  	return IRQ_WAKE_THREAD;
> > >  }
> > >  
> > > -static int max_tcpci_init_alert(struct max_tcpci_chip *chip, struct i2c_client *client)
> > > +static int max_tcpci_init_alert(struct max_tcpci_chip *chip,
> > > +				struct i2c_client *client,
> > > +				const char *name)
> > >  {
> > >  	int ret;
> > >  
> > >  	ret = devm_request_threaded_irq(chip->dev, client->irq, max_tcpci_isr, max_tcpci_irq,
> > > -					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
> > > +					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), name,
> > >  					chip);
> > >  
> > >  	if (ret < 0)
> > > @@ -485,6 +487,7 @@ static int max_tcpci_probe(struct i2c_client *client)
> > >  	int ret;
> > >  	struct max_tcpci_chip *chip;
> > >  	u8 power_status;
> > > +	const char *name;
> > >  
> > >  	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> > >  	if (!chip)
> > > @@ -531,7 +534,11 @@ static int max_tcpci_probe(struct i2c_client *client)
> > >  
> > >  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
> > >  
> > > -	ret = max_tcpci_init_alert(chip, client);
> > > +	name = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%s",
> > > +			      dev_name(&client->dev), client->name);
> > > +	if (!name)
> > > +		return -ENOMEM;
> > 
> > Please always test your code before sending it out.  You just leaked a
> > bunch of stuff here :(
> 
> Thanks for the review!
> 
> I can not see what leak you're referring to. Could you please clarify?

At a quick glance, tcpci_register_port() is called earlier in the
function, but when you error out here you did not call
tcpci_unregister_port().  What else needs to also be unwound?

thanks,

greg k-h

