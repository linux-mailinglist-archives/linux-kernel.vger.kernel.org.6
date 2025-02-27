Return-Path: <linux-kernel+bounces-536151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A01A47C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818457A6FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD43229B2C;
	Thu, 27 Feb 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bnuE8j1G"
Received: from mail-m1973189.qiye.163.com (mail-m1973189.qiye.163.com [220.197.31.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD0215F45;
	Thu, 27 Feb 2025 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655492; cv=none; b=PTqTJM2UfsH7wJakzuq/zwbFx5FrgGn9bNftuBKsmuaDoCCRSlL2NnUA3eZ93p4ON46QVXi3Im6fisWUn+A26++flaOoV1DRLE3XRZRy/ybv8QAlyp6E8p63XOsfHQrLP34H+gxwuvedgaerMtMSfVh4FXHAw6sqvvQZDoCZvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655492; c=relaxed/simple;
	bh=FKAk8+wRDFOCqf7z8bI8jsjeJGr4YxrKXm45h6pCWps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HcNuIVvQkUKVQy0Y/AN1R7IR3GzWMCGcWOemATBoEts2Pdc0vBuj7+L1O/ddWmcTTkFzRTFUNYVmEbU0gpAsem+JQDvweiRzaKZYadpbOkXedX9y7YNzzLHERCYp8nboHiqx3KOI0xuqQPjPndJwJYaE7v/iHyfEEAyHSMRcl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bnuE8j1G; arc=none smtp.client-ip=220.197.31.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f97ef;
	Thu, 27 Feb 2025 19:19:38 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 12/15] dt-bindings: soc: rockchip: Add rk3562 syscon compatibles
Date: Thu, 27 Feb 2025 19:19:10 +0800
Message-Id: <20250227111913.2344207-13-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227111913.2344207-1-kever.yang@rock-chips.com>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlOT1YYQ0kaHU1CGRpDQ0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
X-HM-Tid: 0a954722335e03afkunmc65f97ef
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6NAw*CTIKGQ02Ek0XHgIo
	IgEKFElVSlVKTE9LTU5OSkNLS0xLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSENLNwY+
DKIM-Signature:a=rsa-sha256;
	b=bnuE8j1GfogwPGqSJ9gVccv+umFqY40JKswDoh0mtFkjIwS/dD4T5mzytV8AqbRuUQVay3H9JjjDaDwzzVFPkKu15DqaoGV/PgoeubJu/nJPMTNDBYCsKdf9Y7FCHKnnLSUbI2R0Q+8ZLS/UE5sCC5ITFCllM6/zWQchwmMp73Y=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ja/C1I5fd71PRHTQvaoZ09vrjTeTiZ3BXfrASv1EsSg=;
	h=date:mime-version:subject:message-id:from;

Add all syscon compatibles for rk3562.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 61f38b68a4a3..32357dd4555d 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,12 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3562-ioc-grf
+              - rockchip,rk3562-peri-grf
+              - rockchip,rk3562-pipephy-grf
+              - rockchip,rk3562-pmu-grf
+              - rockchip,rk3562-sys-grf
+              - rockchip,rk3562-usbphy-grf
               - rockchip,rk3566-pipe-grf
               - rockchip,rk3568-pcie3-phy-grf
               - rockchip,rk3568-pipe-grf
@@ -79,6 +85,7 @@ properties:
               - rockchip,rk3368-pmugrf
               - rockchip,rk3399-grf
               - rockchip,rk3399-pmugrf
+              - rockchip,rk3562-pmu-grf
               - rockchip,rk3568-grf
               - rockchip,rk3568-pmugrf
               - rockchip,rk3576-ioc-grf
-- 
2.25.1


