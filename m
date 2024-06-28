Return-Path: <linux-kernel+bounces-234264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228BB91C473
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D118E282043
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88CB1CB338;
	Fri, 28 Jun 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upmW2SU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865B19AA4B;
	Fri, 28 Jun 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594414; cv=none; b=FxRzpL19syg9WnhjJG8/ZB/LwE0XQ+lnlBNwadwkMA1Tccjsyh2dLwfkxWqRqrBXAisQ1GcUVIx364UVCvrDUJEb+q7F56fh+lxAHYH2269yv5mh+AvMGc2NeQEmYBXSr+yYdmm4Tt6BaUB61yDB9dWJf4WMb5y0ZiZ5VqPg7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594414; c=relaxed/simple;
	bh=tuzV+wlKVKinCsa1NBBT834oI6faLS64mAnDCkWoMdg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DvOLU/QXdbeDX192tSyKcHt6D71n+AwrJHdWiSZEKHQMyGXEup/v9IVdWy0Ii9Tbr2Cvg5+RLWJE7cv7TqNLG2YgYVa7/zLkXpogKv/cYnuxFG88T4TIZbmPBIQlnrq57rFdZTZcWRfqUGNiSwiUcQX+rccka66dWy7flhCiHxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upmW2SU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E5AC116B1;
	Fri, 28 Jun 2024 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594413;
	bh=tuzV+wlKVKinCsa1NBBT834oI6faLS64mAnDCkWoMdg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=upmW2SU3SSRfsMu0ZLekbfgLlUC+h/NfkXvJv6rqSBRZp82hA38zh2lOuijhh4dOL
	 viZfSpvhMR1eM2p8UAG0MhLJ5ILZAi44Q5YqwHxxJGVf66dFJjaQ8g07wkGhB3E059
	 ZH7tBLAMr2Q4ifwXKAQ2MXZdJz0HrdONfnTAOpPZK2XcQRhWdWg7iJl/HPmL6EInt6
	 Yi9HVqDyHYy2hEVbEludaT4RuCGNEYF1Uz6m4C0rPm7HHJZE3ewQ/w2C5t9vCgNBQ5
	 tn7uKMa/7HAt06/frCRPe0kVXPdqD4h2+/4S7AEmpdNZdxarMThh0BGZ9snUqrqici
	 Bd6p2Z/So7vrQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, shengjiu.wang@gmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
References: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: (subset) [PATCH v2 0/3] arm64: dts: imx8mp: add audio XCVR
 sound card
Message-Id: <171959441065.130075.14895021485165511530.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 18:06:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 27 Jun 2024 17:52:58 +0800, Shengjiu Wang wrote:
> Add audio XCVR sound card, which support SPDIF TX & RX,
> eARC RX and ARC RX.
> 
> changes in v2:
> - use minItems:3 for i.MX8MP and update example
> 
> Shengjiu Wang (3):
>   ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts
>   arm64: dts: imx8mp: Add audio XCVR device node
>   arm64: dts: imx8mp-evk: Add audio XCVR sound card
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts
      commit: 288921232dd97bb2e35cff2ee38957db5b3e5ef1

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


