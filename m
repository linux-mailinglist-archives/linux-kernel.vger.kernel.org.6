Return-Path: <linux-kernel+bounces-230717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4AA9180FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245BF281BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CA6180A64;
	Wed, 26 Jun 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpV14F3C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB7D53B;
	Wed, 26 Jun 2024 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405447; cv=none; b=bxhKl5Twn1yd5hsVF/cCySjmCZ7z3mo3U2r4cCNupvI00Vdhp4YvrEUENUP/nNax/HGibfRpyQitHiMz8wyt/DIR3aS5v9ckNzZuUsALWk2bhoYfMkUdRddf+Xho8GmiKwS6csWR79K9b8tWq93WyJnrJdbE2kIrQ8VfGLy3veM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405447; c=relaxed/simple;
	bh=pQb/7G7/wHAHw21/xcFGrhcwpBfvJ00H8L5TVaEoaIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nXISJlk9jXooqjd9i3EwGPMyNfNrvol3bmTHG0DcGJKmXtEGUqgWkkGUsVzZVq1rQoykxYKpiWwNYZ/AWZyxc8KP6CMwlH0PuG+1oNSEGMn6Wjf/phDa8/N6QW8/g9q7mxMR3aB3L1oSMqREYcg3lv3L6/8rdhNqN3n2ox4LDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpV14F3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B85C2BD10;
	Wed, 26 Jun 2024 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719405447;
	bh=pQb/7G7/wHAHw21/xcFGrhcwpBfvJ00H8L5TVaEoaIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HpV14F3CDcfzkuE0MFodrYnh9P0lMSTXD0wKXrqklcoTw3PXD6bGYW2Day0fYcF5A
	 MpJ2zClXQ6X8evyNRBXSAKhuVAsZKVu3vgHbXKMrwXk0oL8cZ6WBcUPjadXxyzVfma
	 bvA7gPqLaFiq3asvjSrFwMiPrX3NOSMSbydCbluPe+j0Lom7tvSkR20X5F3jbjxeHZ
	 xPuNCeGuzwksuLqwgXVVs+ywZw+R2hrSgPHQhT5OgmaL/qZIiMkInZNLnW+SGEOdA/
	 ICTe2cZobv/F2gnlZQhGp7BUISWjKXxouTaMm9ddsg7wYgNflN4qlDei1jGigBWrNm
	 Bvsigvt0Dcd2g==
From: Mark Brown <broonie@kernel.org>
To: mario.limonciello@amd.com, linux-kernel@vger.kernel.org, 
 Vyacheslav Frantsishko <itmymaill@gmail.com>
Cc: linux-sound@vger.kernel.org
In-Reply-To: <20240626070334.45633-1-itmymaill@gmail.com>
References: <0e571211-8921-4548-a093-6c5719c866c4@amd.com>
 <20240626070334.45633-1-itmymaill@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA
Message-Id: <171940544619.1360002.3077526009321111718.b4-ty@kernel.org>
Date: Wed, 26 Jun 2024 13:37:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 26 Jun 2024 10:03:34 +0300, Vyacheslav Frantsishko wrote:
> The Vivobook S 16X IPS needs a quirks-table entry for the internal microphone to function properly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA
      commit: 63b47f026cc841bd3d3438dd6fccbc394dfead87

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


