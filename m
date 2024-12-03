Return-Path: <linux-kernel+bounces-430319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E070A9E2F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EAC2838C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB71420A5FC;
	Tue,  3 Dec 2024 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+hVtUmX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EBD1DFD84;
	Tue,  3 Dec 2024 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265179; cv=none; b=q0x9XLGIAaV0IRyD3N8zzO7s9D7bJHMk6hRWhRZTW09pxADdTGQdsEyjNek8vZoiNif4F254vMvgGIzBow5R01QgkZ7b/cDqhZhH3GCbmEnYsXvhISRsQvfGcWBT0LRNxM3wxHsmnwviUO5HjKs19RLdM8yBXu0twNSsY5Pg3I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265179; c=relaxed/simple;
	bh=Bpvf6PT2sZ1szXiUwNXmHPoiyL0/w8E+wBOIB5MmOEk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=CVtu7o74vLb7mfJvJXT5MAdbo22sNPrV3r8AycUyK6eOSz6EYuOEtB2useC/MXepF90TEgLPiVDKQdeNsNJ9o3iMCRNo0hmrmxlDCOrNbvYYuo18PBV3/rr/u8qsibO6por1Qshqw8lqjhQ+GDEBHqnj/Jx+QBZRCEnwR+4/62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+hVtUmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957ADC4CEDC;
	Tue,  3 Dec 2024 22:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733265178;
	bh=Bpvf6PT2sZ1szXiUwNXmHPoiyL0/w8E+wBOIB5MmOEk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=X+hVtUmXnkjxybS5JhrS3ehCvzAbgpvf7j4evJfuNyWITgL3BhTr1L/wW2h1gsde9
	 MdhxOyc+UgPe0okIyWW2D5Uz3m+TXGItm4fLPp1IubXkl/KXka2D9D79ZgB7H/IFbb
	 CqvkltHyQNaL/RmVQ8ZX3i2PWHLij+yEZgME0ES0UAZOxKiYcDmaB+Fe2qoY7pOv/I
	 kqtmTgU+uCGNv6Gvz5UBbE2Gaz0jGHtF5vXC9WceJs6J7+vRu36h9HxATcQF6EmqUX
	 6fTZp+7sZ0Pv4LjmFxk7a4nE8bpErisdROU0u+QCysy/xcYkaQ5Gkw0tWjpLzdZL0H
	 qtX4o9OvZB+sg==
Message-ID: <c982c5061ea6b0d465dd8b7fefc59cc7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dbb2de3c-cb29-4384-a00b-4fdedeab1a10@sirena.org.uk>
References: <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com> <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com> <1jy1131kxz.fsf@starbuckisacylon.baylibre.com> <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com> <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com> <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com> <df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org> <1jr06pkof6.fsf@starbuckisacylon.baylibre.com> <37b656cc8272552ba07c93c5a9a59641.sboyd@kernel.org> <dbb2de3c-cb29-4384-a00b-4fdedeab1a10@sirena.org.uk>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 14:32:56 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Mark Brown (2024-12-03 14:22:04)
> On Tue, Dec 03, 2024 at 12:15:48PM -0800, Stephen Boyd wrote:
> > Quoting Jerome Brunet (2024-12-03 03:15:41)
>=20
> > > I suspect the the generic path is likely to trigger more discussion.
> > > I'd like to be able to finish this migration, instead of leaving half
> > > finished like it is now.
>=20
> > Is the half finished migration a problem for this cycle? I was intending
> > to send the revert later this week and try again next cycle.
>=20
> Yes, this patch was triggered by me reporting that multiple boards in my
> test farm have completely broken audio with defconfig.=20

I thought that commit 5ae1a43486fb ("clk: amlogic: axg-audio: revert
reset implementation") was sufficient to fix the problem. Is that
incorrect?

