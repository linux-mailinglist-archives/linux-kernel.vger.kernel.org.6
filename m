Return-Path: <linux-kernel+bounces-212916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE7B90682B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E061F233F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51113DB88;
	Thu, 13 Jun 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxsW5fmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C45477A;
	Thu, 13 Jun 2024 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269822; cv=none; b=ZVDviwojYoiaqu7a+S9HGqynTBZTL+F8wKOD8AstuIr2gPzNQRwQFAbu3i5pPBSSbErqSV0Z+9hAqmB4bLyPD/k0TBqVehHUlcCkNu5NhFCAUxD4B5u11z49gECbT30kQp1/AaCHZpKrNjLpMBsCEyYalEh5tkzKHhtmNhr3Nb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269822; c=relaxed/simple;
	bh=i3+R/MOG/lALbAym5u86sPkHiGkCU07B8ehAYNtrhWo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dS3pYjahQF0AgL7fNhF58kE0V4J4ifcl4QJLyxz4tRxCVZPnY89fZXlH1FeV7zVTqHBozF10bUxphyA+/7Y849nc2hp7FJYvTg7qPCOtva3jJPRNt94vqyA5ceAhr2fAA7yzDZHlv1LMFwVNQXpqE319UwvQ6Bxji2/EnY3yyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxsW5fmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8535EC2BBFC;
	Thu, 13 Jun 2024 09:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718269822;
	bh=i3+R/MOG/lALbAym5u86sPkHiGkCU07B8ehAYNtrhWo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JxsW5fmAgZawvfuhMoTbze0S/b+DbR3210GjIeXOncb9d8oHM++vXIsk0NNsv5W61
	 S1heVu0l6mdK0hp0eyFp5TdmtV0U8xs8G5+FccwKh5luUOCfHH8Jj9NMmd1FpFaLpJ
	 xUgj5wkiY4DNL3zLTjYwTBHfXLka38EGSzI5LjBlAqtAInu+MvqEXTimaw+XRPmuN+
	 Hia2rA+vFn01bBua2M/00Z9CI/CWs+KVIud0BOdnC/U0zkBz16dovt0ONGNjaMDDJd
	 OZidGrOpbi6+gxSRHPH3wL4+XHf3Co29q1gWS19v0D8NBmcZ/L1osN9BMyFG08DmYS
	 U5UB0oO5e540A==
From: Mark Brown <broonie@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240611124405.63427-1-animeshagarwal28@gmail.com>
References: <20240611124405.63427-1-animeshagarwal28@gmail.com>
Subject: Re: [PATCH] dt-bindings: wlf,wm8782: Convert to dtschema
Message-Id: <171826982107.253389.17897020973792581046.b4-ty@kernel.org>
Date: Thu, 13 Jun 2024 10:10:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Tue, 11 Jun 2024 18:14:00 +0530, Animesh Agarwal wrote:
> Convert the WM8782 audio codec bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: wlf,wm8782: Convert to dtschema
      commit: 01e29260c645bb844fb73ad40a022d6647fb52a0

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


