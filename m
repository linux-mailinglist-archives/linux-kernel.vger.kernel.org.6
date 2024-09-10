Return-Path: <linux-kernel+bounces-323094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1489737CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB34285FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D761917F0;
	Tue, 10 Sep 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ECJdj/Br"
Received: from mail-m3296.qiye.163.com (mail-m3296.qiye.163.com [220.197.32.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B518EFD4;
	Tue, 10 Sep 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972149; cv=none; b=nK+6hShvlyubuFW8pJBIWK+5LntO31UY8jMQ4WZhMp0H/++Ys4eT0GJZqHj7HBaJboOAKwUCmVC3orz923vhbgAMhZ50bLFd8A79yVw0GpGaROwWGc6i/rzCfinlaC2d7mIW1bkDRoQ7ixDmGBR3nciQnpEjAGE5vqI+10W+yxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972149; c=relaxed/simple;
	bh=iR3ouod5aJYvcKZR9ZDk009PDoqjNJ2iGTiSNVSo2G8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UyXacSSyWeKgH5/qu7yhl2S6LpIR7T1TQvvcsGY9gNrRwl9YwfsDRP7TJeWXO3lhg0+OR2RDpvbj9msDaPuv+ta0WmoOoe6m9PULALwShaYqhUiKsyx6txXL66iPu+fswA1HdT9KQYmz1xqaBqjVYVHZPzwfsw4NssRyvCNc9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ECJdj/Br; arc=none smtp.client-ip=220.197.32.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=ECJdj/Br97xXwGwqJhcOeUb48oYKMRI1BhrUyguN4lwlcXIf9iM1/LWpn29gu/A2af3eCGKW34VYHaeUwDDFUGmxmaAWgQZFYyK/RxWIAXpKg7n/9GRq2D1wRS+zAY4XAGIH4Qu5aRXk46O1cVG5OE3O+fmD5dtoYOI8/xN3AkQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=iD1gN182oxprUaNdyDfYIXEVbwMZ8+lfcYcnulZdptU=;
	h=date:mime-version:subject:message-id:from;
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id D7CD3100934;
	Tue, 10 Sep 2024 20:41:31 +0800 (CST)
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
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add rk3588s evb1 board
Date: Tue, 10 Sep 2024 20:40:54 +0800
Message-Id: <20240910124055.3981648-2-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910124055.3981648-1-damon.ding@rock-chips.com>
References: <20240910124055.3981648-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlJH1YeQkpNQ0gZThgfTU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91dbf417f303a7kunmd7cd3100934
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAg6Exw*KDI6ESs8DQJDHBBN
	LhVPCS9VSlVKTElOQkxJS0JISEJJVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTEtONwY+

Rockchip rk3588s evaluation board.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
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


