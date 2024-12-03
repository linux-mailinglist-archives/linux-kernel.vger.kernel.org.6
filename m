Return-Path: <linux-kernel+bounces-430137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53269E2CDE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B47B281A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA27E200120;
	Tue,  3 Dec 2024 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUeTdkSL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD81FBEAB;
	Tue,  3 Dec 2024 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256951; cv=none; b=RUOFsk22XLc6woU0MbDABg+KBBaz0QqZHn2laMp1Z5Pc1Y/3qzhHvlWmSI9kY2R5nWfeZP1d0otQBr4uIrm3Ni4jD0Y9W7++PMsNYOQLHO7t5jytdDSRmOtl+eGw8hGjH70swNNKULOzEol59gPwhP+qSIcnTx7bWwQ/oss0aqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256951; c=relaxed/simple;
	bh=nMvRbDWGMoteA80rhU5gF6aGUXcgXYmz/KEKmev1qRA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=XG8nYSrosQYhcrtPq7u/ygHrssYeSpm0VUobof5IlTUZRa1T3KSbcpt04sLxn3A5YqbnGfzPysIzB2d2XdGwbm6MhRka2PvTTv4q0OxisBY1Z0rdxJvr4TrWDm7TgCy0GUSbpQEdU1IfsOMnTEfrpqN5YiwENIkNSyGT+Xx5HHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUeTdkSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8EAC4CECF;
	Tue,  3 Dec 2024 20:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733256950;
	bh=nMvRbDWGMoteA80rhU5gF6aGUXcgXYmz/KEKmev1qRA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GUeTdkSLrwwtpyDCutlSLaSNwL8dR367APMpqZqPyfH3v/nlyyLuK9nBuPyt9fLpu
	 HQJD85FLhiZRRnTI6wXi1nAOb7xvv3+OqbOyvsBfQUifI1fP09CNjVbHcgx56Gr7aM
	 yAvoKaIzF4FTNYnQOa6V5w5ZtiDstQ1MOpJbh+ypN+thSBz2oNsALoV04wWwDjUr1n
	 YilVlZuqpC9iKY5gbA1uAfwPMv9WgZo3FZQxwdyDnaGQV97BIE1xfwa+KHB8GFtdCU
	 RRyRl8BqPN+ke4DNCi+84xlzhKPcV3INbqUrQHxiuDuNM9z/bnM4VYrnCiATJr0AIO
	 pMeOWhOwA+OVw==
Message-ID: <37b656cc8272552ba07c93c5a9a59641.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jr06pkof6.fsf@starbuckisacylon.baylibre.com>
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com> <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com> <1j4j3r32ld.fsf@starbuckisacylon.baylibre.com> <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com> <1jy1131kxz.fsf@starbuckisacylon.baylibre.com> <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com> <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com> <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com> <df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org> <1jr06pkof6.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
From: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 03 Dec 2024 12:15:48 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Jerome Brunet (2024-12-03 03:15:41)
> On Mon 02 Dec 2024 at 18:53, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > I think the best approach is to add the reset auxilary device with a
> > function that creates the auxiliary device directly by string name and
> > does nothing else. Maybe we can have some helper in the auxiliary
> > layer that does that all for us, because it's quite a bit of boiler
> > plate that we need to write over and over again. Something like:
> >
> >   int devm_auxiliary_device_create(struct device *parent, const char *n=
ame)
> >
> > that does the whole kzalloc() + ida dance that
> > devm_meson_rst_aux_register() is doing today and wraps it all up so that
> > the device is removed when the parent driver unbinds. Then this clk
> > driver can register the reset device with a single call and not need to
> > do anything besides select AUXILIARY_BUS.
>=20
> I think this is fairly close to what I proposed in the inital RFC, but
> generic instead of specific.

Ok :-/ I've realized that we need this sort of approach in more places
to logically split the device without making it SoC specific. It's only
useful to have the registration API live in the driver when we need to
call functions provided by that module from the driver registering the
auxiliary device.

>=20
> I suspect the the generic path is likely to trigger more discussion.
> I'd like to be able to finish this migration, instead of leaving half
> finished like it is now.

Is the half finished migration a problem for this cycle? I was intending
to send the revert later this week and try again next cycle.

>=20
> May I add back the boiler plate code in drivers/clk/meson, similar to
> what was proposed in the RFC [1] and propose the generic implementation
> in parallel ? It will just be a matter of switching when/if it is approve=
d.

Sure. You can make devm_meson_clk_rst_aux_register() use the same
signature as I proposed above so that it's a one line patch later. And
definitely drop the imply RESET_MESON and depends on REGMAP part. Maybe
you can put it in the clkc-utils file?

