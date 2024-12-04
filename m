Return-Path: <linux-kernel+bounces-432108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5289E4546
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD4C28418C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADE61F03D4;
	Wed,  4 Dec 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6W5Bzkj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DC1A8F79;
	Wed,  4 Dec 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733342718; cv=none; b=mi3DEQRS75Hcwj5O3C87vEGYUjRZa/2+9mkrCxjYttjweVogt7M202EJ7DzKDDPlPsv7u+IpGbAXQZ7+o8rMCuiT0G7pFCMlaOKdXCDjC5sFe7hxGtlXN74ZAGyDFPUkB9Qv+Re0BUbTxYxq0YWm/cMyIEaajMyUjxxImOzHWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733342718; c=relaxed/simple;
	bh=RldED8HMCKySelxt0TW6GW/GL2Ep4PQFNk69MJ3zo1Q=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JvFXsLIfrGPi/pawVSn2e2CbZIJPgO7zj0PR4rhPh2izAmmxb/PLKd5eYLSxcA1qVA4RT3pI2JFOGq2og9tX7Mh4+XMT6lQ8JipL1d/qpzr58Cdu5xRKXLpb7ZflteSjBzNoz5DIVwq6NskyYQhrU4xIoTdySDIsM3zxB+Fc0T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6W5Bzkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E5C4CECD;
	Wed,  4 Dec 2024 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733342717;
	bh=RldED8HMCKySelxt0TW6GW/GL2Ep4PQFNk69MJ3zo1Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=q6W5BzkjvXaHTIrnZTdGD5iCwNNhaZN7gMTJBXt+HRzr29Z5/0WmVdr+g1CES8myA
	 +q712arDusrNfXCgjpVAYXHdiYMfkQXKHqnSbKpAgis9/s7oY/zKWz67tc/1eStlFd
	 A276u4hxM3e9zNyp2hDsfkIpvTCWQB7An+sYPJ3qz8GcVOvPPk5+3r98KXm58QxA4y
	 DelmbPkfLUV9+eJshoeBO6HMu88EgXilXtU45V47pWiGHFhjn1PYrTjabDqg04/BeY
	 cOuTi45bsVVavblkC9rWBptE19kaBJ8XUBcfEWJYUcSJUWWZsDpJID7CnIKF9draQA
	 w8w5IyC/lQAlw==
Message-ID: <4e87e30244204b4e71f9b0f630171a40.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jfrn3l615.fsf@starbuckisacylon.baylibre.com>
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com> <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com> <1jy1131kxz.fsf@starbuckisacylon.baylibre.com> <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com> <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com> <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com> <df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org> <1jr06pkof6.fsf@starbuckisacylon.baylibre.com> <37b656cc8272552ba07c93c5a9a59641.sboyd@kernel.org> <1jfrn3l615.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
From: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 04 Dec 2024 12:05:14 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Jerome Brunet (2024-12-04 09:19:50)
> On Tue 03 Dec 2024 at 12:15, Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > Quoting Jerome Brunet (2024-12-03 03:15:41)
> >> On Mon 02 Dec 2024 at 18:53, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Is the half finished migration a problem for this cycle? I was intending
> > to send the revert later this week and try again next cycle.
>=20
> Not really, with the fix you applied. There is just code present in
> reset that should not be used in its current form. I'd prefer to
> sanitise the situation sooner rather than later.

Alright. Let's just sort it out in the next few weeks for the next merge
window then. Maybe you can just do it once then and get auxiliary bus
maintainers to ack the patch so you can merge the helper locally and use
it in the amlogic clk tree.

> >
> > Sure. You can make devm_meson_clk_rst_aux_register() use the same
> > signature as I proposed above so that it's a one line patch later. And
> > definitely drop the imply RESET_MESON and depends on REGMAP part. Maybe
> > you can put it in the clkc-utils file?
>=20
> Sure. Few things I'd like to clarify
>=20
> * I tend think like Arnd, platform data will be needed eventually. Not
>   sure having 2 functions, one with the param, one without is really
>   worth it. We could just pass NULL when it is not needed. It is not
>   uncommon. Would it be acceptable ? (for the generic helper, the
>   temporary solution does not need that for sure)

I'll defer to the maintainers there. I don't feel strongly.

>=20
> * You mean (meson-)clkc-utils.c ? I could but that would add dependency on
>   the auxiliary_bus for clock controllers that don't need it. It is a
>   minor problem really that I could just ignore.
>   I'd rather keep this helper separate if possible.

Ok, no worries.

>=20
> * Why drop 'imply RESET_MESON_AUX' ? I would still like the
>   COMMON_CLK_AXG_AUDIO to 'strongly suggest' RESET_MESON_AUX, with
>   dependency problem sorted out.

Because eventually you'll lose this Kconfig. I guess you'll want to add
that to the driver Kconfig option to maintain "strongly suggested".

