Return-Path: <linux-kernel+bounces-334204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2997D3E1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D1F1F24C43
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F0713C67A;
	Fri, 20 Sep 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Kk3Be7dx"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060C23D2;
	Fri, 20 Sep 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825832; cv=none; b=OBHnzYDdQsRIJ1a6gG8t6w6B3rrPOG1an/8/UO67mV5cRxeGSQmiSyfjzT5tB9jeFaqUJRVeU/nz4K6bjg8rSDI76yHs4Ixin8mOA1Vk3EJlSLIZDPRlZkuEy+izPgK8wQzpqkFce3qGv/yyRCmWH4C2bo8tA9tUyEtOOlWncP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825832; c=relaxed/simple;
	bh=1rdp55/1su/Etf/IoL9ttVbwKhbObizG3UvpcQCk2Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5FtsCdX10veGJtaNasKIdxemTdgJrjwmKqbGwCcW8Ix+4BHs2zwCy5oEGLoj+WhDxxucX07CniC2xR4YQquXXkR06SaBhYJu2CkMxipNW/c3QRYlVGVRDe0cgpUzHGX8FnADQUlt38x04j3qF1nYAOtE7xcH+VkkOLzTIJH/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Kk3Be7dx; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=4Oz9E
	Gwjk4aZj3YbPGhg4yOE8S78lWrNZLAkB1wTa4A=; b=Kk3Be7dxCfYg2o7NiTFgW
	3/NHGYQ3PDBKm4YEQAJ4Xdw/Hb7wXMAgojNDFyeCcphlGTZEjha1j1BlWHn3eMFH
	cova2Mi6GVXkzB3tRml/8mVPjfSYe4aBeRLoaG/nOnL2Lo5C1CfYWtQLRgmxwaoL
	zEzz0tXf0wZJGFZ0AlZCE4=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wD3nx88Re1mbaaqNw--.52618S2;
	Fri, 20 Sep 2024 17:49:52 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: joro@8bytes.org
Cc: conor+dt@kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] dt-bindings: iommu: rockchip: Add Rockchip RK3576
Date: Fri, 20 Sep 2024 17:49:40 +0800
Message-ID: <20240920094947.7566-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nx88Re1mbaaqNw--.52618S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1xZFW3uF47Kw4kCrW3ZFb_yoW3urc_C3
	Wxua1UXF4rtF4F9w1DZ3yxWFn8Gw12kFn3ZF98CFn5Ja4j9rWkJF95Jw15Ar18Gr429FyS
	9Fn3Wry7WF9xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbxwIPUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMx9gXmbtQAOVOwAAs0

From: Andy Yan <andy.yan@rock-chips.com>

Just like RK3588, RK3576 is compatible to the existing rk3568
binding.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 621dde0e45d8..6ce41d11ff5e 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -25,6 +25,7 @@ properties:
           - rockchip,rk3568-iommu
       - items:
           - enum:
+              - rockchip,rk3576-iommu
               - rockchip,rk3588-iommu
           - const: rockchip,rk3568-iommu
 
-- 
2.34.1


