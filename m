Return-Path: <linux-kernel+bounces-550587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5F1A56196
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5107B165113
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7436D1A3142;
	Fri,  7 Mar 2025 07:10:34 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5D1519A3;
	Fri,  7 Mar 2025 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331433; cv=none; b=rlDxpC481op5aAkk7fL5sdkT3LNqzvQTFIdIrx4CMUUstZFC/4qc4MjMdpnRcfxqJ5Mcu3X2h3/BZQUlmks6XK8DDokIF5Up+4UYkTC+FkjQPjMU+puWOoo7Wz4zVrw+/2HHC3Ana2u9qAUAGhW895Cljxe1bAudcXM+0Uej0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331433; c=relaxed/simple;
	bh=/i61AFTna0JtqgSXTvtVBwSvEIxrH0iTFTAZj2TrUDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8VWWqostKIBVYUXwPm4hI+QW/qGIeE2RIycqTWz6kKUW/NFeQ4Ks8sus/j5v2g0rvynWpI1bdnA/si8O9aBrGcNnPSlkzxzCUOG4JX8GzGjZ4KuLcScUKsiwVu2F4b69x1pJjylH8s+NaenHh25bUPUeW9KTJH2718UArxZRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:3300:bb12:a0a3:40d:e82f])
	by smtp.qiye.163.com (Hmail) with ESMTP id d4f8d463;
	Fri, 7 Mar 2025 15:10:22 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	ziyao@disroot.org
Subject: Re: [PATCH v2 8/8] arm64: dts: rockchip: Enable SD-card interface on Radxa E20C
Date: Fri,  7 Mar 2025 15:10:20 +0800
Message-Id: <20250307071020.756277-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5a0a7ce1-1dfb-4d19-8a1e-0d89d177f5b8@kwiboo.se>
References: <5a0a7ce1-1dfb-4d19-8a1e-0d89d177f5b8@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTU4eVhlNHRkaTU9JHkMdGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUhIS0tBGRlKSUEaSxpIQU9LH0EeQ0kdWVdZFhoPEh
	UdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQktLWQY+
X-HM-Tid: 0a956f70dd1003a2kunmd4f8d463
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6Hjo6MDICHDcIIjULGjVC
	CAIKCT9VSlVKTE9KSEhKT0lISUNCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSEhLS0EZGUpJQRpLGkhBT0sfQR5DSR1ZV1kIAVlBT0NCNwY+

Hi,

> On the E20C the sdmmc controller is routed to a microSD card slot mainly
> intended for use with microSD-cards and should normally not need SDIO.
> 
> What card/adapter do you have inserted in the microSD card slot that
> requires use of SDIO instead of just SD or MMC? What is the use case you
> have that requires removal of no-sdio on E20C?

I inserted an sdio wifi module (via sdcard adapter) for testing.
Just out of curiosity :)

Thanks,
Chukun

-- 
2.25.1


