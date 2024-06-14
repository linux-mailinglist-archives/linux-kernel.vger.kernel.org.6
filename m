Return-Path: <linux-kernel+bounces-214272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40B90820C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6911F23D17
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BA18628C;
	Fri, 14 Jun 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA7FO4n5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6281850A1;
	Fri, 14 Jun 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333431; cv=none; b=DFX7s2qdZzPuhiD4A6z61aRPXI7zrQoLK7LXj4RyBoIZfz5y9J/9l5o9n5onVHAnzGHqU5fztl1maz+YJJmrc1bqieiJdTEFPPHEcZecaWttSIhd4N8VwLFviRipTB52twgEzv2xwGvkInS8p0/3cmfpsgRfz/yYKmw9FRSzV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333431; c=relaxed/simple;
	bh=vLeyleJXO9qZUXlgCU5ArXo1Ekwuie6IV960BGsgegg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eU6+eYu4iKBh8iZlniGo01vzO7E+hFSakuPOH/SMIBMQJRk2I4e7cFR6/GPZUtjpRVa5/j1GCMb5tCblURfCDpWCgLm6agoVtduiUFqZuC4ZhCahCN5qJkYQDe4Ha/WFPMrIU3SR5UeOzhv7uxRIzjcL2iouYDMJMwUaDRybcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA7FO4n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A7A9C3277B;
	Fri, 14 Jun 2024 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718333430;
	bh=vLeyleJXO9qZUXlgCU5ArXo1Ekwuie6IV960BGsgegg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NA7FO4n5l4UhQgNCHoQjKGuhd9Z2IWfRLR3uxqoyLe8nLwAqZio69tDmr6gy06H1C
	 phSj/pdDEuIIRh/7mmv/0csIkaeZali2RilCqwQKQGRylCrk8MKqrlHGiKpuLFAlVU
	 1FBD9cujRS2yb5AnqG0B6M/xbXYB9Rn3F5zE+Aj3Nz4XiD9c7Xk2MZOycI+XmRy1Jj
	 CmQWZX42Jj45LoN6EgaKJYckGr5HqbNsi4UI5JGrVoihTVpX7WKPQJQaWFTcJRDSWV
	 B41RhW39EJsZzpl6kYQfYK2L/lZv49KBI+AcVjBCDvorTV9h90AT8RIuzJ1V+sYj7o
	 p824Zi4hlIFSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14531C43619;
	Fri, 14 Jun 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Handle zero length read/write
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171833343007.26166.13833276204967228918.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 02:50:30 +0000
References: <20240613212542.403-1-ben@jubnut.com>
In-Reply-To: <20240613212542.403-1-ben@jubnut.com>
To: Ben Walsh <ben@jubnut.com>
Cc: dan.carpenter@linaro.org, bleung@chromium.org, tzungbi@kernel.org,
 groeck@chromium.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Thu, 13 Jun 2024 22:25:42 +0100 you wrote:
> cros_ec_lpc_mec_read_bytes and cros_ec_lpc_mec_write_bytes call
> cros_ec_lpc_mec_in_range, which checks if addresses are in the MEC
> address range, and returns -EINVAL if the range given is not sensible.
> 
> However cros_ec_lpc_mec_in_range was also returning -EINVAL for a zero
> length range.
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_lpc: Handle zero length read/write
    https://git.kernel.org/chrome-platform/c/b57cd5703a16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



