Return-Path: <linux-kernel+bounces-337964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F84985191
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E1D1C23237
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ECE14B08E;
	Wed, 25 Sep 2024 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7a3609T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86B14AD3F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235688; cv=none; b=NvY5qqcDLmcb3iCjUdcJF0i0W+W32pz+ZJwtPbHxuyOnM0qt78Gl2eET0td10YTJAWmHiMfM7p8m2jzAUa5FsajDLSnVqfuGRM6y47/bGe7M3GYx6EIAAQXmOjE+rjmosdP2g9h9vR9jV1/uuGzBH8dqM/QDIXY333/pqr0V3bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235688; c=relaxed/simple;
	bh=Xce3UyyGKlz+3jg4rHmmMiwwmv+9dBnd289UDXz6Hik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K5UOwssjL9xSer5lftgQNp4XuFCF8COSza69ytxR4cWRagBdIb0te2cqu4yY5nX0ttNxkflL71BDVulQEvIpmO0r8F9eNuYIQjreOgcaZsEzxn7L63YPvALA7/U7Cpo7OIB9Ty09fpzMeYgzEeokcFRmuft9a8Nn8XncXnBkQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7a3609T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E35C4CECE;
	Wed, 25 Sep 2024 03:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727235687;
	bh=Xce3UyyGKlz+3jg4rHmmMiwwmv+9dBnd289UDXz6Hik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p7a3609TEJhik1mwSQt7x/NJ8qqpriX4ccJviepFHCZuj0q9sLmTXwlinr9xIif9q
	 Le0phncemRRwx/UbTAf/V2EZrVJVrCYaMm31KAIpibtMP01CEOcWxQXo1wtOYRuW+J
	 P8KItNkkb1wkRpdQLiR+yQ5bGznlZT75wT949R50JrMXuvO9b1lz04uZG19SA55guk
	 DVb6wr56YP8hXX8nh6STo4z7x1fR5RaJLC6xE2hMLVW++4sR3NhFDl64pS9p1m2vzp
	 waVOwcZPedegSQZLE5mh4NNVDSjU1dnHS2i7nqznqnN2nfdqmfZXrwp93tmo636A/z
	 EcE/cfeR4Ho1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34597380DBF5;
	Wed, 25 Sep 2024 03:41:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 6.12-rc1
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172723568980.97387.2632105381881398970.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 03:41:29 +0000
References: <ZvInHczHWvWeXEoF@google.com>
In-Reply-To: <ZvInHczHWvWeXEoF@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 24 Sep 2024 02:42:37 +0000 you wrote:
> Hi Linus,
> 
> Could you please consider this pull reuqest?
> 
> Thanks,
> 
> The following changes since commit c813111d19e65b6336a6352eae9c1ff5c40f722f:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs for 6.12-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/79952bdcbcea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



