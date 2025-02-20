Return-Path: <linux-kernel+bounces-524061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251C3A3DE9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA192421E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1821171F;
	Thu, 20 Feb 2025 15:28:23 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A611FDE08;
	Thu, 20 Feb 2025 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065303; cv=none; b=Be74Q/lh+lXmtlk6x+iCOufLqDOhDB11FN/ZnrfKEDoN29FWI+0hUlqQNOdzhaSv+2kP6SFK8ce0uYGcU5P1qPyVjRCbx/rmK5K4nD+A761Ypkbye2z7V2oHAYS8LrSx8DC58FZHIg1BhBUYaCO0xX8UsVOHDaqXhe1woUK9dz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065303; c=relaxed/simple;
	bh=hEvVx6R5nLuwey1OcG7Bnt4lVUc5m4FkNLMpgBx6+hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf7ig/0XPVTL9QL3nT66/FR9ybznd3QgQWLqdv7i9RqBWHCPCqw0pnh3rAnltOCXcLLS30RFIagI+5Yy/JQiP1o/okGU2N4hD0OjrksoyhZwr+dSJ6x6qfUshuBLReq50xqHwQrlBoJDp67UODIWr5+I1pnCOSA5jjieRQfBnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: tOC581zNTPWctXl+3O2kJw==
X-CSE-MsgGUID: Bt7qRyNlRSGlQ8rn88gHPg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Feb 2025 00:28:21 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.134])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6CDC04043701;
	Fri, 21 Feb 2025 00:28:15 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: mturquette@baylibre.com,
	magnus.damm@gmail.com,
	krzk+dt@kernel.org,
	rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	sboyd@kernel.org,
	geert+renesas@glider.be,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	robh@kernel.org,
	p.zabel@pengutronix.de
Cc: biju.das.jz@bp.renesas.com,
	claudiu.beznea.uj@bp.renesas.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH 7/7] arm64: defconfig: Enable RZ/G3E thermal
Date: Thu, 20 Feb 2025 16:26:12 +0100
Message-ID: <20250220152640.49010-8-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220152640.49010-1-john.madieu.xa@bp.renesas.com>
References: <20250220152640.49010-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the CONFIG_RZG3E_THERMAL flag for the RZ/G3E SoC.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a1cc3814b09b..91136c0196b5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -714,6 +714,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3E_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.25.1


