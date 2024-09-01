Return-Path: <linux-kernel+bounces-310198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A787967626
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 13:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F6C2820F8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C9116ABC6;
	Sun,  1 Sep 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="pXRBCHA9"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8C915250F
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725189648; cv=none; b=L50E9AFeKyuB6pWSBSwA9ek+551mVdQZNW3n4frJXFvD8oPGBXc7JuojPhU9cS4rxIXyyTfxvsfVnSy6IPNhlK8Lx8ddXqYXMPTcBuNjibfWbcyOkcsaSQ0mtIT64gU+DdrSs/fwh8sg9CmTmwd1kURplUBQ1d2OuIhjeIIphFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725189648; c=relaxed/simple;
	bh=CyAmyZ6ZrmPLChEXlKTG+VR1Re8KLV++wlaMgsHeqjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sC60TjQFLytWRRZX8kuSAeNaBxKiCnsQzBTqAIXWwP3xX8A+sDgZ3sg0r2h7c97QlBKQ6x5a17aJY7nO+CVvD1/7sVl7Zzd1aQPhnmi0DQssaV45vNToaLR20/PVL5jzttT9lrFSS7neG9m+/zWvZfhyW938xl4CXRbJDX0Q/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=pXRBCHA9; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1725189628;
 bh=Z89W5F2t063lBkCLEwxf85Xb/ma4isw7uhvOFuWSdqo=;
 b=pXRBCHA93OvgpublXaezeiHguPr+yYPV6mnYN1vPf2/UuVM7UNyoFzkBPldyxdjHMumVbFZPA
 G7jzOalbVYobbmTivxWzAH8sWFyXH6BO8lq8rk8VP9PBPbXhDjCm9OchDvSjPTIOzVLHBzhVnwi
 iAq08pG6y5GxbC0/d1VgmFAeBfcmwdXAJ7nd4bTU1zI0lijENLUiuwEq0PF9RAzMeHixrP1U3z6
 ki9ZKLLgY9N1DAAsQCOfjUKh7gzs6vgNSSvLG+xjytRQiH0Fo7zalhtMjVKDbiCThor8tauTJIJ
 Xs30XiJVhM3OWQZG9ey9bbXDRVFlLtDG38Njk0DdUKBA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Dongjin Kim <tobetter@gmail.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] arm64: dts: rockchip: Add Hardkernel ODROID-M2
Date: Sun,  1 Sep 2024 11:20:13 +0000
Message-ID: <20240901112020.3224704-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66d44dfb556ab34bbda73d05

This series add initial support for the Hardkernel ODROID-M2 board.

The Hardkernel ODROID-M2 is a single-board computer based on Rockchip
RK3588S2 SoC. It features e.g. 8/16 GB LPDDR5 RAM, 64 GB eMMC, SD-card,
GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0/Type-C.

Schematics for ODROID-M2 can be found at:
https://wiki.odroid.com/_media/odroid-m2/hardware/m2_main_rev1.0_240611.pdf

The device tree was created based on the schematics with regulator
voltage values adjusted to closer match vendor downstream device tree.

Testing was done booting into Linux using mainline U-Boot from [1],
a test build of mainline U-Boot for ODROID-M2 can be found at [2].

U-Boot patches will be sent once DT reach the devicetree-rebasing tree.

[1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3xxx-2024.10/
[2] https://github.com/Kwiboo/u-boot-build/actions/runs/10653436524

Jonas Karlman (2):
  dt-bindings: arm: rockchip: Add Hardkernel ODROID-M2
  arm64: dts: rockchip: Add Hardkernel ODROID-M2

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588s-odroid-m2.dts   | 903 ++++++++++++++++++
 3 files changed, 909 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts

-- 
2.46.0


