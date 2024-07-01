Return-Path: <linux-kernel+bounces-236887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6D991E841
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F0A283B42
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39416F824;
	Mon,  1 Jul 2024 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyDgSE21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B149C8C7;
	Mon,  1 Jul 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860839; cv=none; b=Nv3eZGwdU5pwIhP4oY2PL84uQ7cvQ+svIfADAMAj9804aal6LDJkri/pN869oUJubpsW6Ealw9GGidvDTPfPFnVm/j1rvsQR8NrYzQ5IJljDnHpuAr1KtgwYKQDHJoUWG84i3q3bKG8jrxx93mnm1GcUu76WWbpN32A1GTf1SYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860839; c=relaxed/simple;
	bh=gMrV+ijgZMh0m+2ERFZl/fbLXqTQXBW5x5rclYiAQDs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VAU86BM3OkwWIYgrWkfiR8mVWJl+efuftWYWLb2at7Q24q0Z9CvyOnC94JReeNsi3dIQ6hGxdN3R2LcLw5llpzxTqKrsFtK+ocSzwRiZdZWZvTYt5sdVTZOeV69rxX6QqtaeOVdvSBV4DydlwnyZr/1h5d55qrhbHm4vIryC/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyDgSE21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E0CC116B1;
	Mon,  1 Jul 2024 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719860839;
	bh=gMrV+ijgZMh0m+2ERFZl/fbLXqTQXBW5x5rclYiAQDs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WyDgSE21W/R6Z6n8hZW9i7gR2SypF4OkpA3/Cd0gbuR10uWBqElJUoJ3JKpnos/qW
	 QJM+aWi/H0o8HYyL24E+OTRCsVcVs5zSXcTpAhj32Ej6aqnJOSzNqigan+U6KENP9U
	 Cqwcf+mkzSPjQtnDcf7moWOeqhMrHD1nJWs2bC+/g2pM/ck+Nt/ZnwIrWplqma6RpT
	 tZHlW1jC4HqrI00ETXsPxc/p7zvqQbQYj6sWoL3/aKforoZCcUwnDRnQv4/OlnKKPm
	 k+aeJLhumfJ+2R2rJztRehC8EAbnI5hiPtaGo1hGj0ROtU/L0pOtTCsAZ2uIAOXlcN
	 I7Qd1U6Bx/9rw==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240627105030.14360-1-animeshagarwal28@gmail.com>
References: <20240627105030.14360-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: realtek,rt5677: Convert to
 dtschema
Message-Id: <171986083720.121161.13189262733622905838.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 20:07:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 27 Jun 2024 16:20:26 +0530, Animesh Agarwal wrote:
> Convert the RT5677 audio CODEC bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: realtek,rt5677: Convert to dtschema
      commit: 4381b88b24a2edf9ce130adc9acd53258ba44116

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


