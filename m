Return-Path: <linux-kernel+bounces-536098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E814BA47B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF334188F288
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2822DF8F;
	Thu, 27 Feb 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GVyOOujp"
Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com [45.254.49.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5322A1E9;
	Thu, 27 Feb 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654525; cv=none; b=JalN8iGosAGRRVzNfYmk+Bno6yfz8Pv7bd73aeZ4cmSeBU3tWI/zU6rgo5qKqrm7HOlK06TJmSWQu6X/l3yjFM+kqqZV2Va4iGJkJPOkW00GhIKC4EhkTzsPhnCCe4TCJJKdXGH9AxswG+Zi4tmB7C9eGHYgvUtGFhSBRHBy9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654525; c=relaxed/simple;
	bh=kRUWs4Ib+t6KWDq/VqknDDsHx+YctdyLcm3WvT2nrR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jRET2VypCqHUAdQa8kVSZv8sg/57ZVe++glgFADwvurYr6FQG+FSXZmje2LmSr2kl+VKkjeGImWMWhLcsyJySg/W8Cx2n+EWSdatkaKecjAJ4TNNm0LMHldm9ed08OgyO+MNwUmlNO6xRMHoGd0drmr88X6PECrmB/ppCITb2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GVyOOujp; arc=none smtp.client-ip=45.254.49.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65b3840;
	Thu, 27 Feb 2025 19:08:38 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-phy@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: phy: rockchip: Add rk3562 naneng-combophy compatible
Date: Thu, 27 Feb 2025 19:08:35 +0800
Message-Id: <20250227110836.2343158-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkJKTFZKTRkdThgYGkNKGUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9547181f5303afkunmc65b3840
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6KSo5SjIXCQ0zOAtCLioV
	MyowCipVSlVKTE9LTU5PTkpCSE5MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSUg3Bg++
DKIM-Signature:a=rsa-sha256;
	b=GVyOOujpn+khgzO3Z048/SEeA5nr3Gkm2uzTfzlcxqR6fIr5Tb3ItdJvMY+vWXL7hsoAVLaTJKzgZ8pPG5UeqY/gfjOOyhBEFuXM4YuPH2TIoN8I3geGQWAzl7qq6UOobV6BGNK8HG/un4xhMJvGHqTbuk0XwnwWeejnzvH/Y3w=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=olP6+ZMssv+GG7vBkFycsm66e4Vrx3nQ+fFfC+znn2E=;
	h=date:mime-version:subject:message-id:from;

rk3562 use the same Naneng Combo Phy driver as rk3568.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v2:
- Collect review tag

 .../devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index 1b3de6678c08..888e6b2aac5a 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - rockchip,rk3562-naneng-combphy
       - rockchip,rk3568-naneng-combphy
       - rockchip,rk3576-naneng-combphy
       - rockchip,rk3588-naneng-combphy
-- 
2.25.1


