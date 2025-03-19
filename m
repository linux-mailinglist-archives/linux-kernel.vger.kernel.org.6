Return-Path: <linux-kernel+bounces-568512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855DCA69699
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CB93B21E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F41F09B0;
	Wed, 19 Mar 2025 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liRBXYMP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB051DE884
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405714; cv=none; b=SjeXcfzfv12x7jxJbYYXac70eMcUjhFf5RLpFfGSMp2UBhCUsTqhobZK3zmhsDPmMiepTYDuAoYOKziGQ66/ZIXTN6Rnlot+TlaehCR3+YQqUA5iOi7MleR+WNiKb29nQuX9PwpbpMHGWj1v1vd7pW2BQxe1vQx8qKHbpv+tHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405714; c=relaxed/simple;
	bh=JNUN07cRPn0TPgSak6GRsxqp2qWClwLpBjypESPh4HQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dFhqM21afGOUr06ivPpGTB+gzQNI8bcU5twxHwgarsF5oRCpkM1vdQq16cK+nDiFWzU4kkHAvBW9nTULBXiRFVQeJ2/lwEwxY+IvUmgj8E/PoKTw+GxdoVsBRtCobeeeXcp2/+tzTsxJSjrJK8KnElzCdYU8TkIs+2sB3UGbPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liRBXYMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FD9C4CEEC;
	Wed, 19 Mar 2025 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742405714;
	bh=JNUN07cRPn0TPgSak6GRsxqp2qWClwLpBjypESPh4HQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=liRBXYMPYrHGt8jG0kr78GxyqhK5CeCu3slfT5O/urmXCZJ3/rzHJkT49mAVuoF+3
	 swdFgCJCnGgCh4NqT6twcIW3pRIlQSVO0jbgY7Mrm82NRdR0HMuK5PmwmduV8Jbts5
	 tRmAGBgbJtyfW4ltHfQTGbc4w7YB6EKGeuiAn1p32UyGxFHzwof5sRzHs4NgcFjBX2
	 ZzR4rP1NkRnTRT1wi86wyqUYz7f07SnfEkLalCGBer4Fq5MTN/k8LYfxi3toLo8NAk
	 FE+JMBhrrICCcAM8tss8ixHiWWCKxvvx17g1nxMj2JfFgDNffS7dFRUqT/MLMiOTC4
	 JjIpmOVxEQKnQ==
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>, 
 Philippe Simons <simons.philippe@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20250318205147.42850-1-simons.philippe@gmail.com>
References: <20250318205147.42850-1-simons.philippe@gmail.com>
Subject: Re: [PATCH] regulator: axp20x: AXP717: dcdc4 doesn't have delay
Message-Id: <174240571334.230528.16981469717358901046.b4-ty@kernel.org>
Date: Wed, 19 Mar 2025 17:35:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 18 Mar 2025 21:51:47 +0100, Philippe Simons wrote:
> According to AXP717 user manual, DCDC4 doesn't have a ramp delay like
> DCDC1/2/3 do.
> 
> Remove it from the description and cleanup the macros.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: axp20x: AXP717: dcdc4 doesn't have delay
      commit: c94764d3f4e503c0c4d56c8f64a8a63645091898

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


