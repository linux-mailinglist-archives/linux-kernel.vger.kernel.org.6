Return-Path: <linux-kernel+bounces-573670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D90A6DA83
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DD818961C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDBC261376;
	Mon, 24 Mar 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XuHjMZ4H"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F60425FA33;
	Mon, 24 Mar 2025 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820772; cv=none; b=KckOfAv5L0yk2qj30Szfiv1xQQC/LaufLR2m5wW1bip0QrYe8Gm5PwZIt0QzL3E912fLXeIJHrAYwfN1jTf70AG8fv/unlvvwsH3lBx52BWByWPXho79mbkB55/Q6MfellFJKNQaccv0IfXNPK7wnXJglxD8/Qorf7bj1aKWqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820772; c=relaxed/simple;
	bh=DGpU04yKPRoOZy0YVkJWqS/S+9o26k7SQZrWuf3KMcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TskoDnwY2jgI/4+vAIYfCK1AdjP4+w/9dv1Qz2pwaEQXyFepGWzg9lNfQ5UIllHYa+fCqjHKwVwp4c/IQyOrOZQB2XMzEd2CIwkX0YVNK8/4lcrTbnlnjySP6INVnKPw4rIud7VTBcY8fIaxYb5fob7TZo62oENenPdNHzdPJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XuHjMZ4H; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=PHKuR
	DmBKYPk3+KtVV7z/lVVayQrARu4WFny395S+VM=; b=XuHjMZ4HXjyo2LiJLFL/6
	udAg/qCviGk94zLDk1nyK8+NvlfwSEO9Tljhwg4EHfObmZCK0PBf85mPEvnoJTWs
	xULr6PoEvaxgANf+FluZJGMMDTdkLJ6FZWuhj8v1tCgE7Im3yjS3U1cnMH5tzV7u
	HO1QUdR8DmhPDnDC5cFarE=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnL9mAVeFnOfyBBg--.24149S2;
	Mon, 24 Mar 2025 20:52:19 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	inux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] ARM: dts: rockchip: Add aliases for MMC devices
Date: Mon, 24 Mar 2025 20:52:11 +0800
Message-ID: <20250324125215.160616-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL9mAVeFnOfyBBg--.24149S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DuF47tFW3WFy7uFy8Zrb_yoW3tFg_ta
	43Cw1rJa18GFy5Xw1Dt3yrW343Awn7Kay3G3WDAF18GF1vqa1kXF4kJas7t3WYyFW29rZ3
	JFWfXa1Yqa13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1LvKUUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gYaXmfhTQKPYwADs2

From: Andy Yan <andy.yan@rock-chips.com>

Add aliases for the MMC devices so that after the system starts up,
they will all have fixed device numbers.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 arch/arm/boot/dts/rockchip/rk3036-kylin.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
index 15a8860c7ae47..a2d7ec2729116 100644
--- a/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rockchip/rk3036-kylin.dts
@@ -8,6 +8,12 @@ / {
 	model = "Rockchip RK3036 KylinBoard";
 	compatible = "rockchip,rk3036-kylin", "rockchip,rk3036";
 
+	aliases {
+		mmc0 = &emmc;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
-- 
2.43.0


