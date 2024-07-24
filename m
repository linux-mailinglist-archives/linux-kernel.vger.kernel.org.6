Return-Path: <linux-kernel+bounces-261429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449193B72A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B362807BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005A161915;
	Wed, 24 Jul 2024 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SXHfdTki"
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6C65E20
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847983; cv=none; b=WWYMoec00cA4q6mAclnOxnzZcG7VlDIc3gBUZ90pHtdNDnlq3PcfAus8jTZ2GStkYraHA361H5Up9FThkmMdvqkp4IX4kOKwhGCF1fN+/hBSHkyqFSl9BfEsaJ9D2Smjr8IrmQ48ps8xVOYEuTKFkrYDl4bOF9hS4ogVrVycmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847983; c=relaxed/simple;
	bh=Ts8ZnmloIbjXsfvstwJ7Xon+5vbuZd276D05Bq9Mj0s=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=VjPVwfrUeKf+IIVD8Kt7w+EtUO94jN4mD/oJUVP+AizNsSCPaTGhrqZhsv2Vd359E5UCcuEzgaZQPKnfRQC+k1GCW46PxfftYAiCvK2ywOwc2sXMSNmRMOKV4lfiUOaCia2Xm4xCY5yN2CSwJYMjBOI3dNySabCknuI164OovsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SXHfdTki; arc=none smtp.client-ip=185.70.40.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721847972; x=1722107172;
	bh=xXyqPAWiPGTlRuUl6Au8Vf9PuxCMIzRAhei2a3kfeEc=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SXHfdTkirkEZ7voqfB1b9hCVgNVFDCeiog1HpomvahB/1qkgF/apiVYgqfMBlNNLX
	 ibac/UXQF/TynZ5If8hwimNQaDS+i/pGgl9bpmstV+AAr1eNbzDFjz1EGOA8KwCnMm
	 I3p0Tj/4sjm6mJ8KslR1bgdYMTCjfVFaE43oK+aLmzM4XEMjf/8e3BDTgfP125e29N
	 oz9vncaAOwRbr9WxYFNtORrtN4BDBJqR/U3jmrQ+hqbEVejnSuFmncEgcQMnTVZDAu
	 lnP8LvcOxQz0tKnHGZ1NqLBJ6dvK8no3vkkte3/hiUiq2udoFv3FvnPMqj2+vfwxx1
	 73KoCFUrOPhtg==
Date: Wed, 24 Jul 2024 19:06:01 +0000
To: "airlied@gmail.com" <airlied@gmail.com>, "andy.yan@rock-chips.com" <andy.yan@rock-chips.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "heiko@sntech.de" <heiko@sntech.de>, "hjc@rock-chips.com" <hjc@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>
From: Piotr Zalewski <pZ010001011111@proton.me>
Subject: [PATCH v2] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <Hk03HDb6wSSHWtEFZHUye06HR0-9YzP5nCHx9A8_kHzWSZawDrU1o1pjEGkCOJFoRg0nTB4BWEv6V0XBOjF4-0Mj44lp2TrjaQfnytzp-Pk=@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 2763f33b849810a95c08efa9a15f31ec8564793e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add support for gamma LUT in VOP2 driver. The implementation is based on
the one found in VOP driver and modified to be compatible with VOP2. Blue
and red channels in gamma LUT register write were swapped with respect to
how gamma LUT values are written in VOP. Write of the current video port id
to VOP2_SYS_LUT_PORT_SEL register was added before the write of DSP_LUT_EN
bit. Gamma size is set and drm color management is enabled for each video
port's CRTC except ones which have no associated device. Tested on RK3566
(Pinetab2).

Helped-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---

Notes:
    Changes in v2:
        - Apply code styling corrections [1]
        - Move gamma LUT write inside the vop2 lock
   =20
    Link to v1: https://lore.kernel.org/linux-rockchip/9736eadf6a9d8e97eef9=
19c6b3d88828@manjaro.org/T/#t
   =20
    [1] https://lore.kernel.org/linux-rockchip/d019761504b540600d9fc7a585d6=
f95f@manjaro.org/

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm=
/rockchip/rockchip_drm_vop2.c
index 16abdc4a59a8..37fcf544a5fd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1515,9 +1515,8 @@ static void vop2_vp_dsp_lut_disable(struct vop2_video=
_port *vp)
=20
 static void vop2_crtc_write_gamma_lut(struct vop2 *vop2, struct drm_crtc *=
crtc)
 {
-=09const struct vop2_data *vop2_data =3D vop2->data;
 =09const struct vop2_video_port *vp =3D to_vop2_video_port(crtc);
-=09const struct vop2_video_port_data *vp_data =3D &vop2_data->vp[vp->id];
+=09const struct vop2_video_port_data *vp_data =3D &vop2->data->vp[vp->id];
=20
 =09struct drm_color_lut *lut =3D crtc->state->gamma_lut->data;
 =09unsigned int i, bpc =3D ilog2(vp_data->gamma_lut_len);
@@ -1558,9 +1557,8 @@ static void vop2_crtc_gamma_set(struct vop2 *vop2, st=
ruct drm_crtc *crtc,
 =09=09 * In order to write the LUT to the internal memory,
 =09=09 * we need to first make sure the dsp_lut_en bit is cleared.
 =09=09 */
-=09=09ret =3D
-=09=09    readx_poll_timeout(vop2_vp_dsp_lut_is_enabled, vp, dsp_ctrl, !ds=
p_ctrl, 5,
-=09=09=09=09       30 * 1000);
+=09=09ret =3D readx_poll_timeout(vop2_vp_dsp_lut_is_enabled, vp, dsp_ctrl,
+=09=09=09=09!dsp_ctrl, 5, 30 * 1000);
=20
 =09=09if (ret) {
 =09=09=09DRM_DEV_ERROR(vop2->dev, "display LUT RAM enable timeout!\n");
@@ -1571,9 +1569,9 @@ static void vop2_crtc_gamma_set(struct vop2 *vop2, st=
ruct drm_crtc *crtc,
 =09=09=09return;
 =09}
=20
-=09vop2_crtc_write_gamma_lut(vop2, crtc);
=20
 =09vop2_lock(vop2);
+=09vop2_crtc_write_gamma_lut(vop2, crtc);
 =09vop2_writel(vp->vop2, RK3568_LUT_PORT_SEL, vp->id);
=20
 =09vop2_vp_dsp_lut_enable(vp);


