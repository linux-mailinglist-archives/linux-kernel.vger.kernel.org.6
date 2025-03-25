Return-Path: <linux-kernel+bounces-575427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1ABA702BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE5847EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDFD25A328;
	Tue, 25 Mar 2025 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K79ks/LL"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA472580D0;
	Tue, 25 Mar 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909434; cv=none; b=snZrJYJLJlhaBwnbhyZuL8QWZ5fnD25wVJoaNpXXLasjD5dKs/gnaZM/ypbP8QJE8AUXh6am5LyI8/45PEMJJhDhOVUzgs4sthjb35Qyq+vZIGHNi3eW3mni1CpwJ+T52J8lzSqhp4XgDmpin0qhU68JiN6eRvNggysg0Vu+kgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909434; c=relaxed/simple;
	bh=OVq6YEbQ1WTJhROpiEdv5FE1pk85yX2IfDiVLjvc5h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyeeAT+oJHNtPqJV+E+soUFmUgvTBnrGzQZdzWEwR0fyKpqEVwFshkEz4OSmTXnTR7/GaNXaHKmnRgFO3xHNrDQqdiWJaYx9AE2BOdbqr/+tsGFBEZhvt39fH5P23Nd1nUU9A6ZpZ4mFcpa2mu8ArTxDC9oifjzJs4htpEIS0U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K79ks/LL; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=b4xUr
	2g8P2Yxfewyx9tncEy5+j9/6LhB8iszS/EBG4A=; b=K79ks/LLuSMZu35FzSAPn
	FUTPmIjAhC6jRxmEHuSHfrsf1OS/CBsVJKZUTidAB3cZKq8PazjI+RmXXcG4zLbO
	V5+8Zs/jiX54UmyHs0pXbxxTRL7VnbfYHbpJQ0TpOVwGV5oyPplK5HwolREy8ODX
	vASdnUq9VjMuUXvyqzQnp4=
Received: from ProDesk.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnc2bLr+JnWNnrAA--.35530S8;
	Tue, 25 Mar 2025 21:29:56 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	hjc@rock-chips.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 6/6] Revert "ARM: dts: rockchip: drop grf reference from rk3036 hdmi"
Date: Tue, 25 Mar 2025 21:29:40 +0800
Message-ID: <20250325132944.171111-7-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325132944.171111-1-andyshrk@163.com>
References: <20250325132944.171111-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnc2bLr+JnWNnrAA--.35530S8
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry5Kr43uFW8Ary3Kw15Arb_yoWkGwcEya
	4Ig3W5Ka1FkrWYqry8tw4UCwsFvws5GFZ3Jw1rJr4UGwnYqF4DuFs5GayIyr15Gay2grZ3
	WFZ5Xa1Yyw1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0JDG5UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBQbXmfipyL9GAAAsc

From: Andy Yan <andy.yan@rock-chips.com>

This reverts commit 1580ccb6ed9dc76b8ff3e2d8912e8215c8b0fa6d.

The HSYNC/VSYNC polarity of rk3036 HDMI are controlled by GRF.
Without the polarity configuration in GRF, it can be observed from
the HDMI protocol analyzer that the H/V front/back timing output
by RK3036 HDMI are currently not in line with the specifications.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- First included in this series

 arch/arm/boot/dts/rockchip/rk3036.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
index 22685cd23a708..95ae815ba56d3 100644
--- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
@@ -405,6 +405,7 @@ hdmi: hdmi@20034000 {
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_HDMI>, <&cru SCLK_LCDC>;
 		clock-names = "pclk", "ref";
+		rockchip,grf = <&grf>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmi_ctl>;
 		#sound-dai-cells = <0>;
-- 
2.43.0


