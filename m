Return-Path: <linux-kernel+bounces-235253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8874F91D24A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C2B1F21425
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2B2153BE3;
	Sun, 30 Jun 2024 15:09:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126E1527A5;
	Sun, 30 Jun 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719760177; cv=none; b=DtiCI8Ltltns8j+O4Gdh8J2ucddej1E7kLnvN2lMVu5/DVQH60+jOYfMIB2xZ+tKTIkDmfMQ4N/D5CVJJG/oB66QtGPnZ+xxTL/jnO3UuBGphnYp+HGjf2t8IBMWUVDx6VrSObkFYKJM3VRnKjGh8PxnMoLyFPZ7wvnlf3h+hIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719760177; c=relaxed/simple;
	bh=xbFID+3ErU08rjSuOkfRzCMODIEU1e5ZIdOh0iUKZ48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q+nDRriuzPrz9pR+Xx5Tp9gJz+qjVcBurT84ggYwPCw2WBlYI+P1IhewZ8/wZBZPsG2IhBbugkMdrMqNxY8OXzjPV+A4WFU4PFn24ovet5uys9Sd0ED4/ad8Cpt+VHrFIulnCWmuRac5FxUemgojxSK4Aiz20Pba9sZ2vczvRJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C6CC32786;
	Sun, 30 Jun 2024 15:09:36 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 6D2055FADF;
	Sun, 30 Jun 2024 23:09:34 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>, linux-sunxi@lists.linux.dev, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Andre Przywara <andre.przywara@arm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, Palmer Dabbelt <palmer@rivosinc.com>
In-Reply-To: <20221231233851.24923-11-samuel@sholland.org>
References: <20221231233851.24923-1-samuel@sholland.org>
 <20221231233851.24923-11-samuel@sholland.org>
Subject: Re: (subset) [PATCH v4 10/12] riscv: dts: allwinner: Add
 ClockworkPi and DevTerm devicetrees
Message-Id: <171976017441.1183261.11626776990169196800.b4-ty@csie.org>
Date: Sun, 30 Jun 2024 23:09:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 31 Dec 2022 17:38:49 -0600, Samuel Holland wrote:
> Clockwork Tech manufactures several SoMs for their RasPi CM3-compatible
> "ClockworkPi" mainboard. Their R-01 SoM features the Allwinner D1 SoC.
> The R-01 contains only the CPU, DRAM, and always-on voltage regulation;
> it does not merit a separate devicetree.
> 
> The ClockworkPi mainboard features analog audio, a MIPI-DSI panel, USB
> host and peripheral ports, an Ampak AP6256 WiFi/Bluetooth module, and an
> X-Powers AXP228 PMIC for managing a Li-ion battery.
> 
> [...]

Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!

[10/12] riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
        https://git.kernel.org/sunxi/linux/c/0ce1d34678e5

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


