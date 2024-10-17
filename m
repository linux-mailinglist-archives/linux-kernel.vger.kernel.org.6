Return-Path: <linux-kernel+bounces-370434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D089A2C60
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33F61F211D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9539C201261;
	Thu, 17 Oct 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUbnJ5va"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76318133F;
	Thu, 17 Oct 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190583; cv=none; b=S4ZNDSF6Z5PAkMbkDrdsXj1S563+fxXQA7sDcaVX9rUotrAQXk+u1dCCsNlRBCgpOC4igMGRvFXyapxIUdHyn3MbvztFrXUM9R7gVu+hYDDd9WfRF3ti1TbmZGazPuqhTB6r4E41qzNC6893yst4qBFZ3eDmTVtUQdiZ3U8EPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190583; c=relaxed/simple;
	bh=PcQXk4kA+O+U2bVu5sDiymybdRXz3rGK1neJUq0+tyU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=EluEER1SySfTZPKA0mtrJ7rk2jC9Ap5huDl0+JLpHx5ibiaLngC/FpwKNRJQUdbfc2x1/PfTXMBZWDqay53bNMDTg/6I/zof+VEdz4/Ucg2k+IlNPqoB5VgW9w+V6EVAU8QupQ9uzG3Xmdd9Pb6ngNNT3idky/lgQHBkRKskvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUbnJ5va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853E0C4CEC3;
	Thu, 17 Oct 2024 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729190582;
	bh=PcQXk4kA+O+U2bVu5sDiymybdRXz3rGK1neJUq0+tyU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nUbnJ5vajUPC0jmPEmsFVx+1DO/R1FPQqChPvjEWoAQxUoTpL819cQ7nzI9FS6Ud2
	 J3P1NNt8AtmQ1hzFcOmFyGjTP0wwYVWVYMz6YFAv1VFw0StniVq/H+Xpl9j+9PjXff
	 9D7SpEwjiV5In+T31SHbzg51+W2m1VU55okPGzS/2aocIly262DuGBHLonj2BUesRw
	 gA3yt+TEHJQYHghYjD1qbi4Ps/ekr8/wvAUsgnx/MFz+y0HFtjRl5U2e4DA7kV+X9a
	 A+qttaTCW/cjPJmqOYt6e13kdby7UdMyhgI/Tut4G4aBuhe1tIiI9bzppietkOwTYG
	 DTcglYOh1CCgA==
Message-ID: <3412c930fdb120032478c65e90e4b971.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D4W91PHV3238.3SL8CZLC15V5O@bootlin.com>
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com> <D4W91PHV3238.3SL8CZLC15V5O@bootlin.com>
Subject: Re: [PATCH v5 0/4] Add Mobileye EyeQ clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Thu, 17 Oct 2024 11:42:59 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-10-15 01:50:26)
> Hello Stephen,
>=20
> On Mon Oct 7, 2024 at 3:49 PM CEST, Th=C3=A9o Lebrun wrote:
> > This series adds a platform driver dealing with read-only PLLs derived
> > from the main crystal, and some divider clocks based on those PLLs. It
> > also acts at the one instantiating reset and pinctrl auxiliary devices.
>=20
> I'd be curious to get feedback on this series?
> Could it make it before the next merge window?
>=20
> V4 fixed all your comments but one. You implied the linked list might be
> useless, but I am not convinced:
>=20
> > I had a pending question [0], asking for confirmation that the static
> > linked list to inherit cells from of_clk_init() stage to platform
> > device probe is indeed the right solution. As -rc1 got released I sent
> > the new revision anyway.
> >
> > [0]: https://lore.kernel.org/lkml/D4ELMFAUQYZ7.3LXGQZJSX68UF@bootlin.co=
m/
>=20
> Quoting here the original email for full context:

Thanks!

>=20
> On Tue Sep 24, 2024 at 4:53 PM CEST, Th=C3=A9o Lebrun wrote:
> > On Wed Sep 18, 2024 at 7:28 AM CEST, Stephen Boyd wrote:
> > > Quoting Th=C3=A9o Lebrun (2024-07-30 09:04:46)
> > > > +       list_add_tail(&priv->list, &eqc_list);
> > >
> > > The list is also kind of unnecessary. Set a bool in the match_data and
> > > move on? We could have some sort of static_assert() check to make sure
> > > if there's a CLK_OF_DECLARE_DRIVER() then the bool is set in the
> > > match_data for the driver. Such a design is cheaper than taking a loc=
k,
> > > adding to a list.
> >
> > This list's main goal is not to know what was early-inited. Its only
> > reason for existence is that we want to get, at eqc_probe(), the cells
> > pointer allocated at eqc_init().
> >
> > struct eqc_priv {
> >       /* this field is why we store priv inside a linked list: */
> >       struct clk_hw_onecell_data      *cells;
> >       /* the rest, we don't care much: */
> >       const struct eqc_early_match_data *early_data;

This is __initconst and won't be valid after init, which is possible if
the driver probe is delayed beyond the time that init memory is freed.

> >       const struct eqc_match_data     *data;
> >       void __iomem                    *base;
> >       struct device_node              *np;
> >       struct list_head                list;
> > };
> >
> > I do not see how to do that with a bool. We could put the pointer into
> > the match data, but that would mean we'd have to make them writable
> > (currently static const data). We are talking about a linked list with
> > two items in the worst case (EyeQ6H), accessed twice.

Ah I missed that you were trying to stash the onecell data away. You can
register a clk provider for the same node more than once. The first
"early" one can return an error pointer for the clk indices that will be
registered later. The second onecell data can be registered in the
regular driver probe and return the clks that are registered later. See
of_clk_get_hw_from_clkspec() and how it keeps trying to find a clk if
the provider that matches the node didn't return a valid pointer.

> >
> > The reason we store the whole of priv: simpler code and we avoid mapping
> > registers twice (once at eqc_init() and once at eqc_probe()).

The IO mapping code handles duplicate mappings internally by returning
the previous virtual address. It doesn't hurt to call it again.

> >
> > Can you confirm the current static linked list approach (without any
> > spinlock) will be good for next revision?
>=20

Getting rid of the list will make the code simpler and avoid the driver
probe path from accessing the early data. Please do it!

