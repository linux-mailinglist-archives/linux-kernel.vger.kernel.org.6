Return-Path: <linux-kernel+bounces-199172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42368D836A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FA31F26F16
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9528A12CD89;
	Mon,  3 Jun 2024 13:03:51 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D882D6C;
	Mon,  3 Jun 2024 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419831; cv=none; b=ONPlsSxrYpm24YW50S4fTeBbxiPF6wuhOjA/ttDvYNZ85c3LSnuIKVcMOUARVw/wSXrxM343snt9J9JG9cDaBvbns57OxcJalmSsoSofm1piNxeXng1uG6XYTrvGE6CMOGgBt13ZNMkLWdOAILfZ9HlYNUHPVJDHfO05BOk43pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419831; c=relaxed/simple;
	bh=pQwAZbSp6yuqdG6HclzfMC9AWq7yy7DmsrfsUxhagdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRXGUmEO0qjF78zcYZt3KsOVVZ+/wWAJC51RzEraViCXLZGFyDc/7k+bvNqvyCNucoQtii50RLq0VkxQm7NEjPz9q1tAmpXK0w4rpMgOmOjPXTWRGBiMxntQu+zXGAI+gdQ2gsBoVsrCHxt3Vvz6p1NaRK/mKiXh33nnivXjwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sE7LG-0007Q6-KA; Mon, 03 Jun 2024 15:03:14 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: neil.armstrong@linaro.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Yao <markyao0591@gmail.com>, Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
Subject:
 Re: [PATCH 00/14] Add initial support for the Rockchip RK3588 HDMI TX
 Controller
Date: Mon, 03 Jun 2024 15:03:12 +0200
Message-ID: <11359776.NyiUUSuA9g@phil>
In-Reply-To: <ab0a6372-091b-4293-8907-a4b3ff4845c0@rock-chips.com>
References:
 <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <a4b22708-e85d-448a-8145-244b49bca053@linaro.org>
 <ab0a6372-091b-4293-8907-a4b3ff4845c0@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 3. Juni 2024, 14:14:17 CEST schrieb Andy Yan:
> Hi Neil:
> 
> On 6/3/24 16:55, Neil Armstrong wrote:
> > Hi Christian,
> > 
> > On 01/06/2024 15:12, Cristian Ciocaltea wrote:
> >> The RK3588 SoC family integrates a Quad-Pixel (QP) variant of the
> >> Synopsys DesignWare HDMI TX controller used in the previous SoCs.
> >>
> >> It is HDMI 2.1 compliant and supports the following features, among
> >> others:
> >>
> > .
> > 
> > ..
> > 
> >> * SCDC I2C DDC access
> >> * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
> >> * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
> >> * Multi-stream audio
> >> * Enhanced Audio Return Channel (EARC)
> > -> Those features were already supported by the HDMI 2.0a compliant HW, just
> > list the _new_ features for HDMI 2.1
> > 
> > I did a quick review of your patchset and I don't understand why you need
> > to add a separate dw-hdmi-qp.c since you only need simple variants of the I2C
> > bus, infoframe and bridge setup.
> > 
> > Can you elaborate further ? isn't this Quad-Pixel (QP) TX controller version
> > detectable at runtime ?
> > 
> > I would prefer to keep a single dw-hdmi driver if possible.
> 
> 
> 
> The QP HDMI controller is a completely different variant with totally different
> registers layout, see PATCH 13/14.
> I think make it a separate driver will be easier for development and maintenance.

I'm with Andy here. Trying to navigate a driver for two IP blocks really
sounds taxing especially when both are so different.

Synopsis also created a new dsi controller for the DSI2 standard, with
a vastly different registers layout.

I guess at some point there is time to say this really is a new IP ;-) .


Though while on that thought, I don't fully understand why both a compiled
under the dw_hdmi kconfig symbol. People going for a minimal kernel might
want one or the other, but not both for their specific board.


Heiko



