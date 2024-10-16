Return-Path: <linux-kernel+bounces-368019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106299A09DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880DAB25A39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0779F207A2C;
	Wed, 16 Oct 2024 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="x/b20hD0"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CF207A09
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082143; cv=none; b=YDlY3zutec8bHWAhK3W4fwTfhbeP6aAGYkZZ1M1iEN5m3niBwiadg9p8WSAfuiV6ifm0COpkxHbP+X8DvuQZpSs5i8EnJ3RQlfA63HICETpawhh+GjONLMa2KHp94YrPAQg6XzqGQhdAYQq8HBfy2pS9cOhkU2IZg+/nIvgGyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082143; c=relaxed/simple;
	bh=Nr9lCqkNcOu3fRseyBeKQRrWQLUNT7ErK7fuiN6xt0o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bHslvTFlUN/rn6ok9PegZdHxprASUW2jDbuST4GukhqSGmmcxd4KrVIXZM0zm0FTFYCY1zd4jXnj5x6iklLq37Clscs6dnCH/LkcbXzHbROfmMD5OYRgU4alxpMn/asDQ/drlhyzBlZtKQRzOCwlgWHWK3ob7giuX+uxwlD+pfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=x/b20hD0; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1729082138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTaj8AXpVBWrhNSy1JcE6EXS2SykZrY/1WbUR5yvdpw=;
	b=x/b20hD0hEvfaBAi+hWs8pUvE/sfpOeqDCYrktpK1t2O/NFekaKGmAlokw5DPD4fUtDNnv
	Fx0dArSexcydEYCoBeTElusQR4SnX1iKaqgCHb0M3yNVY+3/sAN8T536FPY7Aih3b56T4r
	myylYYmiNBVVZ3pnsBqBYtbNdVF+JwiOhVEXTqZHhfmuUnNYIyOPVsKEnRTx7zL15tWAQN
	hK6beHJbnnLPJEV//altlD6g9l7cX9KPnmc4igsF/Ebz+lOB9Mqrryi6AG7xgEnQBIBlNZ
	MASHvglPFFD3DpSAq+OSa5Uwz19/h9uuwVbe4XDdGvIkxJAr328zL8qh4cO8ag==
Content-Type: multipart/signed;
 boundary=420a352999a5f0637b0a389b86766f09be8702651d3ea0d2c89ab02af30c;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 16 Oct 2024 14:35:28 +0200
Message-Id: <D4X8GJV0W6JL.32E469JSATFEP@cknow.org>
Cc: <linux-rockchip@lists.infradead.org>, "Diederik de Haas"
 <didi.debian@cknow.org>, "Samuel Holland" <samuel@sholland.org>, "Dragan
 Simic" <dsimic@manjaro.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Michael Riesch"
 <michael.riesch@wolfvision.net>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: (subset) [PATCH v2 0/4] rockchip: Fix several DT validation
 errors
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Heiko Stuebner" <heiko@sntech.de>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Rob Herring" <robh@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
References: <20241008113344.23957-1-didi.debian@cknow.org>
 <172841572989.2562611.18254512768409976284.b4-ty@sntech.de>
 <D4X4RACGCRRH.39SMPGMZZ2GK4@cknow.org>
In-Reply-To: <D4X4RACGCRRH.39SMPGMZZ2GK4@cknow.org>
X-Migadu-Flow: FLOW_OUT

--420a352999a5f0637b0a389b86766f09be8702651d3ea0d2c89ab02af30c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Heiko,

On Wed Oct 16, 2024 at 11:41 AM CEST, Diederik de Haas wrote:
> On Tue Oct 8, 2024 at 9:28 PM CEST, Heiko Stuebner wrote:
> > On Tue, 8 Oct 2024 13:15:35 +0200, Diederik de Haas wrote:
> > > This is a set of 4 small device-tree validation fixes.
> > >=20
> > > Patch 1 adds the power-domains property to the csi dphy node on rk356=
x.
> > > Patch 2 removes the 2nd interrupt from the hdmi node on rk3328.
> > > Patch 3 replaces 'wake' with 'wakeup' on PineNote BT node.
> > > Patch 4 replaces 'reset-gpios' with 'shutdown-gpios' on brcm BT nodes=
.
> >
> > Applied, thanks!
> >
> > [2/4] arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
> >       commit: de50a7e3681771c6b990238af82bf1dea9b11b21
> > [3/4] arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node
> >       commit: 87299d6ee95a37d2d576dd8077ea6860f77ad8e2
> > [4/4] arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes
> >       commit: 2b6a3f857550e52b1cd4872ebb13cb3e3cf12f5f
>
> Please revert the 4th patch.
>
> I must have messed up my testing previously, but BT does not work on the
> PineNote with the 4th patch applied and does work with it reverted.

FWIW, I figured out what went wrong.
My testing was correct, but redo-ing the implementation to make it ready
for submission wasn't very smart.

With ``shutdown-gpios =3D <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;``
it does work correctly, but I forgot to change GPIO_ACTIVE_LOW to
GPIO_ACTIVE_HIGH before submitting.

I'll first figure out a better procedure before making a new submission,
so the revert is still the best approach IMO.

Cheers,
  Diederik

--420a352999a5f0637b0a389b86766f09be8702651d3ea0d2c89ab02af30c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZw+zEwAKCRDXblvOeH7b
bjbgAP9YbTBY27TFko/D2mKhNunoxZyzGN1Ss/H9noU7e6dOtQEAkqQg/YHMODFT
3YTB0Lngl+UqeAUuasytSAUgJxyAhQ8=
=QZhM
-----END PGP SIGNATURE-----

--420a352999a5f0637b0a389b86766f09be8702651d3ea0d2c89ab02af30c--

