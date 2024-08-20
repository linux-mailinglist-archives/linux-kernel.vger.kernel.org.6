Return-Path: <linux-kernel+bounces-294563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE1958F45
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D07285725
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984AE1C37AF;
	Tue, 20 Aug 2024 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMQj1q5t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C814B96B;
	Tue, 20 Aug 2024 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186681; cv=none; b=pBRUb/6VHeatGAPdXxX/Wr9ZVF4hWj7Bre9Jxf+sWvlYvcRE2+bbD1BJd7GxAQtBXGnB+e0KIOeESnOW5lxTSSfpGXRQ4iB07kZEHLh6FN61kjr8o/sSNnOJHhzkLmUjaKIaJRxzeGv/a2d6fTl+tq8tR9G+zrAY+AWD98P3eAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186681; c=relaxed/simple;
	bh=cypaa9U8Ky8ybogEmIi/zzlIjSwLEDGvGkrxvKYEfjg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zj6nweswEfMySZcow5delD26QvA1GK203Hx2k/ChAMtxXBfttX/VEaXXTsS6HhWFtSZwcDSa3tUgAO6ClRODg35JlCWzJaLd4o9x8YH0psNrbAZ32aSyPaP1KZZ4KT+cL6PIkni4KCE+1tXPeCqy+WBtisubUnwYaIurT+Ljpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMQj1q5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85687C4AF09;
	Tue, 20 Aug 2024 20:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724186681;
	bh=cypaa9U8Ky8ybogEmIi/zzlIjSwLEDGvGkrxvKYEfjg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lMQj1q5txFXPh4sph+vowVK2ND8OMURIeFJv+tWiimwdI5aEpo6U4eZE/rTy7FeOK
	 Q7EI0JxzZnysR/03ISROGcQUXtj3lhJUqX8ntLxS9QOCwRPZ1fOyrMQu1oraAugJhW
	 14PJ9o/3WO5j8PIpGp4S17N4vsojsZLTV3eA3AwlvuCM8U4K2SURDfXJd6yFLaqPoY
	 uWdgt2ubIz5hVe4hBLOloaSYZB+ODEas8h3IR5g3T51ujva8m8e5oVgwYeDH6FYPAM
	 9EIfg7PISmQ6cJd8oNIjksxdA6q/SwPgbgYQFKI02bSWJJE6u/mjrkd6xUZ1H8WMkn
	 ciXKLT2OpbFMw==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240820184604.499017-1-Frank.Li@nxp.com>
References: <20240820184604.499017-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: Convert tpa6130a2.txt to
 yaml
Message-Id: <172418667827.929388.15440064155822460838.b4-ty@kernel.org>
Date: Tue, 20 Aug 2024 21:44:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 20 Aug 2024 14:46:03 -0400, Frank Li wrote:
> Convert binding doc tpa6130a2.txt to yaml format.
> Additional change:
>   - add ref to dai-common.yaml
>   - add i2c node in example
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb: /soc@0/bus@30800000/i2c@30a20000/amp@60:
> 	failed to match any schema with compatible: ['ti,tpa6130a2']
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Convert tpa6130a2.txt to yaml
      commit: aaf55d12fb51d7aa64abe51e27acac1d3d1853ec

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


