Return-Path: <linux-kernel+bounces-235249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82191D240
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E869D1C20BDB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57541534E6;
	Sun, 30 Jun 2024 15:07:31 +0000 (UTC)
Received: from mail-m6016.netease.com (mail-m6016.netease.com [210.79.60.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC8135A65;
	Sun, 30 Jun 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719760051; cv=none; b=OklgvslNyWfdvZW6BDSBTubjxr4/ZrjofaPsC2UNkLeFqrlMMYkLfbqV54hjAl2FQyyw5pj6biCBKoDi+3Dw2NmMPEas5JgLqctcNSbYtSLceTKYpCMYkXSeDV9MJAo15t3H4IR9Ofyvr2TDpvzsd+dc+AckwyouWepGGY4fcVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719760051; c=relaxed/simple;
	bh=Yc+nlxb0YDAx67elWIR8Z7mlsgKHHYgfen3rVPRgdDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CpoSvZz6DIVyNv/DFRJ1l8/QXRtAaGMJly7Z1NKt71WfpD7FicgzihzrqL/ODN3+ReqcItNBuZFxy4i8yIOF/q50cGdor9tWGMAsDKkH/ZACL241aXmFXiPQiGc9hHVIpcdFbrA12dZ4D19iuBYP2kM+h2zgsdXHStZ6Rmsy56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=210.79.60.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:1720:3110:52ea:d52a:84f0])
	by smtp.qiye.163.com (Hmail) with ESMTPA id B73027E0187;
	Sun, 30 Jun 2024 23:00:16 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 4/9] arm64: dts: rockchip: remove unused usb2 nodes for Lunzn Fastrhino R6xS
Date: Sun, 30 Jun 2024 23:00:05 +0800
Message-Id: <20240630150010.55729-5-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240630150010.55729-1-amadeus@jmu.edu.cn>
References: <20240630150010.55729-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGE9LVh9DS01KTUNJSB1KHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtKQUpMSUtBSEpKS0FOSR4aQR9OSRpBQ08dS1lXWRYaDx
	IVHRRZQVlPS0hVSktJT09PS1VKS0tVS1kG
X-HM-Tid: 0a9069a93bca03a2kunmb73027e0187
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORQ6Fyo*PzNWERw3LTAhSDY4
	PU0wFB5VSlVKTEpCTE5CTUpMSUNNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBSkxJS0FISkpLQU5JHhpBH05JGkFDTx1LWVdZCAFZQUlNSE83Bg++

Fix the following error when booting:
[   15.851853] platform fd800000.usb: deferred probe pending
[   15.852384] platform fd840000.usb: deferred probe pending
[   15.852881] platform fd880000.usb: deferred probe pending

This is due to usb2phy1 is not enabled. There is no USB 2.0
port on the board, just remove it.

Fixes: c79dab407afd ("arm64: dts: rockchip: Add Lunzn Fastrhino R66S")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
index 82577eba31eb..e08c9eab6f17 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
@@ -421,28 +421,12 @@ &uart2 {
 	status = "okay";
 };
 
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host0_ohci {
-	status = "okay";
-};
-
 &usb_host0_xhci {
 	dr_mode = "host";
 	extcon = <&usb2phy0>;
 	status = "okay";
 };
 
-&usb_host1_ehci {
-	status = "okay";
-};
-
-&usb_host1_ohci {
-	status = "okay";
-};
-
 &usb_host1_xhci {
 	status = "okay";
 };
-- 
2.25.1


