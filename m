Return-Path: <linux-kernel+bounces-361381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9DE99A76F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE0D286874
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0D1946DF;
	Fri, 11 Oct 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko2m0s3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3928684;
	Fri, 11 Oct 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660193; cv=none; b=Dgn3xY5TiTlTGwkC/5quehwnFDanEZZw8YzvSIrQBzU0dO8fUSRA6o0qbeITkvT3/hUgmPD+b9XTuS0knE8zjox9aFt/natdRfXsX74EmhJprw0kJyAi9vgRLUjs1/VHFWK955GwNpaZ8COW6aZka6M0vihe0Xd9w/6XVz9hXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660193; c=relaxed/simple;
	bh=5abdJcObkDYdDf1K/z6kROdkKSUOOC7rXUKVxc1vus4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MIan0KImpuVnnBc9XqGzxso/b/74gafxLkqRPlYigGBHsil8N5VO1ZUj+6bs8hpVLPr4jQ4rdb2I9cu0TTSvF2NDLnGA4bR6a2aVozI/jlh1/TjG5mabmfvjKUQboKFBqA/AiirM4eS5pYbxBwgJPfT6pz9fhXYZbZGiywSP+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko2m0s3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F5DC4CEC3;
	Fri, 11 Oct 2024 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728660193;
	bh=5abdJcObkDYdDf1K/z6kROdkKSUOOC7rXUKVxc1vus4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ko2m0s3ibgGUNKGBHO8670XxIQ+g2knJ65EwMK0XSAo3+QHd05iWVR8n0U1PuTvgC
	 MXiqHg+i7EZYn+l/Yo31EwvsGvWgJmoFfKYgr1IP2hwp8W1NYwod3ykmbn+KbgWjDy
	 bfQ1WUqAVomEQ+ehH7i4l+o4MXXQJhHvNBIiapw182AXXf7H3krY4zMmysKumVFE6w
	 QptUClE+/WMQ3X+Mbmv94WLE4CbFRgZT9Wkw3o30I43CxXS7VBa4xat3oALmmsGVw4
	 cFFzBFmp0ii8W3RTCkzdST/oNuCulDt7Qrib6DQqFJ7XD35U2UqJ34zbgUw+WB1XKd
	 13sM6pABmPoyA==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, "Everest K.C." <everestkc@everestkc.com.np>
Cc: skhan@linuxfoundation.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010175755.5278-1-everestkc@everestkc.com.np>
References: <20241010175755.5278-1-everestkc@everestkc.com.np>
Subject: Re: [PATCH V2][next] ASoC: rt722-sdca: Remove logically deadcode
 in rt722-sdca.c
Message-Id: <172866019117.3915434.7963769393055061429.b4-ty@kernel.org>
Date: Fri, 11 Oct 2024 16:23:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 10 Oct 2024 11:57:54 -0600, Everest K.C. wrote:
> As the same condition was checked in inner and outer if statements.
> The code never reaches the inner else statement.
> Fix this by removing the logically dead inner else statement.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt722-sdca: Remove logically deadcode in rt722-sdca.c
      commit: 22206e569fb54bf9c95db9a0138a7485ba9e13bc

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


