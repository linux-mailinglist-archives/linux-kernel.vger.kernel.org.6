Return-Path: <linux-kernel+bounces-331716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D362997B070
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5EA284179
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB68119BBA;
	Tue, 17 Sep 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvkWVfFB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D213C836
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578040; cv=none; b=W7dPR5ukULSreRVOjs1S0oDF3xxxeAqsEFj8veAEr/KdvWE38KhCqQHnU/D7wdqgg1fpq53b/quWQ5udD4b9Y5Erws6D9SgQN2y9telsCscmDHIPTK3ycJl99iDIXrBNQnYa9DsbHmj8ZdL8wBiOjSgPz51Fr7CR5Jm3IIDd0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578040; c=relaxed/simple;
	bh=9Gsf0XeTsK3+zxYmz4SLt9TBXmm12cmW+FmYYyde/jQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kKT9ubEe8g/LjumdvM1gj0vR9c1Jv9KxI93mbiVhHMG0G++sXbJd4jDJMjzBTAAs7epu3tcXgvFFy+B2q+rHY5nzVwD8deMCjEAetl2Pl49Us16LKtiPL01ZldFOIblV7NPjSylaHAQLnx8wX6MWzKgWu/e9Z1ZgAj4ztBSjzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvkWVfFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87200C4CEC5;
	Tue, 17 Sep 2024 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726578039;
	bh=9Gsf0XeTsK3+zxYmz4SLt9TBXmm12cmW+FmYYyde/jQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XvkWVfFBS0yGxri4DBZK0wb2fwA+bChCszfYIaQ38iEC1L6LmIpDcynQwBwm5CzC7
	 jDglvcv0ZaqHVtH90QrKlFTnoSacoTaZAcGpQlpXtv4x+bKEuJSXVtk9n+0y6MAeTY
	 Opd5GLMGdyo8oDis1gDU7/IuwK5h9hqS5JBV5FJC8/dq6nQ0Uy1IgWwz+lWK7Nq1+O
	 YxrdGDkJkJu100j/Y+7FQJGntQN81sx/5dK2T25JNnAK2O6uNf5YCLUUBOiCoHfRdX
	 jDkZ7zP8fpwPcHdvNoJpTBMMfvCvNQ5mF8dKo+mY5NGET3zHU3D7hf6gZDlPPolu4p
	 Oe8YGz+PsLi/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F743809A80;
	Tue, 17 Sep 2024 13:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: define ILLEGAL_POINTER_VALUE for 64bit
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172657804096.126252.17380283904864990104.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 13:00:40 +0000
References: <20240705170210.3236-1-jszhang@kernel.org>
In-Reply-To: <20240705170210.3236-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat,  6 Jul 2024 01:02:10 +0800 you wrote:
> This is used in poison.h for poison pointer offset. Based on current
> SV39, SV48 and SV57 vm layout, 0xdead000000000000 is a proper value
> that is not mappable, this can avoid potentially turning an oops to
> an expolit.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: define ILLEGAL_POINTER_VALUE for 64bit
    https://git.kernel.org/riscv/c/5c178472af24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



