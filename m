Return-Path: <linux-kernel+bounces-226339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4C913D3D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E707A283801
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAD9185E5D;
	Sun, 23 Jun 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivqen0+R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB770183093;
	Sun, 23 Jun 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163329; cv=none; b=pUKcMDwov4x/R9eMSvrDah75WQw8RQYRGMFE3og3NT5E9aEFQpB4QAEdfJxGGSYEtlQF6T9cjA3ZT/XgeOR9uaipCvXJAOFyp/uRxNFVJnSbm5h0h0CsJUxn9hXxCvv2HoRpfcDbj0+gFqsEgKkUTkA1pjRI83mA0eeARc3uSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163329; c=relaxed/simple;
	bh=QX0DysE08n31ltsLk9kPjmr6O8fcwdo8lFg+WR0u57M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MyRZo/jCQ6uh24gDPCl/qQghckyCJu6a6uI8Iqy17qE3J6UhoBj7cVZoMEErTsdeSxRsR82WailAfFUcer2oE45rP5d01bpqMG2y7KWwaerknXOKdroDTaFjDTeroaYXxZn3+ye8jrrjhjpucFwFu+wIqUYmxbyXUZWMAyP/ess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivqen0+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA83FC32786;
	Sun, 23 Jun 2024 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719163328;
	bh=QX0DysE08n31ltsLk9kPjmr6O8fcwdo8lFg+WR0u57M=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ivqen0+RQLn1pOzbOQWhQ+zfHAfEO8zjGVC2NSljtWWCVMPyslFKCx4BKiIRFoqjT
	 ixdajQX+DZBrsKOcXpGG9gZ95OzB4tNpJs3E24NLfeY5oUe9Bqa6nuHi+aOsIeWGNI
	 m2cYfI22Lh547dCcan2XiNXUOewkLgE9O8Jd71p3RUu9P7nPMo08J8ZEDw78VoRgIj
	 Zwj7k4HgG57qVGfVmPej/+Lmrxu0giEpvgL7cLaEAJDYJG56DHYKHDdVtB7rXCrV3S
	 JzBmeYoXiOJ+24hkXTdTDKcMZFKUW/7qhJJp5oUgH4/k3v1u5iG2eRouX94HPqSAf7
	 gzU2O0HqXPsPQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shenghao Ding <shenghao-ding@ti.com>, 
 Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20240622131245.2607533-1-christianshewitt@gmail.com>
References: <20240622131245.2607533-1-christianshewitt@gmail.com>
Subject: Re: [PATCH v2 0/2] ASoC: add compatible for ti,pcm5242
Message-Id: <171916332554.350242.4619581974113723543.b4-ty@kernel.org>
Date: Sun, 23 Jun 2024 18:22:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sat, 22 Jun 2024 13:12:43 +0000, Christian Hewitt wrote:
> Update bindings and add a driver compatible for the pcm5242
> chip used on the Odroid HiFi-Shield2 i2c mezzanine board.
> 
> v2 adds a compatible to the SPI variant at Mark's suggestion
> and fixes the binding patch title/description which I managed
> to fat-finger in v1.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: sound: add ti,pcm5242 to pcm512x
      commit: 9427997a5e13320a3c404a0cb67a292ad8e00b62
[2/2] ASoC: Add support for ti,pcm5242 to the pcm512x driver
      commit: 9c9b172fdd918c2f852140fc4a3cd827b78fa947

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


