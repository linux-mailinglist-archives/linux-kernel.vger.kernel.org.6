Return-Path: <linux-kernel+bounces-396920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB89BD458
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730B11F22412
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6218C1E7668;
	Tue,  5 Nov 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4EjHN3K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E5149C50;
	Tue,  5 Nov 2024 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830527; cv=none; b=jVcyzSLaU70qFot97HVA1eWXv+V/0091dlfRqbFKznsh/+QG2G7y0yKnoMFvu1WgVd2DLp0+v97a5/HsEBIERcRlPVR2Q8N4Evm0WpKyidjTVHvWJ4XC97i78e3Xh1duA9360JHqu0HGVN3cdd9uOJz9c4w5cSr594AGib7mWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830527; c=relaxed/simple;
	bh=4kEDw3mpTS72uH6/guigCdvq4B9391RyXxfp1ONslIg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EuuojKXn3MFr/z08Tf8/o+WOZSZJbK6t7yQ/rQxZ4sZOS3AtwySR7gYO1Q1uJRR5gndEVjVgUsYcdQ66Rf9gy+Z4bocq0X0ZQ98FhUy0yom+lXPPu3cW4n8bIqUs5O3IzM0xDyPrU/nHgtMJRTUN08tO7E5IVGW58ea5L1seqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4EjHN3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134CEC4CECF;
	Tue,  5 Nov 2024 18:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730830525;
	bh=4kEDw3mpTS72uH6/guigCdvq4B9391RyXxfp1ONslIg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o4EjHN3KIWyxO4EVu77Ic7n63NEXUNIJOI1UTcN1WeMkCroMfUSvNcEIl3R0tYTWW
	 FvD7rzQpq9VH/Oym9sZReWhFOtlQQeijfLMpa/h1niRTILkqYAbwUbVZqXvg2K3ijM
	 5RzBf9MAczmhIg0o+v88USk+hLM3L+dBl60ff0SvpnXvfJPFosYglnxc78Atu9Gov6
	 AMklzazp6+h4RtriKf8HcN/RuSgIr7L5BegqYxcbbkp4T0EcsYAmyeerjF12oX1Tm7
	 Dig+4rIo1CaleamLq358AQsipcjvqX8bCQkQjPNfQth6lAetRASKf0bONDg1N+/710
	 /XY8RTqTlTOGg==
From: Mark Brown <broonie@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
 Trevor Wu <trevor.wu@mediatek.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
In-Reply-To: <20241105091246.3944946-1-fshao@chromium.org>
References: <20241105091246.3944946-1-fshao@chromium.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 mediatek,adsp property
Message-Id: <173083052155.94172.6768091589461565148.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 18:15:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 05 Nov 2024 17:11:36 +0800, Fei Shao wrote:
> On some MediaTek SoCs, an Audio DSP (ADSP) is integrated as a separate
> hardware block that leverages Sound Open Firmware (SOF) and provides
> additional audio functionalities. This hardware is optional, and the
> audio subsystem will still function normally when it's not present.
> 
> To enable ADSP support, a 'mediatek,adsp' property is required in the
> sound card node to pass the ADSP phandle. This allows AFE to link to
> ADSP when the sound card is probed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add mediatek,adsp property
      commit: ed4bcfbcf45d02fa81c77cff86e914d71c1b3c1f

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


