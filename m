Return-Path: <linux-kernel+bounces-365386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB5399E192
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4919A281BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9531D0B91;
	Tue, 15 Oct 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EmWB4ip4"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62518A6A8;
	Tue, 15 Oct 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982231; cv=none; b=Z+4fqqVXKNyfVrveGMBv/2MiykRTHhqLGMToYQZxB61mH/DKzy3b4Osfq/UdKOp54E+ShWKFiO370vO0dNSyBB0H2oN69uG6ApV0U8keePMbCRKNPhYktremrte/AMU8j8sPysyd4g00eamVWXJo6l6rgqC0624iZnsOW5vKtNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982231; c=relaxed/simple;
	bh=1NQgzWnE3190zr4gxbyrXYFAKHrlKNYxNmEOJhdHd4Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Uj7v1DHwUXduut2RTirItQx0pVuC/mdELJGX6Hcl3U+nBTdQbsI45roz4xThlBv9Mb783azfMlubh7ol96zZuIwSHRi1/SYSwFqxyWh09yEkVgeNA7h9SochN4DokWw8klpTJNpGgXp/NMzasACnfXpGNHI5sMeC9n4NKWbaB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EmWB4ip4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E16A1C0010;
	Tue, 15 Oct 2024 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728982227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xnDRAazvPzZ47xJTR0xO8huRjhANCrx409P3pTb++k=;
	b=EmWB4ip4lODwtZPBuBqTkUndqJ0ebdPh28tB+aZXccgUEd5jOJMQoiYWKsN+rR61Jzbecv
	PDOPK8TrQklixhL4utXeYArWGYJEtqnpf1GvEB6uo26TnrVI6ZdLbDJmwsl1QiGYl9fIe6
	loqbMWI8vic1ta2DuaKJy3jxSU7i7DnncPQC7qGB/CD6Wxbn0w28X+JUpMnyi7Ew3DaHXQ
	JqS6kELA8MTXbeeK7QkxK3uHgV5NkY29rQVd4DCQeD3qaHFP7AwjCsC557TSmkCUuGdQPj
	2ctBBdqdBIrbpclQBfPAvDnksCBOgbE5M8Pj1AOSoKrT2C+3ufSgsU2/t62xCQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Oct 2024 10:50:26 +0200
Message-Id: <D4W91PHV3238.3SL8CZLC15V5O@bootlin.com>
Cc: <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 0/4] Add Mobileye EyeQ clock support
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
In-Reply-To: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Stephen,

On Mon Oct 7, 2024 at 3:49 PM CEST, Th=C3=A9o Lebrun wrote:
> This series adds a platform driver dealing with read-only PLLs derived
> from the main crystal, and some divider clocks based on those PLLs. It
> also acts at the one instantiating reset and pinctrl auxiliary devices.

I'd be curious to get feedback on this series?
Could it make it before the next merge window?

V4 fixed all your comments but one. You implied the linked list might be
useless, but I am not convinced:

> I had a pending question [0], asking for confirmation that the static
> linked list to inherit cells from of_clk_init() stage to platform
> device probe is indeed the right solution. As -rc1 got released I sent
> the new revision anyway.
>
> [0]: https://lore.kernel.org/lkml/D4ELMFAUQYZ7.3LXGQZJSX68UF@bootlin.com/

Quoting here the original email for full context:

On Tue Sep 24, 2024 at 4:53 PM CEST, Th=C3=A9o Lebrun wrote:
> On Wed Sep 18, 2024 at 7:28 AM CEST, Stephen Boyd wrote:
> > Quoting Th=C3=A9o Lebrun (2024-07-30 09:04:46)
> > > +       list_add_tail(&priv->list, &eqc_list);
> >
> > The list is also kind of unnecessary. Set a bool in the match_data and
> > move on? We could have some sort of static_assert() check to make sure
> > if there's a CLK_OF_DECLARE_DRIVER() then the bool is set in the
> > match_data for the driver. Such a design is cheaper than taking a lock,
> > adding to a list.
>
> This list's main goal is not to know what was early-inited. Its only
> reason for existence is that we want to get, at eqc_probe(), the cells
> pointer allocated at eqc_init().
>
> struct eqc_priv {
> 	/* this field is why we store priv inside a linked list: */
> 	struct clk_hw_onecell_data	*cells;
> 	/* the rest, we don't care much: */
> 	const struct eqc_early_match_data *early_data;
> 	const struct eqc_match_data	*data;
> 	void __iomem			*base;
> 	struct device_node		*np;
> 	struct list_head		list;
> };
>
> I do not see how to do that with a bool. We could put the pointer into
> the match data, but that would mean we'd have to make them writable
> (currently static const data). We are talking about a linked list with
> two items in the worst case (EyeQ6H), accessed twice.
>
> The reason we store the whole of priv: simpler code and we avoid mapping
> registers twice (once at eqc_init() and once at eqc_probe()).
>
> Can you confirm the current static linked list approach (without any
> spinlock) will be good for next revision?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


