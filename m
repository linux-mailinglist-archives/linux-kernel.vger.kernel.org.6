Return-Path: <linux-kernel+bounces-517734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3499A384ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF6A3A3203
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091BD21CFEC;
	Mon, 17 Feb 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI/U20Sj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FBF21CC63;
	Mon, 17 Feb 2025 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799507; cv=none; b=dojWh5DcaQqqFQCQqcf8uUIKXNfwrC2VPNxNo6sgHkPSmQaIyWg/E/y0A6FQ/MQcZD8ZdOFylxxNhY0qmhi2Uhg/3K8XMyIutGrTxSmdJSXhVz5lg+g3Mw1Apo3P3MXzk97YtxN4PSaPmo2WOYDEgL7+zq7EsTbMCKAohQ0apg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799507; c=relaxed/simple;
	bh=zMdGWJp3+Q85tNq2jwMB6nkQk9pTkBBt/pztVGDMZpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BgsfTuZeD6+dZOti0DDMs+K8bXqCE6m2cpLl+MsM98YYXVXp6E/PCwyaiAiPreD6R0ts7oFrivSQU+oBSh6Y2xGeWq0m9x8ZXuv950BMBHVwyg1NRxAHPyGAi31et3wRGpUOALiAciMHPziJxEgPYTbLPhn2je1y9qbYjlDJXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI/U20Sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949BDC4CEE2;
	Mon, 17 Feb 2025 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739799506;
	bh=zMdGWJp3+Q85tNq2jwMB6nkQk9pTkBBt/pztVGDMZpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DI/U20Sje9MbGSNT81jDaQz8QYb5EPBAVNYSC7U+p3q/fgoqfN2RTWd3LE8XV8Evm
	 sxerrIWfVqIjm+psgGDxNAuXFu2sIBLX1QI/bAP2of5+5Gwe+A6rm3IcSmbuiXPSc5
	 KiJo0lgR5kOv9YOlY9sh3coJ8Vsiic2FQ3pANGVNP9sQ55ER58LlJxSpDjdPxpI3Wc
	 Q/QWJeBecnlMaXPClF1EWPrgqlVKpEUYp3nnBkB92EBdXbtwBW9cev1ceDAjopFp3N
	 3vu/pWrGul2/qlCbHMvua2HlE0/OnGdI6L7aAENNUA+GBtlQFZLCHqw+5+1lvjIBHy
	 TvzBDiB7uXM8w==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250207163029.3365-1-laurentiumihalcea111@gmail.com>
References: <20250207163029.3365-1-laurentiumihalcea111@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8960: add 'port' property
Message-Id: <173979950535.40079.2153617057920573361.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 13:38:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 07 Feb 2025 11:30:29 -0500, Laurentiu Mihalcea wrote:
> The wm8960 codec may be used with audio graph card and thus may require an
> additional property: 'port'. Add it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wlf,wm8960: add 'port' property
      commit: 5c7e4c4da8586d2ef55a11a9f4df626b8ea9a146

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


