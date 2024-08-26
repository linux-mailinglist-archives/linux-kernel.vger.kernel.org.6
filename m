Return-Path: <linux-kernel+bounces-302040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970D995F90A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAADB22131
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7DC194A68;
	Mon, 26 Aug 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU+Orevh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C72C1AC;
	Mon, 26 Aug 2024 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697345; cv=none; b=rIQt5DNbgyJ8IbAHgLVvquQYER5LYHykkb833eVD4mnLk3ez4WlvKyR3YmMJcwrV46qIDVpPNxeWD1RRmXcN3m5S5x3bkadifAAJVII1HPQP+pz3hQYqRvSWy+QGe6s0KJXtU1A0vQdWReEvEQQXCYkWsYQhfux1rMoawQfnIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697345; c=relaxed/simple;
	bh=uiz9Rtx8Hk7QAj5m6TJJAmxSW3fHU5X0XY4yHCbzD+U=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tqlWLUueJBHJxcAL3FVYezPfGetAQq57ifGiUtHVm2nUboLakUYqfD+hpER306/3I2wgFIQZ/5jZLjOZfpzA7fMc6Q6w6udVfGZ1IE0uYQXS6cFfaNLMXwlX9zmO8QtNd/4z5oEadtmiPVBrPyE49o2S1KX4DZ6xyGTxQe0sR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU+Orevh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C26C4DE03;
	Mon, 26 Aug 2024 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724697344;
	bh=uiz9Rtx8Hk7QAj5m6TJJAmxSW3fHU5X0XY4yHCbzD+U=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=HU+OrevhAiyoh5RN5Q+28yH8zKif9sHT8wYEZ6NA0jhbngTn9JRWD9UJIF2zwsyQ4
	 QCvfsalG41fopxdOXF1F+gXbj1ZCmBcA484bXZiDgxRnNgMnSlBmrdDvd3FdXnZMsN
	 z0Xq7cHEd4B2xVqowu0MljhJWn+JUxCKAyLvhP3v0xztp3v7T7k6A7D2riWmnhb8ID
	 18P60NenfqQbnyXTYJrExvlpsXGWX67y5NsBuTQNhfKimFyh4v2wwxzSvtZFLMxxCV
	 0SvJqLrBq1D5lDTN5rvl06BWLRNBrse8Sr90vyTLaWxgUmkWDRFJY51OfOKOnRq+IS
	 ovP30tYIJeq+A==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240825085745.21668-1-krzysztof.kozlowski@linaro.org>
References: <20240825085745.21668-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: MAINTAINERS: Drop incorrect tlv320aic31xx.txt
 path
Message-Id: <172469734019.858128.1291012242968483621.b4-ty@kernel.org>
Date: Mon, 26 Aug 2024 19:35:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Sun, 25 Aug 2024 10:57:45 +0200, Krzysztof Kozlowski wrote:
> tlv320aic31xx.txt was converted to DT schema (YAML) and new file is
> already matched by wildcard.  This fixes get_maintainers.pl self-test
> warning:
> 
>   ./MAINTAINERS:22739: warning: no file matches	F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: MAINTAINERS: Drop incorrect tlv320aic31xx.txt path
      commit: 0225d3b9efe3daca332befaa0c4ce2f119297d5a

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


