Return-Path: <linux-kernel+bounces-204309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557E8FE709
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D48C283BBE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAE9195B34;
	Thu,  6 Jun 2024 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmBjBFWJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E861D696;
	Thu,  6 Jun 2024 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679033; cv=none; b=O9VyWYKApEBqM/pzOTPxwIibuN+cRSq33f8/p+bOSgfCS+PU5ylRmdMkPyle2Jd/AsSpYshqL2DleTk4aHaf1dfXECcOcm4Pr1C4V5/rqyE4BhpMEVhE+rmfHK4mxTcLGxint/WyPJ6oJcaBhiRAEZPsvEnPrDzFRm46SRP/0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679033; c=relaxed/simple;
	bh=7j2qQVuSNB+C9zogsWp3FupLtbD+FHkF7koYC+sia4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pUauQQ8Os+IiGKR3aCLrR0FugLHmoQlUyxdjqSrMR9PeqBWD+AKlgpHYyHsjb4USDH7gjM26qAytRE79eCdFZyZSgORNcDrb2JMdmAQag57FbHzHFwj9Q8yAblXqm7T1rVnGWtaNPpFoG5i/h89LYtHzjrj7xBiRfqViDfwSOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmBjBFWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C1EC2BD10;
	Thu,  6 Jun 2024 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717679032;
	bh=7j2qQVuSNB+C9zogsWp3FupLtbD+FHkF7koYC+sia4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dmBjBFWJ/xv8UjRs7CxI6Gw+fljoJfgF29Lj/OiHSK1rq6Vp98Zvg9rMzM97iFv9e
	 ko3XSsOC2PQCJyq1L05+RoVwvZvlYO3Ud1WPqiUjFEd4Ew3wymKPmdptI0yFGMB2Gw
	 hRppoj2oROTTSN60Sije1INt2BXxYeXdgObrvBigABam8xkOYEv61iIU98PNrdOOzs
	 16u7U3mingg89AfCuFu9goSwGoiFVVUfsrzUhrUz9w2eGpCGhLrK86Jct5ffgxE8VG
	 Ns6SU8IHdn65sIBerEl4q7JIvgYHoSvqVdJbHIOubT4n3e7Ogy6mlTFjNvj+5oq6na
	 jNZZEvOHVpYIQ==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240606-topic-amlogic-upstream-bindings-convert-g12a-tohdmitx-v2-1-70d44fa30790@linaro.org>
References: <20240606-topic-amlogic-upstream-bindings-convert-g12a-tohdmitx-v2-1-70d44fa30790@linaro.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: convert amlogic,g12a-tohdmitx to
 dt-schema
Message-Id: <171767903036.1300004.2234947523747840276.b4-ty@kernel.org>
Date: Thu, 06 Jun 2024 14:03:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 06 Jun 2024 10:06:58 +0200, Neil Armstrong wrote:
> Convert text bindings to dt-schema format for the Amlogic TX HDMI
> control glue.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: convert amlogic,g12a-tohdmitx to dt-schema
      commit: a1708fda9388c83215f0be82ad47df10be6e1975

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


