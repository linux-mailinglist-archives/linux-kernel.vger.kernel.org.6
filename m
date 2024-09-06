Return-Path: <linux-kernel+bounces-318108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D3796E86C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE211C234BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDA038DE0;
	Fri,  6 Sep 2024 03:51:35 +0000 (UTC)
Received: from mail-m17249.xmail.ntesmail.com (mail-m17249.xmail.ntesmail.com [45.195.17.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816A3CF74;
	Fri,  6 Sep 2024 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594695; cv=none; b=jGfSGhsbml1qndV31+ZwG0c6+nNkWBsQ9jDE6sNLV6FP8sBIWfTUXd3eSa5fgeCzHvVGgXz4/clJLzUSBlywSIuMjVm4cM9etM4zX3Efumly8IOUXj53v7PdRE6ePjQkbYwZ//vpo0xYGPWkyEk/TbOk72tW++iTgzWzMPAuNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594695; c=relaxed/simple;
	bh=IJ4DjOQHCwE5V0EMCPyp4XIhTzsQmTstAugwYU/aD4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHfnwP5k08njcOda3MROjwVd+QDCRPZ/UT0uEDMJtxDOCBtcuWqynci0NhIUY3BNLaL4e39Xw0wP0sWu4sBFfSSaghzd/uUFBjh6VVuwsrYdfdDwGdSzJCmncIRlhsZmbndRj+hNycYeTIZ8gvN1A0n0AR6mUC+oMYKPxWXIxAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.195.17.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:3b50::1])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 40DED7E0172;
	Fri,  6 Sep 2024 11:50:24 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: bigfoot@classfun.cn
Cc: amadeus@jmu.edu.cn,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
Date: Fri,  6 Sep 2024 11:50:18 +0800
Message-Id: <20240906035018.33211-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <fd4fc7a0-7def-4f91-a64c-71689ff71d1c@classfun.cn>
References: <fd4fc7a0-7def-4f91-a64c-71689ff71d1c@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGh9IVkwdThhITBhNSxlKQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUgZTktBQUpZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Tid: 0a91c574623003a2kunm40ded7e0172
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oio6Sgw6MDI5DT9NLSkaLUgo
	GEIaChlVSlVKTElOTkJPTUlOSUhMVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSBlOS0FBSllXWQgBWUFKTExINwY+

Hi Junhao,

> I have tried rgmii-id with tx_delay/rx_delay 0x38/0x15, or 0x0/0x0,
> or directly removed tx_delay/rx_delay, they all didn't transmit data.
>
> I saw in dwmac-rk.c that when using rgmii-id, the tx_delay/rx_delay
> properties in dt are ignored?

When using rgmii-id mode, tx_delay and rx_delay can be removed directly.
But you need to test whether the rx/tx-internal-delay-ps is appropriate.

-- 
2.25.1


