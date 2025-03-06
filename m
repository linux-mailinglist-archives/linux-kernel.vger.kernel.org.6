Return-Path: <linux-kernel+bounces-549034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AC0A54C65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DEC3A23EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A4520E70F;
	Thu,  6 Mar 2025 13:40:14 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E541199B9;
	Thu,  6 Mar 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268413; cv=none; b=VeDBbZ+aIbZ8aQBU1Xt//kz+i375M9K+AXMsuReZ/uUCmVJn2DNnlusuUgBKGqag6MgyfomiXfSvERK66ORxbmGU8FVv0SjCD3S853yGOhDKuHNTd9yhMQoxbXXh2LjLTqBR1xXAOTn8DUvi/jOz/D7Cwk35h6xZc1hqmkxEPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268413; c=relaxed/simple;
	bh=9q3ZqR6FlKjalPh4GXvACOvtNtFOGw1ypR74/XDrzIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgmitTvqHxc8eQnz5ilR+la/ozcol5i1vcMiWNMDmKIkigdeInsuLrKB6GXiuytgAM2I1P1BQLa8kgAx8o32VnOMdXw1kbqnCEoZOV5SW4SM4+Ay1pvUcTiQTdOpWgQQsJF/wD+HqYy/2dCLEjZoI8CkVAKSpQPpy5oceHs4+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d2ca2ec5;
	Thu, 6 Mar 2025 21:40:07 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: heiko@sntech.de
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Thu,  6 Mar 2025 21:40:02 +0800
Message-Id: <20250306134002.380690-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4856313.kQq0lBPeGt@diego>
References: <4856313.kQq0lBPeGt@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCThhPVkxNSklOSRhKSBhIQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktJQk1KSlVKS0tVS1
	kG
X-HM-Tid: 0a956baf532603a2kunmd2ca2ec5
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6HAw*SjICKjMhGUICDks9
	FhZPCilVSlVKTE9KSU1DT0tMTE5IVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUhJQjcG

Hi,

> That sram is part of the soc (and has an mmio-address), so I'd think
> it should live inside the soc node?

But soc ranges starts from 0xfe000000, I don't know whether to change it.
And all other nodes are 0xf..., except this sram.
Any suggestions would be greatly appreciated.

Thanks,
Chukun

-- 
2.25.1


