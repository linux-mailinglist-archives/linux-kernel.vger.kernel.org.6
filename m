Return-Path: <linux-kernel+bounces-218013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B7190B7FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F02282792
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DD316EB5A;
	Mon, 17 Jun 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW58t3qi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF416A93D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645195; cv=none; b=pmtZ+a2kXFzP0g+HrX3rdU9DiksChGKo8NqsY5dTAotSz9sMWJ7MF2Lss3Nd69fO1OLhHToJa88G5AQoJtHH9i9t/rbR0R/7OaGMPRDrJnqLkq56wPhm+RGgEnKZrJLognuLAHkOReDzdk4bkixddaFxQnTXcNqInML4w03FUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645195; c=relaxed/simple;
	bh=RBQUQZRRgitr539noZdkXKL/kl543yn4dVs2rg+GSnI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lgAbYodrGzfE0GX6Za38DBtLLmhC7cq3KKL0yTm81axMX2W78iztmj0dV8zSz3oiGPQErYG+etUCNmMTPrpL4LTvzoML2PgCZ7QHVz8Me2FyxvG4ZCVkCvXW8GePrJilKIvvFet+3hrXhYdp1O4akNNgyVlpyCsMny2NISWErCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW58t3qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB861C4AF1C;
	Mon, 17 Jun 2024 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718645194;
	bh=RBQUQZRRgitr539noZdkXKL/kl543yn4dVs2rg+GSnI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mW58t3qi4nQG8MAdHJ4d0yYbcoPcHNHvSMWtVPgFcl0mvMoLjGvIHcG2gSTwcKsg5
	 E3KAiK45EvkHosqlgaJ2zkIEPrbhZk2rRQZ/JHIpptOtinJat71ggByGrf60/6s/GN
	 jgb8AvyK6/qL94k0WQA9Kj85WGo4yfyZ1p2eL+nzTgjhySqhoobzqMpJsrKPLYvQJB
	 TS5TOlCctYHkSnkrkfn8k52oDGWwMLCW19PH+RjTLF0/dMwMdUbTOsL8rsq/IPV0YL
	 /ygVUbf37fG3T3LlCsq3YdDu0mDLLa9U1HFoxtXVltbLOO/jFKAsnu5HH/vwOkN2X9
	 O2oVYJSfNDPDg==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org
In-Reply-To: <20240510175835.286775-1-srinivas.kandagatla@linaro.org>
References: <20240510175835.286775-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: codecs: lpass: add support for v2.6 rx macro
Message-Id: <171864519230.209755.2369055216085451531.b4-ty@kernel.org>
Date: Mon, 17 Jun 2024 18:26:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 10 May 2024 18:58:33 +0100, srinivas.kandagatla@linaro.org wrote:
> This patchset adds support to reading codec version and also adds
> support for v2.6 codec version in rx macro.
> 
> LPASS 2.6 has changes in some of the rx block which are required to get
> headset functional correctly.
> 
> Tested this on X13s and x1e80100 crd.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: lpass-macro: add helpers to get codec version
      commit: 378918d5918116b95300dd7f03913a1d0841f223
[2/2] ASoC: codec: lpass-rx-macro: add suppor for 2.6 codec version
      (no commit info)

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


