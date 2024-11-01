Return-Path: <linux-kernel+bounces-392269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A429B91B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DE4282054
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC59C1A2653;
	Fri,  1 Nov 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFCIfRxb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CB1A2574;
	Fri,  1 Nov 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466945; cv=none; b=g4Nswyd02iWENfZB8ZXfrygk1tI9sFXf5gEla/H+c+V6ENLhxFpqaRxfzqTWbQxr0m7WGY6VIp/ly9ojOShERGeDe1xQOAVIlfJcDfD1Q1TxE7u5ES9QtAwKzibLZfw/8ijghdWTHvlxoGUN7wbDMqaXpnxzDU6idnMyTwbMm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466945; c=relaxed/simple;
	bh=oLL1uzPvimChNWEDE6/41svef1qbVUPXSlsEc5NuqtQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i1X3/btuholK/lEWiCQxd/adKzjlW2BQ7zh3byWWaoSDzVJSVN91ui6tcLa+ojKtYyT+PNe+kqQzgkXrYThreeOJ5ERhzdKrTs8JtgoYFDTxqKxHvlMvLedW4OUDb0hyyis4DU/TzTorANywmI5WU3AD0UbV+adUs3satKyG95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFCIfRxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4764AC4CECE;
	Fri,  1 Nov 2024 13:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730466943;
	bh=oLL1uzPvimChNWEDE6/41svef1qbVUPXSlsEc5NuqtQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JFCIfRxbzc4Kj1DlE1BObUCtLFOgwSlFug34rCtDmM7tjKBadLV0pGF3hRG7zepzh
	 XLqkSuHD+qs7UDoMXL7PCXfcpJ/bfBFP0VzrGf/G/t55r92btGhh7YwuWA08qfE6sB
	 rakOdw0MkHqD/mK/DU+G3Ykrib9XIqVzZTYIjrz/SkioBrBjcg+EaA4vrGe6Fs6Aqp
	 H3XTNetVig10WTpWZly3mJx0sJ1UX/FQmzLoAfmnVgP8zTouXfw30ldwUhC9s+7Gmk
	 B/bkbXECJG8xBnkB/GAcm8ohNKvGa3Ptl0FYc9jppRqv7Nh+lSiJZvrANwHF3APLI3
	 BGWFdudHjNgGg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, corbet@lwn.net, 
 anish kumar <yesanishhere@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-doc@vger.kernel.org
In-Reply-To: <20241031035829.54852-1-yesanishhere@gmail.com>
References: <20241031035829.54852-1-yesanishhere@gmail.com>
Subject: Re: [PATCH V2] ASoC: doc: update clock api details
Message-Id: <173046694202.38444.10908151912961323882.b4-ty@kernel.org>
Date: Fri, 01 Nov 2024 13:15:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 30 Oct 2024 20:58:29 -0700, anish kumar wrote:
> Added ASoC clock api kernel doc in this
> document.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: doc: update clock api details
      commit: 019610566757a749dde7e0c92777d2c1613afef8

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


