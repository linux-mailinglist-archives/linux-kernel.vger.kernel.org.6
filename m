Return-Path: <linux-kernel+bounces-199063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C758D8183
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB304B22F04
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C0985650;
	Mon,  3 Jun 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSlPDIH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960D85291
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415244; cv=none; b=PRFBqAnQaLDAa1El/kwSCMBgztUuNXN2dx+cCJWXR8wSxOs9jrblZEBMhfB+pJpjsTgfwEjnh42SoYSXZPg+mOrB97spopQbsKn7WzkOsGiFh1U75R/KzEtF/FdlmN0X7coCdG7Szm0xKXC+KoDT3S1YxsHgcpZBHOw2CUjVuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415244; c=relaxed/simple;
	bh=3Im1QpDdWkDh0sb6TFhqrVvzJ24+046kZtmwGLRL/Jk=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=bDAAdxf+otRCn2StO724Uly5wLB2zZI6YpGEQGyZ85hDTrKUoYdgb6U8YjARotJq9ipBTOgyjKS4q7NSnE01YRkPeKPRXIQ/QkHpB01sCwYII16ha7RCQA6IAnMwopi8OTOFqSNoxhDAQDmIPCNcYEsuHooBcQV9hFMgZQI9qQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSlPDIH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419B4C4AF09;
	Mon,  3 Jun 2024 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717415244;
	bh=3Im1QpDdWkDh0sb6TFhqrVvzJ24+046kZtmwGLRL/Jk=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=tSlPDIH/gvTaPGlTgTDQUmrEB6CAdfgyZ/5kDLkDs7vbBlI/Pymu4Om48sGbmFPCA
	 6+CD1r/ZA4L81E/q6P6S+Gjq8DOZ2aHj9JaX1aXHiE2SuUADHKMCiYxTL+ScKsC/8Q
	 Yt9q3mq7nVNVyYlWYCjxk4m9jWeVym667qQr0rKxw3FvC+EhhsA9N0M10phRAR6tP1
	 uHp/pSygLH1l6mqFqTsbE69SC9gN9OS1b+L4uNN3DBE7oTYvPh7m8zS/IBkR4sgOc4
	 KF+4Rn+j5gueKjR1/4oCmeX0acmRsUUFVxPBFmogw46N+kd6KbppQf1fAnzf3dQ3cq
	 5QZbui0BORiVQ==
Content-Type: multipart/signed;
 boundary=65f0fc295269b97015ccf49f95fa8248b459b679f76c7412027362baf4cb;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 03 Jun 2024 13:47:20 +0200
Message-Id: <D1QCW5G2I7E0.2MM683BWHR5N1@kernel.org>
Cc: "Daniel Semkowicz" <dse@thaumatec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Chun-Kuang Hu"
 <chunkuang.hu@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Sam Ravnborg"
 <sam@ravnborg.org>, "Vinay Simha BN" <simhavcs@gmail.com>, "Tony Lindgren"
 <tony@atomide.com>
Subject: Re: [PATCH 00/20] drm/bridge: tc358775: proper bridge bringup and
 code cleanup
X-Mailer: aerc 0.16.0
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
In-Reply-To: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--65f0fc295269b97015ccf49f95fa8248b459b679f76c7412027362baf4cb
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon May 6, 2024 at 3:34 PM CEST, Michael Walle wrote:
> This patchset fixes the bridge initialization according to the
> datasheet. Not sure how that even worked before. Maybe because the
> initialization was done prior to linux (?).
>
> The bridge has some peculiarities:
>  (1) The reset has to be deasserted in LP-11 mode
>  (2) For I2C access the bridge needs the DSI clock
>  (3) The bridge has to be configured while the video stream is
>      disabled.
>  (4) The bridge has limitations on the display timings. In particular,
>      the horizontal pulse width has to be at least 8 pixels wide and
>      both the horizontal pulse width as well as the back porch has to
>      be even. According to the datasheet the horizontal front porch as
>      well but in line sync mode, this is ignored. Also line sync is the
>      only supported mode for this bridge, therefore, the front porch
>      is always ignored.
>
> The most controversial patch is probably "drm/bridge: add
> dsi_lp11_notify mechanism" which is needed for (1) above. Some time ago
> there was a series [1] to add a manual power-up, which was abandoned and
> which didn't suite the needs for this bridge anyway.
>
> Also, this will gradually change the tc_ prefix to tc358775_ while the
> functions are refactored.
>
> The bridge was successfully tested on a Mediatek MT8195 SoC with the
> following panels:
>  - Innolux G101ICE
>  - AUO G121EAN01.0
>  - Innolux G156HCE (dual-link LVDS)
>
> [1] https://lore.kernel.org/r/20231016165355.1327217-1-dmitry.baryshkov@l=
inaro.org/

Any comments on this series, besides the discussion on how to do the
reset during LP11?

Most of the other patches should be more or less self contained.

-michael

--65f0fc295269b97015ccf49f95fa8248b459b679f76c7412027362baf4cb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZl2tSBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gPqAGAvrp3hTLYUbjIYBOpNYq9pcLyYAkX0L1M
pnxRMxFhmPLqiUGqptlFhUG/89N83cXRAYDf5X6gn9jZ6lVGmpOmSM8iYxeTgaBT
q/FJmhXj6+H0qREQl40LYeF7XWWiPR5wO9c=
=K1xu
-----END PGP SIGNATURE-----

--65f0fc295269b97015ccf49f95fa8248b459b679f76c7412027362baf4cb--

