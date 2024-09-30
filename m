Return-Path: <linux-kernel+bounces-344867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DEE98AF13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE04282791
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4F1AF4D7;
	Mon, 30 Sep 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z++vsUfR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5921AED56;
	Mon, 30 Sep 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731608; cv=none; b=KPGpddEsBVc8ghsUWSNyp0dqwEHmnux/sOdsAcFvKv65pWBHBH7ekNitNfNt89zkto+McbJDnRZV7xl1BFoioEBePZdwh/hU3I/bVqejRhBmdaJXBuGbU+hfj+aXK8awLwbcxjxJCly062t62xdzuKSKyRK6JN9NOT05JIxIv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731608; c=relaxed/simple;
	bh=fy4TyZjrHxyyox+cwJRMsw2U4PWSehMZUZBuTrFsaE0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kohcSX1wLeC+sc7mmWmaGVL6bLjWsJ3HskCKreA4hpe+QZeM4aHKjfS/s9xt1f7jdwdWANiudLVP6wuu386Jvix1qOh1x4y/2HGV6YtCpgOOBybe+3eR+xbEEkC/OyHQaURQgiuxU9R37tCQ/LLVTBic65SIfjA25/eeuWcK6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z++vsUfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80241C4CEC7;
	Mon, 30 Sep 2024 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731608;
	bh=fy4TyZjrHxyyox+cwJRMsw2U4PWSehMZUZBuTrFsaE0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Z++vsUfRaKfelK2EnUNl/GxwkUzw7+eMC0Gk4MgDxHPHsHLQEas/QlQlsV/bKScqK
	 5K70wQZmllNKHsG81Xopur7RKc4aO9EPZsZ6syw04viKyfk90scndHE8hirVkp4jGg
	 3Kyh8SZhxMLX538IJ19g8kYCs6Gzk/S1iyGGPh5pqmOQ4pF4Vu4hewAzOTsdObypDh
	 va0TvULHwNQs0L1Fj7xMkmUzeQ9ZzTEyno+o8DuehELhucRVohHFDXXdlSdajXdE/+
	 veKbLQf9KnsPH1NR3F4AFJSaG0+awZnqWehiXs3il7qo9dg7bsRboesIj6+ktWkkR0
	 2B0Zfv+0SHboQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20240927205618.4093591-1-Frank.Li@nxp.com>
References: <20240927205618.4093591-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: fsl-esai: Add power-domains for
 fsl,imx8qm-esai
Message-Id: <172773160630.2197048.10836164029932712084.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:26:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 27 Sep 2024 16:56:18 -0400, Frank Li wrote:
> i.MX8QM's esai require power-domains property. Keep the same restriction
> for other compatible string.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl-esai: Add power-domains for fsl,imx8qm-esai
      commit: a2bd5a25c1b548609fb2f095c7356fcae8fabac2

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


