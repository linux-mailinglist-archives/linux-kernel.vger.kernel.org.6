Return-Path: <linux-kernel+bounces-538906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB21A49EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714D93A29C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC155274255;
	Fri, 28 Feb 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fJo3LuEK"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E527424E;
	Fri, 28 Feb 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759845; cv=none; b=YrIt8P1V5+mjKojhM1pb3T/vMFLs2ScIHvBtnRABImPbJvVjLlirqbEx3ZIzfW/++2aoWF8GiNHMia8CpekBWfibIR5nlojxjxRfPOSNRpZjTxudExlHgrJMUNdFrbDIPPnwp45OaEWT21X/jwCobvXeAfVjANA9z2rxdTIyA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759845; c=relaxed/simple;
	bh=B3WjmkvjpILdVi2j1q5otuhwVoDcjg9HxmWCQJcB5kc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lSmI2aLpK2Hf3hbvKOUxE58C6SZrJK2ua/na5TlcJiAcS9EPwHtnX7A+Ijyz3qqyTjzwfgdwDgkwKuTnH1MGe6NfrbcXVLO1WO0LRTRaKF5B8o5UE7aWBRXoH9KFJV7iUyLm1ZZG15kTSkxRI/WXpK9fasG9PPiwefBqXvvt7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fJo3LuEK; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740759839; x=1741364639; i=markus.elfring@web.de;
	bh=wc+tFxfogX72xbNQ0v+6GhtULwhFug+e+zNf2YFFKo4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fJo3LuEKKv4cLVspEqgirzgxy6OV5JKEWseS7Tq0fsMgFIp0mZ3tjMzobZTGV5O4
	 vUDAGs4KdCgyHtsewTD18QXYzIN1uoIkK6IKtNgN1iD36/rN1dwxGhGajtpjbDub8
	 +dFpJyyJpU5Iaa3alOIZsBD9exvXPMMEvuGkdFD1csqDCfARVCrYKeYqSSvw9tWCj
	 NMiuJP3Pa/ShezrpYEJEn5fR6zORVmWwfPX4Vq/kNlmTlwLZ3J4Lu/ltujULlPaeC
	 M89VE0ob3sxFm7ol8aIpJvB6EJobdWfbG2oZA53dIe/hUpJmRoyr4wQDgn9IMCDhn
	 nUVX+zOpGusYtBqNhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.27]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjIE-1u07yl3FCW-00BBlj; Fri, 28
 Feb 2025 17:23:59 +0100
Message-ID: <ecc5cb7f-b28f-4055-ab60-26e76f65685f@web.de>
Date: Fri, 28 Feb 2025 17:23:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Qasim Ijaz <qasdev00@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm: Simplify maximum determination in drm_ioctl()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mtxLx4Ax1FUZU0kM7TZ4SiveHNkV/rUL0KOhNRHh8RY9UxBqp1I
 thNtRttuKCR7wGyEGJatzlGi9eqsLWJGSJnHFNGnZc/S+x8fmzZdBTbtJsKOF8sEfmg2kRe
 beiDUviEFQc9UOmXPAhjmATdSB+jgKYs1/9xJlyaFRsi2T/s8UU/NkabH8mZLKoO50w9m94
 is2dnoNeZBMBIu8CUU1Fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Er3HrmsjsRo=;ZQ96CCkkQWB0stB8LJGyzZH1TBf
 Kux5qvPEP+biUfF0IpuJ/zEHME6gGpk5ii3bWNcUuFxeq021CvRYr/QYVrqo7luCakHmPpqkG
 pvrRw3rkg0e+Bocmuhd/S5rLJfY8+q311mDUL92MG+afyPSoDgTeHPrVu6WvvMSVSh1L7wYpR
 DBP2W18jx8navSPIdH9GBOGVK4hvzmycwYcTaHFCApoytxa7DKasZmHdsyAgWAHb+6YhyYSiU
 hpcm2iaifRfVSRGF0bbIGG7I1B9DSxUJZ8407UfOTIU8O/sPVzRZB3MHn6jVRjGLJ54hl+djw
 fWsuKaxyKKFtFUUich99KOhGWowpPFTXyQR3wIJUalacM/vuAFR8X/GVUTO7IbNibMHWfZSYE
 FgP2XXrg3R80vo0NfUF7t037ZNC//M3n1YnFILAc3tWkGVDiCp2VH3dtdxEHn/esHfF+GPddT
 xn43Gtt5sgzuvaDMk013c+OHbdC+tUPCRJqs5ThiSAlZGcZTMHNF2Wdbx21RY52DzFIL8exrk
 PgE9ylAjiyxaR8s0PMZ4eBctGGYQgokMTBgDvvv0i39fqTCksxi+PxZdNiEJnuIBSC/vzjIaI
 7rBDoX07l7PIU7CVjoDCjGKgrEZwSq9DyDsQ1Az9kCEioRYqIrGuDmNiz0z86ogEjbXxmHXYO
 w0jDy5zdsO7P8b+UbHX6AlmVDRonihcpIV35+hxXQxByr3MMorhJlIbdO1Xla6RovAuTEM5Xz
 m+yrVTiP7nQXj9oPtCQ1+x79I1Jz8PTXRlVOs2r+sSxF/IcKX6ct5KbCaEmDLqZ+JXS2lEKWd
 9uIKSoH+OYS2xqGAs4sXDH2LTFno/5C3iHH94z2s70qKElqeSraN4RYTnsNrZR922wjxjY+DS
 eGXbyimCf8GAqDnGHcwYPtyBUquLfWq906iCkTA+/6QSz2icpp8d9qqVPRc0swJfiMY6iRQr8
 fpsGFW7dmEmdcBzZMxLvX5HivoOEmCJYu82esII1JqNicbDJecqh78dR7OQwuoLgoqMhrvlof
 Bh+GRwEoj+rhqarphPn8n5azn6ncVPcRfGL8oSXI/WmPs+KoiGGLDPlNzoDZZYJaoQgtOMrij
 ze20HWyXdd0I86pSzQNrH+jXFaoI0L8SIC6k9Lfo0gRey5y7zcUlY/ealfq7Fe6vSeSlnpU6M
 cEyamN87lvTuKZoEPvs6b6sy1MJm56NIdkHQo38jpaOUVEMjIMYCzj58PyeK7/5l8xqJrvpQv
 8xjEAtGLFi1708Z8qPLUyaEmtDjFMsZygsGPfFNwZCrbgNwkn2m3mbVQ6amUWbUUH2JxOe7qq
 E24hlwcclIg2BwfCdSmWyiotkfVwJy1l+N7Gj1NCBq7J3bVEu86Ib9l6cvbjeXrGAEFrmxOt6
 tXG3KuhVen6PhTwmM+V6oDWAD54cz1nUllDlgBeNtmotjN8H2tJWM7d378jRB7tFNS/NedR/4
 kmCi/Vw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 28 Feb 2025 17:18:07 +0100

Replace nested max() calls by single max3() call in this
function implementation.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/drm_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index f593dc569d31..115a8eb0d8a5 100644
=2D-- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -856,7 +856,7 @@ long drm_ioctl(struct file *filp,
 		in_size =3D 0;
 	if ((cmd & ioctl->cmd & IOC_OUT) =3D=3D 0)
 		out_size =3D 0;
-	ksize =3D max(max(in_size, out_size), drv_size);
+	ksize =3D max3(in_size, out_size, drv_size);

 	drm_dbg_core(dev, "comm=3D\"%s\" pid=3D%d, dev=3D0x%lx, auth=3D%d, %s\n"=
,
 		     current->comm, task_pid_nr(current),
=2D-
2.48.1


