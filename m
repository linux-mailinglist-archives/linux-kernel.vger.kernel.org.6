Return-Path: <linux-kernel+bounces-548975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC1A54BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE1B3B2C54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE07720CCF4;
	Thu,  6 Mar 2025 13:10:32 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F620C49B;
	Thu,  6 Mar 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266632; cv=none; b=JYPnGU6B4Zn+SaEEbiZzHfd7nutM++k3w7oLpg272rn+QqytDKwA1k0C4IdogOUNqgAnp2Prcqs+rL26ihGucrhYTgWbZLm75bI1qKgBM93B0TvBScWjaApveiAfoPe1hh6kvlEYiaA4QNZB7Pc44KF4dEqVD3/HnyYI5NVV2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266632; c=relaxed/simple;
	bh=GYGBIOgl7UFkl005dcxMCPflmC58aYjN1lbzXYzm3LE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFLy/Q+hwvdp49Agp2tzTx7JRhcWlToNGxqA1IZAlZkaSJ/oTaOXb8D1Hg6oE6tgUmxFeJR4TTnhiAN/OA5/ck4F7DCosNncA+WOE+Z3DY3/XshbgFY1ugF8a46oow4Mzia8QbaEf7je0O1SmF3lKrNuPRW03r+DIYcrwD/nBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d2ca2cef;
	Thu, 6 Mar 2025 21:10:24 +0800 (GMT+08:00)
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
Subject: [PATCH 0/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Thu,  6 Mar 2025 21:10:15 +0800
Message-Id: <20250306131016.281290-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSUoeVk0YSksZTk1JGUJIHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a956b941f9d03a2kunmd2ca2cef
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQw6EAw5KTJWTTMWTkI6Di8x
	PBMwCTxVSlVKTE9KSU1NTUlOS09KVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUxISjcG

Same as RK3568, RK3528 uses SCMI clk instead of standard ARMCLK.
Add SCMI clk for CPU, GPU and RNG will also use it.

dmesg:
[    0.061333] scmi_core: SCMI protocol bus registered
[    0.125780] scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
[    0.126628] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    0.127233] arm-scmi firmware:scmi: SCMI Protocol v2.0 'rockchip:' Firmware version 0x0

CPU frequency: ~# mhz
count=611657 us50=19994 us250=99945 diff=79951 cpu_MHz=1530.080

Chukun Pan (1):
  arm64: dts: rockchip: enable SCMI clk for RK3528 SoC

 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

-- 
2.25.1


