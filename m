Return-Path: <linux-kernel+bounces-552414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A0A579A4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8EA1897EEC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E571B0420;
	Sat,  8 Mar 2025 10:00:17 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D7186E2E;
	Sat,  8 Mar 2025 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741428016; cv=none; b=DPlkMAHO7kngYJWAjselJOqfMvJ2bO8cKzYVbDD9fvjKUasD5seQL8aSUoSFj/fU3ynC7rwjB9kYD820jpMR+eeRGpBwKyUtXKNaA9ACDrAFXa21JOSroXSqwBwhQ8WXz9nhIPb4ElXVHDrZ+6oNLTozVmECSiZBgdqEyz8j5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741428016; c=relaxed/simple;
	bh=MkYZxfvXLcFbXOywwBybLOQBf2wBpU+hYubrKJ1bGcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oViuLwR2YmOf+6tPa55Hg5hGH+w36AeQr0ruaaF4/N64bCSYtGS6do7FBvfjK0zDcRE1rdboLasU0CHL4O8CpehDu3wx2+kXielO3dN0aqtbLVQ2dYIcduGK7zijy4JMVXWjwg9Ip5I1jtPrR9pPYAgSZSjQTKBp26Go2NgKJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:3300:217:f42e:f419:35e])
	by smtp.qiye.163.com (Hmail) with ESMTP id d8ad0330;
	Sat, 8 Mar 2025 18:00:05 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Rob Herring <robh@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 0/1] arm64: dts: rockchip: rk356x: Move SHMEM memory to reserved memory
Date: Sat,  8 Mar 2025 18:00:00 +0800
Message-Id: <20250308100001.572657-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTU9OVkpNT0lNGUweSENKQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUhIS0tBSUpMQR1PSR5BHU9KQkFITh5ZV1kWGg8SFR
	0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0tZBg++
X-HM-Tid: 0a9575329a9c03a2kunmd8ad0330
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pk06ESo4HzJNMik5FjVCDyIB
	TE0wCThVSlVKTE9KT0lDS0tNSENIVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSEhLS0FJSkxBHU9JHkEdT0pCQUhOHllXWQgBWUFNQkM3Bg++

Inspired by recent rk3528 thread:
https://lore.kernel.org/lkml/20250306131016.281290-1-amadeus@jmu.edu.cn/

Nothing seems wrong:
/# dmesg | grep scmi
[    0.086456] scmi_core: SCMI protocol bus registered
[    1.519045] scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
[    1.520074] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    1.520772] arm-scmi firmware:scmi: SCMI Protocol v2.0 'rockchip:' Firmware version 0x0

Chukun Pan (1):
  arm64: dts: rockchip: rk356x: Move SHMEM memory to reserved memory

 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

-- 
2.25.1


