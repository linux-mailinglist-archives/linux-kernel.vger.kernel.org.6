Return-Path: <linux-kernel+bounces-433292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1409E5610
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E22288119
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB921A42D;
	Thu,  5 Dec 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TgWTzXUW"
Received: from mail-m12796.qiye.163.com (mail-m12796.qiye.163.com [115.236.127.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74F218ACA;
	Thu,  5 Dec 2024 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403542; cv=none; b=OSMG8A50eaR3AZmojf3EhB2LVqeQgmro3YJvoHehD8diwDMmL+VaG6m6BAq8zonyUF6oHtJvVqllfzp6AHcTowf9EL/0MZdCoKIqJnOx8xapNWzKHlECuP8Uews+gYSlSO36/x1HrItebMT/G4fnomuDyb2i8a+zvQpAOv2/G7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403542; c=relaxed/simple;
	bh=sDabB6yRsc/ZhrL31a5xwV72EldOXfsBu6FBgKi9BuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYgyEolytz4/TOsvCpJlbDN76wwt1WGaNNi+IqLouNDhZBjJGpuZhsRmsH+1r+9Tbe2gek/GqEvG21a8IPhIUbYWeWmhAMKrZAK3AfN4ZPNLRAs5hXUCpp2NJMQdrXixaZZu2/zt8waVvNNxYoIXk0k+tnIp3A9wzH5Nf5/RAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TgWTzXUW; arc=none smtp.client-ip=115.236.127.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cf7c984;
	Thu, 5 Dec 2024 18:36:34 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Andy Yan <andyshrk@163.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Tim Lunn <tim@feathertop.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: arm: rockchip: Add rk3576 evb1 board
Date: Thu,  5 Dec 2024 18:36:22 +0800
Message-Id: <20241205103623.878181-6-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205103623.878181-1-kever.yang@rock-chips.com>
References: <20241205103623.878181-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwZSlYZSkgZHh1LHU4dTEJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93966493a703afkunm4cf7c984
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQw6Cjo5NDIhCQ1PHyMvCxov
	Q0oaFElVSlVKTEhISEJPQkJOT09MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSks3Bg++
DKIM-Signature:a=rsa-sha256;
	b=TgWTzXUWw2q2NR1exdJuZumgkZ5NCMH3DmjXnsIeD1vSiO+bRplQxnzbj4Xye0Ab0ww/JQx6xD8H/IovZDX17PhM21YM+wj7UDiELScbGeZ7oOOJ6QZKQVPdsnBjKrIoiw8wYWMKeg3YZq4S+Ww0JqXctphCF4VqS1/sDzGQuRM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=NGkIEb4D9Pp+P1b6BLNVuyfPuE9svwhu6wtxLA9nH2s=;
	h=date:mime-version:subject:message-id:from;

Add device tree documentation for rk3576-evb1-v10.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 45ee4bf7c80c..b2681a45867b 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1016,6 +1016,11 @@ properties:
           - const: rockchip,rk3568-evb1-v10
           - const: rockchip,rk3568
 
+      - description: Rockchip RK3576 Evaluation board
+        items:
+          - const: rockchip,rk3576-evb1-v10
+          - const: rockchip,rk3576
+
       - description: Rockchip RK3588 Evaluation board
         items:
           - const: rockchip,rk3588-evb1-v10
-- 
2.25.1


