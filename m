Return-Path: <linux-kernel+bounces-376883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FD09AB70A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5726D28215A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5301CC170;
	Tue, 22 Oct 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHDu0YFf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF11CB523;
	Tue, 22 Oct 2024 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625876; cv=none; b=ZidZbLJLFqmoXHk5YOWirNW3Wz5SyoTh4js39fucRMNxA01cJFn288c49TirR76Dodjih4SXvYeXVgus153qWwxFFEfbbxAmfSlCN9NIWGxJQXxyIg14xKu0YtXZsfdN6C/K47LkGTCyut1uOPpf6QFBinB3WHDj4jfhQH2D3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625876; c=relaxed/simple;
	bh=mL7bSMN56iFRWocfFYLWy1pq2RVY6ZsuMKHDqeFXkEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jst3wLa5VM9XsGp+MxFB+RSneC1DPPvVxRzvKMD7djLC0pQNT16GZsX+omYGcecrILD2KSllKYHCCHprvxDExESg6l2OULRmB2mT2LlqhnhA2RE3T9d0Dp4ESu+/QLh9k9gCqN8rfRd2hz+PVnjBksFXCItVxFP2Ci1fTH3XLQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHDu0YFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEC6C4CEC7;
	Tue, 22 Oct 2024 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729625875;
	bh=mL7bSMN56iFRWocfFYLWy1pq2RVY6ZsuMKHDqeFXkEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rHDu0YFfej9Eb7Yo2MGQ7AeAq5AgowOM9WpKsoRzR+o04KGsxqRIJlQ5PvlCr3lgv
	 xvMyT6pdNs/EEkHW3PUTTX9ERMNg85ZVgzc2ajZu2zdYbZSoPyU+Fy+6vZxlqxOtRH
	 vvEd1YOK1Uck8dPNhtz3MSEpkYtwQYTajV5NiHKw9s4ChQxrsZEurllwJFrqCfYtOP
	 H/tXFQtjsiXKtZbvr/aOryalWRkp30Rrd7+uBXQGHCjXcH2LUGVHSjJTtbEbgMaDAn
	 DXR60E1tjEgYN2xEhWrr3LRYwxntbGQuGzROpTOpHxWA1IClq/EnRxtNRCcEY5FZ9M
	 URn3mGMVKmtIg==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Melody Olvera <quic_molvera@quicinc.com>, 
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
In-Reply-To: <20241022064155.22800-1-krzysztof.kozlowski@linaro.org>
References: <20241022064155.22800-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom: Add SM8750 LPASS macro codecs
Message-Id: <172962587249.134224.1033882736357959605.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 20:37:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 22 Oct 2024 08:41:55 +0200, Krzysztof Kozlowski wrote:
> Document compatibles for Qualcomm SM8750 SoC macro digital codecs (RX,
> TX, VA and WSA), compatible with previous generation (SM8550 and
> SM8650).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom: Add SM8750 LPASS macro codecs
      commit: 6a646e6de58f4aedf5f6c7a4605a0393c4490ef1

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


