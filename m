Return-Path: <linux-kernel+bounces-522663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BDA3CD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C73B74BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9748325D556;
	Wed, 19 Feb 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1WQq79V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13CA25D550;
	Wed, 19 Feb 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006491; cv=none; b=crh8Ks6rndS8nyPaIHommHQYMjqluTdBQrY/6Ocu1Sdaw4W5OkxqvjSAQuGwGPEJjjW4euXsoghRwx+5aLBk/EoeQ4pbWwLdDY/DQjxog9uAMu9VwNCGuFp8jbhOttMBPlD5vl4JTb6cjhthQ88unZC8BuHmbqw/0cohyVeS+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006491; c=relaxed/simple;
	bh=Xs1gPh4JhWP/8ya71+EAU0oDhPGutD9vI7+Q3WYB95M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rOYWyj+zcflKuc1RkmyyuQme4sYarZ7E7o7Wzr73gp1vPuMm/rMDn5e37P+gyJZLTsXwxBfwrEldr8Np6bvHeg7IO20gsvq2IEkcQv8X8v7mlCFgqyqCFdUmNLsGYDJfgf0aGDsAI7gd4nRz7l6+5mM0F0xdPhMmebpoAyXPKpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1WQq79V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993ECC4CEE0;
	Wed, 19 Feb 2025 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006490;
	bh=Xs1gPh4JhWP/8ya71+EAU0oDhPGutD9vI7+Q3WYB95M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D1WQq79VgZEirpJs744p3R9dpoIsArvKYimSeVZi9Dr/le2i6qCy1OkEdhSUia5RK
	 5V/5naZORZ8p0bbk1NWRUso5TaVI/orUw64L+b/z9b3Z3YSfhD9XXmEFShUwly5fD2
	 eqEXkgKpORJq0TvVtEgo6wgEuyB+0V2WiLI5RMSnBcUT+nDM8CG8oTGskabVj86COH
	 i3mZw0gXSp/TVXy7CPNzGsvkvavbejDF02r5ACd8t+rOLHZaAzqDt/AfNm7cJJtdNA
	 obprQoZVpM3MMKGKZsVJgP1ZbnF2af9DmBr59HPqdyINDhLD9vLP+MSe2EHP7hiZUY
	 Hq1f4T0gWj8ww==
From: Mark Brown <broonie@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrei Simion <andrei.simion@microchip.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Balakrishnan Sambath <balakrishnan.s@microchip.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250219-sound-atmel-at91sam9g20ek-v3-1-d7c082af4e14@microchip.com>
References: <20250219-sound-atmel-at91sam9g20ek-v3-1-d7c082af4e14@microchip.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: atmel-at91sam9g20ek: convert to
 json-schema
Message-Id: <174000648731.2064138.12115170736497220241.b4-ty@kernel.org>
Date: Wed, 19 Feb 2025 23:08:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Wed, 19 Feb 2025 11:22:27 +0530, Balakrishnan Sambath wrote:
> Convert atmel-at91sam9g20ek-wm8731-audio DT binding to yaml
> based json-schema.Change file name to match json-scheme naming.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: atmel-at91sam9g20ek: convert to json-schema
      commit: c8d08464bce947ee060e0174a3f4e87503269d0c

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


