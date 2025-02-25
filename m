Return-Path: <linux-kernel+bounces-531983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CE9A44756
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4170819C2C80
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5B1624F0;
	Tue, 25 Feb 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et54jKHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E614A60A;
	Tue, 25 Feb 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503035; cv=none; b=PZPoGHIrH6LwClm0brAlexEmGNZ+ZT5483vxZrOl03qWVFiLPP+qujpWKPdotGwsUO9oS7IU2m1bh7TGCwBkBgwKpZZxhb1uHzvR4qyJqpD83oeAfY0EpzcRptR2tc4Mk8yfHaan4JzZBdvgqeSeSqfd3rXno5CkSO/Li6CKoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503035; c=relaxed/simple;
	bh=NaOhW6Z7FzJMXfe5JimFmCTP2wgV0kwD8fHu8uLUX4w=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dvdg6/jmftesZqBHpRyn/q/2s7t4OzVw5wvmy6rLMgIia7pCva54DP3aeRyiXBu7JAU6p+KB+wLk3y9qWQxXbGkPxBbU7zN2RbY98egIhhP9BtVqv1NTLIT12YHsW3slo5rMjOv3VPQ5HmCo+qlFTKvkakNLl+VIY4O2BsT5s84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et54jKHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE95C4CEE8;
	Tue, 25 Feb 2025 17:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740503035;
	bh=NaOhW6Z7FzJMXfe5JimFmCTP2wgV0kwD8fHu8uLUX4w=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=et54jKHAq+LpZE2cb0Z6k64MKStYHd000g5RBK7OlGvI6u6HabfMXkkIpfFuzngWO
	 uBCrN/7ILf/aH23yEoDOcs7w6N6RN2IZP+n+ztSoK9VFcAFOHEGnft2ONTnp+ilauB
	 PxhzaxF94GXvMMVYqhmIUrc6jQVTNLyCRQE1HKTLbwuDOIzJBRNcqL3bRPwGr549RZ
	 40zH+K+aJTJoJL8dnen7aFr7bDHj22cKDfHrrcYP6Cgbk6UZU5iU58dLF5IRu1Bi6R
	 VFY3VINLtA73AOwbJbIR9JLO1RYpicH9lAdJspZualJizohEvck2UOFyiSkbtVbmPy
	 v7ycmuiMD/o2g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250224090413.727911-1-shengjiu.wang@nxp.com>
References: <20250224090413.727911-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: dt-bindings: fsl: Reference common DAI
 properties
Message-Id: <174050303228.104078.2142878652001092797.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 17:03:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 24 Feb 2025 17:04:11 +0800, Shengjiu Wang wrote:
> Reference common DAI properties for fsl,easrc and fsl,imx-asrc
> 
> Shengjiu Wang (2):
>   ASoC: dt-bindings: fsl,easrc: Reference common DAI properties
>   ASoC: dt-bindings: fsl,imx-asrc: Reference common DAI properties
> 
> Documentation/devicetree/bindings/sound/fsl,easrc.yaml    | 5 ++++-
>  Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl,easrc: Reference common DAI properties
      commit: 6542db20caf4987b938ed8feec07d199779823f2
[2/2] ASoC: dt-bindings: fsl,imx-asrc: Reference common DAI properties
      commit: 3e7b375752b5e4de56e92dfb9c43309cd985b869

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


