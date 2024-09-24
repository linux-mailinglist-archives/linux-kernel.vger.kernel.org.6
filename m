Return-Path: <linux-kernel+bounces-337219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119E2984723
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC492284356
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF061AAE22;
	Tue, 24 Sep 2024 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRG32gE1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA41AAE0F;
	Tue, 24 Sep 2024 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186338; cv=none; b=iPJh4VraekdtjE03COGJi6pw+fSXiVFqPiDGmnULMv9dy7Bqx6KQvuTeiqZqDgepzI9+dratRV0k0pqb4pNpXeyc4a8Ku1kgckFeDy06xVmfRsbqjKM9sO0ihyNsjvfi+JQ9w2M/6AAKitWPz+WXv8XgGWUxsylFT3eLntRV/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186338; c=relaxed/simple;
	bh=wOmAV/NVLES4Ot48enknKQtgF1inWU6rd8X6FWlO0uM=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=lx2fi0/weAUDOJi4+VnPmOKtTQRdHrYY+8b/BGfRahCAFqzW3Hqm5SwUKaT6X4hTKTMcDOfk1QrpX8vcUotCRO2yJqke3iwjxLa+Qz7bs70pHurOhAQxsfWkN/c7uzCvmHjXCEYhrcRc7WO/44Zk/xka2M7uhO0dlVXpxnFCbEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRG32gE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC29C4CECD;
	Tue, 24 Sep 2024 13:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727186338;
	bh=wOmAV/NVLES4Ot48enknKQtgF1inWU6rd8X6FWlO0uM=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=JRG32gE1VKNj4N+5DNAxkHvHz/CX1JdjHGhy9bm28gSPxCjinn+c5Tuo1TiBbChXM
	 mUpbI0EVjkhhdCAr4pT/ctEN7TPDayOO4gn+88agO/VctgNpiGW2olGHNcP4qtMhDz
	 TNYPBA39zkbx7w2NVZGSqteanVouQvXE3Dp1mBDy6qtdbvRTbpex909QA6pjXdehbM
	 kdoKkTZPxwunnXwKV/hWPA1hRCAkUxsFsWz9sQTFvert+qZhIEUeJxN+dHk4i7UIl/
	 huU8XLhyuxIsZRbiz4NPO655yyR1Cs8qC1IoSLOruIyFoLJq+Rrci0tSglT1v857TB
	 GNTAZMsNMTiLg==
Message-ID: <097f09d73db95dddcccfec9008e2a362@kernel.org>
Date: Tue, 24 Sep 2024 13:58:56 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v7 1/3] drm/bridge: synopsys: Add DW HDMI QP TX
 Controller support library
In-Reply-To: <20240914-b4-rk3588-bridge-upstream-v7-1-2b1348137123@collabora.com>
References: <20240914-b4-rk3588-bridge-upstream-v7-1-2b1348137123@collabora.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, "Alexandre
 ARNOUD" <aarnoud@me.com>, "Algea Cao" <algea.cao@rock-chips.com>, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Andy Yan" <andy.yan@rock-chips.com>, "Conor
 Dooley" <conor+dt@kernel.org>, "David Airlie" <airlied@gmail.com>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Luis de Arquer" <ldearquer@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Mark Yao" <markyao0591@gmail.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Robert Foss" <rfoss@kernel.org>, "Sandy Huang" <hjc@rock-chips.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Simona Vetter" <simona.vetter@ffwll.ch>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Sat, 14 Sep 2024 21:56:51 +0300, Cristian Ciocaltea wrote:
> The Synopsys DesignWare HDMI 2.1 Quad-Pixel (QP) TX Controller IP
> supports the following features, among others:
> 
> * Fixed Rate Link (FRL)
> * Display Stream Compression (DSC)
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

