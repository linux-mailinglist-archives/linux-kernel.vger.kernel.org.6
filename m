Return-Path: <linux-kernel+bounces-302201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B495FB14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6411C22693
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9FD19A292;
	Mon, 26 Aug 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="wDVvOuYs"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [164.92.70.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851CB199381
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=164.92.70.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705766; cv=none; b=Eym52PFXbjirre3Ll3+t46UgzRUyz9lkU0u1PSt1vW57/SBpQsHl1deU5rfKHLThDeFupadzdO2DGuGdxlWNmEO3qXQq1bDjdqRGycCIPJpcBu5yO7RgjbU7AndU06PrL0rT0JwpFfHr2mY9BJJAU16HUHCMYT45ifqq1jJg4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705766; c=relaxed/simple;
	bh=jFUP/27MV1FVEDFzFe66e8U0/TnQn3kfXparQUdw/j8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qLDzdbtMVUwdHPhKkGelII4GusKl+Si5DcIh6QZLSGxWaKNg7PBiDmB50vU8HZAshq0ep86LGCa63JWOpju0wuUnRNTKY11tFyr8TBDvJ6RFTh5LOmklkufF0wXSIjRtOyRMur9YlomlstuczieBNKlOmEcDgztOyOTd5R7UEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=wDVvOuYs; arc=none smtp.client-ip=164.92.70.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Date: Subject: Cc: To: From:
 Message-ID; q=dns/txt; s=fe-e1b5cab7be; t=1724705747;
 bh=La1r0vb8HqM0uZe15gW8C1ZAEEWVA2k/jF0DeZaxmiQ=;
 b=wDVvOuYsLVLkoicjTT2+ZtBY4+zDFHiv4ydbCWMhuStOfsqWrnkcsiOL6cb+w7IMg+20KmcsN
 WwrZuPGbVAtbRP0y48oJa1ZepPoG0ZO5RWNSpWh6ROO0UgN4Bt7jqZ5qj4QSEo+VusAvBii3ZTG
 eDXnEPr+qpTWrpMxlUbAlV+KMcrF4eCRoQRKPv7aYRbTeBfVylRCYv058J/uZn2OgR1539qFhDC
 z3Ml1OJG7P871U8+yJsUowCu5Vvg8URMpaWdAqKOBCDm35Q4OJ0yO+j9raLHYSRfYg6WMMFc7vP
 wzb3t5GaAOWoYJg+lnnfx+r1MoDCAmZwlIGEd1GVMIdQ==
Message-ID: 20240826205538.1066103-1-jonas@kwiboo.se
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] arm64: dts: rockchip: Add Hardkernel ODROID-M1S
Date: Mon, 26 Aug 2024 20:55:27 +0000
X-Mailer: git-send-email 2.45.2
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
 164.92.70.200
X-ForwardEmail-ID: 66ccebd2e59276ede820346a

This series fixes wrong vendor prefix on the Hardkernel ODROID-M1 board
and adds initial support for the Hardkernel ODROID-M1S board.

The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.

Schematic for ODROID-M1S can be found at:
https://wiki.odroid.com/_media/odroid-m1s/hardware/m1s_main_rev1.0_230906.pdf

Jonas Karlman (4):
  dt-bindings: arm: rockchip: Correct vendor for Hardkernel ODROID-M1
  arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-M1
  dt-bindings: arm: rockchip: Add Hardkernel ODROID-M1S
  arm64: dts: rockchip: Add Hardkernel ODROID-M1S

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3566-odroid-m1s.dts   | 663 ++++++++++++++++++
 .../boot/dts/rockchip/rk3568-odroid-m1.dts    |   2 +-
 4 files changed, 671 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dts

-- 
2.45.2


