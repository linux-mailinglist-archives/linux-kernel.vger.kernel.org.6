Return-Path: <linux-kernel+bounces-402018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F19C9C2249
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A1C1F26232
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC0198E79;
	Fri,  8 Nov 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="g3nGu8Bt"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FB19414A;
	Fri,  8 Nov 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084052; cv=pass; b=cdY/6fztuFoJ8W2o70s3QT6UEONyz+gVZBVlXrll03Wr4SpTJZyrNZW0iJZp+6WfcJfJZ7pZmMPKexpJ2xI5ziskr23kj3UoQ8Ijcg5mBYZSHOGEMbYoy0SHvtcvW8aXrUTdDA3kCu5FOGDw4jaJCmLGj+EAyVJc06B8zx0jHrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084052; c=relaxed/simple;
	bh=9akKl0Fm3dQUhvXK24huAwurs1YZRTNPplRT0fsWtnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tg1eq7cm2Qv88dIVd2+5X0M0ZLRr4HiXAL+kEMsp9Udau3SgYDAEihxVWJIBe64kzjrbndOiEk63+v710YkqKVK4O8jSnfBlc8G6V00LOzYPl3WBUwGbRHNRGSX87ufyUT9TPIhffOpFbx1UvyLoBn0NLnYU8gG0WjFkBwFmmlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=g3nGu8Bt; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731084007; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kMBT7aXZMRHb9dlcAQR0f39OWKGOMxfoMaV3v0k3ji9AISTCzGboFxVq3Mtd09FaUo8E3E6k8CjPbxU+WhIvFv2YLpw8/sDTR+0hrXXnUKPREQz6rtgE+m5pHK5BwEt2BcAfoyBwn/hzC+mRmZu4bZn8DkPwZxUwTlwquCKXpVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731084007; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zGW5K4Z5kc/vSl3bz25b30mPWd8sGZbhmSQVIloBb6Y=; 
	b=K2QHm+eD9NrEzfdLEakHRuzUtYiQBZ1YpWKRU4H/yxNcf8C9nRZ8r3oTiq1QUtdLVsVl3xQc+jo+fhZH9IZWmyZFBVHE8sdPwWDOBWrWatdpX4yHlyLyDuNHiNmoGD7B5ilHVmj6tX4i0Y/jYg8eyOQHUxZ/H/XSUaN9nVny6Ts=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731084007;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=zGW5K4Z5kc/vSl3bz25b30mPWd8sGZbhmSQVIloBb6Y=;
	b=g3nGu8BtvOegMI7iWOw8v6SERxvHosLnzsy4xET800NfmNh6cDKO1EHbiF62ilEH
	dF0IMNC23rV2s8u8kDnC8LDcWwIAHMmIaMOp94mf4coSiKAObUGHQV0196EryvqdyU/
	Z1tmu6hJrxcg8uFagT48w19VlNx0ezT1/ytIgEF4=
Received: by mx.zohomail.com with SMTPS id 1731084004452888.298092585493;
	Fri, 8 Nov 2024 08:40:04 -0800 (PST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Andy Yan <andyshrk@163.com>
Cc: linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Chris Morgan <macromorgan@hotmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 1/3] vop2: Add clock resets support
Date: Fri, 08 Nov 2024 11:39:57 -0500
Message-ID: <4605629.LvFx2qVVIh@trenzalore>
In-Reply-To: <6a3d3fb1.3755.18fa893239e.Coremail.andyshrk@163.com>
References:
 <20240522185924.461742-1-detlev.casanova@collabora.com>
 <20240522185924.461742-2-detlev.casanova@collabora.com>
 <6a3d3fb1.3755.18fa893239e.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Thursday, 23 May 2024 23:09:26 EST Andy Yan wrote:
> Hi Detlev=EF=BC=8C
>=20
> At 2024-05-23 02:57:48, "Detlev Casanova" <detlev.casanova@collabora.com>=
=20
wrote:
> >At the end of initialization, each VP clock needs to be reset before
> >they can be used.
> >
> >Failing to do so can put the VOP in an undefined state where the
> >generated HDMI signal is either lost or not matching the selected mode.
>=20
> Would you please provide a detailed description of your test case?

The test case was to switch modes (using modetest) until the HDMI signal wa=
s=20
lost on the TV side. It was also possible to detect the issue by tracking t=
he=20
HDMI TX Controller_VIDEO_MONITOR_STATUS[1-6] registers, especially at addre=
ss=20
0x890, where the register would take the value `0x0000018c`.

After adding these resets, the issue cannot be reproduced. I can share a=20
script that reproduced this in the past (but this is an old patchset now, s=
o=20
things could have changed)

> >Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> >---
> >
> > drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 30 ++++++++++++++++++++
> > 1 file changed, 30 insertions(+)
> >
> >diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> >b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c index
> >fdd768bbd487c..e81a67161d29a 100644
> >--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> >+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> >@@ -17,6 +17,7 @@
> >
> > #include <linux/platform_device.h>
> > #include <linux/pm_runtime.h>
> > #include <linux/regmap.h>
> >
> >+#include <linux/reset.h>
> >
> > #include <linux/swab.h>
> >=20
> > #include <drm/drm.h>
> >
> >@@ -157,6 +158,7 @@ struct vop2_win {
> >
> > struct vop2_video_port {
> >=20
> > 	struct drm_crtc crtc;
> > 	struct vop2 *vop2;
> >
> >+	struct reset_control *dclk_rst;
> >
> > 	struct clk *dclk;
> > 	unsigned int id;
> > 	const struct vop2_video_port_data *data;
> >
> >@@ -1915,6 +1917,26 @@ static int us_to_vertical_line(struct
> >drm_display_mode *mode, int us)>
> > 	return us * mode->clock / mode->htotal / 1000;
> >=20
> > }
> >
> >+static int vop2_clk_reset(struct vop2_video_port *vp)
> >+{
> >+	struct reset_control *rstc =3D vp->dclk_rst;
> >+	struct vop2 *vop2 =3D vp->vop2;
> >+	int ret;
> >+
> >+	if (!rstc)
> >+		return 0;
>=20
> In fact, this check is not necessary here.  The following reset control a=
pi
> will check for NULL pointer

Agreed, I'll do a rebased v3 and remove the check.

> >+
> >+	ret =3D reset_control_assert(rstc);
> >+	if (ret < 0)
> >+		drm_warn(vop2->drm, "failed to assert reset\n");
> >+	udelay(10);
> >+	ret =3D reset_control_deassert(rstc);
> >+	if (ret < 0)
> >+		drm_warn(vop2->drm, "failed to deassert reset\n");
> >+
> >+	return ret;
> >+}
> >+
> >
> > static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
> >=20
> > 				    struct drm_atomic_state=20
*state)
> >=20
> > {
> >
> >@@ -2055,6 +2077,8 @@ static void vop2_crtc_atomic_enable(struct drm_crtc
> >*crtc,>
> > 	vop2_vp_write(vp, RK3568_VP_DSP_CTRL, dsp_ctrl);
> >
> >+	vop2_clk_reset(vp);
> >+
> >
> > 	drm_crtc_vblank_on(crtc);
> > =09
> > 	vop2_unlock(vop2);
> >
> >@@ -2706,6 +2730,12 @@ static int vop2_create_crtcs(struct vop2 *vop2)
> >
> > 		vp->data =3D vp_data;
> > 	=09
> > 		snprintf(dclk_name, sizeof(dclk_name), "dclk_vp%d", vp-
>id);
> >
> >+		vp->dclk_rst =3D devm_reset_control_get_optional(vop2-
>dev, dclk_name);
> >+		if (IS_ERR(vp->dclk_rst)) {
> >+		        drm_err(vop2->drm, "failed to get %s reset\n",=20
dclk_name);
> >+		        return PTR_ERR(vp->dclk_rst);
> >+		}
> >+
> >
> > 		vp->dclk =3D devm_clk_get(vop2->dev, dclk_name);
> > 		if (IS_ERR(vp->dclk)) {
> > 	=09
> > 			drm_err(vop2->drm, "failed to get %s\n",=20
dclk_name);





