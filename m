Return-Path: <linux-kernel+bounces-218014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D4A90B7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6442B1F2178B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B16016DC28;
	Mon, 17 Jun 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8JaZiW4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E5616EB72;
	Mon, 17 Jun 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645198; cv=none; b=VAaN0P7WeVOQu/8lSnbO6hSwfsrL+YdDjwWimgVakK5vM/idUn2CbgsP9Kb3+E5o54hKwDYo645IYFHVt64twgWAXg2zhyQqKIZPdQTsoUgIS6vBUVyAXWzzEi8arWOYvQ09x8FzF+jdG9ipN/FsNDzJ8KfXZDE61XM2NjDAE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645198; c=relaxed/simple;
	bh=mGYQvXUGMdu10xeflRHa+x5lMbk5O6JrX6/PT+IMeqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ee33vwP+ZRm0y4Qj5MYI7tilnTLM5bAxDSHlNK9rwIX80h1eP2TjGyPPXVM/BENDkCxY//LHk4ZwRHN6xS8U1s7tVUxbynJnIVNUphwNOIUgSV7U8UxR8Tysh9ajsYodpatZrYcr/7QXQJk/AgHv1dwBYwiWuhDtgQO6Eo4CJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8JaZiW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA4EC2BD10;
	Mon, 17 Jun 2024 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718645198;
	bh=mGYQvXUGMdu10xeflRHa+x5lMbk5O6JrX6/PT+IMeqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q8JaZiW4OG+GOQh8WXMzw4XQW21R7AnjZb6U9YPJntmp/CfAIMk/gvsWbRXOw4CHB
	 WA2uH0HnE9azUtDBOdCVvtmYU798gEvZgWQt2h4mPtjeHST3tABPuUYz4SMdwYxptD
	 WRHGp5ubpq9JGX9bIAqKqMSvviADachIX2Q3QEw1FOeHI5GP00kRFoDnYth5lYknUn
	 KHOJ3xzvMfeusbW17/563m0hq2nfL7d2XarBkanuiqmSIhxpngL/oh777iehbUPuHK
	 GnH34eXBraI1ZBPCkIJ5uvUYDrrgtsxr/leH+KeRf7XBn2o66Tk6ddPH3iGPvX4drt
	 lITf4UyDCG6Yw==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240616074936.151267-1-animeshagarwal28@gmail.com>
References: <20240616074936.151267-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: realtek,rt5631: Convert to
 dtschema
Message-Id: <171864519512.209755.10728526082941128699.b4-ty@kernel.org>
Date: Mon, 17 Jun 2024 18:26:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sun, 16 Jun 2024 13:19:30 +0530, Animesh Agarwal wrote:
> Convert the ALC5631/RT5631 audio CODEC bindings to DT Schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: dt-bindings: realtek,rt5631: Convert to dtschema
      commit: 20346f5c7bc9f83c74b5efed163ae4e2ea7616a9

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


