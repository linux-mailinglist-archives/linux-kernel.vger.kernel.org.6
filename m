Return-Path: <linux-kernel+bounces-552391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453FFA5797F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811FD17280E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A01D1B0418;
	Sat,  8 Mar 2025 09:30:21 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96541ACECF;
	Sat,  8 Mar 2025 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426220; cv=none; b=VuvWga4LoFNrwMylWknNBT+2WZyshwmD44BesEi+CqMUkDioPtPw1x0xiP869szuN9WIMOwZpVGr6yqSygim5Yd2OmKAERJIKVXoJz8Q5RX491VM6Rv6SABBfja7Bf2wHzytPEKUdMBQA/SyJ1WquNX0r0F8NQ9Kx1Of8A1QivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426220; c=relaxed/simple;
	bh=51vSvuDMAgfQv4gSE/kW/ED/BDvnkaNoUpF4+mByvkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a65wltV0DHH5Ain7CMAut3DXoXcGHrvcZ81zcsd8ZzF5UvkMc/JIJ94PFhTw6/vREw1jxsDAjAXSeOgbDTfPAde/D+XS7P9X9s557VeIImMToPiFSD44k2hLTVD9Md1kUQ5E0RSCU2DYCzMTZhfhgfXBLScSb4Lg9st2XVuood4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:3300:217:f42e:f419:35e])
	by smtp.qiye.163.com (Hmail) with ESMTP id d88bc5e8;
	Sat, 8 Mar 2025 17:30:11 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 0/1] arm64: dts: rockchip: rk3568: Move PCIe3 MSI to use GIC ITS
Date: Sat,  8 Mar 2025 17:30:07 +0800
Message-Id: <20250308093008.568437-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR8fVhpDGEMYGB1NTx5KGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUhIS0tBSUpMQR1PSR5BHU9KQkFITh5ZV1kWGg8SFR
	0UWUFZT0tIVUpLSUJNSkpVSktLVUtZBg++
X-HM-Tid: 0a9575173bd103a2kunmd88bc5e8
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6ORw4KDJKFCkIASJNMTcf
	KCwKCi9VSlVKTE9KT0lNSUpJT0xDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSEhLS0FJSkxBHU9JHkEdT0pCQUhOHllXWQgBWUFJQ01PNwY+

For a long time, rk3568's MSI-X had bugs and could only work on one node.
e.g. [    7.250882] r8125 0002:01:00.0: no MSI/MSI-X. Back to INTx.

Now the ITS of GICv3 on rk3568 has been fixed by commit b08e2f42e86b
("irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor")
and commit 2d81e1bb6252 ("irqchip/gic-v3: Add Rockchip 3568002 erratum
workaround").

Following commit b956c9de9175 ("arm64: dts: rockchip: rk356x: Move
PCIe MSI to use GIC ITS instead of MBI"), change the PCIe3 controller's
MSI on rk3568 to use ITS, so that all MSI-X can work properly.

~# dmesg | grep -E 'GIC|ITS'
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] GIC: enabling workaround for GICv3: non-coherent attribute
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 320 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: MBI range [296:319]
[    0.000000] GICv3: Using MBI frame 0x00000000fd410000
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000fd460000
[    0.000000] ITS [mem 0xfd440000-0xfd45ffff]
[    0.000000] GIC: enabling workaround for ITS: Rockchip erratum RK3568002
[    0.000000] GIC: enabling workaround for ITS: non-coherent attribute
[    0.000000] ITS@0x00000000fd440000: allocated 8192 Devices @210000 (indirect, esz 8, psz 64K, shr 0)
[    0.000000] ITS@0x00000000fd440000: allocated 32768 Interrupt Collections @220000 (flat, esz 2, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x0000000000230000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000000240000
[    0.013946] GICv3: CPU1: found redistributor 100 region 0:0x00000000fd480000
[    0.013968] GICv3: CPU1: using allocated LPI pending table @0x0000000000250000
[    0.014948] GICv3: CPU2: found redistributor 200 region 0:0x00000000fd4a0000
[    0.014968] GICv3: CPU2: using allocated LPI pending table @0x0000000000260000
[    0.015904] GICv3: CPU3: found redistributor 300 region 0:0x00000000fd4c0000
[    0.015923] GICv3: CPU3: using allocated LPI pending table @0x0000000000270000

~# lspci -v | grep MSI-X
        Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
        Capabilities: [b0] MSI-X: Enable- Count=128 Masked-
        Capabilities: [b0] MSI-X: Enable+ Count=32 Masked-
        Capabilities: [b0] MSI-X: Enable- Count=128 Masked-
        Capabilities: [b0] MSI-X: Enable+ Count=32 Masked-

Chukun Pan (1):
  arm64: dts: rockchip: rk3568: Move PCIe3 MSI to use GIC ITS

 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1


