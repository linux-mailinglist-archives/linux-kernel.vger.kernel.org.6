Return-Path: <linux-kernel+bounces-396921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6DC9BD45A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB8A1C234FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3BC1E7C2C;
	Tue,  5 Nov 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tp+AHXtT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E81E7675;
	Tue,  5 Nov 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830529; cv=none; b=SWTDxaxikTQPVMNvqY5QV46eIBPS4g0+ZHctF78ZHzBxna0VSm6r4SDqMX7NEIBBbUWcBjjvzMa2svpNj3/mJFe1+hK68G4DAwYq5k9N6Q4piJKgxfCVw5kaJxH5tH2wutx+GpeR5+PA5l2yBau69u5RwrGzcSqOiROXsOh/PMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830529; c=relaxed/simple;
	bh=0SLyPYXn8qaiU3kOUbKXZq/OLmpMozf3yCJYHEr3Ea0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rYUEg9ATmIXQTyAUop+VerRWEqRzB0QzhNvii3y9i2fzVLfvcL3v5C4IECA6Z1/+Pil8NhqLYy1zxm+PV7CHmNLWqaCvtCJymlj40RcuqTgbftZVcfYeqv4+B3eZhuOLXiAIUY/1hbL4BONMMBILsUGGVUsKaxUFQQj5PzcK/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tp+AHXtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA06CC4CED3;
	Tue,  5 Nov 2024 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730830527;
	bh=0SLyPYXn8qaiU3kOUbKXZq/OLmpMozf3yCJYHEr3Ea0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tp+AHXtTXvtedpfAIISt8W+JoF+2R4z2B7o6AEGmZ2ioHcxjLQV2cID4zKARYJRD1
	 uQAm5qvitzA4T4aelDRL2FRV35uxkBkmMIgOaxIQeFgXVSy7YH0YBZARO4oywaFf/h
	 9KieqTw+nHHAmcLix8cRyT9rC4iI+oj86DpKhaqtQy53zj7AQJoLsDeHYjunYIWM4O
	 XE64ePaaZzORzA7It9RUz3wdo9LBOjqhoxXApy2Zgp/lMfEN5P/Ib7QAGNYFdBUn/d
	 u2ndf1nMdmLOIAIAImA/+IAcrhX0mejyu5tWTIze8ArMNcZm8hPPE4hmrTGFmQ5E7z
	 yEOodN5gCfPYw==
From: Mark Brown <broonie@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 David Yang <yangxiaohua@everest-semi.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <20241105091910.3984381-1-fshao@chromium.org>
References: <20241105091910.3984381-1-fshao@chromium.org>
Subject: Re: [PATCH] ASoC: dt-bindings: everest,es8326: Document interrupt
 property
Message-Id: <173083052542.94172.3226642386925576095.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 18:15:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 05 Nov 2024 17:18:11 +0800, Fei Shao wrote:
> The ES8326 audio codec has one interrupt pin for headset detection
> according to the datasheet. Document that in the binding.
> 
> This fixes dtbs_check error:
>   'interrupts-extended' does not match any of the regexes:
>   'pinctrl-[0-9]+'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: everest,es8326: Document interrupt property
      commit: 99348781d249817c8f96a7cbf636b7c6d74bd756

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


