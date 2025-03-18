Return-Path: <linux-kernel+bounces-566113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AB5A67357
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2D2189AB05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6020D4E8;
	Tue, 18 Mar 2025 12:00:15 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97920AF7E;
	Tue, 18 Mar 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299215; cv=none; b=W/h16sBXcaf0eXS/eNymmL4T4M78HTpFR4MPjIC0hHzvmh8rQjIWppOHP3tKZ+0KCN2plafXTUBftQ6JiR5dcdZTEGE0MMRqIW/uC45U9JWmLM4LqrkFQVrx+Fm79peq9A8M5IyE1X+6qV95ZfTa+FQ9Ze+7b2uZTnt8voY+lFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299215; c=relaxed/simple;
	bh=fa2jGi99nVxP4vX5x8fBVjXFObPurxOLYJ6bjniTskU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jir5exM+KZHggcXQ3yoeloafjZfbRFGXI5ee5h3Cg9YNCBd5SQ+snY4KnkUS3hLt3o+x3c8SticmCXowPvWEe4G+Q1009Eql3QCjU0u1Rksc3kex5GjWgxLspwOW1/kX4HfrUnRsl7TGizTVhMNhYwDo0kdli/t7a2X88fQxzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.202])
	by smtp.qiye.163.com (Hmail) with ESMTP id eaf1c5cf;
	Tue, 18 Mar 2025 20:00:06 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Tue, 18 Mar 2025 20:00:01 +0800
Message-Id: <20250318120003.2340652-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHxlIVkNOGRlNTENITk5LSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VSUtJWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a95a920143d03a2kunmeaf1c5cf
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6FDo6FDJNPksQMVEWKx1D
	Iz8wCQlVSlVKTE9JSUJCSUtMTk5IVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VJS0lZV1kIAVlBQ09KNwY+

Add pwm nodes for RK3528. Most rk3528 boards use pwm-regulator to
supply to CPU, add node to enable them. The PWM core on RK3528 is
the same as RK3328, but the driver doesn't support interrupts yet.

Note that pwm regulator needs to be initialized in U-Boot:
```
&vdd_arm {
	regulator-init-microvolt = <953000>;
};

&vdd_logic {
	regulator-init-microvolt = <900000>;
};
```

Changes in v2:
  Remove merged bindings patch
  Remove pwm pinctrl in rk3528.dtsi
  Enable pwm regulator for Radxa E20C

Chukun Pan (2):
  arm64: dts: rockchip: Add pwm nodes for RK3528
  arm64: dts: rockchip: Enable regulators for Radxa E20C

 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 72 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 80 +++++++++++++++++++
 2 files changed, 152 insertions(+)

-- 
2.25.1


