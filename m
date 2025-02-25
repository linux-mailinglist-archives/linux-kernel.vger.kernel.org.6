Return-Path: <linux-kernel+bounces-531485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC2A44111
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CBC3AFE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194A2698A2;
	Tue, 25 Feb 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKctaJM2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5126A0AE;
	Tue, 25 Feb 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490733; cv=none; b=glYN2LdIurbt5UrolSUOnc0ZcrtNeUX4dkYaQhRGAVBavQyd5hn65v8ftEOSFukQ03vx4alTGLB0oDqoGG+EKQ6zJe/5UiZG15uQ4pivTkS3N5ff1edKXlohFSvuPTixgLb9S17nBlAtZDnbf++MAqx5zW1/KvV2MeIo5yE5MtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490733; c=relaxed/simple;
	bh=v/BNU5heKZpu2nBxSPPaeh+4XqT8mTNPloSVQ5SDHYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HJAvNlGKrwGrdbdKyUqKXQwA0+kJCic4sF4qRUWT4aTpK/y3cPdt8yuJ/7N+wufGiEvErG3aN8CJC3VtgVQu+Ub3OzwBI/HZKwZxiqXwrrXFe9ZKNAL+a1scdgy41PnTWKOgSYU2IJHCf+zye4J9veOtrcdiAcd+cgmFjUklZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKctaJM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23804C4CEE8;
	Tue, 25 Feb 2025 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740490733;
	bh=v/BNU5heKZpu2nBxSPPaeh+4XqT8mTNPloSVQ5SDHYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IKctaJM2Cg/8lZx1mcHTa9gef5xJdr7i/pSJcDoQMUztJynwV17YCAQprIqaY+ytD
	 GD85x+DhXFoLqvuLaJabw19WSSIV73Idd7RCaybMX1eCslk2Hig/oRM+sCoyHOvA2K
	 DU1XL0KgUB0CJA0pMYsxQlOOf3Glsn8lb9aIOHaSLyzHH2WAnVnBybJmXjPKXRFjX0
	 FKfj3oPM9WipiGWyPByyUSWCccwXWVAtmL7x1BlsXZpo96cgPqchRBIHtyMaTC4nTd
	 0/Fm6kqGvzdjZHQmbUtjCb9tjtmxsK2rNRDa4/sKQ2FthiXycoLWFB1J95a5pjXIp8
	 hjraPtCNJMllg==
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250221-dapm-graph-node-colour-v1-1-514ed0aa7069@collabora.com>
References: <20250221-dapm-graph-node-colour-v1-1-514ed0aa7069@collabora.com>
Subject: Re: [PATCH] ASoC: dapm-graph: set fill colour of turned on nodes
Message-Id: <174049073185.42497.3918767630550396939.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 13:38:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 21 Feb 2025 21:39:32 +0100, Nicolas Frattaroli wrote:
> Some tools like KGraphViewer interpret the "ON" nodes not having an
> explicitly set fill colour as them being entirely black, which obscures
> the text on them and looks funny. In fact, I thought they were off for
> the longest time. Comparing to the output of the `dot` tool, I assume
> they are supposed to be white.
> 
> Instead of speclawyering over who's in the wrong and must immediately
> atone for their wickedness at the altar of RFC2119, just be explicit
> about it, set the fillcolor to white, and nobody gets confused.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dapm-graph: set fill colour of turned on nodes
      commit: d31babd7e304d3b800d36ff74be6739405b985f2

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


