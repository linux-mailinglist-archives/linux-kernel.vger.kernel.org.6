Return-Path: <linux-kernel+bounces-549403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8613A55214
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FD83A2D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97D125CC96;
	Thu,  6 Mar 2025 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martijnvandeventer.nl header.i=@martijnvandeventer.nl header.b="gI4G9Y6W"
Received: from mail.mvand.net (mail.mvand.net [185.229.52.35])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687432566F8;
	Thu,  6 Mar 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.229.52.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280259; cv=none; b=X3dnS34skNpdaeYsf9QZkKo+aRyxOAV+bL738XilD+KM/tUDR2VZaj2gk7+6S+RdQtrIja8Nuby4bxx2s9WCSV5iPSJcua3gUePnrNbFW/+14ggoF8IEUjbRp86QFT0f7V0uPYRNBmdo8RWw6dQeOK5J7AkBN5GSqlRhTsYvg4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280259; c=relaxed/simple;
	bh=SIUt61OEmPLOReb3UFOpiP9TLUmxG7qMn3Riz8VOTPk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 Mime-Version:Content-Type; b=mM8QVyJGW1zyBQbz91TQSk6tAp6HnySljNIFCIvPxPbH0lqeDrikRAPVPFBqiHiM17nDC5CFaHNtWVIeZMHzZsf3hEuySK0TYEnl47hfDQdzro16nWDGs+oDMhyaOFl7sTUx+MtglLosnf8NtuhBD+YZXk+XPw7x1yAGl4qbrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=martijnvandeventer.nl; spf=pass smtp.mailfrom=martijnvandeventer.nl; dkim=pass (2048-bit key) header.d=martijnvandeventer.nl header.i=@martijnvandeventer.nl header.b=gI4G9Y6W; arc=none smtp.client-ip=185.229.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=martijnvandeventer.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martijnvandeventer.nl
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.mvand.net (Postfix) with ESMTPSA id 13FB91FE54;
	Thu,  6 Mar 2025 17:48:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=martijnvandeventer.nl; s=default; t=1741279714;
	bh=SIUt61OEmPLOReb3UFOpiP9TLUmxG7qMn3Riz8VOTPk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=gI4G9Y6WO9bg9HFoC/7y/9XVn1Tk6u0Wo01917PgF2/eMzceuorFNUip91ecirwE2
	 f2VZYiZNvVSPh3/LDNLbu5eVTo0Mj6jCPrzYHplbxCPPlwbgcKMlJyhhqNzu4JiBlB
	 Po0CR+oyPPgQBkbmaWNEyjEj2A1LDjNPTLXkbDRxZmIRD9C/QedNxrW2xPTX8hzSvY
	 Psvgxx63C7Rcer4WVgV3+uWsJj1L5PaqqXPGbDSpwbcWW8NTr9OA+J4SDxx2+dge7H
	 RgV5EhsraXg8ZALKpXs+ffPVTGmDxrrrD8G2Ni2b9vFth3GnRLtK9wGfnqkLnltYu5
	 jyY/HNuQ7adRA==
From: <linux@martijnvandeventer.nl>
To: "'Jerome Brunet'" <jbrunet@baylibre.com>,
	<linux@martijnvandeventer.nl>
Cc: "'Neil Armstrong'" <neil.armstrong@linaro.org>,
	"'Michael Turquette'" <mturquette@baylibre.com>,
	"'Stephen Boyd'" <sboyd@kernel.org>,
	"'Kevin Hilman'" <khilman@baylibre.com>,
	"'Martin Blumenstingl'" <martin.blumenstingl@googlemail.com>,
	<linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250213221702.606-1-linux@martijnvandeventer.nl>	<1jpljkzyf0.fsf@starbuckisacylon.baylibre.com>	<003301db888e$8ea84e90$abf8ebb0$@martijnvandeventer.nl> <1jplj3g21q.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jplj3g21q.fsf@starbuckisacylon.baylibre.com>
Subject: RE: [PATCH] clk: meson: g12a: Fix kernel warnings when no display attached
Date: Thu, 6 Mar 2025 17:48:33 +0100
Message-ID: <004801db8eb7$99808e20$cc81aa60$@martijnvandeventer.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Thread-Index: AQH3Houg6kGqwWGxu7A7A+ZA83tGEAI4axMrAfruu2QCUs8BLwKsXM3O

Hi Jerome,

> >
> > Thank you for reviewing, and apologies for my late response due to a
> holiday.
> >
> >> On Thu 13 Feb 2025 at 23:17, Martijn van Deventer
> >> <linux@martijnvandeventer.nl> wrote:
> >>
> >> > When booting SM1 or G12A boards without a dislay attached to HDMI,
> >> > the kernel shows the following warning:
> >> >
> >> > [CRTC:46:meson_crtc] vblank wait timed out
> >> > WARNING: CPU: 2 PID: 265 at
> drivers/gpu/drm/drm_atomic_helper.c:1682
> >> drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
> >> > CPU: 2 UID: 0 PID: 265 Comm: setfont Tainted: G         C
> >> > Tainted: [C]=CRAP
> >> > pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >> > pc : drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
> >> > lr : drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
> >> > Call trace:
> >> >  drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
> >> >  drm_atomic_helper_commit_tail_rpm+0x84/0xa0
> >> >  commit_tail+0xa4/0x18c
> >> >  drm_atomic_helper_commit+0x164/0x178
> >> >  drm_atomic_commit+0xb4/0xec
> >> >  drm_client_modeset_commit_atomic+0x210/0x270
> >> >  drm_client_modeset_commit_locked+0x5c/0x188
> >> >  drm_fb_helper_pan_display+0xb8/0x1d4
> >> >  fb_pan_display+0x7c/0x120
> >> >  bit_update_start+0x20/0x48
> >> >  fbcon_switch+0x418/0x54c
> >> >  el0t_64_sync+0x194/0x198
> >> >
> >> > This happens when the kernel disables the unused clocks.
> >> > Sometimes this causes the boot to hang.
> >> >
> >> > By (re)adding the flag CLK_IGNORE_UNUSED to the VCLK2 clocks, these
> >> > clocks will not be disabled.
> >> >
> >> > This partially reverts commit b70cb1a21a54 ("clk: meson: g12a:
> >> > make VCLK2 and ENCL clock path configurable by CCF").
> >>
> >> It looks like DRM needs those clock enabled regardless of connection
> >> status on HDMI. Even with this change applied, you would get the same
> >> problem again if the bootloader does not take of turning the clock on,
> >> which is not a given.
> >>
> >> CLK_IGNORE_UNUSED gives not guarantee a clock will be enabled or stay
> >> enabled at any point.
> >>
> >> A proper fix to this issue should be done in DRM, IMO.
> >
> > I know and I totally agree. Unfortunately, I don't have access to any 
> > vendor
> > documentation, nor do I have any real knowledge about the DRM/HDMI
> > subsystem to fix that.
>
> You have identified which clocks are not properly claimed, by what they
> are not claimed and even when. 50% of the job is done. Thanks for this.

You're welcome, no problem.

> >
> > And I guess if it were as easy as adding a clock to the DT and calling
> > clk_prepare_enable on it in the probe function, Neil would have done
> that
> > already.
> >
> > So, all I can do, for now, is revert to the previous situation when it 
> > did
> work
> > for (probably) most boards.
>
> Maybe so, but it does not make this change appropriate. The problem
> is the DRM driver which does not enable what it needs to properly
> operate. This should be fixed.

I understand. So I guess that is the end of the line for this patch.
Because this patch will not be accepted and if someone else finds the 
time and has the knowledge to fix this the proper way, it will be a 
completely different patch.

Although I, of course, agree with you that it should be fixed properly, 
I find it a bit difficult to accept that if we accidentally break something,
while trying to make things better, we are not allowed to revert it 
because it was already somewhat broken. Resulting in a more broken
situation than before...

On the other hand, I also understand that if you, as a maintainer, allow 
that, chances are it will never see a proper fix. :-)

Cheers!

> >
> >> >
> >> > Fixes: b70cb1a21a54 ("clk: meson: g12a: make VCLK2 and ENCL clock
> path
> >> configurable by CCF").
> >> > Signed-off-by: Martijn van Deventer <linux@martijnvandeventer.nl>
> >> > ---
> >> >  drivers/clk/meson/g12a.c | 12 ++++++------
> >> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> >> > index cfffd434e998..1651898658f5 100644
> >> > --- a/drivers/clk/meson/g12a.c
> >> > +++ b/drivers/clk/meson/g12a.c
> >> > @@ -3234,7 +3234,7 @@ static struct clk_regmap g12a_vclk2_div = {
--
Best regards,
Martijn


