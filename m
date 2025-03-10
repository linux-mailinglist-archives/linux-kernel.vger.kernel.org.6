Return-Path: <linux-kernel+bounces-553456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4AA589EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DCC188BD2F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930FB15A864;
	Mon, 10 Mar 2025 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKgWNPOg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5BD2FB;
	Mon, 10 Mar 2025 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741569967; cv=none; b=e4WnVrAaGv+KYMUmSxr/7h7nlc3qHGyRTInGIbp+3y6nN/kVfOZMwSCnPfXBpJCtLGcpKTNoKi5wB29gtXi/TwXe2IqKtt6s/X23Rx/AUoaOtQcaAJ25hVuJunzil0cGRlM1XJ48l5IL+wi737p6RVW2lnK1HcN24Xn8wTnYQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741569967; c=relaxed/simple;
	bh=niTPujelY/5yJ2aZGPQo/oOGRfZZBnNHnH4STmdWhzs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qgKMpvF+nBIICriiXdaIMg7Q01YaFpko+gTd67nPO9xyIBrzDQj+hRhu7k6Hb5zNin/3mcWmsK+6GKmEAbbwtNdJpThDZ1LKjt+EFioCmecbv0FebapEqHrQphEes4LMsYgKoI5ZZ8ogsVeA3ZnJy3oszue/imjBihhc7Tf6Sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKgWNPOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2FEC4CEED;
	Mon, 10 Mar 2025 01:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741569966;
	bh=niTPujelY/5yJ2aZGPQo/oOGRfZZBnNHnH4STmdWhzs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OKgWNPOgpP5Hvg55x3Eo8nfgm3rpxEtORf+cHGQuqJPyuod3JxrLOYXrgN3E5zmYq
	 3zN6Gszv2KmYUFBjI01gFPoeBunNxJILmMhXFto63eiyCH60BTSPK1umTO5AIRznl9
	 XCcXaruCqXjuWFPPEUE4W1772K90TAU0iMSVtbN2ZwdsbCzEMypvkFp6t/1/UAhjJC
	 eyKlJE4ofA6d6TKlENGKtbnV5KF00GtC+L9mtJPAfNlUftK1Xc6wK/gX083x6y8tFZ
	 CpIaKLcvVsvMsYoUALvDt8XkB37af1J1wdmStxJUIOPYhbAPEOh1F2814zWqrzUy9w
	 Hv0crZGSQZ7bw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250306053138.1914956-1-shengjiu.wang@nxp.com>
References: <20250306053138.1914956-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,imx-asrc: Document audio graph
 port
Message-Id: <174156996154.2353078.15110736493128457712.b4-ty@kernel.org>
Date: Mon, 10 Mar 2025 01:26:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Thu, 06 Mar 2025 13:31:38 +0800, Shengjiu Wang wrote:
> This device can be used in conjunction with audio-graph-card to provide
> an endpoint for binding with the other side of the audio link.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl,imx-asrc: Document audio graph port
      commit: db91ad81a2545eb82aa47d0306bc3e1adb05e336

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


