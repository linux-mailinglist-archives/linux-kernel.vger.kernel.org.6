Return-Path: <linux-kernel+bounces-242796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F172A928D47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80530B24E0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9916D33B;
	Fri,  5 Jul 2024 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbqLDmGY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B41F94C;
	Fri,  5 Jul 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202670; cv=none; b=l8k2kDHxYmZcggw5OEMFeKd1RJGdmWnmWurKLYbeNc64Eurk6zwPuPHSgFrqjmsNwssa/Ag2ME544aK06f+eDETQWHFLbiOXP79Z9Ju1ZNFBwWEowzjMUa1pSPKhpfj1SwzuFxU9wIu4FawzIbNhJAMOfKMZ2fyO4+AWdAbJLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202670; c=relaxed/simple;
	bh=oVA9Y3iprymzKBVonIx4sBSh4HyDYrRJCjzGW54LtzM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EsAITHzh7jkrHOvV+nHdcGknP9lzMs6I4uhQO3xRKPYyvlFdOCAX6KUVhvhanbuWzaws5YJfBWuQx0JM0exkTJLdemeKgkFjZRdgnms9LrJrtD7qmRTvHza5vLZn02ekuOOvajRbZrwZbLGdKTpnqkp8tW/binm8/+PxUzO/Sug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbqLDmGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008C8C116B1;
	Fri,  5 Jul 2024 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720202669;
	bh=oVA9Y3iprymzKBVonIx4sBSh4HyDYrRJCjzGW54LtzM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IbqLDmGY8O+Rz2gJ0DAGUO0BsihwVxoFfkBITX5XQt0G07vj06XrZNs/rUx2a9bhG
	 LqgGa9jC9m46urPwXpKzk5EaY5epduNtoSPGj0Jh4cuUNhilimaPoMKNqGZlITEVZ4
	 CRJgS6ITQwwAQN1ZRsPYoNmXOeU2brbAM+iUlIyHDMKTgkLuSRaW0YsiOT87QsXnmk
	 P28FZRDDfcKsQS5kPYZ9Y6KPhUtaJboEhy/fWguhDIMB0HD+emCyO93wNW830Ey2f5
	 lXsTBYpiHSIr3K0P/ItFijTxvNoQiti6NzSVWEyf886ZVYs7V/Jnh9Pwu36Kr/wE6A
	 b9HLyax3Wh3bg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Shenghao Ding <shenghao-ding@ti.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, perex@perex.cz, 
 tiwai@suse.com, 13916275206@139.com, soyer@irl.hu, tiwai@suse.de, 
 Baojun.Xu@fpt.com
In-Reply-To: <20240705064846.1723-1-shenghao-ding@ti.com>
References: <20240705064846.1723-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoc: pcm6240: Remove unnecessary name-prefix for
 all the controls
Message-Id: <172020266771.58587.7899074000705853915.b4-ty@kernel.org>
Date: Fri, 05 Jul 2024 19:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 05 Jul 2024 14:48:46 +0800, Shenghao Ding wrote:
> Adding name-prefix for each audio controls is a redundant, because
> name-prefix will be automatically added behind the control name when
> creating a new control.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: pcm6240: Remove unnecessary name-prefix for all the controls
      commit: ccb367c5ab5814bb731eb517544a2ba6b7c3b689

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


