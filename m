Return-Path: <linux-kernel+bounces-433295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151129E561D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DD7188532D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CCA21C17F;
	Thu,  5 Dec 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CguSG57m"
Received: from mail-m49210.qiye.163.com (mail-m49210.qiye.163.com [45.254.49.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F584218AC6;
	Thu,  5 Dec 2024 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403556; cv=none; b=kFIGsmk7DFeO3IhLtUz33hCFM9VieiTH/DgakOUemfIuvpoNJqtjtUzFy0741WumQbntIxkHSTemJN7JJKkBNnbld/mcgFVMkZnCqjw9sWIBZXl8GoMSCbpDo0mQZb+EejUypREL2iNMi/4dM59ucxU5xEYd3HnFpVe0BpP3w2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403556; c=relaxed/simple;
	bh=RjL3ggCTK1JEXlzG/hbX0AmRbmzqx/dU/jH+bRIvKW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LRR1bg5vlc3cfd/xAHSU85w87NYhMz0deT1Ziaj3+8YnuODDqFwNf3L4oOFUj3IETWVJ14wa3NkUlXV8ds+FSUUK2OJpWLWuvGYmkNw0trEzLZ7c5m2MpapDGa7K61sHYCsElo4bbRWho2hgfArH5u38qpvw1S55JYChxc1fTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CguSG57m; arc=none smtp.client-ip=45.254.49.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cb1edb4;
	Thu, 5 Dec 2024 16:23:12 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: vendor-prefixes: Update rockchip company name
Date: Thu,  5 Dec 2024 16:22:58 +0800
Message-Id: <20241205082258.857018-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5DSVYZSBhDSkofT0wZSktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9395ea7d9503afkunm4cb1edb4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6DAw4PjItHQ0PHCgCCAgO
	IhlPCyFVSlVKTEhISENNQkJPT0pNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTEI3Bg++
DKIM-Signature:a=rsa-sha256;
	b=CguSG57m7fMaCiHvFyoDvQ2skC2gwEwzB7H0fPqT2SPkbVpZcm2AygYCvPSHUfH/kP1Oe6nMHonI36sBiVHJcOGKdCmE+RDee7wcxngFLl89h6BgehsiethW3jUrNf/UeBuArxaM0Ns507PH78ttSTPwl/griL0qi0N6fgbtQFQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=SnchjJcA4w+G8vlGm0jH7kMfnqakh7U1nII57Iby3/I=;
	h=date:mime-version:subject:message-id:from;

Rockchip company name has update to below name since 2021:
Rockchip Electronics Co., Ltd.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index da01616802c7..6e3ed21ab4eb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1261,7 +1261,7 @@ patternProperties:
   "^riscv,.*":
     description: RISC-V Foundation
   "^rockchip,.*":
-    description: Fuzhou Rockchip Electronics Co., Ltd
+    description: Rockchip Electronics Co., Ltd.
   "^rocktech,.*":
     description: ROCKTECH DISPLAYS LIMITED
   "^rohm,.*":
-- 
2.25.1


