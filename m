Return-Path: <linux-kernel+bounces-322044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FF3972347
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7CA2867F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD018C000;
	Mon,  9 Sep 2024 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlS4rOXx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9A189B95;
	Mon,  9 Sep 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912517; cv=none; b=fUExuI6MrmILP/5/ViaIhngjO0dnFH2aEtqgggeplWl4oJhalkaeMFAuTYmuBYC6mtsJ4QdihPw8P6JcW6olhfxcOWwmQEUbLYEPDM6RLMCLBW8y/eR867ix65aAZ0tRWkNtdzkpnDNN2jnEBoh6s/dcOONjk9PXu9tb4l1gddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912517; c=relaxed/simple;
	bh=C4zDe1A5VTIL8iAyQvoyiHCNJ1fLL1JCgVhP0BOhBOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gFY3GmQVN/5kTDs6Zn1dYA00WsBQJVP82O6yvaQsNKynhzhhmp03+MuRLt4ZxLIgW8okk2AMV9/GdMovYJhvflTihc6bcAnzRND9yfImrX8SZ6E1iyIJQfs9LE4rPKTVYXnRW7LW7ZUN6RSLhFHKmvPaiKTAbmF7ZPJTcV1aFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlS4rOXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDADEC4CECA;
	Mon,  9 Sep 2024 20:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725912517;
	bh=C4zDe1A5VTIL8iAyQvoyiHCNJ1fLL1JCgVhP0BOhBOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rlS4rOXxU74UAWvfzqWY7autHXMFvhCYItA22/OdaUFBMwtFVlUL1gabn1OnTdYb7
	 K7BzTmDwCQcGHy2otbYJY5Ta8JdU8/sGZtgGUZNjPTWZLLoSgZM+ln7wamu092AihG
	 DX6HHvr0b/Rdk+u4ZbDxKe6Y98w4clF1bMeEgrzro34HYTe9s+nfh1puRfQ9IgKDrq
	 XtIK/ocd13qM47o35iL6LKZzomOXsMZHdHmAGJFmA6Y3oivWHNive44/gJBXHU8Wx2
	 Tt4vUNZMHA3XQjuGso6af4wINVzsGzfAD70LWbFGF5ZFl8NRU7yt3ypa53xtQy6nC2
	 iX5/bpbZ5Prxw==
From: Mark Brown <broonie@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <54258bfe11112d70d2f1eb1deda2791eb9ef99c1.1725784852.git.christophe.jaillet@wanadoo.fr>
References: <54258bfe11112d70d2f1eb1deda2791eb9ef99c1.1725784852.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] regulator: da9211: Constify struct regulator_desc
Message-Id: <172591251569.127770.3107235861067404635.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 21:08:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sun, 08 Sep 2024 10:41:11 +0200, Christophe JAILLET wrote:
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
>   13982	   2118	     16	  16116	   3ef4	drivers/regulator/da9211-regulator.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9211: Constify struct regulator_desc
      commit: 0c0966b5019f97e2af0ab802c1453162748b1166

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


