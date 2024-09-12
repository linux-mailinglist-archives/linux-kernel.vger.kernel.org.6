Return-Path: <linux-kernel+bounces-326714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C762976C14
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238B81F28A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5711AE87F;
	Thu, 12 Sep 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="J1GpqNWT"
Received: from mail-m3286.qiye.163.com (mail-m3286.qiye.163.com [220.197.32.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB051B982F;
	Thu, 12 Sep 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151288; cv=none; b=pehgkiWsFuDMcQHvHesNlD1BfslkLr4C3/LBS5txWVtfE26s+nYpqk+bQbCldDafDEGYqXJh4OS00p67hEEpcBoyBNJpDcEkvGAxx7r0aiOBBm/pCS3zayC2UoUuCyd73z9ed8kxX+kPHoI/vMmjlisVa+S833WDihEyPYv4i+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151288; c=relaxed/simple;
	bh=DK+v+22EZz5ENpKUfX/gHGhM6CYDYS3BQtQ/SGerRzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tnlt0U6kWUcDHmXjbc4Gvu/PyAL3hSrzGFZirLEIidyQF+JDPmVC0LMzhDC79q4oPDrUkLmAoumn6wjoXeMKVJxiUgo8Sxta4y6Z88kBP3JoQ8H4gKPzcbAfcQzh13taEeLyW0463z9I2Sxk0jbhf/0qZoshslkiKM+co3CE6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=J1GpqNWT; arc=none smtp.client-ip=220.197.32.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=J1GpqNWTuAOXyj1458CD0KpxFacY/JVRzOtQjyV2aGC8o5Hxz5r8GbN/h1NYIkvZpuxYVPj/xhQNI/uTxkr/EUSLq8Z6v8FaZ5isVRAi8iWDZtQq/XtmNJbgyRKXtoC6qFNSQN0aukYXpwXggt6FDWzOHt6u03u+SI4hNtlFpqs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Rifbf6LNchQUBXr5NiVt464i0aIKbw7yq2BirSFdw6g=;
	h=date:mime-version:subject:message-id:from;
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 9D44F100348;
	Thu, 12 Sep 2024 16:03:07 +0800 (CST)
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
	Damon Ding <damon.ding@rock-chips.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: rockchip: Add RK3588S EVB1 board
Date: Thu, 12 Sep 2024 16:02:47 +0800
Message-Id: <20240912080248.1133061-2-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912080248.1133061-1-damon.ding@rock-chips.com>
References: <20240912080248.1133061-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhITlZNHR1KTE9PTR1OSktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91e541ed5d03a7kunm9d44f100348
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pyo6Pzo5DzI#Nyw9Qy8OMjoa
	CDMKCgFVSlVKTElNSklDSkNCT0hNVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0JLNwY+

Add devicetree binding for the Rockchip RK3588S evaluation board.

RK3588S EVB1 board features:
- Rockchip RK3588S
- PMIC: RK806-2x2pcs+DiscretePower
- RAM: LPDDR4/4x 2pcsx 32bit
- ROM: eMMC5.1+ SPI Falsh

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


