Return-Path: <linux-kernel+bounces-563844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D35A64989
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4141D189881E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A723A9B8;
	Mon, 17 Mar 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACnyNqcA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB023815D;
	Mon, 17 Mar 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206664; cv=none; b=DLxCb88xlamSQYkJWStdDlxRVUM9yRZl+I2UzxQ1z3OPJ4Pfv6oRKFjjt6ckfPcXWlXkBdBk5LgJ7Sk3sn2paUZ7pU029nm2biX+rdr3n/rOG50qNmo5p1yZYLBwGHzcP8W8q+lvgxcfI+EzDH/wE/5qJhrea+eeetZFdM0QNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206664; c=relaxed/simple;
	bh=K+dT2OqwlrGWuY5J0ybeS+cjfkByhT15PrV3fcSnIJI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cQTwUkGXduMfMX69BQWxd0VTXRLY6eC2edkz67UHQUFcg+yz/bOFI4y38LfcCfrJ6v2oqzQ8e6rHnHhD6mp5FeWMcNfAHLwaqiPpmJuGN23UGiLrZAa6ADxO7AeBFGwqYau3SQH8CRxH5lWIXu27n7iinRIpsG/7Qf8rj2kUE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACnyNqcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8385C4CEE3;
	Mon, 17 Mar 2025 10:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742206664;
	bh=K+dT2OqwlrGWuY5J0ybeS+cjfkByhT15PrV3fcSnIJI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ACnyNqcACMkiGKUG5rsXV8dVU+AVCYr/QSjZ+7Nhe36DXRgWi1VkxehDPqNNaUozM
	 IIFDLPJXAoVMoi+9oFlSZ3apmJRSBFgW780zbUCU8mRvyQN7vU2sMBorSFl2NQypTK
	 hj/KT2IWvCQhtSkJRC+O5Jme2sC4Ksug/OgRGhI95/9kH1nt6fTirLrm2fSCrjrxz7
	 1OWqSz2vAoO//x9RRF56sC3CLk8IcobsrUp5GHJX5Dh3dP1yw1d3wz2ha08rNhl8uR
	 5WA0eWw/JgVX0/F0Un1JGhup3YclG/D9pjpEw37+qO5gJKetc8QJmxVRsN8yH2Jlqm
	 QbRbBMhOfNjEA==
From: Mark Brown <broonie@kernel.org>
To: kiseok.jo@irondevice.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Chenyuan Yang <chenyuan0y@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250311015714.1333857-1-chenyuan0y@gmail.com>
References: <20250311015714.1333857-1-chenyuan0y@gmail.com>
Subject: Re: [PATCH] ASoC: sma1307: Add NULL check in
 sma1307_setting_loaded()
Message-Id: <174220666253.86423.2465322150839880396.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 10:17:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 10 Mar 2025 20:57:14 -0500, Chenyuan Yang wrote:
> All varibale allocated by kzalloc and devm_kzalloc could be NULL.
> Multiple pointer checks and their cleanup are added.
> 
> This issue is found by our static analysis tool
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sma1307: Add NULL check in sma1307_setting_loaded()
      commit: 0ec6bd16705fe21d6429d6b8f7981eae2142bba8

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


