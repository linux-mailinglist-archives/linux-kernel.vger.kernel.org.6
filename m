Return-Path: <linux-kernel+bounces-208643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772099027A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE9CB218F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E001474A9;
	Mon, 10 Jun 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLEdkmqf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C6145354;
	Mon, 10 Jun 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040133; cv=none; b=jZfgsZnC72EGYTK9TSXY/C+xCdpdZoksJ0Zg7EQ1wfJVzLgcc47pmEdb333R20XD225T/cSn6X+xfNJ1dyoAVEMUqc5nrXU2C4WQjzJNLjn174H9RNxVFVj0OxmQ23WKA5nrcFFSJD7s8oxT8O0H0SzxolzjdO9r7XD4pXw2Y1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040133; c=relaxed/simple;
	bh=57ceoUh1lnuArA+V9KSwn1wYEhKAqL2QRV8U4HJi8FM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nXoSx+gnfPnmOrjlxbiR8rDSqrTTz2zgqecnUVTse9sZvvdnnhjV6eu7XAn8L+fTyGJJQvnEo4rybpa/gj+mEGxccWgdo+HwM1xkIm2K9LU/z11y6hIENNMbCI4sp4gVgOFGiu/g5cwK83YqgPIQuQgpcarPXHGpi0YX5w4i2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLEdkmqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27896C4AF1C;
	Mon, 10 Jun 2024 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718040133;
	bh=57ceoUh1lnuArA+V9KSwn1wYEhKAqL2QRV8U4HJi8FM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dLEdkmqf/RWesXBOgyql3gws/IZVT49DJ12PYVp9REDf4n03PLZ1wWjMxXslZQlJ7
	 XVI/bI4jp5AjHhOBFZJdMm1QeZDMhm2cB1L2rKiH5B3gk5CYEjBWEJMUMxrhYNc/WQ
	 hM1hz0CcWMedcWGxl4jW2fO6OptdFzcESXjtKeoMWQ4lVQezArLd6O/fhOXirQRLi0
	 naFWWEpan586FAZyULfsGRfR28hP6kvD8eKmAjZb0WH2tOpsj6mKcbMG3zqYzkwiIo
	 tYVs76MKzoX0n48+vzGg7TotImwqtNCrUEWzFtay5E+2zfxNvCoK6nguamPBq/ar8E
	 a5c3K3lujvzSg==
From: Mark Brown <broonie@kernel.org>
To: Mighty <bavishimithil@gmail.com>
Cc: peter.ujfalusi@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lopez Cruz <misael.lopez@ti.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240608095305.2887-1-bavishimithil@gmail.com>
References: <20240608095305.2887-1-bavishimithil@gmail.com>
Subject: Re: [PATCH v7] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
Message-Id: <171804012926.149444.13267117462085027164.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 18:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Sat, 08 Jun 2024 15:23:02 +0530, Mighty wrote:
> Convert the OMAP4+ McPDM bindings from txt to yaml (dtschema).
> Drop ti,hwmods property as it is not needed since the sysc conversion.
> Add dma, dma-names, reg-names properties to match the DTS so as to not
> break the already existing ABI.
> Also update example node to match the existing node in the DTS.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
      commit: b97e40905580c4585faa491189214e74101ca2ad

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


