Return-Path: <linux-kernel+bounces-534920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F22EA46CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F5169C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924424A062;
	Wed, 26 Feb 2025 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martijnvandeventer.nl header.i=@martijnvandeventer.nl header.b="hqGR0Oth"
Received: from mail.mvand.net (mail.mvand.net [185.229.52.35])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37084239561;
	Wed, 26 Feb 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.229.52.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602918; cv=none; b=X575Cd7uYO35XHnjqoXWunXnMzAe4L0ON1EijWA9catSdECVSmiYG/4x5Wtzx8JzhTUye+2e0CUBxc5d2ya+WiZ/GS2fGWaAomxL3x7xtmvTpsh3kHYDgppps6immhWAj3VT4i5bvZuysD4/XdqvmT/AJZbIUkd27gn0Lrc/Oys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602918; c=relaxed/simple;
	bh=Us1Ow4+6XA3oM8CNVlGcAJVhehzo86KySSpNCM9g1Mg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 Mime-Version:Content-Type; b=e4OKPdGTkAyqQj+XzZ28YSBlyuRwJtvefmqzarvFtPeeGuIXxua+fNRGnmSd84ZgE4PkgP/y0BVq4rJ3XmJ21BbeKgDjOofxIECAaS2qDpRHngNxmc9D6lGa+bdKqnUhU2E/rsRfBMnGFYPxXflUTeoPrnarc1pHzUdh/MKO+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=martijnvandeventer.nl; spf=pass smtp.mailfrom=martijnvandeventer.nl; dkim=pass (2048-bit key) header.d=martijnvandeventer.nl header.i=@martijnvandeventer.nl header.b=hqGR0Oth; arc=none smtp.client-ip=185.229.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=martijnvandeventer.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martijnvandeventer.nl
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.mvand.net (Postfix) with ESMTPSA id C6A1B1FE54;
	Wed, 26 Feb 2025 21:39:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=martijnvandeventer.nl; s=default; t=1740602379;
	bh=Us1Ow4+6XA3oM8CNVlGcAJVhehzo86KySSpNCM9g1Mg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=hqGR0Othq8GqD+Fmyma4JQQO33n6Sx7TUB9dim/KvrVtYWLQ+J5Puc7ypC8piUv4A
	 ngsDRZqBnOb9VALJ8nfBl43nZ90KfdCPlBs9GPsFmAtXFbOT6VqqmJXl655EWVwaG/
	 fHhNktlcqhXRgeqfhBtpSOE3mGqNJi7ZTZNVaSEMzND5i30Gvvq+ET2OFfbG0153Ad
	 vZejdWhT9RxYiI0FvvUtsAQOGsR4kUeY1mEfOTCfuqwH2tpwrwmsazTReRvbwnRR9J
	 kk0pkvggl/C+gs73nO28lPh+OQ05Uzw2WPb7vrBP25tGR414NvFdZkz/cxAI5JvZmw
	 msR4QXHrdNtnA==
From: <linux@martijnvandeventer.nl>
To: "'Jerome Brunet'" <jbrunet@baylibre.com>
Cc: "'Neil Armstrong'" <neil.armstrong@linaro.org>,
	"'Michael Turquette'" <mturquette@baylibre.com>,
	"'Stephen Boyd'" <sboyd@kernel.org>,
	"'Kevin Hilman'" <khilman@baylibre.com>,
	"'Martin Blumenstingl'" <martin.blumenstingl@googlemail.com>,
	<linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250213221702.606-1-linux@martijnvandeventer.nl> <1jpljkzyf0.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jpljkzyf0.fsf@starbuckisacylon.baylibre.com>
Subject: RE: [PATCH] clk: meson: g12a: Fix kernel warnings when no display attached
Date: Wed, 26 Feb 2025 21:39:39 +0100
Message-ID: <003301db888e$8ea84e90$abf8ebb0$@martijnvandeventer.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Thread-Index: AQH3Houg6kGqwWGxu7A7A+ZA83tGEAI4axMrsxEbdYA=
Content-Language: en-us

Hi Jerome,

Thank you for reviewing, and apologies for my late response due to a =
holiday.

> On Thu 13 Feb 2025 at 23:17, Martijn van Deventer
> <linux@martijnvandeventer.nl> wrote:
>=20
> > When booting SM1 or G12A boards without a dislay attached to HDMI,
> > the kernel shows the following warning:
> >
> > [CRTC:46:meson_crtc] vblank wait timed out
> > WARNING: CPU: 2 PID: 265 at drivers/gpu/drm/drm_atomic_helper.c:1682
> drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
> > CPU: 2 UID: 0 PID: 265 Comm: setfont Tainted: G         C
> > Tainted: [C]=3DCRAP
> > pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
> > lr : drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
> > Call trace:
> >  drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
> >  drm_atomic_helper_commit_tail_rpm+0x84/0xa0
> >  commit_tail+0xa4/0x18c
> >  drm_atomic_helper_commit+0x164/0x178
> >  drm_atomic_commit+0xb4/0xec
> >  drm_client_modeset_commit_atomic+0x210/0x270
> >  drm_client_modeset_commit_locked+0x5c/0x188
> >  drm_fb_helper_pan_display+0xb8/0x1d4
> >  fb_pan_display+0x7c/0x120
> >  bit_update_start+0x20/0x48
> >  fbcon_switch+0x418/0x54c
> >  el0t_64_sync+0x194/0x198
> >
> > This happens when the kernel disables the unused clocks.
> > Sometimes this causes the boot to hang.
> >
> > By (re)adding the flag CLK_IGNORE_UNUSED to the VCLK2 clocks, these
> > clocks will not be disabled.
> >
> > This partially reverts commit b70cb1a21a54 ("clk: meson: g12a:
> > make VCLK2 and ENCL clock path configurable by CCF").
>=20
> It looks like DRM needs those clock enabled regardless of connection
> status on HDMI. Even with this change applied, you would get the same
> problem again if the bootloader does not take of turning the clock on,
> which is not a given.
>=20
> CLK_IGNORE_UNUSED gives not guarantee a clock will be enabled or stay
> enabled at any point.
>=20
> A proper fix to this issue should be done in DRM, IMO.

I know and I totally agree. Unfortunately, I don't have access to any =
vendor=20
documentation, nor do I have any real knowledge about the DRM/HDMI=20
subsystem to fix that.

And I guess if it were as easy as adding a clock to the DT and calling=20
clk_prepare_enable on it in the probe function, Neil would have done =
that=20
already.

So, all I can do, for now, is revert to the previous situation when it =
did  work
for (probably) most boards.=20

> >
> > Fixes: b70cb1a21a54 ("clk: meson: g12a: make VCLK2 and ENCL clock =
path
> configurable by CCF").
> > Signed-off-by: Martijn van Deventer <linux@martijnvandeventer.nl>
> > ---
> >  drivers/clk/meson/g12a.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> > index cfffd434e998..1651898658f5 100644
> > --- a/drivers/clk/meson/g12a.c
> > +++ b/drivers/clk/meson/g12a.c
> > @@ -3234,7 +3234,7 @@ static struct clk_regmap g12a_vclk2_div =3D {
> >  			&g12a_vclk2_input.hw
> >  		},
> >  		.num_parents =3D 1,
> > -		.flags =3D CLK_SET_RATE_GATE,
> > +		.flags =3D CLK_SET_RATE_GATE | CLK_IGNORE_UNUSED,
> >  	},
> >  };
> >
> > @@ -3270,7 +3270,7 @@ static struct clk_regmap g12a_vclk2 =3D {
> >  		.ops =3D &meson_vclk_gate_ops,
> >  		.parent_hws =3D (const struct clk_hw *[]) { &g12a_vclk2_div.hw
> },
> >  		.num_parents =3D 1,
> > -		.flags =3D CLK_SET_RATE_PARENT,
> > +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> >  	},
> >  };
> >
> > @@ -3354,7 +3354,7 @@ static struct clk_regmap g12a_vclk2_div1 =3D {
> >  		.ops =3D &clk_regmap_gate_ops,
> >  		.parent_hws =3D (const struct clk_hw *[]) { &g12a_vclk2.hw },
> >  		.num_parents =3D 1,
> > -		.flags =3D CLK_SET_RATE_PARENT,
> > +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> >  	},
> >  };
> >
> > @@ -3368,7 +3368,7 @@ static struct clk_regmap g12a_vclk2_div2_en =
=3D {
> >  		.ops =3D &clk_regmap_gate_ops,
> >  		.parent_hws =3D (const struct clk_hw *[]) { &g12a_vclk2.hw },
> >  		.num_parents =3D 1,
> > -		.flags =3D CLK_SET_RATE_PARENT,
> > +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> >  	},
> >  };
> >
> > @@ -3382,7 +3382,7 @@ static struct clk_regmap g12a_vclk2_div4_en =
=3D {
> >  		.ops =3D &clk_regmap_gate_ops,
> >  		.parent_hws =3D (const struct clk_hw *[]) { &g12a_vclk2.hw },
> >  		.num_parents =3D 1,
> > -		.flags =3D CLK_SET_RATE_PARENT,
> > +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> >  	},
> >  };
> >
> > @@ -3396,7 +3396,7 @@ static struct clk_regmap g12a_vclk2_div6_en =
=3D {
> >  		.ops =3D &clk_regmap_gate_ops,
> >  		.parent_hws =3D (const struct clk_hw *[]) { &g12a_vclk2.hw },
> >  		.num_parents =3D 1,
> > -		.flags =3D CLK_SET_RATE_PARENT,
> > +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> >  	},
> >  };
>=20
--
Martijn


