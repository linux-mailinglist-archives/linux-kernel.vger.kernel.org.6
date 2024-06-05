Return-Path: <linux-kernel+bounces-203347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D68FD9C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326C728A2A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F5415FA60;
	Wed,  5 Jun 2024 22:17:21 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E9513C3F2;
	Wed,  5 Jun 2024 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625841; cv=none; b=Fz5voYUHJNhm0Xono7qreLZgmnHb900P0i2nToQcGg5dn/uOLnEhZXWAxfwr617C7F/8BHDurfpOOlwuAKDxJZG4bZ3M+fAQZd9Pzo44kCbbqyILz6OBBbPm6PLq7CC/sJ1/RcNPcgbxYXVBP1zteL1lPUQYN3JYEcpr8oLI9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625841; c=relaxed/simple;
	bh=n+0SQnez5jBfxsz+0xPSktbvqPygijGYkybxnB8gmj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzlHOqr+EwA1sQt9jwp/wdrhQzBUU8hUse6gYA/tK0zVAuvkcfBgE12P7UESm7bMSgMyVm7C8TrSfcDhoOrtIpayZAkmmyG7URI8bSuu3L/UazfB1zUAE+TgmSj6mC8hzx6MlcxZxPvlvq97zRAkZ1XTGth3aS9jehbsSCWctyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b65.versanet.de ([83.135.91.101] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sEyvt-0003V2-CY; Thu, 06 Jun 2024 00:16:37 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Algea Cao <algea.cao@rock-chips.com>
Subject:
 Re: [PATCH 13/14] drm/bridge: synopsys: Add DW HDMI QP TX controller driver
Date: Thu, 06 Jun 2024 00:16:35 +0200
Message-ID: <2827569.XrmoMso0CX@diego>
In-Reply-To: <02e22411-e22e-41f7-8bca-95c8ef5a4346@gmail.com>
References:
 <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <2554679.TLnPLrj5Ze@diego> <02e22411-e22e-41f7-8bca-95c8ef5a4346@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Mittwoch, 5. Juni 2024, 21:58:23 CEST schrieb Luis de Arquer:
> On 6/5/24 16:48, Heiko St=FCbner wrote:
> > Without this change, connecting to a DVI display does not work, and
> > reading the EDID ends in the "i2c read error" below.
>=20
> I had a lot of problems initially with the vendor driver on my DVI=20
> display, and am aware that several changes were required.
>=20
> However, I tested Cristian patch and worked fine. All modes were=20
> apparently detected from the display and they all worked. But maybe I=20
> was just lucky and it was using a somehow cached table, I can't say.
>=20
> This is an AOC DVI display from 2011 with a passive adapter.

=46or me it is an LG IPS235. On its native hdmi input I always get regular
1080p output. But on its DVI input I always ran into the i2c read error
before adding that change.

I guess I should determine which reads actually fail.



