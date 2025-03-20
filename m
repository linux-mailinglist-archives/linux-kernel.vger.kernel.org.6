Return-Path: <linux-kernel+bounces-569108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4BA69E94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF1E171A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899A21EB18E;
	Thu, 20 Mar 2025 03:00:34 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB411DDC1D;
	Thu, 20 Mar 2025 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742439634; cv=none; b=YBmQWbeprF/YH2uNbxRXK7XmJsOnCEy0pVH0t34ogw/hoZ2xzjESLx4OZ43FAe72vFI9pvO/FSXRSqMPbHg8I2dUzADOmLCBhtWWzAo309pNoP3LQqvwWy/1OZZT9NxjQQ0BWATXIRPMbJHV6FpKvqYkLMiZTxO2Zf0uNt2lNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742439634; c=relaxed/simple;
	bh=hJ9+sDzOClWAF1ynnj0RCGQtQpyAf9tu87OUxPGxERk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAzondeAnXOX3R8IMHlERFE3OEQ+OLO0y15prFA46dzPlX9WCX2bvIebuRDWRHj6g4201OUjdv3m0ByyLRsCLLAdIa0UQsnBNuyPy0Sj3P/IS3kvNLbzFTCzniUjBy7P90UGFTGPWZIi9AgURYwO1/I36DTOixURbv8I41W2dKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:27b0:f94a:f4f2:2533:fddf])
	by smtp.qiye.163.com (Hmail) with ESMTP id ee2bc7b4;
	Thu, 20 Mar 2025 11:00:19 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	robh@kernel.org,
	ziyao@disroot.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Thu, 20 Mar 2025 11:00:15 +0800
Message-Id: <20250320030015.177232-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0d638134-0c0d-4918-af47-e23d2ead3bf3@kwiboo.se>
References: <0d638134-0c0d-4918-af47-e23d2ead3bf3@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUxPVk5KS0sZH01CGBgfH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUlMGUtBHUJPGkEdTx1JQUlOSEhBHR8fHVlXWRYaDx
	IVHRRZQVlPS0hVSktISk5MTlVKS0tVSkJLS1kG
X-HM-Tid: 0a95b17e9c9503a2kunmee2bc7b4
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006EQw6EzJKKkwQMgpOTwge
	CTAaCwxVSlVKTE9JT0hCTUlLTU1CVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSUwZS0EdQk8aQR1PHUlBSU5ISEEdHx8dWVdZCAFZQUpITEk3Bg++

Hi,

> The device tree should describe the hardware, not what the driver
> support, so interrupts should probably be included.

Before I submitted, I noticed these two commits:

1. ARM: dts: rockchip: Drop interrupts property from pwm-rockchip nodes
https://github.com/torvalds/linux/commit/f98643d8daf3443e3b414a82d0cb3d745f8c8bbc

2. arm64: dts: rockchip: Drop interrupts property from rk3328 pwm-rockchip node
https://github.com/torvalds/linux/commit/1bbd894e2ae67faf52632bc9290ff926d9b741ea

So I removed the interrupts to avoid dtbs_check warnings.

Thanks,
Chukun

--
2.25.1


