Return-Path: <linux-kernel+bounces-185480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3948CB55D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D935AB2135E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E858149E1B;
	Tue, 21 May 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="VcUUV3dm"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036146521
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326592; cv=none; b=AholPlpVsqSf8bjp+jnyKq7vTtBhaqdfY9Y7E98qEu1h+5R9aQ/IR5smjmPi8894COU2DqqTm7aS+mBRD9ijXDpPvKWRa47fPvivDuJIHhfcjz8o6w3a+k9TqH3uVFC2aRyL3Jww+dWPll93z6sSzHLOff4FAYuBl28l0DPIGj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326592; c=relaxed/simple;
	bh=YJ7KJNVEY0nD3CLnLr55Yms/XPIA0CL+Z3cIOA+FFeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beEgSQuh4WOEoaKfuuYNGQwG5R8M7H6zM9xgD9o9SVNZn1Lt44amMlsTZZmlJyB0kB6Qb/Az0wX9K1W5IBsYShAKDkEHKNIbARNYpcqsabHXrsnBIm77p6LnvmXr6ylfY2Svt6lqW2NA5AuCCeY2JudNjVodB/rhcUPpLXFSaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=VcUUV3dm; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1716326576;
 bh=iSM4GlQoeQiLh4kh00cMbzGdcD5BMtLxx/m4Qk1LltQ=;
 b=VcUUV3dmB4iKyXNX8HGCx2bOAIVN2Ufcp5lqsgKRLKhWF2lekqlvZXsE74dEWUnERmCzqUn/r
 nVUiC+TLEle6y7IufdDN9lgUrmltA/lCipZPv/+aIFb3UQ/K7gexJc2ZWpTul5L4MNsS8RHBQsc
 nc9tVZ1H6/KeMaQ80u8PzUIqCfr9Ecb6CO4kCAVrmESncQQ4O24mT1SXNmc97Jyk+0SOfPQxSvd
 g0jtneA0k+nbzLwc4nPKP/z0fMWPA20lybvzQqY759yM5MMo1+HmgRAZAgtkwp8Y5BBujzoUqN2
 Mdu1QxyZos72EW/hhvX9lq/i9ymx6yV6QPdqrQ75qRcA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] arm64: dts: rockchip: Add Radxa ROCK S0
Date: Tue, 21 May 2024 21:22:41 +0000
Message-ID: <20240521212247.1240226-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
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
 167.172.40.54
X-ForwardEmail-ID: 664d10ad8b6b0c828344b0e5

This series adds initial support for the Radxa ROCK S0 board.

Radxa ROCK S0 is a single-board computer based on the Rockchip RK3308B
SoC in an ultra-compact form factor.

Schematic for the ROCK S0 can be found at:
https://dl.radxa.com/rockpis0/radxa_rock_s0_v1200_schematic.pdf

This series depends on the series "rockchip: Fixes and improvements for
ROCK Pi S" [1] to pass DT schema validation.

[1] https://lore.kernel.org/all/20240521211029.1236094-1-jonas@kwiboo.se/

Jonas Karlman (2):
  dt-bindings: arm: rockchip: Add Radxa ROCK S0
  arm64: dts: rockchip: Add Radxa ROCK S0

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3308-rock-s0.dts      | 293 ++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts

-- 
2.43.2


