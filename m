Return-Path: <linux-kernel+bounces-423584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5BA9DA9F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89673B21B55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5574200100;
	Wed, 27 Nov 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yf9eqOCF"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED81FF7B1;
	Wed, 27 Nov 2024 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718272; cv=none; b=ckZHvRoSe377sgzEG0Fn9Ae+AvGgtyR0GmihI4KD6tog/eJuD5wML+bgZDFBFPM4jaci1DpgrTLQM9KSaASctMzEeKY7sG7ENIEECu/crTSMb5FsWCCnBrzNuj8YNrj5hRWL66MQatWjRWU04bi8gM2GztqZ2D8Le0x9uaOKgF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718272; c=relaxed/simple;
	bh=G0zjQb7YcT1RBPWRBm9GEV3CE/XK0rV7IqnbkMTcHjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLUTKSjVLNH/9FawlmYcf4+WMFZ8Jf1G8QJUzMhH/mdYvEo2OrfrnIVYed6dCls6qfH12EBJwVKYFDRmoMop+X7CAkz7jSFAzKASw3KTzRDgyes4fTlMmQIYqSI1MiKGidt7zlVhklO2d/QmxBtJdKdxMew1HNInVQvCRhzJX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yf9eqOCF; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PRuTuVIq3JpU5i9Vun6Kp/iyX1Q3OEVdomcFKNsz8gI=; b=yf9eqOCFuF8Cb/5VXuebfFnd20
	Tm0P6rxtSspLNDID/Fb3VD3gr/X1xWfhAsTGFhpkRmhQuHLgB32P8Xfi+dj83G0DADwstV2Orx1zz
	IwbF+S1BTln426TNd7/ySHZ4CJ0nai7/fBEn7LO2Tx3640DZR+eCN8QdNTtuUgjcOkD+FIQKqjtAy
	n64gqnVu+tsvv8T+ct7UC9kqHzvPc5mKs0+DyP+Nuukmw8j2X09f4rZ+cilyPHrXVMUgV78v6xYvQ
	utdjLo1Bm+MsKnP4X7VZQC3fysdnwL+Y3AApqzfXCqM4Sq6oUCSISbX/yMMQ2CXaa9hI0FTs1MbWx
	d3/igNXg==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tGJAj-0002n6-9v; Wed, 27 Nov 2024 15:37:41 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dse@thaumatec.com
Subject: [PATCH v2 0/3] arm64: dts: rockchip: add and enable DSI2 on rk3588
Date: Wed, 27 Nov 2024 15:37:16 +0100
Message-ID: <20241127143719.660658-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the dcphy and dsi2 controller nodes and adds an overlay
for the Tiger-Haikou Video-Demo adapter that provides a DSI display.

changes in v2:
- adapt to changed dcphy binding (phy-cells = 1)
- tiger-overlay changes (Quentin):
  - drop forgotten hdmi-connector node
  - improve description
  - fix node sorting
  - drop unnecessary pwm-pinctrl (set in tiger.dtsi)

Heiko Stuebner (3):
  arm64: dts: rockchip: add mipi dcphy nodes to rk3588
  arm64: dts: rockchip: add dsi controller nodes on rk3588
  arm64: dts: rockchip: add overlay for tiger-haikou video-demo adapter

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  99 ++++++++++++
 .../rk3588-tiger-haikou-video-demo.dtso       | 144 ++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso

-- 
2.45.2


