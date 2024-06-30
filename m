Return-Path: <linux-kernel+bounces-235252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B0E91D249
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC9F1F21481
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7960153BD9;
	Sun, 30 Jun 2024 15:09:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122014532C;
	Sun, 30 Jun 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719760177; cv=none; b=QeaZb18Iqu+xGtMyuK7Ub7SH52S/Uy8sVKNjmzsxxmIXE7GUZyAhHq5VXtTlVdXf08RL1zJc12CaZQiI0F0iieVxlKaeJ+0O69NNCuVBfmE/wPddy3z/KdLqOGO0IFQvMq38dVhfJSE5QW6vcYc5YtcVmNfC9XwGaxYZYoqDBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719760177; c=relaxed/simple;
	bh=Ckmw76GXm2zzEq4ZCUoSaz/kUej8/dtuZVBSbiJRl1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QttWOsq0GLzoTED1ETO+m2vj+oNghVW6BxwlFSDRbY682pqWSr98oTrg/JAoJyRk5SHhM8Z6q3fPq5wa3LU0DuvuUgbifMC6XtfELBM3uOmsxeSfmkY5Rk27730OXfLd2v9D/fBHOWkRUnkxZRSuaM3wnfuFH1GlEMlu59MWMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF39C2BD10;
	Sun, 30 Jun 2024 15:09:36 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 840DD5FD47;
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
 Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20221231233851.24923-1-samuel@sholland.org>
References: <20221231233851.24923-1-samuel@sholland.org>
Subject: Re: (subset) [PATCH v4 00/12] riscv: Allwinner D1/D1s platform
 support
Message-Id: <171976017453.1183261.1853381079950313116.b4-ty@csie.org>
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

On Sat, 31 Dec 2022 17:38:39 -0600, Samuel Holland wrote:
> This series adds the Kconfig/defconfig plumbing and devicetrees for a
> range of Allwinner D1 and D1s-based boards. Many features are already
> enabled, including USB, Ethernet, and WiFi.
> 
> The devicetrees use bindings from the following series which have not
> yet been merged to linux-next:
>  - In-package LDO regulators:
>    https://lore.kernel.org/lkml/20221208084127.17443-1-samuel@sholland.org/
>  - Ethernet MAC binding fix (not a new issue with D1):
>    https://lore.kernel.org/lkml/20221231220546.1188-1-samuel@sholland.org/
> 
> [...]

Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!

[10/12] riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
        https://git.kernel.org/sunxi/linux/c/0ce1d34678e5

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


