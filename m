Return-Path: <linux-kernel+bounces-171267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB98BE201
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2E6B2777E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27015ECCC;
	Tue,  7 May 2024 12:23:11 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB315B96B
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084590; cv=none; b=Qgfo5toVJ/jVCxmybFWYQkPB+444IUNqospbDc01E8gin5zezb7EbLawMQQrdhQ+rTk2yUjKeIL5NolkPjH0O6SWmc0mLRJnlasLCpgHyOJ22xpo30nHv+pMEUvCJfFYkcrRx2xu/iwfPffN3Q5ySyCX6SOlGiYnQN7+z/oZlaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084590; c=relaxed/simple;
	bh=CHPTXwsd0OA2FqAgbqwMFREtiS40MgtcKotbwznkjuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B7gmttcIOEjgMPxd5eJOhvRGu7NdHXtmN+fwpAhE3GeqSKH43KnWaZLfEjpnJURcxZIFsazB55ZvO1PyKT7/BX88vcD6GRftBqB2mrnhw528ScilWKoR/P5XZnXdmmSaL2MUUszztjmxl0GuaS/VmE/d2zgpQreEgYYQfiHlsqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s4JqY-0006h6-VH; Tue, 07 May 2024 14:23:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: srinivas.kandagatla@linaro.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de
Subject: [PATCH 0/3] Small changes for Rockchip NVMEM drivers
Date: Tue,  7 May 2024 14:22:53 +0200
Message-Id: <20240507122256.3765362-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the option for legacy cell dt layouts was added, the
Rockchip OTP driver seems to have been overlooked, so set
the necessary option to allow seeing the cells again.

And two patches set the nvmem-type option in the device config.

Heiko Stuebner (3):
  nvmem: rockchip-otp: set add_legacy_fixed_of_cells config option
  nvmem: rockchip-otp: Set type to OTP
  nvmem: rockchip-efuse: set type to OTP

 drivers/nvmem/rockchip-efuse.c | 1 +
 drivers/nvmem/rockchip-otp.c   | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.39.2


