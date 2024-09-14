Return-Path: <linux-kernel+bounces-329321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F289E978FFA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C2283B51
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA2B1CEAA4;
	Sat, 14 Sep 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TFkN/gvF"
Received: from mail-m2418.xmail.ntesmail.com (mail-m2418.xmail.ntesmail.com [45.195.24.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06979F6;
	Sat, 14 Sep 2024 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726309941; cv=none; b=ivyna/1jZtbQedDvYt/Ef3FJaCVX6d/L/tUhC2fIHqXg9JL28+xWJw/qvyd4TMW75TtEv9cHbyfKCu0GTl2iLMgZ7f7LygK+p4Z3B9wZ7QBA+9FNRrjEoRU1TfoIA/IuEXuaXIIcb3kVj4Nxj1YKdcWhfALa1oJ7N0xEugEYbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726309941; c=relaxed/simple;
	bh=QrpsE1nZWNXFbPygeWrhB1RlOGJsw6Of80UjmzJuFWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtQuOPDjonQngacD/ptMqHhy0/GGUipym/GtOjr2dboXOrnE/jiAyRjnLrwRFiEc9Rzg/bUne/qnDhkKRtB3K4QdNBnqyyDKTFknYsC2NjVAYwAEG77QKQPZUfYtMB6AKq/FIsgAIc/2En2s4YprKmP+Ox0fMex5gI2XrnZ1NiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TFkN/gvF; arc=none smtp.client-ip=45.195.24.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=TFkN/gvFGsg8e6NpzcBp7IJdrR/4SwH9c/XEROCmZuAeNtOqqi5KNOP2tWr/ZqAKGf8bElxAtCPDvj/cx7N8PHTBmxasPYKq/hPVkdDZjNFKRrEDwTAdmkrMKY80G/wIJrb2ByDALOfrp9vEV4fyb1RG0jatspVyPgKkQSxhgpE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=lqEAZurWTFkVzgiLFg5ho1LcUkSvOwSMyAmxDQ97qf0=;
	h=date:mime-version:subject:message-id:from;
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 02EC7100684;
	Sat, 14 Sep 2024 17:55:06 +0800 (CST)
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
Subject: [PATCH v5 1/2] dt-bindings: arm: rockchip: Add RK3588S EVB1 board
Date: Sat, 14 Sep 2024 17:54:55 +0800
Message-Id: <20240914095456.2347532-2-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914095456.2347532-1-damon.ding@rock-chips.com>
References: <20240914095456.2347532-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhoZSlYZTEtPSxhIT0oeSktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91eff52c7103a7kunm02ec7100684
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6DDo6MjI9QhMvIksjPzUp
	FAgwCkxVSlVKTElNSEtMTEtDTk1MVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQk9CNwY+

Add devicetree binding for the Rockchip RK3588S evaluation board.

RK3588S EVB1 board features:
- Rockchip RK3588S
- PMIC: RK806-2x2pcs+DiscretePower
- RAM: LPDDR4/4x 2pcsx 32bit
- ROM: eMMC5.1+ SPI Falsh

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---

Changes in v4:
- Add more detailed comments in commit message

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..4f6e24fcc765 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -942,6 +942,11 @@ properties:
           - const: rockchip,rk3588-evb1-v10
           - const: rockchip,rk3588
 
+      - description: Rockchip RK3588S Evaluation board
+        items:
+          - const: rockchip,rk3588s-evb1-v10
+          - const: rockchip,rk3588s
+
       - description: Rockchip RV1108 Evaluation board
         items:
           - const: rockchip,rv1108-evb
-- 
2.34.1


