Return-Path: <linux-kernel+bounces-322136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D98972495
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE1E28557C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D76618C936;
	Mon,  9 Sep 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLfXetRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8018C91D;
	Mon,  9 Sep 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917731; cv=none; b=r1E2WjfFH8dWm2fYA4jUneTaY8hnkK5wLr1JkVnR34L78ojsAxWzUZYlFWLdTfTgWUVDCj4AXAxwK1qL6aswQfiB4mgJH7sbUR3xy6UzESC8WKHLepAed69TkBUTjtaedhyW2jlI6tTya6Lfvm+a6fi6bgcT9ZAoNZxbyohooVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917731; c=relaxed/simple;
	bh=ABb+ZfLdlG2gN2f3g7xwpoPiZYnjKAV1QkEg+j4S0Ao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OvYsgebwpPaITYz2P40XN0wt/h7dbteYnqFmqvYTcfRbYplIKfTpPLuYm6GUSob+5yLMlA+bc/i8w9xFJBhZUy7mwWDR1j6lqJa2R2rVB9ECjehi5BAhtFLAq47urK25xkqnQ/zc82BM8ptZRT/Z2+gQjLNXmAFYBeje5gsrc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLfXetRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3B1C4CEC5;
	Mon,  9 Sep 2024 21:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725917731;
	bh=ABb+ZfLdlG2gN2f3g7xwpoPiZYnjKAV1QkEg+j4S0Ao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YLfXetRZaE+IlnMKFzAHZRjZcgvbDyjuJ9meGmHoDLtuxxMwv50dWZZLfudtNl819
	 CagTeOSoc2ORs4UpMDtZ9U6F44rUrPM1YY4pJ9iGzkUA4z31djT4bu6dHEoA71rz2H
	 VkVhmccyf2r32Wb+BAnechbw2JtMSNV6vgMhp1UWllrmdMMVdowYpXm90QKVf5P+Ne
	 0OOBFtpx2ky9pGNT2ISEVGCXuY4mq3sjg9t/n+ASxqDMaXvwip7M631UhPl0FBm/nr
	 VFnek6n2mUHuXAiThTgA2APL50SKBJI1SL5bCvJfjZswSpwDjYlvmIRADJJAlzte3b
	 ibktNe/S9VYDA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <7727e493490d37775a653905dfe0cc1d8478f8e0.1725908163.git.christophe.jaillet@wanadoo.fr>
References: <7727e493490d37775a653905dfe0cc1d8478f8e0.1725908163.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] regulator: tps6287x: Constify struct regulator_desc
Message-Id: <172591772999.144124.1097678117910341898.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 22:35:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 09 Sep 2024 20:56:19 +0200, Christophe JAILLET wrote:
> 'struct regulator_desc' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    4974	    736	     16	   5726	   165e	drivers/regulator/tps6287x-regulator.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps6287x: Constify struct regulator_desc
      commit: 63a68ee1c27f5d1a17b78a2c937b86b0fb1fd99a

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


