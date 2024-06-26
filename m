Return-Path: <linux-kernel+bounces-231423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF791988F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305D81C21BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B391922FF;
	Wed, 26 Jun 2024 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCnsA5BE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2302719069C;
	Wed, 26 Jun 2024 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431568; cv=none; b=VYWT8C08cnTBqPUj5CkqDQiRzFstVGYyrMz7YB1kEH+oojf3ft1dV2fEVTjvDQ1uo3AqNMiTLfSa2TFaV0HC7wmtvNaUOVCuYN2r3RtzgL/5vrVnrD50E3MofLejJWSYjIIOLdPuE6qHF+PwuUBc4G3k48wU7GW3CWp5ncSVEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431568; c=relaxed/simple;
	bh=rNDLMS+vya2aLaa8DFgO3Tum00J0/6sLmaarSdgOpGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ag2fkYShtMaK9lmR7/VKn3I93iaaJi/LKz+JWUbrxkV6BKH/vVRRRRCcY9azllN7yUuh2k6jzqSLc027j7m/hHXscPEDwxxTbJ2ZmhrBCi+/+JOgrKYzODIWZk2WI072K2XMlUac98mikY8fC2Y0ELWc26pfVak+dS8KE0vd2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCnsA5BE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A11C116B1;
	Wed, 26 Jun 2024 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719431567;
	bh=rNDLMS+vya2aLaa8DFgO3Tum00J0/6sLmaarSdgOpGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aCnsA5BEAvrQdzPkI3MIGW6fne4PO2OA9XFxxXSnK1lduqFfzP6YBFZ0jbc0iOK4O
	 17F3NPUunj9X8cpC6aPJV7p6iH34hZ4b6wk7bSKkzGtVF3SG0popNge1rv0Ezjsxdv
	 mr1MDu3CyOfLLmCxMlx6fUvUFk/96KI9LHB02S63ZwojuhmoatyZ3oAdn3gKsHxbNU
	 rZEr6ZYfys61gPuW3pG+Ww0eTKb/7j+ZPQBDwG7y4Rqs1+z48/Hn2ooLJgvZo8O+QR
	 bZHf47PvWo0wMkXfAR2BOne+E1GIRpEcXAGPUa8D+L1seViOogfiN1ROl7hSlvbkDI
	 DGjDmlmU9tdqw==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-audio-widgets-v1-1-65bd7cc2e09b@linaro.org>
References: <20240605-topic-amlogic-upstream-bindings-fixes-audio-widgets-v1-1-65bd7cc2e09b@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: amlogic,gx-sound-card: drop
 minItems for audio-widgets
Message-Id: <171943156536.1690751.17356861338866008648.b4-ty@kernel.org>
Date: Wed, 26 Jun 2024 20:52:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 05 Jun 2024 11:40:51 +0200, Neil Armstrong wrote:
> Like "audio-routing" drop the minItems: 2 from the "audio-widgets", because
> any limit here - lower or upper- is rather meaningless.
> 
> This will also fix `dtbs_check` warnings like:
> sound: audio-widgets: ['Speaker', '7J4-14 LEFT', 'Speaker', '7J4-11 RIGHT'] is too long
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: amlogic,gx-sound-card: drop minItems for audio-widgets
      commit: 4faed8ca581c0307af4a58e6c0027ce2b2cbd5d3

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


