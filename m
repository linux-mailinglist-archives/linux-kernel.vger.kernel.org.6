Return-Path: <linux-kernel+bounces-170168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1AA8BD2CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA51F24302
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA795156864;
	Mon,  6 May 2024 16:29:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49A156C5F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012944; cv=none; b=IUGAs7M4MoDypOdm4KP0O7V5ZFk0f92iKSBo05dbr2V2yFbWGxqJ8odGLGU5YgLfK5KxTr+sbhRoYfvobfCcA9cXTmYJCcqMf2TgVIRQrU0H5BSCIrEwzbgas9r5DkT5xe3UEZv6yyP8ee0/ZYfLFDnH3YL3fvn1YiYyOr7E4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012944; c=relaxed/simple;
	bh=G+z0/hQtCD+wvrY4kxXcRA5auY8F5tKt+wPRD7j0mRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBVJrRhm+dJE0CTkDZlX3UZm01Cm5g4uj6vsLmJTb4JPY1E9l+vvkul1qGyrtUT9rafdH8PQBD2DseYAmpDAfn9g724jLGg5WTUFFWmP2lmRzaDXpa/AhBx7pDC4e0GBhEBcwwQhx8Oo9Rv+BEiczqipZb+TNrg7XAV4zX+fhG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s41Cp-0007mZ-6s; Mon, 06 May 2024 18:28:47 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Douglas Anderson <dianders@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
 Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [RFT PATCH v2 08/48] drm/panel: innolux-p079zca: Stop tracking
 prepared/enabled
Date: Mon, 06 May 2024 18:28:46 +0200
Message-ID: <6928663.G0QQBjFxQf@diego>
In-Reply-To:
 <20240503143327.RFT.v2.8.I99c73621fe3fba067a5e7ee6a1f6293c23371e1e@changeid>
References:
 <20240503213441.177109-1-dianders@chromium.org>
 <20240503143327.RFT.v2.8.I99c73621fe3fba067a5e7ee6a1f6293c23371e1e@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 3. Mai 2024, 23:32:49 CEST schrieb Douglas Anderson:
> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> double-check before, that double-check is now in the core and not
> needed in individual drivers.
>=20
> Cc: Chris Zhong <zyw@rock-chips.com>
> Cc: Lin Huang <hl@rock-chips.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: "Heiko St=FCbner" <heiko@sntech.de>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

the underlying setup (rockchip-drm with dw-dsi) as well as the
change itself is similar to the ltk050h3146w variant, so I don't
see how this should behave differently ;-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



