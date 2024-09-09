Return-Path: <linux-kernel+bounces-322105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE7E972415
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CD61C2243B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FC418BC31;
	Mon,  9 Sep 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPMy7l+L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C618B49B;
	Mon,  9 Sep 2024 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915708; cv=none; b=Zz1FQWAQ7eFS4+EI4nYvVzheHYWU50ioOwUu2tWKpe0nA/kFCQy6gGXEh1+IfRQCB/do3xS52WKLl1sPFP3SLk9i4n2BzxI5vh3VNxeXr1A0DsyCo5Sg+rsxPzEuf9pp8qdw18f+0zrOilDRlX2dSgBk3sdcmHUODv+leFLDntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915708; c=relaxed/simple;
	bh=gxpWwUlAxibrNDTItu3pZrMMyq790BK/xTGjxMPNjSo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WcTFYsmJrjdnaqo/wbWN3A0I9yEuR0i7g1hO1uO8eOSSe48Rx1aOS9DF4e/ZqRyHJ+UhVw/SBfhckTkSkozRdbeRHWZ3cXV7DCTP/kx89pKDDlg6kGyZagFr2Y6cgarDKL/k1xEjjXYDGf9CGLUCopzUW8qi/Bp+DjjLNbD0u4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPMy7l+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657FFC4CEC6;
	Mon,  9 Sep 2024 21:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725915708;
	bh=gxpWwUlAxibrNDTItu3pZrMMyq790BK/xTGjxMPNjSo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nPMy7l+L6WYCWGVQKxQKHLjLqXT8/BCh/FuCF2mBHpNHTRnaxu5seKmImEg2ziE70
	 dJV4Xby/qBTMkF8Iwr12lhphfLorktn7JBo2m35SNnopkQbvQ9cm253Xw2DagDvwG+
	 KsTFR99gH1yCrD/YV1WNJl/2M8bGjyWg1yx0Z0ysTBqp5pknfK5i54kXnQkn/EYuub
	 8qlwc4xEt08vHUvoiW4A7AmZhGj0fhKe3iC/k26cGSUxUUFJXVgkAjwZSPiasqS389
	 aI6MW3Q0wZk7kV9uAPazZRAFzEUE6IvMFG641gxJFUHXhgaGbyQbEtslvArKthbKtu
	 lSMX6b1cChiKQ==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240909083530.14695-1-andrei.simion@microchip.com>
References: <20240909083530.14695-1-andrei.simion@microchip.com>
Subject: Re: (subset) [PATCH 0/2] Adjust Stream Name and DT Bindings
 Updates
Message-Id: <172591570513.136248.18212360068719293673.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 22:01:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 09 Sep 2024 11:35:28 +0300, Andrei Simion wrote:
> This patch set proposes the following changes to improve the flexibility
> and configurability of the mchp-i2s-mcc driver by allowing the interface
> name to be set through the device tree and by introducing a new property to
> better manage multiple interfaces.
> 
> Codrin Ciubotariu (2):
>   ASoC: atmel: mchp-i2s-mcc: Remove interface name from stream_name
>   ASoC: dt-bindings: microchip,sama7g5-i2smcc: Add 'sound-name-prefix'
>     property
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: atmel: mchp-i2s-mcc: Remove interface name from stream_name
      commit: b09c71f3e8413ac0a9749f9d0d06f6f0d0b2cc65

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


