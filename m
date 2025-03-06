Return-Path: <linux-kernel+bounces-548331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 289AAA54372
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F64188634F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE21C862C;
	Thu,  6 Mar 2025 07:15:21 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493451A0BC9;
	Thu,  6 Mar 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245321; cv=none; b=Gdbo3vqfp5L3HV3marBOZNVBXu1UPesnozjC+H9PDDwQARlTwyLQD8pENx2T4zoRhSDhvhDmvCLPyfs/WV+Qu5p4MW/FvPNvV/Q5BkXwmdlxNqv6hPqobKZJ+PbBYHBD1HPRP6QbJUqri4TnOnluEJh2WkcKaE6H2ncp3F7iR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245321; c=relaxed/simple;
	bh=FS01cR9eS2TLxatOTIGVgw9kaqjPJtqvu5ZIHMkMGKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r1L8Od7kBoUDQ7YiZrAB0AC7crp3APmm+oaWoc3eLgZXMo1Zov9SmNdf96Ol37K8sAtvNorNzWJJ7WBgfCdwyuHV4iZhYVCrCz55okbuMaAOHHEBukPQABT8EppGCv9betjvPrjCrOyL/XTBQd/Y6XsP4mQtBJgaDE2iSIxGIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c02:1dd0:964a:aacd:16c3:d0a])
	by smtp.qiye.163.com (Hmail) with ESMTP id d21cf5a8;
	Thu, 6 Mar 2025 15:15:07 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: krzk@kernel.org
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	lee@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add rk3528 QoS register node
Date: Thu,  6 Mar 2025 15:15:02 +0800
Message-Id: <20250306071502.96949-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <52155b03-20f3-4e64-b636-70042db03ffa@kernel.org>
References: <52155b03-20f3-4e64-b636-70042db03ffa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTR0aVkJPGE4fSENNHx0fSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtJQUofH0tBQk1PGkEaGhgfQUpNGEhBH0saWVdZFhoPEh
	UdFFlBWU9LSFVKS0lCTUhKVUpLS1VLWQY+
X-HM-Tid: 0a956a4edab403a2kunmd21cf5a8
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mjo6Nhw*MjJWMjwpEkhMUTpN
	KzxPFBpVSlVKTE9KSU9OSEtDT0tLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0lBSh8fS0FCTU8aQRoaGB9BSk0YSEEfSxpZV1kIAVlBSk9PTjcG

Hi,

>> Copy QoS nodes and add rk3528 compatible from bsp kernel,
>
> No, don't copy stuff from BSP kernel. It results in terrible DTS.

But there is no public datasheet for rk3528, it's just a minimal change.

> Did you just define syscon per few registers? Third case last weeks...
> so no, define what is your device here. 8 registers is not a device usually.

As commit 3e712a03d0481f7b0c24d961a43e385dcfa78c74 says:

---
ARM: dts: rockchip: add qos nodes found on rk3066 and rk3188

QoS nodes keep information about priorites etc on the interconnect
and loose state when the power-domain gets disabled. Therefore the
power-domain driver stores the settings of available qos nodes and
restores them when the power-domain gets enabled again.
---

I add these so they can connect to the power-domains of rk3528 SoC:

	pmu: power-management@ff600000 {
		compatible = "rockchip,rk3528-pmu", "syscon", "simple-mfd";
		reg = <0x0 0xff600000 0x0 0x2000>;

		power: power-controller {
			compatible = "rockchip,rk3528-power-controller";
			#power-domain-cells = <1>;
			#address-cells = <1>;
			#size-cells = <0>;

			pd_gpu@RK3528_PD_GPU {
				reg = <RK3528_PD_GPU>;
				clocks = <&cru ACLK_GPU_MALI>,
					 <&cru PCLK_GPU_ROOT>;
				pm_qos = <&qos_gpu_m0>,
					 <&qos_gpu_m1>;
			};
                  ......
		};
	};

This is also what the other rockchip SoCs do.

Thanks,
Chukun

-- 
2.25.1


