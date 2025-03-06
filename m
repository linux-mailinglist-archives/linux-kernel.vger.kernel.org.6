Return-Path: <linux-kernel+bounces-549111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C6A54D86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8A33AAC43
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9369A166F3D;
	Thu,  6 Mar 2025 14:20:21 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D51494DD;
	Thu,  6 Mar 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270821; cv=none; b=F5m39kIseSvS0kIKhuw9dQd7XjgNRYt8xgao4IZrwvhulMgtH5XdiIGSC906sGsQWCpkBO9FcjZKp/CA23IbCFIK3B+FKy9H72zCsJ/6oFsyZ09D2VhtXdAeGqeu0gQVWgVj159M8BF5pGexILGxLTp+ZULS8wlQBQstKLK9cfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270821; c=relaxed/simple;
	bh=cy2CG0e7leAUd6HUdz1oxEyoECukYvwgHa+ERpJB80I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LaxgOemZeFxgiob6WkY97775wj24fIvYHwqHiJL+/K7C2sIxhUHZGHKbEyNXaDlIWhjQ++lVYknlrP4+ydiQYoUtvlqPz+ZFg/kF/iLRxgglLsMq9Nn8cusPPSWD47a0PNquOCrXwzTsct+CcDE0hsS3BWGXYk4GweTvQNzhGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d2dccefb;
	Thu, 6 Mar 2025 22:20:14 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: krzk@kernel.org
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Thu,  6 Mar 2025 22:20:08 +0800
Message-Id: <20250306142008.389243-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <10115c0f-4a7f-460a-a0bd-0c86d1e7d3b6@kernel.org>
References: <10115c0f-4a7f-460a-a0bd-0c86d1e7d3b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTx0dVk5IHhpJGBhDHUoYQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktJQk1KSlVKS0tVS1
	kG
X-HM-Tid: 0a956bd40f2703a2kunmd2dccefb
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06NQw4CDJNEDMqDwkDIg0w
	CBcwCQxVSlVKTE9KSUxLQ0pOSExOVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUlDTTcG

Hi,

>> Any suggestions would be greatly appreciated.
> Where is the SRAM located? Inside the SoC or is it carved out external
> ROM/RAM?

It is located in the SoC.
"Embedded Memory" Area:
BootROM | PMU_SRAM (8KB) | SYSTEM_SRAM (64KB) | OTP

Thanks,
Chukun

-- 
2.25.1


