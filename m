Return-Path: <linux-kernel+bounces-423173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F163F9DA3E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1C728436C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD8189F20;
	Wed, 27 Nov 2024 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZnmhMHy0"
Received: from mail-m17240.xmail.ntesmail.com (mail-m17240.xmail.ntesmail.com [45.195.17.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F6183CA6;
	Wed, 27 Nov 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696113; cv=none; b=TcU8jplhMOm8678fngDjolwZeL71BgFQ7Kb+z21p10fLkMgCS2vfyis8DGzaK+i8jFBDQpEuUtvWj3Ro/7hdY1QgCmqKlC9G5CygAGr9OWdCUr0n+jtHHnLRez39vzFm+QafvlHfBAJBwWAtqm29Y9FQEcOLo4yYHMYPaB5cM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696113; c=relaxed/simple;
	bh=27F6Ryy9j34tNIeiCE9AYa3Z7WWDd1pA6lndR1qFTAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEmB8vPiJE9HOH0XNWzMB3ikt8GtdK8XNVhALjw8Zyb/3yRmWomEh23BmHL3ICCcUAmbad37mYnMqOa/b48zkdnD0ccH0zMkrVlGEehlkEWqxc8NwPDFYDeN6Hi+1VaPAXWSyjAg36BYh2AQ8+R2nD6goK/dnKWoPuZXUVN14jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZnmhMHy0; arc=none smtp.client-ip=45.195.17.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3f86cd87;
	Wed, 27 Nov 2024 15:52:57 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rfoss@kernel.org,
	vkoul@kernel.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	l.stach@pengutronix.de,
	andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	algea.cao@rock-chips.com,
	kever.yang@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1 02/10] dt-bindings: display: rockchip: analogix-dp: Add support for RK3588
Date: Wed, 27 Nov 2024 15:51:49 +0800
Message-Id: <20241127075157.856029-3-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127075157.856029-1-damon.ding@rock-chips.com>
References: <20241127075157.856029-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh1PQlZMT0JKSR0aTh5LGE5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a936c9be9ff03a3kunm3f86cd87
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSo6MDo6DTIoFS8KAQJMTQk9
	KSxPCxhVSlVKTEhJTUJIQkxCSUJKVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTEk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=ZnmhMHy0GAB/d77J2emnNsSaThCemkZ2LEpHRdXbq/K/pF6yDQtFcRGd7NVrcOKV6ZHBj/EWgJBT/kaV6Ix4aUxmE/v4C8iawwxBVMPDne+0kHWip9fEvlqEemc5sGtB10QjGElelgfIKu/KQh9e35f4CyrxGItU1j5DPM0oSCg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=SgmZOoNiiSBhN27GyedHl1ViJKgjvccJ9T2kAuGZc5M=;
	h=date:mime-version:subject:message-id:from;

Add the compatible "rockchip,rk3588-edp".

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../bindings/display/rockchip/rockchip,analogix-dp.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
index 60dedf9b2be7..b82b693532e1 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
@@ -15,6 +15,7 @@ properties:
     enum:
       - rockchip,rk3288-dp
       - rockchip,rk3399-edp
+      - rockchip,rk3588-edp
 
   clocks:
     minItems: 2
-- 
2.34.1


