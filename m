Return-Path: <linux-kernel+bounces-522006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C18CA3C4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB4D189BCEA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1D1FECAC;
	Wed, 19 Feb 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="U5jUlKZE"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420CE1DFE22;
	Wed, 19 Feb 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982022; cv=none; b=Hd9XrOdKXpbUi6WuNLSkKO8zLIJEeaG4Dm8yP6EsRGFc1j8L4r7+GYIB7WpBfIGlBJP1GPe5lt8+5qDE+oxHDhGRzpd/WmZBfRN2YVyCoFWFDHmMqjDzlTPsqpBMXYN1iaygq2ipWTYcjAposoJu1dHx/Jy8ZZYSp8E7Li5j67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982022; c=relaxed/simple;
	bh=+0LOcYm6fSsPFqHx1s95FCUsSr75f1CKB2mKlq8PkVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgkmeSM+F4I9IT3puZHGe0fl9GKNAyPCH4iZa1LYXn9KLeBAkIQJdGInIdXwym35h+PyrACbjqKYMAKy8xhEPyYHd0DxxMCkyJof+F23Dey+jD/X1alLRmKJ1nBFCdNzadNvSJNTJ40fapSyoxS0o3KLuCXF9n8WxdpPYXLCad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=U5jUlKZE; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id ECFF01F996;
	Wed, 19 Feb 2025 17:20:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1739982018;
	bh=+RCWGqzFDgmd2FwOpznRu+lUDieVK6vkZsF0gYl+7kY=; h=From:To:Subject;
	b=U5jUlKZEBU7blMI+/7EODl7BL/0W3hM9eLGgtBaXrBQYbC6w12J7Q7zUvu7ajqkt9
	 HqIwFuQKIZ2Tabn3Za/mrbxoalkPEUHm71qXkPKEI518LSAMg1b0GzufY8wQ6XClSE
	 wqwDSh7F/fCsxqdjcl/yAKb4ZCx/9km77jr7mhkY4W4RK87eo5JmzWVAC15K+3zM3/
	 Ip2ltv0eaBs/go/TlcXwREYuar0FjSxb8aom9Ok0oudmANqUeaxYGmHtimRfuZ0y7P
	 N/PGNZdAqeCunavB/qAckqTQP4YYl6MSvTqzMwcG6nyrWqgTO6NEAMRp+kWJq+RNbt
	 rzUdwbqbQmGIg==
Date: Wed, 19 Feb 2025 17:20:16 +0100
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
Message-ID: <20250219162016.GC22470@francesco-nb>
References: <20250218165633.106867-1-francesco@dolcini.it>
 <20250218165633.106867-3-francesco@dolcini.it>
 <eb5c844a-e726-44c0-a0c1-7796d1a28ec3@cherry.de>
 <20250219103307.GA22470@francesco-nb>
 <24e8abf9-0bb9-4cbd-857b-0842fc914486@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24e8abf9-0bb9-4cbd-857b-0842fc914486@cherry.de>

Hi Quentin,

On Wed, Feb 19, 2025 at 12:12:24PM +0100, Quentin Schulz wrote:
> On 2/19/25 11:33 AM, Francesco Dolcini wrote:
> > On Wed, Feb 19, 2025 at 11:08:43AM +0100, Quentin Schulz wrote:
> > > On 2/18/25 5:56 PM, Francesco Dolcini wrote:
> > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > 
> > > > Add support to configure the PWM-Out pin polarity based on a device
> > > > tree property.
> > > > 
> > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > >    drivers/hwmon/amc6821.c | 7 +++++--
> > > >    1 file changed, 5 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> > > > index 1e3c6acd8974..1ea2d97eebca 100644
> > > > --- a/drivers/hwmon/amc6821.c
> > > > +++ b/drivers/hwmon/amc6821.c
> > > > @@ -845,7 +845,7 @@ static int amc6821_detect(struct i2c_client *client, struct i2c_board_info *info
> > > >    	return 0;
> > > >    }
> > > > -static int amc6821_init_client(struct amc6821_data *data)
> > > > +static int amc6821_init_client(struct i2c_client *client, struct amc6821_data *data)
> > > >    {
> > > >    	struct regmap *regmap = data->regmap;
> > > >    	int err;
> > > > @@ -864,6 +864,9 @@ static int amc6821_init_client(struct amc6821_data *data)
> > > >    		if (err)
> > > >    			return err;
> > > > +		if (of_property_read_bool(client->dev.of_node, "ti,pwm-inverted"))
> > > 
> > > I know that the AMC6821 is doing a lot of smart things, but this really
> > > tickled me. PWM controllers actually do support that already via
> > > PWM_POLARITY_INVERTED flag for example. See
> > > Documentation/devicetree/bindings/hwmon/adt7475.yaml which seems to be
> > > another HWMON driver which acts as a PWM controller. I'm not sure this is
> > > relevant, applicable or desired but I wanted to highlight this.
> > 
> >  From the DT binding point of view, it seems to implement the same I am
> > proposing here with adi,pwm-active-state property.
> > 
> 
> Ah! It seems like I read only the part that agreed with the idea I had in
> mind :)
> 
> > Do you have anything more specific in mind?
> > 
> 
> Yes, #pwm-cells just below in the binding. You can then see that the third
> cell in a PWM specifier is for the polarity. If I didn't misread once more,
> I believe that what's in adi,pwm-active-state is ignored based on the
> content of the PWM flags in a PWM cell specifier, c.f.
> adt7475_set_pwm_polarity followed by adt7475_fan_pwm_config in
> adt7475_probe. I would have assumed that having the polarity inverted in
> adi,pwm-active-state would mean that the meaning of the flag in the PWM cell
> specifier would be inverted as well, meaning 0 -> inverted,
> PWM_POLARITY_INVERTED -> doubly inverted so "normal" polarity.
> 
> adt7475_fan_pwm_config was added a few years after adt7475_set_pwm_polarity.

I think this is out of scope for this patch. The amc6821 can control the
fan PWM stand-alone, this change has nothing to do with the generic pwm
framework, this is required to have the PWM out pin correctly driven by
the fan controller chip.

> Module params over DT is fine with me, I just want consistency here, so if
> it's always the case, fine :)

Ok, I'll implement it this way.

Francesco


