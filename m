Return-Path: <linux-kernel+bounces-267248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D086940F03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004DD1F23B67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B9B197A91;
	Tue, 30 Jul 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qQvYMIdO"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBF1192B65;
	Tue, 30 Jul 2024 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335147; cv=none; b=WX+xJ7CW9WsPE80iDg3n4Fzg6rleAowg2jjXP2nidDF2VgABWwldLrlglk3uw0qilvkw0ZOrZ+Iq9uzW2G2jqAIACfq2Yugw/SrcdmsvEaW20pe+gm6b4uUpxFFssvfFG/CT1adSjtUBH30KFw9wyaU2w6iJAXNJUc4mv0V1YYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335147; c=relaxed/simple;
	bh=ccIJuTFvMC3/YgOBlsEaSCFAd34n+Wa7NEpjb2xGeoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qFkXKw1CPDhvbvTiM2fAJwhH5ANfDIuOROwdBUvbcWUBJwAI4nyJH50BVqsRkbmEAWQGnYaGnJtafSwc6bFUlzfi+nSc2wB/E8/ABwY4/cJDrFm9JcY+ShONihmwMB57bQWC30OzE6ZzfDRVuqHbopbw2qDCHJQ92LARg1iyk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qQvYMIdO; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xINS1
	sxEhEb8/wio/243RoKaWhtQ2h9F9g0D3EW4nVA=; b=qQvYMIdOffngeLzvxQWTh
	HRbyD9HmOypMh9085jEiT2eqSQfxu8d+DtUmjhhFvStapHPTRP661nTprohqz3F1
	mKO8a2uvjj+cTmDEm1jawZQVg4BFTfHCmvo8m8XrDRVv3YuKs54MdxPgcOdsnVXO
	DJkfaPWxHg7v6ri9kWVn2A=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3f_div6hmxPMCFA--.50877S2;
	Tue, 30 Jul 2024 18:24:38 +0800 (CST)
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
Subject: [PATCH v3 0/2] Add support for Cool Pi GenBook
Date: Tue, 30 Jul 2024 18:24:31 +0800
Message-Id: <20240730102433.540260-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f_div6hmxPMCFA--.50877S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1kKFy8Xw13XF1ktryftFb_yoWkuFb_Ka
	17ZrZrJa1FqFnIvas3tayUJry3G39rCrnxGFWrZFs8ZF9xJ3y8G3WfJ3Wvv3W5Aay29r13
	Aa1FqF1rXrnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_4So3UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwksXmXAm11sygAAsN

Cool Pi GenBook is a rk3588 based laptop, it is designed to consist of a
carrier board conntected with a CM5 SoM.

This series add support of eMMC/USB HOST/WiFi/Battery/TouchPad/Keyboard,
with a mainline based u-boot[0], it can boot a third-party distribution
such as Armbian on u-disk.

[0]https://github.com/andyshrk/u-boot/commit/8eedc6700367166bfa63b861d8e7aca486d315fe

Changes in v3:
- Wrap commit message by a maximum 75 chars per line
- Remove the superfluous blank line
- Use "coolpi,pi-cm5-genbook" instead of "coolpi,genbook"

Changes in v2:
- Descripte it as Cool Pi CM5 GenBook
- rename dts to rk3588-coolpi-cm5-genbook
- enable touchpad
- enable battery
- descripte it as CoolPi CM5 GenBook

Andy Yan (2):
  dt-bindings: arm: rockchip: Add Cool Pi CM5 GenBook
  arm64: dts: rockchip: Add support for rk3588 based Cool Pi CM5 GenBook

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 349 ++++++++++++++++++
 3 files changed, 357 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts

-- 
2.34.1


