Return-Path: <linux-kernel+bounces-514513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD911A357F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AD73A8C88
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155FD20C034;
	Fri, 14 Feb 2025 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Ln6N8mWX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aG5yRY79"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1292F15573F;
	Fri, 14 Feb 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518459; cv=none; b=eb78UkxBexoxNzsDHRjQDDEX6EoJ4Sj4Vnsqt3cnuYObpvonhg0e1pol1KwY9ME8gsGFLvROcAFkjOM/P9oCDFEkkD21P60kreaNs36GoPOtlmvPy34/DRBPS5xnxEqo5tDXYG/koGUmJZVHrSnviSjfeMIjYZL1JM7P+uyyzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518459; c=relaxed/simple;
	bh=t0RRQcNs3xk62uBWPaYuG8GD/ubv1IKgcm17hsshzSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRU//gZ/IoE77chSbVk9Eo2xL6Yjm4BOMiZVRqb0kmSSJyB978TZ3QvlmPfXkR9VMMTm/IOBpghO/xAV4eWECHodX6sTR2mV7ZQt91odwYN0q2Ac1Q+rgZGeSEqQcFwoK1o1U2s0mbLelWZvPK8ivSm/Z3w2ebNwePRRrb05EbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Ln6N8mWX; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=aG5yRY79 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1739518455; x=1771054455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqBLyZA03PfD+/Z73Ovi+UOnmR4xxrTEqCfGNVFEHgs=;
  b=Ln6N8mWXf0Vnb17I5UXidtLM9oUR10TYzodGjypHt6vZcexjXk21POpj
   o/W2k/b9p8uLDIwu0a0lzaPVg82YgGIgxhJobudLcS7MR/9mbG69RfkoN
   46zw3Cwhf3qtEZijtZ6uvrkq1Br7KMMT9JM/fRuXnQkpYDbIXFqXXYGji
   t/p8AmCbGLzqS0Uk/bQ1Lv4icJeNJm2EubFAc1FenyMjkuwU7wEmXxCzE
   2LkXnkGFcdgj1O7LxFXE2HulSSftPjUmar+jkm2ZvOA2ylFCczE0DozlY
   8CEagejahEbNm8LXBeWtH0WlGuODE3TGqR1hWZRZj/Myxvr9qr9hsv+wC
   w==;
X-CSE-ConnectionGUID: VmwVF+vFQgS7wY/KlJlFVA==
X-CSE-MsgGUID: xLlWDxviTo2lQMr3EMGI2A==
X-IronPort-AV: E=Sophos;i="6.13,285,1732575600"; 
   d="scan'208";a="41845952"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Feb 2025 08:33:56 +0100
X-CheckPoint: {67AEF1E4-9-EBA888C4-C1AC8B84}
X-MAIL-CPID: F48EE102AD0F0138F0FF3E9174C0B0BC_0
X-Control-Analysis: str=0001.0A002123.67AEF1EF.0012,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29BAF16B879;
	Fri, 14 Feb 2025 08:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1739518431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqBLyZA03PfD+/Z73Ovi+UOnmR4xxrTEqCfGNVFEHgs=;
	b=aG5yRY79cPuYPJezU0ratTDxHgDNxG6xLeVjTezdVN4mXg+a1VWNKBHCmpQVPnnXzukx9g
	h95qwjPurFMmuABsaPOB0ekrdQZi7ge4C9QPNlj77A6VSxhipTQ8ZSMrwkUIxfe488zYEL
	lFetBKr+oePS25yaltr7HdZQfLSmB8G1/yCSPpaW06/66uRmOcWwV5bVn2sJfieKvgAhDu
	bNRocf8g/8ty/TGeWHB71nJPPF8Eq77DMiZ8AzOqPzKcJJ5MaP7021TWoiYMJBTshs2G9H
	Fa5yhCRV+TH6lLAouv4RcyzTuQW2kylAn/dKUt9cdunmCF3UJISZWe5rxvktZQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Marek Vasut <marex@denx.de>, Herve Codina <herve.codina@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v6 0/4] Add support for errors recovery in the TI SN65DSI83 bridge driver
Date: Fri, 14 Feb 2025 08:33:46 +0100
Message-ID: <2023388.usQuhbGJ8B@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250210132620.42263-1-herve.codina@bootlin.com>
References: <20250210132620.42263-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Montag, 10. Februar 2025, 14:26:15 CET schrieb Herve Codina:
> Hi,
>=20
> Usually the TI SN65DSI83 recovers from error by itself but during ESD
> tests, we have some cases where the TI SN65DSI83 didn't recover.
>=20
> In order to handle those cases, this series adds support for a recovery
> mechanism.
>=20
> Compare to the previous iteration, this v6 series fixes a NULL
> pointer dereference.
>=20
> Best regards,
> Herv=E9 Codina

=46WIW
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> #tqma8mqml-mba=
8mx

> Changes v5 -> v6
>   v5: https://lore.kernel.org/lkml/20250203161607.223731-1-herve.codina@b=
ootlin.com/
>=20
>   - Patch 1:
>     No change
>=20
>   - Patch 2
>     Add 'Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>'
>     Add 'Reviewed-by: Maxime Ripard <mripard@kernel.org>'
>=20
>   - Patch 3
>     Add 'Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>'
>     Add 'Reviewed-by: Maxime Ripard <mripard@kernel.org>'
>=20
>   - Patch 4
>     Add 'Reviewed-by: Maxime Ripard <mripard@kernel.org>'
>     Fix a NULL pointer dereference reported by Alexander Stein in v5.
>     Mode the dev_warn() signaling the pipe reset closer to the pipe
>     reset operation itfelf.
>=20
> Changes v4 -> v5
>   v4: https://lore.kernel.org/lkml/20250203145824.155869-1-herve.codina@b=
ootlin.com/
>=20
>   Exact same changes as the v4. The v4 series doesn't apply on top of
>   v6.14-rc1 and should be simply ignore.
>   This v5 series is the v4 fixed to apply on top of v6.14-rc1.
>=20
> Changes v3 -> v4
>   v3: https://lore.kernel.org/lkml/20250108101907.410456-1-herve.codina@b=
ootlin.com/
>=20
>   - Patch 1:
>     No changes
>=20
>   - Patch 2 and 3 (patch 2 in v3):
>     Rename the helper to drm_atomic_helper_reset_crtc()
>     Split the patch available in v3 in two patches.
>=20
>   - Patch 4 (patch 3 in v3):
>     Take into account commit d2b8c6d549570 ("drm/bridge: ti-sn65dsi83:
>     Add ti,lvds-vod-swing optional properties"), available in v6.14-rc1.
>     Disable irq when a fault is detected and re-enable it after the pipe
>     reset.
>     Remove state duplication and use bridge.encoder->crtc directly
>=20
> Changes v2 -> v3
>   v2: https://lore.kernel.org/lkml/20241217143216.658461-1-herve.codina@b=
ootlin.com/
>=20
>   - Patch 1:
>     No changes
>=20
>   - Patch 2 (new in v3)
>     Move reset_pipe() from VC4 HDMI driver to a new atomic helper
>=20
>   - Patch 3
>     Use the new drm_atomic_helper_reset_pipe()
>=20
>   Patch removed in v3
>     - Patch 2 in v2
>       No more needed
>=20
> Changes v1 -> v2
>   v1: https://lore.kernel.org/lkml/20241024095539.1637280-1-herve.codina@=
bootlin.com/
>=20
>   - Patch 1:
>     Add 'Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonb=
oard.com>'
>     Add 'Acked-by: Conor Dooley <conor.dooley@microchip.com>'
>=20
>   - Patch 2 (new patch in v2)
>     Introduce drm_atomic_helper_disable_connector()
>=20
>   - Patch 3 (patch 2 in v1)
>     Reset the output path instead of the full pipeline.
>     Update and add more information related to the bridge in commit log.
>=20
> Herve Codina (4):
>   dt-bindings: display: bridge: sn65dsi83: Add interrupt
>   drm/atomic-helper: Introduce drm_atomic_helper_reset_crtc()
>   drm/vc4: hdmi: Use drm_atomic_helper_reset_crtc()
>   drm: bridge: ti-sn65dsi83: Add error recovery mechanism
>=20
>  .../bindings/display/bridge/ti,sn65dsi83.yaml |   3 +
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c         | 142 ++++++++++++++++++
>  drivers/gpu/drm/drm_atomic_helper.c           |  41 +++++
>  drivers/gpu/drm/vc4/vc4_hdmi.c                |  30 +---
>  include/drm/drm_atomic_helper.h               |   2 +
>  5 files changed, 189 insertions(+), 29 deletions(-)
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



