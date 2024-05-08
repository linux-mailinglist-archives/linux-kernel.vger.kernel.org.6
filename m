Return-Path: <linux-kernel+bounces-173175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E71D8BFC8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A121F25441
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514A82D8E;
	Wed,  8 May 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DViiBMBf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFE8288A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168727; cv=none; b=opEIlM2v3Tp70AO7FKqGym+jbqkGqPES59ZpY/xisD08T/4rHgIoZ/+/v+Jwuf/cpQs3QOVLbaXzWmdB/JGCK5J3ZHC++RosttEKJB2/hW7tXNiuMY4el5okUQOx5TaDchIvKu+OJmoUZSE12ELmQiTAf3ovCPY64aq2bCH+pxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168727; c=relaxed/simple;
	bh=MHEpXaea2vwkautiJ1URrZr3IAGketdW3dy5SWhS2M0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TdLwDldRv8LRaZ+eXOpd5ZMV3UFwPG58ieQ4cdqSHC9NdeW0CZg3KGLaibmj37nitHUlOXjvyZTCQs5yGABHUouExCIuc2XjzOhYIouaFChOvsjEyTxGaAM5Qvb9PnEr3fpagokw4+IjC7JxKavepIQJRw2F4DIuGqZE7IbqbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DViiBMBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F367FC3277B;
	Wed,  8 May 2024 11:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715168727;
	bh=MHEpXaea2vwkautiJ1URrZr3IAGketdW3dy5SWhS2M0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DViiBMBf1VZ5FTvixCKuJqmLCMSaC2yxUmCO/DzZITJyM/+wwilX/815f7oClVn9f
	 O4dU6VaaUFVKdeamdkzD8q4XbOA43FgpJI0MKek0Pfz3faY3rYRY0o+fGnrFoCskQX
	 UGq1ayfSF3E7I5yEWH/cpaQ1S0cQmq5HN2OYJnL4MGnsa5E0ohiSZKevMzsG0ExaSf
	 /ll5klqVaa3n9MTa1yFmnH2AvY8Q2ENzt6mHcQn5rDUFmGl58U6E2eySXqkho9i6kx
	 /ZsDAshwpR7Vm9t9PHcAEp88l2nVZX/+wd4NYmCm2VDBhNRlwxnbkITjWrs4W/NjGr
	 Z0mGat7TGyueQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20240507104703.2070117-2-u.kleine-koenig@pengutronix.de>
References: <20240507104703.2070117-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: Mention regulator id in error message about
 dummy supplies
Message-Id: <171516872575.2006327.16231349651539331829.b4-ty@kernel.org>
Date: Wed, 08 May 2024 20:45:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev

On Tue, 07 May 2024 12:47:02 +0200, Uwe Kleine-König wrote:
> With the name that is currently looked up it is considerably easier to
> understand the issue and fix the warning.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Mention regulator id in error message about dummy supplies
      commit: 75c48adfe9b16fc5a468ef4cec4e87a1418c3ed8

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


