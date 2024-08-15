Return-Path: <linux-kernel+bounces-288031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C211195314F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3187CB22EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820CF1A0733;
	Thu, 15 Aug 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbyaF5U9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33FC1A01AE;
	Thu, 15 Aug 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729949; cv=none; b=lepQTj654cvJ9Bojey6OqZ9ONl5xXgbVWDhurDYD6lo9rYNPDcDkeBvqVaSGw1g7vNVEvWTISpVYxlly40wc4o2GarCtQ/c/1nUSPoXHu7ilRJSMvqxKgVPPkcEzL7efhqs8uTuT751rynpJRlxiwpTk//KxUyaSF3H2NdODor8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729949; c=relaxed/simple;
	bh=ibNntRJVFxbQ+yZWo122ZBUpmjx3d0ByVkW6+HNnPw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LjLfFRkJrTX3qcF+FObfhsj+W+KlqYxahBgPUnhbMj8XsioFi93gJ7YeDKSai0vFeJSflQgy316skKQIstbeVreKDw4MsC7/qYWCFHgTSsUZPmR9IemnSUCfZYTImMwehTsR33jLZKdsAEny3ol1AvZFJh6DLO+V6OeciMOKmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbyaF5U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5978DC4AF0A;
	Thu, 15 Aug 2024 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723729949;
	bh=ibNntRJVFxbQ+yZWo122ZBUpmjx3d0ByVkW6+HNnPw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hbyaF5U9yA1cgUxB2kgD+hCbKRRJsKglBhVOCbyBeZ/d5BoG2yE+rSRVkOlwYZ4rU
	 /mmXMHH2Tcf5ZjvU1YSADTj2ByH4/FSd+RqWnEU6p2h+SOwAlg3TbUXXWek7MWXxKb
	 j5mv3dKCy2QYad40K2Be9qrY9CQDHBada9i2VcjXe7yxv5eNGuNBHLLVmEvsuP3HTV
	 8XkauGmmbhj4XMISI68+RiK0BoVC7ZxhyeSYwfor/Of7ym819IRwy+IxKBf/PkoQEB
	 n8l6c3xA4mfVmj5pXZ7dDNdKNtuAUU57TRrNqKuYxiYocCXcD6L/SNn0iRp5k98KTn
	 CUwkkZ7GTKznw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 tangbin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240713153428.44858-1-tangbin@cmss.chinamobile.com>
References: <20240713153428.44858-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: loongson: Remove useless variable definitions
Message-Id: <172372994809.42484.2642656660990650698.b4-ty@kernel.org>
Date: Thu, 15 Aug 2024 14:52:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Sat, 13 Jul 2024 11:34:28 -0400, tangbin wrote:
> In the function loongson_pcm_trigger and loongson_pcm_open,
> the 'ret' is useless, so remove it to simplify code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: loongson: Remove useless variable definitions
      commit: 60b5c173f5542adf020f5235db7fe5e5fa4ae0d8

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


