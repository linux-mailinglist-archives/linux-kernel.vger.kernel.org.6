Return-Path: <linux-kernel+bounces-322043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C46D4972344
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEE01F242AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E18018B47E;
	Mon,  9 Sep 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7rxi6DB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A42218B474;
	Mon,  9 Sep 2024 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912515; cv=none; b=PJvJiviHBObYb1vMLzh5ORuUZJUk4zyrFF5JDy3p5xxUxLZqyAe+3n6RSm/JjaSx8W65ko0p056v8vZ1oLOSmR7IDteiD5Y650E/R5LHBcvKrEDQm7aimmSj5gtHBlNVtTy/nWDRBATiXhtUJj7E1BKdu5spwKbVr7htH3UT01o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912515; c=relaxed/simple;
	bh=RSL8rK9M+0+000gkIhOfhVy0hPI7m6w7XzcYGaicM1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=La52bxZZEP/Hoa9WgxtWhz6TtbnT46mR/tljG0Xs3Ajdtr1aGyb1lHInpxVoFEbSTJ0auC5vrMR9hrxcRisi8dHGGKO4lo2Cyk33vbV8V2M+No/unfBWzdY73tWrLXhWbrZKfGtbo9QwbcShglCJE0KNs2HU0HxxXko1nHWcb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7rxi6DB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739E9C4CEC5;
	Mon,  9 Sep 2024 20:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725912515;
	bh=RSL8rK9M+0+000gkIhOfhVy0hPI7m6w7XzcYGaicM1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M7rxi6DBsPbRl+qrmEgeS9o1gWI1uVxbXg0jneskyxyIs1x78tdHeVxiKnOPNsQRQ
	 o8CKrjsWRhtmVTXYA8m1JvN20V9VYXi1+zm4/eL+dqh9ZF1G0G+5fAEZaytOayY2aF
	 nwX6rpNjxeQnYMf5LRTAZFaR7ZINFgyVfc9SB7jBBtJfwHn/S486LOMvuQQeJYwbom
	 Um+LPlfBdX0sNEoYLkM0udexMztZ5rKGmALiTsjUEo6Yr54Sb1C16Jt4AqRYT+gqW3
	 9gJbvV06VT5OFwGTr8tuCQlTJ77bx6+WQoSH3h/tBThNlUMjrXiocIi3Weqjc7jHCt
	 7I8WTCB/uT7VA==
From: Mark Brown <broonie@kernel.org>
To: Saravanan Sekar <sravanhome@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <fd8d1307f211ec7754f46b6678c04309556003bc.1725807320.git.christophe.jaillet@wanadoo.fr>
References: <fd8d1307f211ec7754f46b6678c04309556003bc.1725807320.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] regulator: mp5416: Constify struct regulator_desc
Message-Id: <172591251419.127770.16591249074261510379.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 21:08:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sun, 08 Sep 2024 16:55:58 +0200, Christophe JAILLET wrote:
> 'struct regulator_desc' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    3516	   5320	     32	   8868	   22a4	drivers/regulator/mp5416.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mp5416: Constify struct regulator_desc
      commit: 97e63bc35f4c086ab7ad3894c9693e18e79162d9

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


