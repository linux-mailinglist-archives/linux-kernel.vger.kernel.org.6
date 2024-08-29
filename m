Return-Path: <linux-kernel+bounces-307259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D89964AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653BD1F26D75
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BCD1B5303;
	Thu, 29 Aug 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHgblykA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8FB1B3F19;
	Thu, 29 Aug 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947479; cv=none; b=C8tkm9II+6VZwdviavu6IgXTKFeFaa8t5P+K3RBpRbCU1jmt6vqiLoenKQjBW0GUcMePI39INiIyHkrrar2vuHEBOCQU/wJpWtRh5k6KHKq99wIsZWIZy1/HlZRWU4UnxXYgxPhweBwzplTRtl7iaH2rVQ7wFvrjiKmA26ihry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947479; c=relaxed/simple;
	bh=/UWwwm9DQOK+k3QK01sWwhtAkx/XzO3OvB3mEjmcYzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ine7CRgs0l2CVjcwFgErtBzFTRw1oAJnPLPfzNsT/vEYE/VL3dxkrvGnxAckQt/yASJzKCSkMHLOvUMTuAMUp30Catow5rl2+IwS6L6r0CYgne2aIFNakNnNcxIw4RYb00WlZh5seuQPIaCKEomvML17eAGW77XgielQj1FaZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHgblykA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB79C4CEC1;
	Thu, 29 Aug 2024 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947478;
	bh=/UWwwm9DQOK+k3QK01sWwhtAkx/XzO3OvB3mEjmcYzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dHgblykAb4kxCUJ/032sObRj3RrPtwB/BmXxqQwE3u4LdFYtt9GrMkSHQ58l62sFB
	 tgAPnKiMjN3GTaJqpG5LseAhe4UAAm9/hAbB+xW/vC4wReq9hyj0bymaXVAUT84bRe
	 H6k/TbZopEpQkWnhQDcHXUpvuW/VVFSdAdAAcxW91ABrdlDLy/xMXuegj6a5cw2dVP
	 udMWX9u+kmM6t+gz+NG0b7QlQobZtXBqMG2wxuZ8H56Ii2kwXDhwS8Fylc6rdo9z4f
	 kMB5mPufF7LIf0E9ozMeP0eNW/Ql4YsfED6sylYP3XI4YBcxfvdXf79XOve43h5F9Q
	 CHyB278AuvPng==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240829-cs4271-yaml-v3-1-f1624cc838f6@maquefel.me>
References: <20240829-cs4271-yaml-v3-1-f1624cc838f6@maquefel.me>
Subject: Re: [PATCH v3] ASoC: dt-bindings: cirrus,cs4271: Convert to
 dtschema
Message-Id: <172494747609.570876.9753159786712866803.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 17:04:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 29 Aug 2024 10:52:57 +0300, Nikita Shubin wrote:
> Convert the Cirrus Logic CS4271 audio CODEC bindings to DT schema.
> 
> Add missing spi-cpha, spi-cpol, '#sound-dai-cells' and port, as they
> are already being used in the DTS and the driver for this device.
> 
> Switch to 'reset-gpios' and drop legacy 'reset-gpio' used in original
> bindings.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: cirrus,cs4271: Convert to dtschema
      commit: 7817eb1ad353d732bac546b39316f2422c76fff4

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


