Return-Path: <linux-kernel+bounces-208935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679FA902AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E081C284A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72DA14F9ED;
	Mon, 10 Jun 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1iXrHE/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D517441F;
	Mon, 10 Jun 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055887; cv=none; b=DVWdNVC7qDgexJJ3HwsxdLxsRBu9iP0/S+5xPzup6M9AzhbWKSBM8jvjENFGpp/5fo/0zUNQdhSppgWfaIsrP1vospJaTHwmcFvOxvnnNya4SE3VWejzV4tTcxYnbBgedG+hCB6DKpqffHtuVIhQ1Ij4si96pMTi83Vo2T+V4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055887; c=relaxed/simple;
	bh=Yq1fJAM7TJWvAOIEFxNG4hN4+EqR+5pk4rau/PBxoRs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=etZhnTytJIkJnTAOgcsfm3atqhY/ShL/Z4P0xdtaF9LuSxTNYfQPlOivf2GKlnStTGSrhog360ajH6WZQnkPR/GUCUw1fEyt5zP8V+abz0A9bTgfA/k73C8hK0g6HQbHiTghWAOwIqSHGZydr3czmGxcx5vlOV0mFYVwJ+TFTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1iXrHE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78913C2BBFC;
	Mon, 10 Jun 2024 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055887;
	bh=Yq1fJAM7TJWvAOIEFxNG4hN4+EqR+5pk4rau/PBxoRs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a1iXrHE/BKuNDrm+Sp1K/Ct8YZb/la8YIZTOAQUJPhe2XXDboTko82d37wJx5vge0
	 YcTeEz+hGWjzREYDX9/rlL1vtP1jiR/wAw/pBQCWP3hwRgtWepRp4/ACFF5dBOEcZj
	 QcIjCj1SapkMPKL28OZMu286SnHADhTd3LV3PNhnfy/lUzFMQF22+MTbhy0n6EeC/M
	 w4+cYa55P0SqKoHxdIdOX7RJpUmCmUQ27ueXM3Shx0XimxWhnvSrqmL4JmZhHSMrCR
	 2U/CKBn0CJ0OW8foY+F/e7RVFNuCzi6N05OdQnKEcpDR8RW5fjKTZSDEVp1TIcljy6
	 /B/JUS1XAZsXQ==
From: Mark Brown <broonie@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240610-md-drivers-regulator-v2-1-cf39106d7e54@quicinc.com>
References: <20240610-md-drivers-regulator-v2-1-cf39106d7e54@quicinc.com>
Subject: Re: [PATCH v2] regulator: add missing MODULE_DESCRIPTION() macro
Message-Id: <171805587951.166318.13582723419199956307.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 22:44:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Mon, 10 Jun 2024 07:30:51 -0700, Jeff Johnson wrote:
> On x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/da9121-regulator.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/rt4831-regulator.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/tps6286x-regulator.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: add missing MODULE_DESCRIPTION() macro
      commit: 8a2744f2955a584188a82d631937aa365d4ea966

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


