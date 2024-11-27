Return-Path: <linux-kernel+bounces-423931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7039DAE68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9421E1670C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D59202F84;
	Wed, 27 Nov 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CXkmgC8f"
Received: from mail-m244.xmail.ntesmail.com (mail-m244.xmail.ntesmail.com [45.195.24.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA72CCC0;
	Wed, 27 Nov 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732738615; cv=none; b=b2DOFvDLfixSZRmK4P9TlC9c3PO4O5iwqPCkvJHH60uinrcjde6Z/uXS/LyRBXYs/2e8PBZzkXuKbfm2CEIk9QhXFjPL6qwOGTndkfb++zSPrtKG+sdq0IfgiUY0cvG2ooR2yCZMv4Ubww19lP8ADKIbJU8SWcipGu43oEGtW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732738615; c=relaxed/simple;
	bh=aWbKNMc0evtCax85SeHu81QliludFZ8JWl/d2qoKl/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iApuMzDaN5MIOJJZ2fTYdauNGCqjLnRZ6uF7k6jTAVZvKf6rsIPlCFm55be5Xpsd4xi6C1iEHSrYA9M3zfwX5/iCQaPKaYNptVvi+n3hRIZwMVjL9bH0A6TxlK+QZZ8PUbUw2RXOp12O1KIBAdHaqtgpKJcKWyRkXjGhV8u/upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CXkmgC8f; arc=none smtp.client-ip=45.195.24.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3f86cdb7;
	Wed, 27 Nov 2024 15:53:07 +0800 (GMT+08:00)
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
Subject: [PATCH v1 07/10] dt-bindings: display: rockchip: Fix label name of hdptxphy for RK3588 HDMI TX Controller
Date: Wed, 27 Nov 2024 15:51:54 +0800
Message-Id: <20241127075157.856029-8-damon.ding@rock-chips.com>
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
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1ISlZIGUwZSktIHh5DH0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a936c9c108f03a3kunm3f86cdb7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06CBw6FjIuGS9NP0k4NUM6
	Q1EaFDhVSlVKTEhJTUJIQkNCSkJPVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSU5MNwY+
DKIM-Signature:a=rsa-sha256;
	b=CXkmgC8fARHitiPXO3Py9xuh/SQy+Hzv8UtbnSVwgKM3HjRlZaICu2rXXm1EMs3451NZKflRS2IiY6L2b2lICZgKmPEPQlbKEB90iaN/v/14977i6EBVrvT+Kstz9L9WRNGEYGaLtT4mDEF384IvOzvZ7S6i1YsLz2YPozXrZ3w=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=8PFlBTYiMmJvxqSw4EeY0pYReC+RSBIG9La+5v1DTv8=;
	h=date:mime-version:subject:message-id:from;

The hdptxphy is a combo transmit-PHY for HDMI2.1 TMDS Link, FRL Link, DP
and eDP Link. Therefore, it is better to name it hdptxphy0 other than
hdptxphy_hdmi0, which will be referenced by both hdmi0 and edp0 nodes.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
index d8e761865f27..7a1ae31cc535 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
@@ -156,7 +156,7 @@ examples:
                      <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
                      <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>;
         interrupt-names = "avp", "cec", "earc", "main", "hpd";
-        phys = <&hdptxphy_hdmi0>;
+        phys = <&hdptxphy0>;
         power-domains = <&power RK3588_PD_VO1>;
         resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
         reset-names = "ref", "hdp";
-- 
2.34.1


