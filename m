Return-Path: <linux-kernel+bounces-350792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC719909BE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A0BB21ADB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6261CACED;
	Fri,  4 Oct 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j5dAmvSe"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B80481CE;
	Fri,  4 Oct 2024 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060922; cv=none; b=JxMIIOzszQg1dwpo0f/krem6vRJpPsSIyE8ejOPMHEIGhhZcc101s7FCROxMe4vlCw07+FB2VixOXatgNOz+gZ9hqkPDEfmRW64kUB4kFnPiwqLrJOkG8NeI+7Er7Pa6+lVpSthJK5dmwrTvdj+Egv8WC5e+GoROfykD2TLm8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060922; c=relaxed/simple;
	bh=2N8Az+6adF+E6pdBqPy0YObeupcf83vhXWtkovYhiN4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=qQCmkLP8R6UHmQzvS2iqOY/O+TaVYjXcJo5Dej/lFHqa+Ih33zJvbvn/Xr8BrGdQvd7/Zp/0PKj+WZ0WIYB911OXrgEmX7G+UYmlx2J40fO0zjBexNDLOE6PNJQ6dkDiLuL4RaV/vVhtnj/C5HFQ9aqsSDMc+2itsRBr7TgYrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j5dAmvSe; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2F96240007;
	Fri,  4 Oct 2024 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728060916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UaVOGZXc77/9zjUtLUSwZwPDWMsz2YXg6qf1K6eg9E=;
	b=j5dAmvSertzXppJtGp+wTsEyHhoGVeVB9FlTbh+Xocdih7vUY6x0JPSF67Lxg9JLQEXPJG
	7IkKvJl5CXtZQzZqU0XALys1xRNRNMqPk82aOo6ZzIHkOI6xC0fZsHwu8j8y5IWW3K/71K
	FpbvfHVu76IGp2waucfTkcMliMCenah9SO/OWWG3ossV+tHro6lHsAo7JuF56CGZnkvomN
	hpWruVvE9UQPENX3z09Wuuaos1+/l0tU/ulz2EBJt+XggpifalLQUtvMazQV15g+YM0ZLW
	EH1EkeUrVTpPotpbprJQvPEVQsIST0rzaxxKOldKs/oabVTWm0XbQk3W+70rlw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Oct 2024 18:55:15 +0200
Message-Id: <D4N6GX6P0ZCH.2PJGDMKEZ6LLQ@bootlin.com>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 4/4] clk: eyeq: add driver
Cc: <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241004-mbly-clk-v4-0-c72c2e348e1f@bootlin.com>
 <20241004-mbly-clk-v4-4-c72c2e348e1f@bootlin.com>
 <75884d07-f052-435d-9f1a-44e9e0bb755f@wanadoo.fr>
In-Reply-To: <75884d07-f052-435d-9f1a-44e9e0bb755f@wanadoo.fr>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Christophe,

On Fri Oct 4, 2024 at 6:34 PM CEST, Christophe JAILLET wrote:
> Le 04/10/2024 =C3=A0 17:45, Th=C3=A9o Lebrun a =C3=A9crit=C2=A0:
> > +static void eqc_probe_init_plls(struct device *dev, struct eqc_priv *p=
riv)
> > +{
> > +	const struct eqc_match_data *data =3D priv->data;
> > +	unsigned long mult, div, acc;
> > +	const struct eqc_pll *pll;
> > +	struct clk_hw *hw;
> > +	unsigned int i;
> > +	u32 r0, r1;
> > +	u64 val;
> > +	int ret;
> > +
> > +	for (i =3D 0; i < data->pll_count; i++) {
> > +		pll =3D &data->plls[i];
> > +
> > +		val =3D readq(priv->base + pll->reg64);
> > +		r0 =3D val;
> > +		r1 =3D val >> 32;
> > +
> > +		ret =3D eqc_pll_parse_registers(r0, r1, &mult, &div, &acc);
> > +		if (ret) {
> > +			dev_warn(dev, "failed parsing state of %s\n", pll->name);
> > +			priv->cells->hws[pll->index] =3D ERR_PTR(ret);
> > +			continue;
> > +		}
> > +
> > +		hw =3D clk_hw_register_fixed_factor_with_accuracy_fwname(dev,
> > +				dev->of_node, pll->name, "ref", 0, mult, div, acc);
>
> Should this be freed somewhere or is it auto-magically freed by a=20
> put_something()?
> Maybe devm_action_or_reset()?

This driver does not support being removed. It provides essential PLLs
and the system has not chance of working without them.

Almost all instances will be instantiated at of_clk_init() stage by the
way (ie before platform bus infrastructure init). Devres isn't a
solution in those cases.

We are missing suppress_bind_attrs though.
I can add that at next revision.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


