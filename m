Return-Path: <linux-kernel+bounces-304046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F73896191A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22A4284DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006111D4603;
	Tue, 27 Aug 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="jymOPbnC"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447691D365F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793537; cv=none; b=QfBlQrvKqlKuUOAYTbssXYjPd3VekDlshA11DmIVwMOc6fbmPGeuMr10ps9hCG0Tc7tln0lrIwNfjvQMmNT/w7snFHu2NC0KIlWeFS7Xr5Xr3AUCb8hUf1UMLyE5PzHVNJn1liwFaKhtiIS8H1KFLOTsTH7mt2OeUDwvKvNS0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793537; c=relaxed/simple;
	bh=lulpCZUKJfW7wRaBCLPAXtflDNkfseGxvX6jk1vYD3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jK0dIJMZQBUt2+HBVTxoSLpmojvrS17DJb37u/Bw0Y0tQFQyN2w9o5eRWps6wFi8O4nri2oiYgEKb0XIeFEriWYRWD6SyK+kE+4NhS0yFVTTciAAou8bxX5wxFvJwdFMcVELYf7rdj2nwqMRNvMnfVFS2TkYcWQ2Al+D+9Poq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=jymOPbnC; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1724793513;
 bh=YHUKJmb3UnAxZ0k+vBXUS+OxFZW8B1ZiGLNKbG0akdA=;
 b=jymOPbnCihV05dBfAQwJKm8kQXNCngh6A+WURBR6wKo0SngEKeUk7o0BSK05mPgqVmy6KVf2t
 fd0XBjnWYPRHk5yJ/4JhRirGOMra6Djrlb38MDh4rGT86Rd64JcXmjeh6X4tO2chQ5Yo+6EO5uJ
 tgQOd8Gn98jjFUfTlIcBLNi8YaUZE9P95yj8RivQYFCH/0JjK4Oe9zYKInfUjY+JJ12OiEnxL+q
 HvUIYRCfbZRsiS8x1zQkh5aY/jCpJpVcQGG6ozv3VNQZpQBDVgPhZacH0Ea/ob7Kv525O6qHOUr
 PIRCHqFw7HszXFCnzPfwxKhttY+ft3EL9Y1CFTOAyDdw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] arm64: dts: rockchip: Add Hardkernel ODROID-M1S
Date: Tue, 27 Aug 2024 21:18:14 +0000
Message-ID: <20240827211825.1419820-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ce42a7ec205819dc6f1776

This series fixes wrong vendor prefix on the Hardkernel ODROID-M1 board
and adds initial support for the Hardkernel ODROID-M1S board.

The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.

Schematic for ODROID-M1S can be found at:
https://wiki.odroid.com/_media/odroid-m1s/hardware/m1s_main_rev1.0_230906.pdf

Changes in v2:
- Remove the redundant rk356x- soc prefix from board compatible
- Collect r-b tags

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
2.46.0


