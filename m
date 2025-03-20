Return-Path: <linux-kernel+bounces-569451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F9A6A334
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2606A19C26A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC42253E8;
	Thu, 20 Mar 2025 10:00:15 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9404F224229
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742464814; cv=none; b=mJVMrwZv4BYWiUArQFpmL7rdOvtzj0bW0BJ3JTh6q4dGgvPLlbuPu6UER0XpwPxN3LekHpxD5HftwBwD5hMhbSmQkwjPTudi8X+LK54iggHbCB9mMIPBXk2HVJkJa9nC1T3ikmitnDL4k84WsPwSve8R/7K4AAv45YbAxw4Vg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742464814; c=relaxed/simple;
	bh=QzwPDMSwc/YQPRyKyUzMqV0iZPE07HugNb4f4pAgfqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ov/F81Q8Cl7xOUHXY1oDkBw90ZuPl+XioGeKgPSI8vBWbL4Mk8g0QfS0pjv+1PCvStAeXiMMQoE+sAql0OsBSHlrJUDGbBeTZrgmnOh3Bcgc+cw660RbHNbVdKpEwhG5pbkyTzcyWJAyG8vTstd5GwPuWYIEsBtOHwT9wPaMigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:27b0:1bde:abfc:3838:af13])
	by smtp.qiye.163.com (Hmail) with ESMTP id ef1b2939;
	Thu, 20 Mar 2025 18:00:05 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] arm64: dts: rockchip: rk3528: Add CPU frequency scaling support
Date: Thu, 20 Mar 2025 18:00:01 +0800
Message-Id: <20250320100002.332720-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSh9JVhpPQkMeQk9OTh5DQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUlMGUtBShkfHkEaGR0YQUhDSENBGh1KSFlXWRYaDx
	IVHRRZQVlPS0hVSktJQkNDTFVKS0tVS1kG
X-HM-Tid: 0a95b2feea1a03a2kunmef1b2939
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mww6UQw4GjJIMkIjTRYMMRgz
	MhYwCTpVSlVKTE9JT01PQ0tNTk1NVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSUwZS0FKGR8eQRoZHRhBSENIQ0EaHUpIWVdZCAFZQUlMQkg3Bg++

This series depends on the pwm series:
https://lore.kernel.org/lkml/20250318120003.2340652-1-amadeus@jmu.edu.cn/

By default, the CPUs on RK3528 operates at 1.5GHz. Add CPU frequency and
voltage mapping to the device tree to enable dynamic scaling via cpufreq.

OPP values come from the downstream kernel, and voltage is chosen from
the one that makes the actual frequency close to the displayed frequency.

Here are the test results using mhz [1] on Radxa E20C:

------------------
display |  actual
 408MHz |  395MHz
 600MHz |  593MHz
 816MHz |  833MHz
1008MHz | 1089MHz
1200MHz | 1215MHz
1416MHz | 1428MHz
1608MHz | 1640MHz
1800MHz | 1804MHz
2016MHz | 1952MHz
------------------

If we want the actual frequency to reach 2016MHz, the voltage
needs to reach 1.13V (+0.03V), not sure if it is safe.
The maximum opp-table voltage of downstream kernel is 1.1V.

Jonas previously suggested using the maximum voltage of the
downstream opp-table due to differences in silicon quality.
However, this will make the actual frequency difference a
bit large. Here are his test results using maximum voltage:

--------
 4 boards (E20C, ROCK 2A, ROCK 2F)

 408000:  873mV   394MHz   394MHz   394MHz   394MHz
 600000:  873mV   592MHz   592MHz   592MHz   592MHz
 816000:  873mV   941MHz   977MHz   954MHz   953MHz
1008000:  873mV  1148MHz  1186MHz  1169MHz  1168MHz
1200000:  900mV  1368MHz  1380MHz  1366MHz  1360MHz
1416000:  964mV  1547MHz  1554MHz  1547MHz  1534MHz
1608000: 1014mV  1734MHz  1768MHz  1770MHz  1740MHz
1800000: 1064mV  1850MHz  1883MHz  1887MHz  1854MHz
2016000: 1100mV  1931MHz  1963MHz  1970MHz  1933MHz
--------

The downstream kernel reads the efuse value from otp to
select the voltage, usually using opp-microvolt-L3.

[1] https://github.com/wtarreau/mhz.git

Chukun Pan (1):
  arm64: dts: rockchip: rk3528: Add CPU frequency scaling support

 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

-- 
2.25.1


