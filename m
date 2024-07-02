Return-Path: <linux-kernel+bounces-238323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A4924845
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA7A286270
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4AE1CF3D5;
	Tue,  2 Jul 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab+f4MpR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB121CD5BD;
	Tue,  2 Jul 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948403; cv=none; b=b4Z8w+tI2uuBg4b91b5g5W0VKeQEn42AjwBrUT7psK9kA6GUVmnGVjsfr0p7zsYV5UiqxadyZeuiP4RRT4ux6uFlpunDEsQb16r32xPARK1V1MS3mrlVYviaZrfjhav2IBnhbRleSI8+lgoMzfUtG3AoK7y5sAzSzyHogiy6hc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948403; c=relaxed/simple;
	bh=trXhHBaFepqUpknmYV+VppqoIMsKQsffNfVDAWVzp/8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MWC9dFS69QpZAXMCMbc928ZOlQFUSU3gyJvBbwmsKvNf7T+rJBL0dPZIxf+hSc5H13vp/5Vjxu6xJAU3aMJN6s4o+PSgZebZ3gWNNgtOzphivZxt309h88rs4LZSjMH/pasfKP0qpliC8mWZHQHHTJFQcZNhgTlC0MohT7y4UL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab+f4MpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8458C116B1;
	Tue,  2 Jul 2024 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719948402;
	bh=trXhHBaFepqUpknmYV+VppqoIMsKQsffNfVDAWVzp/8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ab+f4MpRzG93o7GOiuVpew5D35+V0H5Fv3RLKHQwc/jseuLAxSs4y0V2W49TgNsL6
	 WqoF2CXEJaDO7QFzWYqqrEJel+bqCCwvvvgDbQRWnjSsdnnOJhGUGTtn5tAA/qSpRL
	 +SkpqfN1RRQuma+KxyQKPgGW8IBXDE36HdzdpiLAbUuIHEYI4faqLE4aP31wc7IKkd
	 AiN+AsCqLMNhCEcQRenWJ5oXSJAgAjyMtGT1KM7uR4l4Uk5BUvT/458C4Qykfn69zA
	 tkH4V7U+dm+QzHdiqDERXANQFhKs0sMn010lmYfhvs/IL5uJCSQIb0BeR0LBDguDno
	 qae3h5Q21q/ZQ==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240702120106.17100-1-animeshagarwal28@gmail.com>
References: <20240702120106.17100-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: realtek,rt5645: Convert to
 dtschema
Message-Id: <171994840054.1008252.10809558321000741884.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 20:26:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 02 Jul 2024 17:30:58 +0530, Animesh Agarwal wrote:
> Convert the RT5650/RT5645 audio CODEC bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: realtek,rt5645: Convert to dtschema
      commit: 83d43ab0a1cb83b1f3d731885a5d800ad8e84524

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


