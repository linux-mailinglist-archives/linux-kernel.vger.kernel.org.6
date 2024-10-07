Return-Path: <linux-kernel+bounces-353450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF92E992DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA771F23F09
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ADF1D54EE;
	Mon,  7 Oct 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JkSYhg2Q"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5F1D4618;
	Mon,  7 Oct 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309378; cv=none; b=dkYU6o5jQ0usLV+7E5JsPTmEUEfnYJrs7B8v/A3GXAM4N9PTmhlcz6oeUnobf51a6XmoHWaF7RsM2Dsf25msGY6o+2WjenG0XFje4X+Rfeof0/77cgp1JL6CVFSH6Vl48nLi4ycDFuATCJWZycPkQKYYLiay9KAssY7TmUxo3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309378; c=relaxed/simple;
	bh=3DWa82qDFPSleOr4UGlJjFaPWyy2oBAJIzcdCVQzIwg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JeMSjsITMFffuBJBqJFXmHT0r5+ee7Oj3XUj8ZshbWxqrs0wzEcf23GMLld/ksAezp5Q0FSQ7txBGnQxvTKsWFOA9wdzmNRZJLDVllpGX1IuyXMM7PAQeo98Dps85QBwbTPLXzguj1U9kAFAkSK1eqJHuux9KiY1xBTmljlNaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JkSYhg2Q; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C34B41C0003;
	Mon,  7 Oct 2024 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728309375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTBCMTyNc51WfzJG+muqvC+lkyLv4Qj65h0etwEqxXY=;
	b=JkSYhg2QWctq84CBBKk9V5tAc9GlPlmUfysTRacIpJZ0u98rmp67RIt55bPKNJqMDzG1Uk
	oEDnN1XEFVoRb+MsXtpyoMvk3b7esn1NVBoM+UXXUJ3udkj54TNyNRMNAVTwLrDwurDLFO
	w6fOvsbRCE4wkHK4RJPyP/TIsUwqmAJYmz9foMopa81nZxfCBmVjDcUI2JXJ5TL4D7SNob
	eGFSCEFyVu8WsLZoUsR9u3fwZew0mJOiTP/Kf9RN8AfdeOCHHUsWg/YKCt5jb75jrxkmCd
	6fb9DzNKTgYlo030rnHlQaOOSlU28yw46wgfvhJdoOZOkVP/53KBPxFhDONFPg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Oct 2024 15:56:14 +0200
Message-Id: <D4PMJHMDRCCJ.HPOLK6JF49DO@bootlin.com>
Subject: Re: [PATCH v4 4/4] clk: eyeq: add driver
Cc: <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241004-mbly-clk-v4-0-c72c2e348e1f@bootlin.com>
 <20241004-mbly-clk-v4-4-c72c2e348e1f@bootlin.com>
 <75884d07-f052-435d-9f1a-44e9e0bb755f@wanadoo.fr>
 <D4N6GX6P0ZCH.2PJGDMKEZ6LLQ@bootlin.com>
 <8334a319-96e4-4249-9659-132c8698c895@wanadoo.fr>
In-Reply-To: <8334a319-96e4-4249-9659-132c8698c895@wanadoo.fr>
X-GND-Sasl: theo.lebrun@bootlin.com

On Fri Oct 4, 2024 at 11:20 PM CEST, Christophe JAILLET wrote:
> Le 04/10/2024 =C3=A0 18:55, Th=C3=A9o Lebrun a =C3=A9crit=C2=A0:
> > On Fri Oct 4, 2024 at 6:34 PM CEST, Christophe JAILLET wrote:
> >> Le 04/10/2024 =C3=A0 17:45, Th=C3=A9o Lebrun a =C3=A9crit=C2=A0:
> >>> +static void eqc_probe_init_plls(struct device *dev, struct eqc_priv =
*priv)
> >>> +{
> >>> +	const struct eqc_match_data *data =3D priv->data;
> >>> +	unsigned long mult, div, acc;
> >>> +	const struct eqc_pll *pll;
> >>> +	struct clk_hw *hw;
> >>> +	unsigned int i;
> >>> +	u32 r0, r1;
> >>> +	u64 val;
> >>> +	int ret;
> >>> +
> >>> +	for (i =3D 0; i < data->pll_count; i++) {
> >>> +		pll =3D &data->plls[i];
> >>> +
> >>> +		val =3D readq(priv->base + pll->reg64);
> >>> +		r0 =3D val;
> >>> +		r1 =3D val >> 32;
> >>> +
> >>> +		ret =3D eqc_pll_parse_registers(r0, r1, &mult, &div, &acc);
> >>> +		if (ret) {
> >>> +			dev_warn(dev, "failed parsing state of %s\n", pll->name);
> >>> +			priv->cells->hws[pll->index] =3D ERR_PTR(ret);
> >>> +			continue;
> >>> +		}
> >>> +
> >>> +		hw =3D clk_hw_register_fixed_factor_with_accuracy_fwname(dev,
> >>> +				dev->of_node, pll->name, "ref", 0, mult, div, acc);
> >>
> >> Should this be freed somewhere or is it auto-magically freed by a
> >> put_something()?
> >> Maybe devm_action_or_reset()?
> >=20
> > This driver does not support being removed. It provides essential PLLs
> > and the system has not chance of working without them.
> >=20
> > Almost all instances will be instantiated at of_clk_init() stage by the
> > way (ie before platform bus infrastructure init). Devres isn't a
> > solution in those cases.
>
> eqc_probe_init_plls() and eqc_probe_init_divs() are called from=20
> eqc_probe(), which has several devm_ function calls.
>
> Would it make sense to remove these devm_ ?
>
>
> devm_platform_ioremap_resource(),
> devm_kzalloc(),
> devm_of_clk_add_hw_provider(),
> eqc_auxdev_create() which calls devm_add_action_or_reset().
>
> I sent this patch because of these calls.
>
> Either I miss something, either maybe things can be simplified.

You are right, mixing devres and non-devres handled resources was a
mistake. Things have been simplified in revision v5 [0]. It sets
suppress_bind_attrs to true and switches to 100% non-devres calls.

[0]: https://lore.kernel.org/lkml/20241007-mbly-clk-v5-0-e9d8994269cb@bootl=
in.com/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


