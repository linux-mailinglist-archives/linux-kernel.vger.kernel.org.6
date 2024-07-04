Return-Path: <linux-kernel+bounces-241022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D409275E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7D6B23A13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF391AE0B8;
	Thu,  4 Jul 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgPtmfrO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A174C76;
	Thu,  4 Jul 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095889; cv=none; b=F2FgS+mb1HMim3P/5dgxy4i0+DgRXSVjsL8XV9by0ZvjR0Qr872ZArasKdxEop6dFdHs1RHh0bSPoHldzMFKpXqFBs96SvbNBBeXD6QNW2CH5Vq1wcjFvDzyPgPx0fwk1mls9Qowgqb7/FYzZi3mv+1ZMQNO7jrRcEkf399UKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095889; c=relaxed/simple;
	bh=tcmoWNkg1mIAF37WjNIEwacrxDGbi3ao2NOlwUh3y4M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DGDOhnNRBv0KcO/9HcsxccO0oWGo/qwLhitx4ctCgzlqmJ48XULfGNAnsGhtksQBHTLEfD8mxS/pZdmwAZOf220BSRyEaCFy3kUrOaaIKyXmg1lhItcLmWrOYKBSFk91HSI/bVZYwY0320Pm1/KSs6lCTkJ5xo28cZL3m3wG8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgPtmfrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D784C3277B;
	Thu,  4 Jul 2024 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720095888;
	bh=tcmoWNkg1mIAF37WjNIEwacrxDGbi3ao2NOlwUh3y4M=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JgPtmfrOayx06z5W4PLmusVtQ5IhL1mb5Jb09krUrIQ+zIE6XCrTUiSm48bm1v4cU
	 uVnI+5O6gLGZ6jxKlDmTVb8mZ+2li5+a2lS6ttnqXEM7xTriSQquD4Lx3P4QtqCbpU
	 eViqhAJO+HqkbnpYOVrc1e2G8etYgEKO+a5K/rmzzA7iJ2TqYronzGiBNrXo+iWc/Y
	 TyEtcEqIidbkhNkDsvpRCgCg4AZCIUznqGHLUkfUmTVHYbTgPuoSJmFma+yPSoWXla
	 nFgOiTdCyLlW1jX9nOgmxDILqpaMNm2X0cXtlRfEMgD9RS6fwY5Dmn8FGiN+SVDDn/
	 MTLgFXaBydGDQ==
From: Mark Brown <broonie@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20240612134039.1089839-1-andreas@kemnade.info>
References: <20240612134039.1089839-1-andreas@kemnade.info>
Subject: Re: [PATCH -next] dt-bindings: mfd: twl: Fix example
Message-Id: <172009588718.37463.16228782053635790556.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 13:24:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 12 Jun 2024 15:40:39 +0200, Andreas Kemnade wrote:
> Fix example to also conform to rules specified in the separate
> not-included gpadc binding.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: mfd: twl: Fix example
      commit: 80e64b6d34812d037e4edcaca88719da51a943be

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


