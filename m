Return-Path: <linux-kernel+bounces-550818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15791A5647E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864CD1735DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27FF20D500;
	Fri,  7 Mar 2025 10:00:24 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5520C000;
	Fri,  7 Mar 2025 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341624; cv=none; b=qqj/iyjhILyhUSxhiiKzehJF37wLExJ8eKlEacHlrCJ8tt/dcc+dht8j9eMLO3CONiWC8IIyn96vLlNtbyxajQ+CaZFw2zCwiAvPLobjMCGnTz5w1mdG3MKRbdLFBKucAViV+Jh7Oy35odxA2Zb3DwhyEwnrR820IQ41IX48tL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341624; c=relaxed/simple;
	bh=ExNEzbE0kj5w02IFGodwiFqK8I2Ad82PnSevrzYOBA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fHjSakmT4nq4mWsSESmJAoGuKgBu/pgVznzAGWjmO4dWasDYTAp6qPi2L/a8CCCHl3fXsvpacUu2YSCajCTd+17w9nxoUz2rUHlIUWt2CHZjyae7vqsom2eIbIbow/PS1jbEV6P5bi1jGu6S2teFC/wjk9xHpKtZ/OiAWI17uXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:3300:467f:62a0:f2ba:1721])
	by smtp.qiye.163.com (Hmail) with ESMTP id d586ba78;
	Fri, 7 Mar 2025 18:00:11 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v3 0/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Fri,  7 Mar 2025 18:00:07 +0800
Message-Id: <20250307100008.789129-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHh5NVkkYQ05ISU0fTE5CS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUhIS0tBT01MHUFNSRpLQR1JGRpBSkxJSllXWRYaDx
	IVHRRZQVlPS0hVSktISk5MTlVKS0tVSkJLS1kG
X-HM-Tid: 0a95700c562a03a2kunmd586ba78
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Sxw5CzJILjZRNyo2OAo6
	Pk0wCTZVSlVKTE9KSE9KTUpJTUhDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSEhLS0FPTUwdQU1JGktBHUkZGkFKTElKWVdZCAFZQUJKTzcG

Same as RK3568, RK3528 uses SCMI clk instead of standard ARMCLK.
Add SCMI clk for CPU, GPU and RNG will also use it.

dmesg:
[    0.061333] scmi_core: SCMI protocol bus registered
[    0.125780] scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
[    0.126628] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    0.127233] arm-scmi firmware:scmi: SCMI Protocol v2.0 'rockchip:' Firmware version 0x0

CPU frequency: ~# mhz
count=611657 us50=19994 us250=99945 diff=79951 cpu_MHz=1530.080

Changes in v3:
  Remove unnecessary assigned-clocks

Changes in v2:
  Change sram to reserved-memory

Chukun Pan (1):
  arm64: dts: rockchip: enable SCMI clk for RK3528 SoC

Chukun Pan (1):
  arm64: dts: rockchip: enable SCMI clk for RK3528 SoC

 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

-- 
2.25.1


