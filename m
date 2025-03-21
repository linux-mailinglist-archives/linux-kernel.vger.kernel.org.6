Return-Path: <linux-kernel+bounces-570828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F05A6B517
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEAB1B60449
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0D41EEA5A;
	Fri, 21 Mar 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxLfznHG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F333F6;
	Fri, 21 Mar 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542138; cv=none; b=mK/fnnTUsUtkDNYSql+7aHlSKzzZBtCcAimHGj7dhS744kdeeC9Z+AuXMp9rkMaGoJPsTp96ib+YUEEP2XsIMKx8QYxOUonh3/B433JM1EOzIt+1zgcT+ROPHdD/ksKci4BgJx0VVIIN2hYLvE3dSBDIG9Wf70TjTHcwEhiFxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542138; c=relaxed/simple;
	bh=YHRnSxFCweEr4pJ3QOh++GXoMY1kQwWeFi8Ywp231uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQcYxxeGN+9J54LAoPlJWVO4JGEBw/WD50kv2+VQvM6Zy8UcN1WR99O+WZNudJSwuJanlMyw/6TtSjYt5I0rjmryDNvIkh+XPchFPB12IMaKp7yp81KwdogAsLqxTObCVJ0JNrHToYcq1p1ZSOmflfcbvOd5IPLcZCd3p89YHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxLfznHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8392CC4CEE3;
	Fri, 21 Mar 2025 07:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742542137;
	bh=YHRnSxFCweEr4pJ3QOh++GXoMY1kQwWeFi8Ywp231uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HxLfznHGc07s3z+OtUpP3rZ3HKiX5pPKn3nydJ1yUR3sXnetwkQBdrIjw7PropiXx
	 ccAp1+nSzlLLQm24o47aPJrnjbEWuR7CaeCiqqvQBqHLvpN6/OXWtXGWew2e3c22vT
	 mqmZWlfJFORWwKeqF9YilQzQUtg/LH5vot+ZhFJm6TlIxTQ+jnVFlTYz34azg2IhMU
	 XCgS0OHSHMeP6ju/EGpfGn0u0u/dxcOYO9eAS/mggco4DCw/rtlSK4ZXPNPZLg3TZL
	 KwH3RxN9lXxZ6dgEaLENwaJAp1P2NHTb8TmCe2nGWrfCkyHdhahbuTySLExgjbQi24
	 8IC1Jyop0ivhQ==
Date: Fri, 21 Mar 2025 07:28:52 +0000
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] mfd: rohm-bd96801: Add chip info
Message-ID: <20250321072852.GC1750245@google.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
 <fd445f9cbbdaa3fd5d7a9e59093f86e5ff7139b1.1741864404.git.mazziesaccount@gmail.com>
 <20250320165220.GB1750245@google.com>
 <e1e83290-64a8-4f06-b00f-d9fa8774a421@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1e83290-64a8-4f06-b00f-d9fa8774a421@gmail.com>

On Fri, 21 Mar 2025, Matti Vaittinen wrote:

> On 20/03/2025 18:52, Lee Jones wrote:
> > On Thu, 13 Mar 2025, Matti Vaittinen wrote:
> > 
> > > Prepare for adding support for BD96802 which is very similar to BD96801.
> > > Separate chip specific data into own structure which can be picked to be
> > > used by the device-tree.
> > > 
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > ---
> > >   drivers/mfd/rohm-bd96801.c | 83 ++++++++++++++++++++++++++------------
> > >   1 file changed, 57 insertions(+), 26 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
> > > index 60ec8db790a7..1232f571e4b1 100644
> > > --- a/drivers/mfd/rohm-bd96801.c
> > > +++ b/drivers/mfd/rohm-bd96801.c
> > > @@ -40,7 +40,21 @@
> > >   #include <linux/mfd/rohm-bd96801.h>
> > >   #include <linux/mfd/rohm-generic.h>
> > > -static const struct resource regulator_errb_irqs[] = {
> > > +struct bd968xx_chip_data {
> > > +	const struct resource *errb_irqs;
> > > +	const struct resource *intb_irqs;
> > > +	int num_errb_irqs;
> > > +	int num_intb_irqs;
> > > +	const struct regmap_irq_chip *errb_irq_chip;
> > > +	const struct regmap_irq_chip *intb_irq_chip;
> > > +	const struct regmap_config *regmap_config;
> > > +	struct mfd_cell *cells;
> > 
> > We're not passing MFD data through OF to be fed back through MFD APIs.
> > 
> > It's generally considered better to device_get_match_data() on an enum,
> > then populate MFD cells using that as a differentiator.
> 
> Or, at least someone has done this at the beginning and it got copied all
> over the place, right? ;) Sometimes we just need to challenge the status quo
> to develop ;)

This is not one of those times.

I've never allowed mixing platform init strategies (arch-plat, OF, ACPI, MFD).

> I can go back to enum + switch - case in probe, and pick the correct data
> there. Done that before as well. It's just that during my journey to some
> other subsystems, I've realized people can often just skip the enum and
> switch - case, making things a tad simpler :)
> 
> Well, not a big deal to me. I suppose it has some value to keep things
> consistent inside a subsystem - and I'm not offering to drop the switch
> cases from all of the drivers :p
> 
> TL; DR - Ok.
> 
> >    git grep compatible -- drivers/mfd | grep data
> > 
> > > +	int num_cells;
> > > +	int unlock_reg;
> > > +	int unlock_val;
> > > +};
> > > +
> > > +static const struct resource bd96801_reg_errb_irqs[] = {
> > >   	DEFINE_RES_IRQ_NAMED(BD96801_OTP_ERR_STAT, "bd96801-otp-err"),
> > >   	DEFINE_RES_IRQ_NAMED(BD96801_DBIST_ERR_STAT, "bd96801-dbist-err"),
> > >   	DEFINE_RES_IRQ_NAMED(BD96801_EEP_ERR_STAT, "bd96801-eep-err"),
> > > @@ -98,7 +112,7 @@ static const struct resource regulator_errb_irqs[] = {
> > >   	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_SHDN_ERR_STAT, "bd96801-ldo7-shdn-err"),
> > >   };
> > > -static const struct resource regulator_intb_irqs[] = {
> > > +static const struct resource bd96801_reg_intb_irqs[] = {
> > >   	DEFINE_RES_IRQ_NAMED(BD96801_TW_STAT, "bd96801-core-thermal"),
> > >   	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPH_STAT, "bd96801-buck1-overcurr-h"),
> > > @@ -345,18 +359,37 @@ static const struct regmap_config bd96801_regmap_config = {
> > >   	.cache_type = REGCACHE_MAPLE,
> > >   };
> > > +static const struct bd968xx_chip_data bd96801_chip_data = {
> > 
> > Just call it 'struct bd968xx' then below instead of cd, use ddata.
> > 
> >    git grep "cc =" -- drivers/mfd
> > 
> > VS
> > 
> >    git grep "ddata =" -- drivers/mfd
> > 
> > Conforrrrrrmmm ...    =;-)
> 
> I've lived through the depression of the early 90's in Finland. Learned how
> to avoid wasting things - especially letters. Wouldn't guess when reading my
> review replies, right?
> 
> ...Ok.
> 
> Thanks for the review :) Much appreciated.

NP

-- 
Lee Jones [李琼斯]

