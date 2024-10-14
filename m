Return-Path: <linux-kernel+bounces-363988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E37BD99C981
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E228B2453F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87A519E971;
	Mon, 14 Oct 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4hZPo8J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0681684B4;
	Mon, 14 Oct 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906746; cv=none; b=dXjmQQztBfDugw/AtNAdvKFMnPGXkgoXS6iUUvPIBl6zHLGKDQ44qHHhM9CtO7vYxKqEksoVmRGkY1uy1FqoNJvTy1+UWGT9xtARq/KYtwYZAZOPtuNRihpld5Hs6LOKn+gg4voojddBQn+V/OObE68roaYxo+j8I1Bf5dyJD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906746; c=relaxed/simple;
	bh=sDrRw60zuzKbS92EBKllWgxujSkHVzdPmKV/iFTcCSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ni6Y4NLGSwrbYBO8TC4etOHbyJoc2K7Ji0VQIUm/CvRNH2G8PHZ5OJVMStDmdzmrs4m/s+WSZDjxi3OJdZ6hb9oH4ZLR5xlrpZ/ScJvSXaiSg7nEDhCVcPeG7IcQ4cJiLuTyxppn3AJ+GtPvZKR5b0C/8RWton0AsP0JnaCaieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4hZPo8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7E8C4CED0;
	Mon, 14 Oct 2024 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728906745;
	bh=sDrRw60zuzKbS92EBKllWgxujSkHVzdPmKV/iFTcCSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V4hZPo8JulfCIGIR1+wxel5FOy5lMvZYoN1xlsOS4T3feuPgoLHpubNe0d45gBzaY
	 9FdDF+78nogni21y6/n+ZhotQLNbi9hGTYs/yeSwpVVx0FZX2AwQRPmkxgkH21w4Pt
	 Y63Vn2XzP/R/OfYR6T0zA5mn4ZDBKvQ3yI2vtwxs+XP/2uEBxgN25HSk449zEGxHsR
	 B8vVyRE8RydpbT7fAyfxORBtaV6UxfYcFWceaJq4TcpYkKUD4UI+wY+PehN2YGRKbh
	 Z/tzkfSZwlEBV4rQjB2KZJxhhvauVgrSaWr4QPAg/ULB4dfGbdh3nmc2YkChkxzUyC
	 V8xQjRWKz82cQ==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
 nicolas.ferre@microchip.com, Andrei Simion <andrei.simion@microchip.com>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241014092830.46709-1-andrei.simion@microchip.com>
References: <20241014092830.46709-1-andrei.simion@microchip.com>
Subject: Re: [PATCH v2 RESEND] MAINTAINERS: Update maintainer list for
 MICROCHIP ASOC, SSC and MCP16502 drivers
Message-Id: <172890674010.4183272.7344078847755683372.b4-ty@kernel.org>
Date: Mon, 14 Oct 2024 12:52:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 14 Oct 2024 12:28:31 +0300, Andrei Simion wrote:
> To help Claudiu and offload the work, add myself to the maintainer list for
> those drivers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Update maintainer list for MICROCHIP ASOC, SSC and MCP16502 drivers
      commit: 3692a4ccacf3c44249e584aea3ae8568f953e7e4

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


