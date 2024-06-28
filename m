Return-Path: <linux-kernel+bounces-233843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3335791BE16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636651C227C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E038015688F;
	Fri, 28 Jun 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="lHdl2hyM"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C9158A10
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576137; cv=none; b=r7PfFcgqoG9u7O8lCZFCuyEj8OG5ojjhdIDtQJKMSE9AYUaQx9XzS9ds6SOw36wCnubusb68JFi4GYMc5DdA8wj1wzf74qpXhKVWZns6JfiBgWR7oibnDCmfwz991+5/Xg+JuF7lS3/PD5zYVU5axZtl5bMFo3nekUm0n8bObJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576137; c=relaxed/simple;
	bh=1uSrJkD5Zjfn20B0+Voqc1tYBBjAIlt32I1fxB4N9J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmfddFg615cGq2j/eqm344etEZTY3jFC/xvFTfFwGtZdfSN3i14MRT0GuELmgHrg1bbwt02W8v/Q66+sQse6SxcqpHoiXNo7mokJBZsZte3wG8+lNfseIgoVc0H2lMvUrfk8PRpX5MJJuD78vqlWy9jz9Gx7l9p0V/iyJ16dITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=lHdl2hyM; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1719576129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sfuZFBB5M5HzceMLfENqUVqIXCu7nq+4d20hGrJdaF0=;
	b=lHdl2hyMNHhzITHZTrrKvZs6BqdIjLJ1EeebRI2kMoTaXbH1Ai41zCDEcFyzPAe6ciIQf1
	Fu0MOS6RM05zY2Kbbs3J9UDQLNtSOMbzpzaanoMBNoW1+9YlzQ/Ns9r3sVqpRcdagPz0KB
	4gZE8wD7CsHrJ8AAGJLwAZ5M2XOhIrRVwSGn0xYpchIHZIHySemtwvaPInSko7O6WXdDx8
	Iyc0L8mU6YGhl7N0BqLaqNB69LOG1iwPWJ4HrX0+TkUJpwV8DbItjeuk6WloPQnD+tOiLy
	1tLoHDDGudWPu2jNz9ycny1D+m070dru7LJdXar5XJBVPqkbLKIY/2EsDuCHmw==
X-Envelope-To: didi.debian@cknow.org
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: dsimic@manjaro.org
X-Envelope-To: ukleinek@debian.org
X-Envelope-To: wens@kernel.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Dragan Simic <dsimic@manjaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add dma-names to uart1 on quartz64-b
Date: Fri, 28 Jun 2024 14:00:43 +0200
Message-ID: <20240628120130.24076-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There have been several attempts to set the dma-names property on the
SoC level (in rk356x.dtsi), but that appears to cause problems when set
on channels without flow control.

Quoting part of a previous attempt for clarification:

> Nah, enabling it for bluetooth is fine because you have flow control.
> My issues have been on channels without flow control. Without DMA it
> simply drops messages or the channel hangs until you close and reopen
> it. With DMA, when an overflow locks up the channel it is usually
> unavailable until the board is rebooted.

Setting it on the board level for the bluetooth connection was deemed
safe, so do so for the Quartz64 Model B.

This fixes the following error/warning:

  of_dma_request_slave_channel: dma-names property of node
      '/serial@fe650000' missing or empty
  dw-apb-uart fe650000.serial: failed to request DMA

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
Link: https://libera.irclog.whitequark.org/armlinux/2024-02-29
Link: https://lore.kernel.org/linux-rockchip/18284546.sWSEgdgrri@diego/
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index b908ce006c26..13e599a85eb8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -652,6 +652,7 @@ &tsadc {
 };
 
 &uart1 {
+	dma-names = "tx", "rx";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
 	status = "okay";
-- 
2.45.2


