Return-Path: <linux-kernel+bounces-383023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EBD9B164C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCC71F229BA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A991CEE8E;
	Sat, 26 Oct 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZeOSmZy4"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178791C7B7F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729930810; cv=none; b=JZ7hwgR8CQw0DEFyNYAzbqIr9iO0EkXqsum0+4cVrrc+MY8Ujuj/6CSCEMaQm2k0dHoGhXQVH2QGOZpKSGzI/Ogobg7o9x3aLlnFkfW0LMm2qO0SMz1j8iCPcwzvutkntMlSNXA11NihnSU0GVOiH1u+EnnDF20ivsQXxKJwWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729930810; c=relaxed/simple;
	bh=/BKXCQiu5+9T5D+Nnc173YgEHb5heI47VdS/5F60+bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGi41h8KUUEyHwJ8deCYP49rerp5S7BuFaV0Xgcg+1BguJoY5WYTxtyEHj+0HrOJ6bxPFP+7OUCYw1JXppQQUq4URTzvszXFRrZCZB4sX62CS/XoP0neAeEUjKcyEOgFGpOfbYXZmy3uzSm2fw8Hw7xcrb8WJlo/3vRkxsICSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZeOSmZy4; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=PbnFu
	oI9Q3MVTHlFsPg0C991ZYtgsER8pJ/y4bB0BEw=; b=ZeOSmZy4yG9DeS4uqgJk5
	NvFF1Kr3dEVSMF2xBP9R2dRuCAZNsexjyoffVWYOrn2QzDtG4GPNia0cRvxaFWtU
	bJHXrir6cpGsGJuxu5Nr3tqTmjQY0FWugTWlYa3x8lSQ3lOMjg352t4con0/1/5T
	5PPsahzPoUaM6qSREiox8o=
Received: from ProDesk.. (unknown [103.29.142.67])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3v9wkphxnW2U0Dg--.30094S2;
	Sat, 26 Oct 2024 16:19:52 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH 0/3] Enable hdmi for rk3588 based Cool Pi
Date: Sat, 26 Oct 2024 16:19:25 +0800
Message-ID: <20241026081942.348459-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v9wkphxnW2U0Dg--.30094S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRnmiuUUUUU
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxuEXmccoZRKCAAAs+

As the hdmi-qp controller recently get merged, we can enable hdmi
display out on these boards now.


Andy Yan (3):
  arm64: dts: rockchip: Enable HDMI0 for rk3588 Cool Pi CM5 EVB
  arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi 4B
  arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi GenBook

 .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    | 49 ++++++++++++++++++
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 51 +++++++++++++++++++
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 49 ++++++++++++++++++
 3 files changed, 149 insertions(+)

-- 
2.43.0


