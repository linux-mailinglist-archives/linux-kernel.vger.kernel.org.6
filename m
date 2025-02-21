Return-Path: <linux-kernel+bounces-526241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0199A3FBDC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3590E18963F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0E1F3FD9;
	Fri, 21 Feb 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=szczodrzynski.pl header.i=@szczodrzynski.pl header.b="2hls+aUo"
Received: from s2.avantea.pl (s2.avantea.pl [46.242.128.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF21F12EC;
	Fri, 21 Feb 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.242.128.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156037; cv=none; b=XSj3gVPZJ3q1S7DBYxULw1KZWgqc7XucTiQljOgYgqPRM84Xl/Y+QPtMNnaSH8BpfdFUePHURjNfntAxK67y1rgRkxF8Jqzjh8A81pBJ4jmOI4ODaCgtJK7j+vjVpWLua7ZlqM6h5D+1qSmT/bao7q/bafrwxjmSHMIJZJxoTyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156037; c=relaxed/simple;
	bh=ZVmiymIAhMQOMLZ34be0QbNLgSkp+U56bA+I1slqbnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hSFAAzEBh4mMa+IVU+IncdZGc/asjs0a83G7mfmMp3lsky0b5BeGV5tDt+6S5gVOhLX8YnDVf9890io2m6QRu9QZOh1hLUSrFz9391Y+k4/K1G30DYgmltCbuu2ouVcUY2ynyXPuyTwriR24hgETuOGZhLA50CRefINbuP5ehYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=szczodrzynski.pl; spf=pass smtp.mailfrom=szczodrzynski.pl; dkim=pass (2048-bit key) header.d=szczodrzynski.pl header.i=@szczodrzynski.pl header.b=2hls+aUo; arc=none smtp.client-ip=46.242.128.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=szczodrzynski.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szczodrzynski.pl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=szczodrzynski.pl; s=x; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7RHCIXkAEB3Q6gvisTKmVhU8q9lDZL30dJeI5tINmhs=; b=2hls+aUoDtpBz0zvI2ZI+E++3Y
	2siSdOmW4PBTuCYqdXDVDUjQQzkZolBRiM/lcNIyuEBi3qoke0fXe8kGHUj0EXivc5mMo90iPZlOj
	UugrMUSaZD6WPVVUXYBxfZ8qRsQpzkHGvN6lGAQVlprOSt+fsD+ZFLtNob53O7VRou3OqBDqpToaD
	O3Lmfdm+LI+F2GigjHqX68zctIEpDRVm+PgNmysmtiegJsoUH25nBghgwpD2+0aKgU5q7WPMf0xpv
	OLkrjOlqMvbx5EFFJlFxp5sAIQKRbDi1NJXVyvPkA9JrUsf4gM3A21nFS/uNLty+KLTvVlBrRC7mA
	SXhLlq+g==;
Received: from [62.171.184.96] (helo=buildhost.contaboserver.net)
	by s2.avantea.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96-58-g4e9ed49f8)
	(envelope-from <kuba@szczodrzynski.pl>)
	id 1tlVit-00AOLX-29;
	Fri, 21 Feb 2025 17:17:55 +0100
From: =?UTF-8?q?Kuba=20Szczodrzy=C5=84ski?= <kuba@szczodrzynski.pl>
To: Maxime Ripard <mripard@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/5] drm/sun4i: Support LVDS on D1s/T113 combo D-PHY
Date: Fri, 21 Feb 2025 17:17:46 +0100
Message-Id: <20250221161751.1278049-1-kuba@szczodrzynski.pl>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: kuba@szczodrzynski.pl

Some Allwinner chips (notably the D1s/T113 and the A100) have a "combo
MIPI DSI D-PHY" which is required when using single-link LVDS0. The same
PD0..PD9 pins are used for either DSI or LVDS.

Other than having to use the combo D-PHY, LVDS output is configured in
the same way as on older chips.

This series enables the sun6i MIPI D-PHY to also work in LVDS mode. It
is then configured by the LCD TCON, which allows connecting a
single-link LVDS display panel.

Kuba Szczodrzyński (5):
  phy: allwinner: phy-sun6i-mipi-dphy: Support LVDS in combo D-PHY
  drm/sun4i: Support LVDS using MIPI DSI combo D-PHY
  drm/sun4i: Enable LVDS output on sun20i D1s/T113
  riscv: dts: allwinner: d1s-t113: Add D-PHY to TCON LCD0
  riscv: dts: allwinner: d1s-t113: Add LVDS0 pins

 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 10 +++
 drivers/gpu/drm/sun4i/sun4i_tcon.c            | 40 ++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |  6 ++
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c   | 65 ++++++++++++++++++-
 4 files changed, 119 insertions(+), 2 deletions(-)

-- 
2.25.1


