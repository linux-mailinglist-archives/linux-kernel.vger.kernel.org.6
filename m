Return-Path: <linux-kernel+bounces-380609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF649AF370
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E911F21A14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE031AF0A9;
	Thu, 24 Oct 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN3PSIaR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98D22B650;
	Thu, 24 Oct 2024 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801015; cv=none; b=G5jLi1oKjsXw6pIaftpWIUwfDVC/UQ0NG9CMvyW+6MylHQaXSrNwv+WdlBYsOA2bg8/CxUSxS2MBNESPOf2ITL//w7+oVI3SzwkhUPtE8vG86DfOwuHVuyJccCjd2NUMr7QyOGCv7Dsssjk7mWanynQdNx9hAzwsvv30Y3GqlqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801015; c=relaxed/simple;
	bh=s17en98HCPC4smiDIgxFZgt3DoaeAwBGD5lpSCP0NXY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xr9amLH0dOhO9twfIsFw2OV5lhunbuGHuIlBNmo3wclys06fn7SHlJ6T7ZYf8uJpBnEwiP4x3b7Iycf3WkqBX0mZVc2f1cWTV7Zl8jvI/GISDxIDKP2p0SUmf++KrWwsKHMXCvbWbrLNLoak0uRTabFMpdpykLYlnmLvrm6HoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN3PSIaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD1BC4CECD;
	Thu, 24 Oct 2024 20:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729801015;
	bh=s17en98HCPC4smiDIgxFZgt3DoaeAwBGD5lpSCP0NXY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fN3PSIaRgf39zGbEzct0rOD33kVm8KPFR++PzQavQEALSng2aODPsqp0uHl2lQ104
	 u23eIgNuO1U9G448+HHADdzmGMU8ocd9WGLxu5/8+B6RqQqDr3MCNilMloEGq6pHhI
	 HsIXtApidyCnEeM5EcFy9USp5/zySZkYVsAnrSw4GPpnDYzqjtgpMcdBzEat8rms4j
	 jttK4atwsFkBqsl4F1F8DVIGnfu0FkGE/wXIk1epMObUz4eycmeVA3FT9zNVLV1/bv
	 T89QbaRcj7MLuDMs7uwzmFZlfoGcys0BfNrucuB08JV2PlPWUT+vYb6OPDyiGhpduY
	 g1OEus1nLn7/Q==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, James Calligeros <jcalligeros99@gmail.com>
Cc: asahi@lists.linux.dev, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>, 
 Neal Gompa <neal@gompa.dev>
In-Reply-To: <20241020-cs42l84-v2-0-37ba2b6721d9@gmail.com>
References: <20241020-cs42l84-v2-0-37ba2b6721d9@gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: add CS42L84 codec driver
Message-Id: <172980101186.554299.11182862966336254463.b4-ty@kernel.org>
Date: Thu, 24 Oct 2024 21:16:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sun, 20 Oct 2024 00:47:30 +1000, James Calligeros wrote:
> This is version 2 of the Cirrus Logic CS42L84 ASoC codec driver.
> 
> This patch set adds a driver for the Cirrus Logic CS42L84 codec. This chip
> is (so far) found only on Apple Silicon Macs. In keeping with proud Apple
> tradition, the CS42L84 is essentially just a CS42L42 with a different
> regmap and no publicly available datasheet. It may also be missing its
> parent's S/PDIF capabilities as none of Apple's devices support S/PDIF out,
> however this cannot be positively confirmed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] dt-bindings: sound: Add CS42L84 codec
      commit: f2a67da9f4eb03f5402acb9aeb65b23cac990827
[2/3] ASoC: cs42l84: Add new codec driver
      commit: 250304a0fb34bb74f4726645ae24dc31d7582a22
[3/3] ASoC: cs42l84: leverage ring sense IRQs to correctly detect headsets
      commit: 2391b8719d686b1947b5f81250281fa112da91dc

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


