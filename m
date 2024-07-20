Return-Path: <linux-kernel+bounces-258057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650479382D9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 23:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965D01C20D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 21:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D75C149009;
	Sat, 20 Jul 2024 21:09:10 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943CE26ACA
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721509750; cv=none; b=SwsnqrAVWpzAoUhw6n5grRQEbUppsox0Epr9oZzaQ+bhUnqBGAa0Fe/vngRQj6Qtl21HsAM5s6pG+XRe7ebv4CTjdZxZPUwg7Fr9J+XU/aDobmbFipAE1S78NZpkh6e9/qkL4t7R2OmUOO/FVReISncImCRLvDlf0K9D/xd+8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721509750; c=relaxed/simple;
	bh=N+dakdaJ+GgjB/Ltq/6ldjl/pSxY2sK7W/UlXXtc2g8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cOycD3/jH4QEv6LzNHOHk8xaP+GMN8iVeAdDlt1liqdU7bPkgBpuBh8VzMTjRy4mlojQJbOWqu+wZHh/TU1PCcFWlamwDHlILtEKwA4B5ndKY8yViv7Zs0jYHLAvIxy7kQr4P+qc8YceFpyOsSuazAELlKpAgp+AERt3i+cDXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVHKB-00061D-79; Sat, 20 Jul 2024 23:09:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Expand available features on Qnap TS433
Date: Sat, 20 Jul 2024 23:08:46 +0200
Message-Id: <20240720210856.778014-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to the nicely supported rk3568, the hardest part for adding things,
is to pull things from the vendor-kernel and translating them to mainline
standards.

This series allows the TS433 to use all 4 bays [0], wiggle some LEDs and
access devices connected to all 3 usb ports.


[0] I only have two drives right now, but I tested both the internal
sata connector as well as the PCIe connected sata controller.


Heiko Stuebner (8):
  arm64: dts: rockchip: add PCIe supply regulator to Qnap TS433
  arm64: dts: rockchip: enable second PCIe controller on the Qnap ts433
  arm64: dts: rockchip: enable uart0 on qnap ts433
  arm64: dts: rockchip: enable usb ports on qnap ts433
  arm64: dts: rockchip: add stdout path on Qnap TS433
  arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
  arm64: dts: rockchip: add board-aliases for Qnap-TS433
  arm64: dts: rockchip: add hdd leds to Qnap-TS433

 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 224 +++++++++++++++++-
 1 file changed, 223 insertions(+), 1 deletion(-)

-- 
2.39.2


