Return-Path: <linux-kernel+bounces-322388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6CB972850
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5CD1F24D99
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14014EC44;
	Tue, 10 Sep 2024 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="M9EENae7"
Received: from mail-m25482.xmail.ntesmail.com (mail-m25482.xmail.ntesmail.com [103.129.254.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED14F218;
	Tue, 10 Sep 2024 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942496; cv=none; b=H8grmvqVe5y3UBUG6S25d/gL6Uq6bP/p2Oq+8UGws8nLk7TwBj1Fkgn6gO5EyZuVFUuDJXrTk9ib5yJXqyJAFDCehKtDMqk99snyfOU7AABGfD3DojSCcuakVxUOhmYKQ5q0+1bbyTngkBp7cOxlTAeFQAruw7wnmoNxUvQgKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942496; c=relaxed/simple;
	bh=obxQ8mvuugakE4oLNK/5ZHZ5HwX8BVR6JNobh3UVUW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owZ407Djzi9RwS5SkjdTAD9KdGZQpMteq+AUMbYc2CeefvKEY7iEdmgF46MnYhmhy7gzhfwXiQvRbjex2oM9d2GaokyP0/jnFjwNDXMzyoNAFjSWHTT8PK+gCVNoxiC6zP1DQQ7sC7dp+XYXtXsAooqucxet1uNRTx4LFxopDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=M9EENae7; arc=none smtp.client-ip=103.129.254.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=M9EENae7dm9lrvZydttnTOhjp+1HrXCuKXNZddCnkvrgJBW3zC3wjS62FKIpOHbW1IEGyAut0Gry7+iWs5MmXegTV06jLowE/RaObwQ7xUkUAwDfhupGnIr7zuNTQmKPZgCp6dlqLdWMdBAc+9kUZQ0iumSnwmtRscsgFKVwUKs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=OyCjbYBCeFbpBOCm7HDwCrJogQYorO3TUDUejbm/lqI=;
	h=date:mime-version:subject:message-id:from;
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id B57D81004DD;
	Tue, 10 Sep 2024 11:10:01 +0800 (CST)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	macromorgan@hotmail.com,
	jonas@kwiboo.se,
	tim@feathertop.org,
	knaerzche@gmail.com,
	efectn@protonmail.com,
	andyshrk@163.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	megi@xff.cz,
	sebastian.reichel@collabora.com,
	alchark@gmail.com,
	boris.brezillon@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1 0/2] Add support for RK3588S Evaluation board
Date: Tue, 10 Sep 2024 11:09:49 +0800
Message-Id: <20240910030951.3670653-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhIT1ZOTh4YTU4aSUoZSBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91d9e8de5e03a7kunmb57d81004dd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Phw6GTo5ITI5PzUzTSpDSxRD
	PA8aCg5VSlVKTElOQkhMQ0tIT0hOVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSUNINwY+

Specification:
- Rockchip RK3588S
- RK806-2x2pcs + DiscretePower
- eMMC5.1 + SPI Flash
- Micro SD Card3.0
- 1 x Typec3.0 + 2 x USB2 HOST
- 1 x 1Lane PCIE2.0 Connector(RC Mode)
- Headphone output
- Array Key(MENU/VOL+/VOP-/ESC), Reset, Power on/off Key
- 6 x SARADC

Damon Ding (2):
  dt-bindings: arm: rockchip: Add rk3588s evb1 board
  arm64: dts: rockchip: Add support for rk3588s evb1 board

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 1120 +++++++++++++++++
 3 files changed, 1126 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts

-- 
2.34.1


