Return-Path: <linux-kernel+bounces-564920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD2A65D16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642B23AF06E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8291E1DE6;
	Mon, 17 Mar 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7jwGNFM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04C18BBB9;
	Mon, 17 Mar 2025 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237158; cv=none; b=tnGPDhMMSDTO+xhpFDWGzDdl6K+SqOOFfMbCq9qJBLS6lil2sPpccIHJcvS849OyfO+Gt26hdFabgjLs1Jwjsm4DfNI7/3HhTfT2ECXafIXBinHlpsIgDu70WvsdZOZjUiFL2BLk8M55lZQMyvnl4FOGOf4zhs1WWIDecc56g74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237158; c=relaxed/simple;
	bh=nW9nD2UgaxlDSv2ovhhIn+oqtcnE12lT6Du503aNy4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fpdJfsWo8U8NwFL8Ze/XSxh6ivlSC6CghFxkJROsqoJsU4bYXIbB2+9Yf2/nv8zpUgHaqhR0AB9VL/Mo4LLkPY1fxf5GwXz9XePSkTomrZGR01kpDQhERSTZv0xVwkUJwlyu/aCn5hHjOxtwI/yfI6TYjqOxEDbkWBMy6DOBoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7jwGNFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0289C4CEE3;
	Mon, 17 Mar 2025 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742237157;
	bh=nW9nD2UgaxlDSv2ovhhIn+oqtcnE12lT6Du503aNy4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I7jwGNFMsd6ljJEJWB+JAWOqaBB0wqnJAJ8a9/c985vq8OX2AdgAGql7h1evgK+Ms
	 MiyIGu9jLSA8ZFMPUpeiMajJ2NM8hW+FoQdaZBTJ24rFXWbhyjg8cyZZKP6Q8GHkQc
	 Ugo8Y9M/NH5ZQj7Mvj5byyUuWjaGE5WQXjAJqRwHn2f3ZuH5Tpqlf3pHs3kEjqA+fS
	 ejKgNyyD/nF/Dmp2Sa2YTRCDB0Uv71DeThI3Vj/YpfyQexCS5ct7FhYHG9UWqb1+Ji
	 SKlbkCBrqskTmuI9Yh1x+iW8O2cosFWEOcR0CdM/KnNYfo7yNxb9vmUuOFairNsGTl
	 KYx4BnBFdMRaQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org
In-Reply-To: <20250317165845.525593-1-colin.i.king@gmail.com>
References: <20250317165845.525593-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] regulator: rtq6752: make const read-only array
 fault_mask static
Message-Id: <174223715666.285678.3463516965373849528.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 18:45:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 17 Mar 2025 16:58:45 +0000, Colin Ian King wrote:
> Don't populate the const read-only array fault_mask on the stack at run
> time, instead make it static.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtq6752: make const read-only array fault_mask static
      commit: 502d16c0bd8fa40ba194f00ccac4bc205a5c253f

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


