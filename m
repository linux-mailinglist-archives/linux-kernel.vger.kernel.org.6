Return-Path: <linux-kernel+bounces-566292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB822A67624
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02761896DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7860820E01C;
	Tue, 18 Mar 2025 14:09:13 +0000 (UTC)
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B82620DD5C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306953; cv=none; b=erjanIfXQE2qxpOlQMUaipXT+ZL+bn9V5gRhL4BKP5xEAN9bdufwxpQtrbRPsfd4H/XWYhjcQ1BPoXHh4jPH7bytp571pwaBLvhDo3BtvJ2HNuB/UBwNBnaSEwse2K9aP67lipB77x3mItME26vTH50OowDeOJxxvtf5K9Zj0MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306953; c=relaxed/simple;
	bh=e7IPWI1faT8i1sKWFHAnQOxsaLiXsXYbWQX2x5FjKTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRaibZ9w4BJkZHxHbqDaqe5M+cxNyhPkYC6Wr3SoWrge60bNmBGuto057oHxF78faahXLkf5JvVHuAbLJ6Bh3fvFH79T4SNw9pbmL6epxeEZxwxcthx1mv/rwGFU/yIYoiod/G44jKlNkxq9Bz+OuSu8ZAHGyY/cU2FN2cRBqlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4ZHD8c3xmfz4x3wQ
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:03:44 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2568:e3d1:1e11:17f3])
	by xavier.telenet-ops.be with cmsmtp
	id SE3b2E0011Mz0fJ01E3bzP; Tue, 18 Mar 2025 15:03:36 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tuXX4-0000000Eeni-1Zsa;
	Tue, 18 Mar 2025 15:03:29 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tuXXV-0000000AOnB-1Nhv;
	Tue, 18 Mar 2025 15:03:29 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Shreeya Patel <shreeya.patel@collabora.com>,
	Dingxian Wen <shawn.wen@rock-chips.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-media@vger.kernel.org,
	kernel@collabora.com,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] media: platform: synopsys: VIDEO_SYNOPSYS_HDMIRX should depend on ARCH_ROCKCHIP
Date: Tue, 18 Mar 2025 15:03:27 +0100
Message-ID: <fa5622428f071a20ca5df96218aedc84fb7edc1a.1742306464.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the Synopsys HDMI HDMI RX Controller is only supported on
Rockchip RK3588 SoCs.  Hence add a dependency on ARCH_ROCKCHIP, to
prevent asking the user about this driver when configuring a kernel
without Rockchip SoC support.

Fixes: 7b59b132ad4398f9 ("media: platform: synopsys: Add support for HDMI input driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/media/platform/synopsys/hdmirx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/synopsys/hdmirx/Kconfig b/drivers/media/platform/synopsys/hdmirx/Kconfig
index 27e6706f84a37375..4321f985f6320611 100644
--- a/drivers/media/platform/synopsys/hdmirx/Kconfig
+++ b/drivers/media/platform/synopsys/hdmirx/Kconfig
@@ -2,6 +2,7 @@
 
 config VIDEO_SYNOPSYS_HDMIRX
 	tristate "Synopsys DesignWare HDMI Receiver driver"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
-- 
2.43.0


