Return-Path: <linux-kernel+bounces-521331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E701A3BBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C390175973
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52851DE3BB;
	Wed, 19 Feb 2025 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="W0PukoyZ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85C2F41;
	Wed, 19 Feb 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961202; cv=none; b=jEW5lJywCHFQwHr/lrWK2IsuCQHoF5zgF0fyFEdBwjHLH8UeUBL1qOAJMKoQrDgesjsGrNkBTBKGwKC7uNl5/gp+qWe+Jcxw6du3rfLLcE969o06keeNiFpowIvCLz4y1weVJLoudnfNJ0ZnF/R79no0+drN8L0URKuiFexxiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961202; c=relaxed/simple;
	bh=e/jBCLCEMXLt2zyHShTUYjUTd+F+cErCr2KyPu1I/Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt5b6GuzBVF0CsXAl79NwHXQMA5mjdy1DqN4oHom7HAyaOwbLkkXHH4PQ/LUxeQGfwKJaAZIIfG3X12FuT7bJ70NdVrzCJCRyxIG1ck0ZZk8JV3XblpPdzqfmn1diylF7szDofM43pzNJL8LFbS4D7ar4iZWMJX9TcMz/c6fiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=W0PukoyZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 1ECAC1FA98;
	Wed, 19 Feb 2025 11:33:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1739961195;
	bh=BPELQkHLLDnKGOkHJi+6/rCSbKkXPkV56KASAKI3mjs=; h=From:To:Subject;
	b=W0PukoyZU+5Ia2v5WSdcRAjlfWkwMUAnZJc1DqtOeS5jDMTEi/M9oIoNLRgyxRbd0
	 ZwqkxEdJtSNxto3GS8vx9DCTQIiIUBwX5gNj3ufdnUj1gzD8tigMyAwtY71o0tpnkt
	 VFQ1err5mU5IRMXCuQZELvkIP2UdzlZhD62Les9Em7rMYdGBb93nBCtUhc7HkOu+UU
	 1844H7YmRQJ7q48rxwy4UQSau9KCybTzvQ4pUaZE1nGWPJTUyDJY/T30Xiu7sk5IZm
	 Q4lcCI59ySw/H9pT0CfN7ccZ2bEPjPNMYOibrhqwCrEl01RLyfw6OyOvkXQ5B3/ZjZ
	 UgyTxUn+F5KRg==
Date: Wed, 19 Feb 2025 11:33:07 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] hwmon: (amc6821) Add PWM polarity configuration
 with OF
Message-ID: <20250219103307.GA22470@francesco-nb>
References: <20250218165633.106867-1-francesco@dolcini.it>
 <20250218165633.106867-3-francesco@dolcini.it>
 <eb5c844a-e726-44c0-a0c1-7796d1a28ec3@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb5c844a-e726-44c0-a0c1-7796d1a28ec3@cherry.de>

Hello Quentin,

On Wed, Feb 19, 2025 at 11:08:43AM +0100, Quentin Schulz wrote:
> On 2/18/25 5:56 PM, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Add support to configure the PWM-Out pin polarity based on a device
> > tree property.
> > 
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >   drivers/hwmon/amc6821.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> > index 1e3c6acd8974..1ea2d97eebca 100644
> > --- a/drivers/hwmon/amc6821.c
> > +++ b/drivers/hwmon/amc6821.c
> > @@ -845,7 +845,7 @@ static int amc6821_detect(struct i2c_client *client, struct i2c_board_info *info
> >   	return 0;
> >   }
> > -static int amc6821_init_client(struct amc6821_data *data)
> > +static int amc6821_init_client(struct i2c_client *client, struct amc6821_data *data)
> >   {
> >   	struct regmap *regmap = data->regmap;
> >   	int err;
> > @@ -864,6 +864,9 @@ static int amc6821_init_client(struct amc6821_data *data)
> >   		if (err)
> >   			return err;
> > +		if (of_property_read_bool(client->dev.of_node, "ti,pwm-inverted"))
> 
> I know that the AMC6821 is doing a lot of smart things, but this really
> tickled me. PWM controllers actually do support that already via
> PWM_POLARITY_INVERTED flag for example. See
> Documentation/devicetree/bindings/hwmon/adt7475.yaml which seems to be
> another HWMON driver which acts as a PWM controller. I'm not sure this is
> relevant, applicable or desired but I wanted to highlight this.

From the DT binding point of view, it seems to implement the same I am
proposing here with adi,pwm-active-state property.

Do you have anything more specific in mind?

> 
> > +			pwminv = 1;
> > +
> 
> This is silently overriding the module parameter.
> 
> I don't think this is a good idea, at the very least not silently.

I was thinking at the same, and in the end I do have proposed this
solution in any case.

Let's look at the 2 use cases in which the DT property and the module
parameter are different.

## 1

module parameter pwminv=0
ti,pwm-inverted DT property present

=> we enable the PWM inversion

I think this is fair, if someone has a DT based system we need to assume
that the DT is correct. This is a HW configuration, not a module
parameter.

## 2

module parameter pwminv=1
ti,pwm-inverted DT property absent

=> we enable the PWM inversion

In this case the module parameter is overriding the DT. It means that
someone explicitly set pwminv=1 module parameter. I think is fair to
fulfill the module parameter request in this case, overriding the DT

> I would suggest to add some logic in the probe function to set this value
> and check its consistency.

With that said I can implement something around the lines you proposed,
if you still think is worth doing it. I would personally just keep the
priority on the module parameter over the DT and add an info print on what
is actually configured by the driver (not checking if they are
different).
	
Or I can just add a dev_info() telling the user about the actual PWM
polarity used, making this more transparent, without changing the logic
proposed here.

Francesco


