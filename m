Return-Path: <linux-kernel+bounces-527231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0947DA408B6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C01618902C6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645F86325;
	Sat, 22 Feb 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se1oLYqn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8D27453;
	Sat, 22 Feb 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740231264; cv=none; b=Ddpu64gSYiHj0LhbgHSBgTD3CEGkOM6OLafpPE8yWz3m16jhwZ6rMkuJqh+j63036/7OjZjq2i2Ns7ePVWql/oUkSJ6QnNBMzXR6cleVK3qs7VQGbERDvR+EhVQjA3nvansG6kjs88Ssb7EWs3wZ82qEmo7DRYx0rrfCeOabbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740231264; c=relaxed/simple;
	bh=H4tUwQx9kES2MajEfXKp73q3XQ8Ce/GEw2CwrT3eRLI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fbP7o3WyEPdgJA2Xr1brLLJvlnI7ck4gx9IUHHQXy+TkJPkc5ZYjDHJrOR1bO7jwjJdtEvYWr72ljPwyWyfETs7HcQz4FZqlbXxIJjvfV91r1PUomCcsXAVxh95RDWrFclwDTtsGPyDjEGenw44+BzKob0ygxnISWJe6+32nhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se1oLYqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2806AC4CED1;
	Sat, 22 Feb 2025 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740231264;
	bh=H4tUwQx9kES2MajEfXKp73q3XQ8Ce/GEw2CwrT3eRLI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=se1oLYqnmIf2Nu0e9gtRB/WJE5/v1ZTFQMe+fsmIZ/kHUFw2ohNOyVk7kk5WMtCP5
	 YsM4bcVVWQKxtCYS0AzJmwui6/Eon43YZK/KChPZuxEO9FUusbRGJS3ARFEmE+sBM7
	 dhsoodqDuxrw24GYMriL+64sXwZpGaF/RwbP2cODUBZCueY6jrg7DvjgRjAa4IHo1j
	 amfC/LmIG03HWETW4u5x8/1NY42Uj9d1+pLXUnPCtXCfWFIo32gkY9kzDiR+crqhAg
	 7eGrKpya4s8Tr5TwBDoplxhHX0wPyHG1CewDhLeI3SfFlUtcIjEEoM8Nc1HZg4Xk1s
	 obdJCUasJVcmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BDBC021B2;
	Sat, 22 Feb 2025 13:34:24 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maud_spierings.hotmail.com@kernel.org>
Subject: [PATCH v2 0/2] riscv: dts: starfive: jh7110: increase eMMC bus
 speed
Date: Sat, 22 Feb 2025 14:34:14 +0100
Message-Id: <20250222-fml13v01_emmc_speed-v2-0-3ffc5b1f5663@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbSuWcC/32NQQ6CMBBFr0JmbU1nAEVX3sMQAnSQSSglLWk0h
 LtbOYDL95L//gaBvXCAe7aB5yhB3JyAThn0Yzu/WIlJDKSp1ISlGuyEedTYsLV9ExZmoy7XCqk
 zt67QBaTl4nmQ91F91olHCavzn+Mk4s/+70VUqDjvDFHRsubqMbrVtjKde2eh3vf9Cxahi4m4A
 AAA
X-Change-ID: 20250215-fml13v01_emmc_speed-67812bd9b404
To: Conor Dooley <conor@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740231263; l=1048;
 i=maud_spierings@hotmail.com; s=20250222; h=from:subject:message-id;
 bh=H4tUwQx9kES2MajEfXKp73q3XQ8Ce/GEw2CwrT3eRLI=;
 b=AKDOcG4/fMadkNRP0txy87XkPD7kQ0hQednAf1KSYpBbTV8P4jL3Ix2rrQUFz2EQo2GXT32kU
 zYr1qxlZp8ID1p+0GI8Vt88E2EzaXlaGc38fx7tPZF1slc3bJXvwH+n
X-Developer-Key: i=maud_spierings@hotmail.com; a=ed25519;
 pk=Z2m97WkDS9Sm3JnKpIpH4JwQtLm2Yw8oFCNw6uMBqb8=
X-Endpoint-Received: by B4 Relay for maud_spierings@hotmail.com/20250222
 with auth_id=346
X-Original-From: Maud Spierings <maud_spierings@hotmail.com>
Reply-To: maud_spierings@hotmail.com

The deepcomputing fml13v01 eMMC memory slot is currently limited in
speed by the common definition, increase the common max-frequency
parameter and specifically increase the clock on the fml13v01 board.

This achieves a x2~ speed increase in seq read/write performance.

Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
---
Changes in v2:
- Move max-frequency increase to jh7110-common
- Link to v1: https://lore.kernel.org/r/20250215-fml13v01_emmc_speed-v1-1-e3bd224ae0e8@hotmail.com

---
Maud Spierings (2):
      riscv: dts: starfive: jh7110-common: increase mmc0 max-frequency
      riscv: dts: starfive: fml13v01: increase eMMC bus speed

 arch/riscv/boot/dts/starfive/jh7110-common.dtsi                | 2 +-
 arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 0bc08ec1ff5a32449d2b04704173dbf3ebd6b014
change-id: 20250215-fml13v01_emmc_speed-67812bd9b404

Best regards,
-- 
Maud Spierings <maud_spierings@hotmail.com>



