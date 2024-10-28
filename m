Return-Path: <linux-kernel+bounces-386010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599949B3E09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CEC282E96
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF07F1EF92A;
	Mon, 28 Oct 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga38WuB1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3418C02D;
	Mon, 28 Oct 2024 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155964; cv=none; b=en6PhBy2NUrB4TZqlO6NStuDDTUBmxwE6ELzwoJCIIA30P56yq4BvdYbv9zZji82lmUbPckawy4RTdXnFHX2GZSgU/7ef3o093PH+zjIQ4vhifvETzHjtOUixrUlaZy81bztVhUg4XWPTLW7U5EzHGoS46NWBoveH9D6NmKQMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155964; c=relaxed/simple;
	bh=gKFMj3KX2UlE+Cgln5pGvRLJNvEuq2h0wTRF7c/U6bQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kLqF4YK5fMwJqX8jGZrHzxaUXbhGCkXYibBizenZWVi9OIGSHE28P1vhrcQ15vJiJKGWZpyg/iAawXklBagzCbU3BiTQTieS/fvCoLTd7ZiFfGtMPoz3JjXBggr2rm6MOPAQ0RkTDMGO2NH8AIIWiOFLu7YQJ8PR+GhQnvn0R1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga38WuB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872F9C4CEC3;
	Mon, 28 Oct 2024 22:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730155963;
	bh=gKFMj3KX2UlE+Cgln5pGvRLJNvEuq2h0wTRF7c/U6bQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ga38WuB1tGWrTc1iRNIDtC59eunPY3eh40a37hKV0SJ1jo0RB7+SLKwQSVUZcOC9d
	 QGtol2JSEmdCfxia9ud9/GXxwE3iW6gnwLQVqZuVMZ9vNMiqrfFl10455sTJEnbPkP
	 FaCJs0Ht53W6IUdPe1E3sfUG2L1jwDn6F3ukKyvrtNvyc6wxunVstxyf4xPpNRgS9d
	 HR3COKfkIa4knAdslfyOSqx3iYDop1UE4HcDK76Ear/r1sGWNuSAZdEYsO7o1LgJye
	 oiUOG62YXmVtz+Dy1HgME8Eu1iudZMTwtblHTeLnzRlGM5X6KA099xD8Y/VD0Zmt+i
	 QVhfePpnaHYHw==
Message-ID: <39b99c310a307d97955ec6f9335c0439.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D541S8TMBS94.3AKP8ET4TID6Y@bootlin.com>
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com> <20241007-mbly-clk-v5-4-e9d8994269cb@bootlin.com> <b3f8bf0e933064a49d1a5e3527646200.sboyd@kernel.org> <D534ZSNLN6G0.3HSREQ803OFIQ@bootlin.com> <02cbfefaf7db9220652c2f9605838f96.sboyd@kernel.org> <D541S8TMBS94.3AKP8ET4TID6Y@bootlin.com>
Subject: Re: [PATCH v5 4/4] clk: eyeq: add driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Mon, 28 Oct 2024 15:52:41 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-10-24 05:50:16)
> The bug is elsewhere: we do get valid clocks from PL011. Both clk_get()
> calls give proper pointers.
>=20
> The issue is that we are using `compatible =3D "fixed-factor-clock"`
> clocks in the middle, and those don't wait for their parents to be
> active.
>=20
> Simplified clock graph is: pll-per -> occ-periph.
> pll-per is register by our driver. occ-periph looks like:
>=20
>         occ_periph: occ-periph {
>                 compatible =3D "fixed-factor-clock";
>                 clocks =3D <&olb EQ5C_PLL_PER>;
>                 #clock-cells =3D <0>;
>                 clock-div =3D <16>;
>                 clock-mult =3D <1>;
>         };

Why is this fixed factor clk registered from DT vs. from the driver that
registers pll-per? Is it useful to describe it in DT because the factor
can change? Where does it physically exist? In the SoC?

>=20
> Sequence is:
>  - eqc_early_init(): it registers a clock provider that will return
>    EPROBE_DEFER for our pll-per.
>  - _of_fixed_factor_clk_setup(): it registers occ-periph, even though
>    its parent is EPROBE_DEFER. clk_core_populate_parent_map() runs all
>    fine without complaining; logical as it doesn't query the clk_hw for
>    its parent, it only stores indexes.
>  - amba_get_enable_pclk(): it does a clk_get() which works because
>    occ-periph exists.
>=20
> Maybe __clk_register() should check the clk_hw for each parent: if any
> is an EPROBE_DEFER then it should EPROBE_DEFER itself? That looks like
> a rather big behavioral change.
>=20
> The other solution is to keep as-is: provide all clocks consumed by
> fixed-factor-clocks at of_clk_init() stage.

Another solution is to register the fixed factor clk from the pll-per
clk provider.

And yet another solution is to return EPROBE_DEFER for orphaned clks. We
have everything in place for that but we ran into trouble with consumers
wanting to get orphaned clks in their probe or during assigned-clocks
handling.

