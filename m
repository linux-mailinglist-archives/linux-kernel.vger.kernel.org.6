Return-Path: <linux-kernel+bounces-210217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C14989040EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F261F23B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648523B791;
	Tue, 11 Jun 2024 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl9FMEwg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294511720;
	Tue, 11 Jun 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122370; cv=none; b=ii31TFzbyWjgMTdtwURBNJKQIg7XFpqS6HRoTP8DosREQCKKxNDT0xQWeHZTc45ntR4vsqcH5XlrkNhh3/ZrTA6XWU4tdQe5vOQinbRfsiSSfea21nlkjUH4A3Ih4mi/LVuhUobC1v2TG1U9NMoRMbr39WZdxl8uUHHVkM6IYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122370; c=relaxed/simple;
	bh=/2cQVTuJO9C88TSfeHS2I4PccXrdEUkcAQ3hBE1u/0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cl6UAIuGVODn9kRI9KjNAX8pFqXSENyWTg6dogpBZVtnR7413kyX/La+/ZPUcKc+bn98B09HhrarqbgUQnzjUs87nARsvCNmBWKtMJ8JS9/WRFf+AfVeCw+QFZB7PxCOHn9yDr67+6twGlcshB8xLRqotS58BDnGlo5w1pyIxQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl9FMEwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616BEC2BD10;
	Tue, 11 Jun 2024 16:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718122370;
	bh=/2cQVTuJO9C88TSfeHS2I4PccXrdEUkcAQ3hBE1u/0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dl9FMEwg4HfQ3gszUr4kZTQ5Ou1hMo1t00S9dOq/3lsejxDOOfJVhZAIEFz5G5Tgc
	 NiyL/JKm1HBYfuWdGXZHwRsLCFUD5AS37sLZ3FATgpiicNutxV57b90DNpiUQ6XGVx
	 ldiM05vhdrGsVYAPjq/dgPldRrIqgWCEIS6Wz5zOD6v4n1awzHcnVqDJR0y+VPmC4L
	 h75ksb/+bDmehXNvRcnBmF5PlfhAeENMOobcb87TJqQf2tS2X/IAY1t2fUQP67WtgU
	 nkHntEJsdbqE7MUK5pB0CsaQR3dQbWRy8jN7Q6nLwQAHeDB0dGNmwxP0F9J7EpLG/s
	 b3e0LzpziPSig==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607055725.38057-1-animeshagarwal28@gmail.com>
References: <20240607055725.38057-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: ak4554: Convert to dtschema
Message-Id: <171812236787.201359.12608772770752770380.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 17:12:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Fri, 07 Jun 2024 11:27:20 +0530, Animesh Agarwal wrote:
> Convert the AK4554 sound codec bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: ak4554: Convert to dtschema
      commit: 0ac3f1a4c2a345c48d22e8eb5b5aeb9304cb11db

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


