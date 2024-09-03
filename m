Return-Path: <linux-kernel+bounces-313140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A3796A0CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899C71F21E74
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B40153BD9;
	Tue,  3 Sep 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb9vqPz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260ED1537A4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374243; cv=none; b=YShgrP9eqGAgLIe35jjUFD+IkKBeJQZCpBam/7SL/cgOXQuEsJeRJSnDzyrg8Lf84DIdD2O+7sjl0TAf81maKiqhj/UTyByXz95Jl5NI4edjYmnciSDoWhOmUPXNj64wstNf2jaWto0VjkYyppOZu1/VvMNI553E7uiqZOudd+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374243; c=relaxed/simple;
	bh=Ky1kfxpqkYZU9W4lnttu7s9ET1ebaacJPEO9AEO3ltM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KllrUMOCgfKWIQviY+Nr5syaDsZnqzODVQKxqm/FFksN6XWqkYOnQUC83krN8VwxmHg2CTP2DqDp0X9DXz6mMXk6PZrzZpafYekFxCgY/sRyNwJCPisAWzo1AbqewMNmttw2CrNcG4AaDQLxDPUQH+YIKdvyQq80M3SwstMRRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb9vqPz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08DAC4AF09;
	Tue,  3 Sep 2024 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725374242;
	bh=Ky1kfxpqkYZU9W4lnttu7s9ET1ebaacJPEO9AEO3ltM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fb9vqPz3y+tVC6zu+tPXvEU9dHd3ZyaCdbEEcT923JGZd/Nwx8hJuWlmhBmcatPxb
	 Uq7WCVo0NDZ9w3cMQUVhzkNhsPXcViov7hufvV8x9uyPCPYT0EWgBf7uxtmKbONFbE
	 Yk+JUgpJnPbxUaIpDiOCG0yGuQEh7yQ0OuYKY+WkNdUU9SRKDpaT6fxTD0Nc84QPk0
	 kWwLs8P0HjO+cjwKEtSNMOs3Pp2WHDKtDzPSqUEkyqD3ImAspEtf6OUR35FHjjUB6z
	 0B93IPkcoKskgTj/QtPtvmo8UZStK4j6cnHbHVZzCqgLUOGSa35dEyuVN1g1XScIM1
	 JuBu0HezZIMtw==
Date: Tue, 3 Sep 2024 15:37:18 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: bd96801: Add ERRB IRQ
Message-ID: <20240903143718.GX6858@google.com>
References: <cover.1724655894.git.mazziesaccount@gmail.com>
 <05b576f3eef81a21cb9b4bcebee4873b7aafb4af.1724655894.git.mazziesaccount@gmail.com>
 <20240830072822.GS6858@google.com>
 <dbdfbcd1-3f18-4ca5-9d4c-3c35bb3dee48@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbdfbcd1-3f18-4ca5-9d4c-3c35bb3dee48@gmail.com>

On Fri, 30 Aug 2024, Matti Vaittinen wrote:

> On 8/30/24 10:28, Lee Jones wrote:
> > On Mon, 26 Aug 2024, Matti Vaittinen wrote:
> > 
> > > The ROHM BD96801 "scalable PMIC" provides two physical IRQs. The ERRB
> > > handling can in many cases be omitted because it is used to inform fatal
> > > IRQs, which usually kill the power from the SOC.
> > > 
> > > There may however be use-cases where the SOC has a 'back-up' emergency
> > > power source which allows some very short time of operation to try to
> > > gracefully shut down sensitive hardware. Furthermore, it is possible the
> > > processor controlling the PMIC is not powered by the PMIC. In such cases
> > > handling the ERRB IRQs may be beneficial.
> > > 
> > > Add support for ERRB IRQs.
> 
> Thanks for the review Lee! :)
> 
> > > 
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > ---
> > > Revision history:
> > > New series (only ERRB addition)
> > > v1:
> > > 	- use devm allocation for regulator_res
> > > 	- use goto skip_errb instead of an if (errb)
> > > 	- constify immutable structs
> > > 
> > > Old series (All BD96801 functionality + irqdomain and regmap changes)
> > > v2 => v3:
> > > 	- No changes
> > > v1 => v2:
> > > 	- New patch
> > > 
> > > mfd: constify structs
> > > ---
> > >   static int bd96801_i2c_probe(struct i2c_client *i2c)
> > >   {
> > > -	struct regmap_irq_chip_data *intb_irq_data;
> > > +	int i, ret, intb_irq, errb_irq, num_regu_irqs, num_intb, num_errb = 0;
> > > +	int wdg_irq_no;
> > 
> > Nit: Not sure why the smaller data elements have been placed at the top.
> 
> Because some people have told me it's easier for them to read the local
> variable declarations when the code is formatted to "reverse xmas-tree"
> -style. I suppose I've tried to follow that here.
> 
> > They were better down where they were.
> 
> My old personal preference has just been to have 'simple' integer types
> first, then structs, and the pointers last. I don't think having xmas-tree
> (reversed or not) plays a role in my code-reading ability...
> 
> I won't re-spin the series just for this, if this is just a 'nit'. I will
> try to remember the comment if I need to rebase / respin this later though
> :)

Please leave them were they are.

> > > +	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
> > > +	struct irq_domain *intb_domain, *errb_domain;
> > > +	struct resource wdg_irq;
> > >   	const struct fwnode_handle *fwnode;
> > > -	struct irq_domain *intb_domain;
> > > +	struct resource *regulator_res;
> > >   	struct regmap *regmap;
> > > -	int ret, intb_irq;
> > >   	fwnode = dev_fwnode(&i2c->dev);
> > >   	if (!fwnode)
> > > @@ -213,6 +364,23 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
> > >   	if (intb_irq < 0)
> > >   		return dev_err_probe(&i2c->dev, intb_irq, "INTB IRQ not configured\n");
> > > +	num_intb =  ARRAY_SIZE(regulator_intb_irqs);
> > > +
> > > +	/* ERRB may be omitted if processor is powered by the PMIC */
> > > +	errb_irq = fwnode_irq_get_byname(fwnode, "errb");
> > > +	if (errb_irq < 0)
> > > +		errb_irq = 0;
> > > +
> > > +	if (errb_irq)
> > > +		num_errb = ARRAY_SIZE(regulator_errb_irqs);
> > > +
> > > +	num_regu_irqs = num_intb + num_errb;
> > > +
> > > +	regulator_res = devm_kcalloc(&i2c->dev, num_regu_irqs,
> > > +				     sizeof(*regulator_res), GFP_KERNEL);
> > > +	if (!regulator_res)
> > > +		return -ENOMEM;
> > > +
> > >   	regmap = devm_regmap_init_i2c(i2c, &bd96801_regmap_config);
> > >   	if (IS_ERR(regmap))
> > >   		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
> > > @@ -226,16 +394,54 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
> > >   				       IRQF_ONESHOT, 0, &bd96801_irq_chip_intb,
> > >   				       &intb_irq_data);
> > >   	if (ret)
> > > -		return dev_err_probe(&i2c->dev, ret, "Failed to add INTB IRQ chip\n");
> > > +		return dev_err_probe(&i2c->dev, ret, "Failed to add INTB irq_chip\n");

Kernel logs are user facing.  The previous message was better.

Please drop this change.

> > >   	intb_domain = regmap_irq_get_domain(intb_irq_data);
> > > -	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > > -				   bd96801_cells,
> > > -				   ARRAY_SIZE(bd96801_cells), NULL, 0,
> > > -				   intb_domain);
> > > +	/*
> > > +	 * MFD core code is built to handle only one IRQ domain. BD96801
> > > +	 * has two domains so we do IRQ mapping here and provide the
> > > +	 * already mapped IRQ numbers to sub-devices.
> > > +	 */
> > 
> > Do one or more of the subdevices consume both domains?
> 
> I believe the regulators consume both.
> 
> > If not, why not call devm_mfd_add_devices() twice?
> 
> Thanks for this suggestion :) It didn't occur to me I could do that. Well,
> here I need both domains for regulators so it probably wouldn't work - but
> maybe I will remember this is a viable option for future designs! Thanks!

That's a shame.  This all looks quite messy.

-- 
Lee Jones [李琼斯]

