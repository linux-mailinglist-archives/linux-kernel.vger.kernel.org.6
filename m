Return-Path: <linux-kernel+bounces-537233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEC3A48968
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2891890267
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432F62702D7;
	Thu, 27 Feb 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm+jiQVE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4626FA73;
	Thu, 27 Feb 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686880; cv=none; b=i4tGBxo7/ohlF98HlOLH0ORHogG6cCfkfIlj4KKHkDFZ1I5HlptrSQwfXAeeIm/H3gH50Tv47V9GCkD9g1vyZT0VG8nVrKhcV1dKpDggOyi1Mj6eB8zqTWMC7Wsq+m8tsCGqFRyEmKkdOgzYTaf2LzGX7QiX9L8+bgKe9Nwu7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686880; c=relaxed/simple;
	bh=qzrV7ojG37Gb87LwnmyFT03tAi+5cM0gi1gFMUwOnSg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=UMbT4zEnixADfjnAwiUrNbeEgkmrZlmMB2FgHJoqAuEWgZhukkR/9XWf0N3OgpzBx6z9pWF8G8BuNoXchQtoXzoipDleb2gI68THgs+NPQRgmhE9tL+UvX0cYZ8EnLrLctpqO43N1bqe15XB3nPsqo6m0R60ThCMO3xK80kC55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm+jiQVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6027BC4CEE4;
	Thu, 27 Feb 2025 20:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686880;
	bh=qzrV7ojG37Gb87LwnmyFT03tAi+5cM0gi1gFMUwOnSg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Wm+jiQVETdhzpdKjuXSx8EyQpLWsIwCCInB8UTvsDaXula4vn5SYpUL5wwmhljKYr
	 C0rHLXmqRLLjwjKbOREYhyU5K9Fz9lXhwAa7/LrK3OwAqH+j8xfOCpWfqRzehfqBc1
	 sVpKg2zTHC/fLVyF074bYCUrKyFhvvqYV/aTn3JDEz/Ihj5+LpVSfkRzPxphdgKQyh
	 nbUTymGW+3kWJBqEkg5qhIBxenfGpCrI4E5JjQ+R6tSh3bM8XoXfc4se4uqdPU1sEJ
	 KnS93UaP8pCdIeJKQYXl5pGBLEHVTc/dVA+Kq2YOw7DrsnQesOyaEiUf1JeG6NAX3s
	 tgNrI/NMjC+tQ==
Message-ID: <250d7040fac61c408d648996e275aedc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jjz9bg0pg.fsf@starbuckisacylon.baylibre.com>
References: <20250120-amlogic-clk-drop-clk-regmap-tables-v3-0-126244146947@baylibre.com> <20250120-amlogic-clk-drop-clk-regmap-tables-v3-1-126244146947@baylibre.com> <508a5ee6c6b365e8d9cdefd5a9eec769.sboyd@kernel.org> <1jjz9bg0pg.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH v3 1/4] clk: add a clk_hw helpers to get the clock device or device_node
From: Stephen Boyd <sboyd@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 27 Feb 2025 12:07:57 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Jerome Brunet (2025-02-27 02:07:39)
> On Wed 26 Feb 2025 at 17:01, Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > Quoting Jerome Brunet (2025-01-20 09:15:30)
> >> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> >> index 9b45fa005030f56e1478b9742715ebcde898133f..9818f87c1c56ab9a3782c2=
fd55d3f602041769c3 100644
> >> --- a/drivers/clk/clk.c
> >> +++ b/drivers/clk/clk.c
> >> @@ -365,6 +365,39 @@ const char *clk_hw_get_name(const struct clk_hw *=
hw)
[...]
> >> + * Return: the struct device associated with the clock, or NULL if th=
ere
> >> + * is none.
> >> + */
> >> +struct device *clk_hw_get_dev(const struct clk_hw *hw)
> >> +{
> >> +       return hw->core->dev;
> >
> > Maybe we should increment the device refcount and require callers to
> > put_device(). Now's our chance to make the change!
>=20
> I'm afraid this would lead to a lot of boilerplate code and mis-managemen=
t,
> especially in the clock ops.

Don't we have __release() helpers? Not sure what boilerplate you're
talking about.

>=20
> Would it be better if clock core took care of that, at least for the ops
> part ? I mean incrementing and decrementing the ref count based on the
> clk_hw registration. That would make things a lot easier for clock
> users.

Meh, I don't know. We've been assuming that the device is present
because the driver will be unbound and the clks unregistered before the
device can disappear. Nothing enforces that though so things could go
wrong if we have a bug somewhere vs. knowing for sure that the refcount
is incremented here. What you're suggesting is a bigger change, pushing
down the reference counting so that as long as the clk is registered the
device is known to be valid.

Looking into the crystal ball of the future shows me that this will get
wrapped in rust and at that point we'll be sharing the reference (likely
not mutable) with the caller. If we do proper reference counting at the
start that will make it easier to convert code, but it probably doesn't
matter much because any rust clk provider would use the rust wrapper
where we could handle the refcount logic.

>=20
> If the consumer of the API uses it for something that may outlive the
> clk_hw, then it is up to it to properly increment the ref count since it
> is clearly not clock stuff.

Sure. I'm fine to not change anything. Mostly thinking out loud.

