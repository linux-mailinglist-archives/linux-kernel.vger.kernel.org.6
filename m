Return-Path: <linux-kernel+bounces-565889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60232A670A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DFA3A83F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59448206F37;
	Tue, 18 Mar 2025 10:00:28 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754E1EF366;
	Tue, 18 Mar 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292027; cv=none; b=GvWXGIRwkL+bVI1F/LvAW1hDpe8MLFPU2mLLoG+e5XqTiCuE6PrNsDAmqqzkPgjLw1DkpQz7ZqoQYqZqFWtsoZZZz089t2UsAqEyDk3PKF0ElFompcxvL5LXsZ27zATZBp49dG0BYLqjyNRvaQWyUbQlKf+wGrNJSEgr0lNPkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292027; c=relaxed/simple;
	bh=eGvltnHtvp+4GBgsbVX8GpomyE71UOMZi+G9uiLe95g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=invkhTpxUlBnIWNO6Gu360xHKjlazAEUz5k+J4pfMy7CL3916+qfaK8nn3/52G3YX6vLwu7Bl/CBqFVHyO7L8109iauFBlRVNfpSUbAb1+vW/5caoL8dTEH2WS0JRYHc4p5HVR7SI3T4rfsMpje8MeiO4EYvQMX9W90LIt6kxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.202])
	by smtp.qiye.163.com (Hmail) with ESMTP id eac37604;
	Tue, 18 Mar 2025 18:00:15 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Yao Zi <ziyao@disroot.org>
Cc: Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 0/3] arm64: dts: rockchip: Add DMA controller for RK3528
Date: Tue, 18 Mar 2025 18:00:07 +0800
Message-Id: <20250318100010.2253408-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGBgeVhhLTBpMSUlNT0saSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VSUtJWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a95a8b257fa03a2kunmeac37604
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N0k6Mxw4TTJDHEsPAg4XGBEc
	OQgwC05VSlVKTE9JSUJJS0pNSk1LVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VJS0lZV1kIAVlBTEhONwY+

First commit adds missing uart3 interrupt for uart3 node.
The next commit adds the DMA controller that can be used
for spi and uart. And add DMA description for uart nodes.

~# dmesg | grep dma
[    0.103466] dma-pl330 ffd60000.dma-controller: Loaded driver for PL330 DMAC-241330
[    0.104212] dma-pl330 ffd60000.dma-controller:       DBUFF-128x8bytes Num_Chans-8 Num_Peri-32 Num_Events-16

Chukun Pan (3):
  arm64: dts: rockchip: Add missing uart3 interrupt for RK3528
  arm64: dts: rockchip: Add DMA controller for RK3528
  arm64: dts: rockchip: Add UART DMA support for RK3528

 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 29 +++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

-- 
2.25.1


