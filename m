Return-Path: <linux-kernel+bounces-268264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217BC94225A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963FA1F2425A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0697D18E02B;
	Tue, 30 Jul 2024 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UGz7Gj0i"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6981AA3EF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722376237; cv=none; b=q11rMdtJKRNv1IOd7hwQxJFtw9AHKx1XMFcQyWjT6/xFURnhSki2dFIwGKqa+5mRrlA34hgNEvJbolz4CquIevxh68Y9zOYz4P52Cth0JtVrxdgubFIJ6+RsUgRwZR5joE2Q/sqnGS6+2KWIqdWy7W6LCwboor8bGg88p6fNz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722376237; c=relaxed/simple;
	bh=RI+MO1DUmLECB6a6KqRs8Ki6aLcuzWc/MPzcype02eU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzC6HJKpeK98kGBMpWUQuqjO6QJOfdAxP8tnAP84i+73bYMDhPhEVN+liLTPotKAIc7R/4H4BW9NiMbD3KF8GQz3sDbKd+dPA3I9AQPH2lfw3LkCu1lnOkSeASq24KsOMIBc2TedP2cfF4xEl6X7pxOlpkrYvKh/2BX5VHITMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UGz7Gj0i; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722376228; x=1722635428;
	bh=RI+MO1DUmLECB6a6KqRs8Ki6aLcuzWc/MPzcype02eU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UGz7Gj0iD8b72ONMMp3U48oCY1W36JIttlQHOkCcqR/Dc+w7CYGPg/YufXPF7KsU7
	 KrkG/ONaPjUaam0ECrUVRVP9lLELqvIRgkPZ5Wzt33lSRrR51bfosllpoWRvDYhlPM
	 i+BO6sachtnZvkwHB3zF7yfzZUPJV2YRgtzb0p4nBIo0kQ/q4WPkYFF970mcx34y7l
	 xf21DkbiDQ0LjJZKW1vcpdZBQf5oEofESJneA2veF6E5Yo+qYjnqK7wBhv6wB904lr
	 HyjJ1ZpVKiKP37xoyGxjSAGb3VNEZW+14yO/pRLreonkwfz+3mNpmelQPApyJeyPuN
	 JChuwW8z7tP7g==
Date: Tue, 30 Jul 2024 21:50:23 +0000
To: Andy Yan <andy.yan@rock-chips.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "heiko@sntech.de" <heiko@sntech.de>, "hjc@rock-chips.com" <hjc@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: Re: [PATCH v3] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <jmdWz62Mhq515i3Kg6STPlrgiBbmxcryXENKYO5ov3fNtDwuF3_6eeq-sC4DC5HB0BDzlCGnPNnuNQoXYgVRI9YZDiUxKlXsS_bf27IwdEo=@proton.me>
In-Reply-To: <7d998e4c-e1d3-4e8b-af76-c5bc83b43647@rock-chips.com>
References: <TkgKVivuaLFLILPY-n3iZo_8KF-daKdqdu-0_e0HP-5Ar_8DALDeNWog2suwWKjX7eomcbGET0KZe7DlzdhK2YM6CbLbeKeFZr-MJzJMtw0=@proton.me> <ec283a7c-845b-4c58-8d86-cdd07862a0dc@rock-chips.com> <KbOjWzFKMM_fwDora8CjaLFBHWypRP1Mk6nPzHkwNAGxFHzJIynx3W8_jyZvbygH99lRAXDdrJmdFEQuY8M2Ao-a8F42zt8no4B1DCBiQIs=@proton.me> <48249708-8c05-40d2-a5d8-23de960c5a77@rock-chips.com> <y_bpV0FizWkAqq0XPIKrauaZ07r_Ds-MnDr696Y1qFTLNiLsx7pL4C-Zsu-K9TzVBJ85L5cdkzDQOExcXXTf0owUYramMHdZd4erMRpJUXI=@proton.me> <7d998e4c-e1d3-4e8b-af76-c5bc83b43647@rock-chips.com>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: d2e110ff2b83b052d01e54318b01eb36611f3ec6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, July 30th, 2024 at 12:43 PM, Andy Yan <andy.yan@rock-chips.com>=
 wrote:

> Hi Piotr,

Hi Andy

> On 7/30/24 05:20, Piotr Zalewski wrote:
>=20
> >=20
> > On Monday, July 29th, 2024 at 4:35 AM, Andy Yan andy.yan@rock-chips.com=
 wrote:
> >=20
> > > > > > +
> > > > > > +static void vop2_crtc_gamma_set(struct vop2 *vop2, struct drm_=
crtc *crtc,
> > > > > > + struct drm_crtc_state *old_state)
> > > > > > +{
> > > > > > + struct drm_crtc_state *state =3D crtc->state;
> > > > > > + struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
> > > > > > + u32 dsp_ctrl;
> > > > > > + int ret;
> > > > > > +
> > > > > > + if (!vop2->lut_regs)
> > > > > > + return;
> > > > > > +
> > > > > > + if (!state->gamma_lut) {
> > > > >=20
> > > > > What's the purpose of checking !state->gamma_lut here,
> > > > >=20
> > > > > and you check it again at the end for return.
> > > > > This makes me very confused.
> > > >=20
> > > > I understood it this way - since the vop2 lock is unlocked after di=
sabling
> > > > gamma LUT, the CRTC state can change while waiting for DSP_LUT_EN b=
it to
> > > > be unset. With the change I sent in response to Daniel's reply, gam=
ma LUT
> > > > state modification should now be fully atomic so there shouldn't be=
 a need
> > > > for the second state check there anymore (if my logic is incorrect =
please
> > > > explain).
> > >=20
> > > After reading the commit message for adding gamma control for rk3399[=
0] i understand
> > > what is going on here:
> > >=20
> > > we should run into the if block in two cases:
> > >=20
> > > (1) if the state->gamma_lut is null, we just need to disable dsp_lut =
and return,
> > >=20
> > > this is why vop1 code check !state->gamma_lut again at the end.
> > >=20
> > > (2) for platform unlinke rk3399(rk3566/8), we also need to disable ds=
p_lut befor we
> > > write gamma_lut data, for platform like rk3399(rk3588), we don't need=
 do the disable,
> > > this is why vop1 code also has a !VOP_HAS_REG(vop, common, update_gam=
ma_lut) check.
> > >=20
> > > so we also need a similary check here:
> > > (1) if the state->gamma_lut is null, disable dsp lut and return direc=
tly.
> > >=20
> > > (1) if the state has a gamma_lut, we shoud dsiable dsp_lut than write=
 gamma lut data on rk3566/8,
> > > buf for rk3588, we should not disable dsp_lut before write gamma
> > >=20
> > > [0]https://lists.infradead.org/pipermail/linux-rockchip/2021-October/=
028132.html
> >=20
> > Ok I see it. So In my patch it doesn't make sense at all to check it ag=
ain
> > (forgot about that extra if statement condition there, which I cut out
> > when porting to VOP2). I reworked my patch further for it to handle RK3=
588
> > case and to better utilize DRM atomic updates. It's contained in the
> > response to Daniel's review [1]. I experienced some problems so I'm wai=
ting
> > for his response/comment on that.
> >=20
> > Regarding RK3588, I checked RK3588 TRM v1.0 part2. In its VOP2 section =
I
> > found:
> > - SYS_CTRL_LUT_PORT_SEL: gamma_ahb_write_sel (seems to represent the
> > same concept as LUT_PORT_SEL in case of RK356x)
>=20
>=20
> We should also setting it to she VP id we want write gamma, this is used =
for selet
> ahb bus.
>=20
> > - VOP2_POST0_DSP_CTRL: gamma_update_en (seems to represent the same
> > concept as in VOP1 in case of RK3399)
>=20
> we also need to set it every time we update the gamma lut.
>=20
> > - I also found dsp_lut_en but I presume it is a bug in documentation.
>=20
>=20
> No, it is not a bug, we should set it when we enable gamma lut, we just d=
on't
> need to disable it before we update gamma lut.
>=20
> Here is some code you can take as reference [0]
> [0]:https://github.com/radxa/kernel/blob/linux-6.1-stan-rkr1/drivers/gpu/=
drm/rockchip/rockchip_drm_vop2.c#L3437
>=20

Thank you for further clarification. I will include it in the next version
of my patch.

> > Should RK3588 be handled as RK3399? (gamma LUT can be written directly =
but
> > gamma_update_en bit has to be set before). What about gamma_ahb_write_s=
el?
> >=20
> > [1] https://lkml.org/lkml/2024/7/27/293
> >=20

Best Regards, Piotr Zalewski

