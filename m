Return-Path: <linux-kernel+bounces-264487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B593E412
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26B82816B0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 08:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E9715E8B;
	Sun, 28 Jul 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iyfKsx5w"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E548F8C06;
	Sun, 28 Jul 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154863; cv=none; b=SjhxfQwWpi+Lx7X6f32cRsHWMbpw1gq6YGgcYOQeujaeZku5NMU1oikjL8CP13fQQ9rcayLSLqUt/f9gNvzDbDESAZL5WpYWhreMSsEWEEQW538pNGtIFm3pF5kAmFseCGichofFnZakztrzzQ+xuyKorI+4d+BnrVGQrMyQ1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154863; c=relaxed/simple;
	bh=VEqyOaOnbH7k/vuDrxwukqau9uwg7ZnmlPoONB5vzWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oHFeYwoxJ5rwEpuUA4719uhGQ4xk3TlcOu1idixWm5tMv06N52QYwvAOAMYM/rCRSWjlI/4Z9BirJCmeY10f9jtnnuCYbMK60UGgW+x+iUeXmkXdV3ZcoOOYElzMEAmVwgmv1N/WGatgp+ZpXGMX7Cq20d+v5RIGo79XDmIza38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iyfKsx5w; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=adiGC
	DuL728eGkg+8TRJCfZU+t/cL/RD1/bFz0cBfCM=; b=iyfKsx5w6IVHdwq3IPnCz
	dTpvZXD97qoYx8YNqr+L9yq28GNUd9UuGfGhoySt2cZxPbAfbdh7eMI4GC6uDC8M
	XAag+tAGHet3V/GhmUp/d6GhAJovNdmGEmuv5MnGeFfimdhV1LbvEZarm0G0/Ccp
	x4rVo3M/76DOVeGewgr2J8=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wCnb242_6VmJZF9Bw--.37149S2;
	Sun, 28 Jul 2024 16:20:10 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: dsimic@manjaro.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 0/2] Add support for Cool Pi GenBook
Date: Sun, 28 Jul 2024 16:20:02 +0800
Message-Id: <20240728082004.36575-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnb242_6VmJZF9Bw--.37149S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1kKFy8Xw13XF1ktryftFb_yoWDJwb_Ka
	y7WrZrJa1FqFn09F9xt3y8JrW3G39Fkr98GF4rZFsxZF9rJ3y8GF1ftw1vvF15AFW29r13
	Aa1FqF1rWwn8CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_NBMPUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQYqXmVOBz4pcgAAsS

Cool Pi GenBook is a rk3588 based laptop, it is designed
to consist of a carrier board conntected with a CM5 SoM.

This series add support of eMMC/USB HOST/WiFi/Battery/TouchPad/Keyboard,
with a mainline based u-boot[0], it can boot a third-party distribution
such as Armbian on u-disk.

[0]https://github.com/andyshrk/u-boot/commit/8eedc6700367166bfa63b861d8e7aca486d315fe

Changes in v2:
- Descripte it as Cool Pi CM5 GenBook
- rename dts to rk3588-coolpi-cm5-genbook
- enable touchpad
- enable battery

Andy Yan (2):
  dt-bindings: arm: rockchip: Add Cool Pi CM5 GenBook
  arm64: dts: rockchip: Add support for rk3588 based Cool Pi CM5 GenBook

 .../devicetree/bindings/arm/rockchip.yaml     |   8 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 349 ++++++++++++++++++
 3 files changed, 358 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts

-- 
2.34.1


