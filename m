Return-Path: <linux-kernel+bounces-540077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045CBA4AD59
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC45C1896AD9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40551E5716;
	Sat,  1 Mar 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RAXDiiw1"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D11C5D61;
	Sat,  1 Mar 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740853710; cv=none; b=YpmE6MoHFpuTerdQ4YPzvZrEH276bFNt+NFtDVrwfisMz5VBHPtbt0rO86DrkdRdT5jUMA8S+OYojVyKUZ8utc7EF7KaVse5T5kwouNKyckSaB2hqIkIjZ2H+kMWkifLEDO//IyO7b1KY2lLCe8a8uP8Bx+qeywB5avo5eH8dMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740853710; c=relaxed/simple;
	bh=HbQ1yPq8BeEqX0CXAVNZ0UfzgnFZIeuoYkVsuEjiOew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dgyis+REQSUFMESONZnL1tvG/LQqgthwCSjfNh9g3d4Smm7Lv4adShHPeUdq/nLGhCueiPnFDm3g5JpSLUjy5xbDrWga/1Y+3dRg7uogSG/ywvI05bSPzB3PzxgAn73QHlw3WsTXcSLp+qtzM4WkRx2ACVo9PZEA+rFBHsX0qgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RAXDiiw1; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HbQ1yPq8BeEqX0CXAVNZ0UfzgnFZIeuoYkVsuEjiOew=; b=RAXDiiw1szmRllTLCsfWYIkABt
	5M8maW8X5dftva5kJfNjYhbrEiREaIWbM3x+REQqlJL7bcCn1Z10xqzpbfZvPVIT45jUIVO9A+eKG
	Cbz3lXNaXNOS3gfbZe/yiGJh+8tRby+A2h95UQq9uCqY9eh9Jwqza2aZ3B1OkJ5Ub9JEF0RIv0vGP
	C/ExROWSCvB54jyp+5F+wTqmDq8p07T70hGukeIUGZH3yPeWFM+I9IDYdziOdyfh7/J5UvhOXmvm9
	hpVnlBWNUkTlOZvyvlyvemfMDjWahGTZ48J0KUdCFiVEthOngTmp8xf9oJHRfGF9ogTWYCH9m137n
	x7hiSpMw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1toRZ4-0001tc-FW; Sat, 01 Mar 2025 19:27:54 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Detlev Casanova <detlev.casanova@collabora.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Algea Cao <algea.cao@rock-chips.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 dri-devel@lists.freedesktop.org, Niklas Cassel <cassel@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, kernel@collabora.com,
 David Airlie <airlied@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org,
 Chen-Yu Tsai <wens@csie.org>, FUKAUMI Naoki <naoki@radxa.com>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v7 0/3] Add HDMI audio on the rk3588 SoC
Date: Sat, 01 Mar 2025 19:27:52 +0100
Message-ID: <23891130.6Emhk5qWAg@diego>
In-Reply-To: <0A30138B-183E-4816-80FF-AACDCFE3B3A6@gmail.com>
References:
 <20250217215641.372723-1-detlev.casanova@collabora.com>
 <3337030.aeNJFYEL58@trenzalore>
 <0A30138B-183E-4816-80FF-AACDCFE3B3A6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Samstag, 1. M=C3=A4rz 2025, 10:11:54 MEZ schrieb Piotr Oniszczuk:
>=20
> > Wiadomo=C5=9B=C4=87 napisana przez Detlev Casanova <detlev.casanova@col=
labora.com> w dniu 25 lut 2025, o godz. 15:58:
> >=20
> > From what I see, the error is not present anymore on linux 6.14-rc4. I =
tried=20
> > reverting your patch "ASoC: simple-card-utils.c: add missing dlc->of_no=
de"=20
> > (dabbd325b25edb5cdd99c94391817202dd54b651) and the error reappears.
>=20
> Guys,
>=20
> Just FYI:
>=20
> On 6.14-rc4 without 0001-ASoC-simple-card-utils-Don-t-use-__free-device_n=
ode-.patch - i still have oops like this: https://gist.github.com/warpme/ed=
75c05d3b68f995d429dbd9097005ba
> They are happening not every boot - but still happening.
>=20
> However applying 0001-ASoC-simple-card-utils-Don-t-use-__free-device_node=
=2D.patch (with some adaptations as it not applies cleanly on 6.140rc4) - d=
mesg becomes clean (10 boots; all ok)

that patch was submitted yesterday [0], so hopefully will make its
way into 6.14-rc next week or so.



[0] https://lore.kernel.org/all/87eczisyhh.wl-kuninori.morimoto.gx@renesas.=
com/T/#me866307a928c2d592a2ba883867f028c5c8b9b40



