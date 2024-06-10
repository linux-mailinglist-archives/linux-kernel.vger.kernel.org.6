Return-Path: <linux-kernel+bounces-208150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA448902183
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3174E281773
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9908172A;
	Mon, 10 Jun 2024 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldPP3ySS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F180C09;
	Mon, 10 Jun 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022035; cv=none; b=GwovlWbqxrYQF/Uj4t/Z7asZVyd6xGeHzbEGRlAYGzeje8CuzELsyYT62ik+BQFbbszcB17C+bE8PWkfO1Hfw8/eYzxksgEnU8VwrJgJNrc7ghontqptVZktIWosQTcmN9g91pqaErYprib0d37uXgljVYtsa67mz5zAvUTY5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022035; c=relaxed/simple;
	bh=dBGtLw+8X5xbuaTdkgiVWJbt1CyU5OtXpJiFTHcoTj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I92xntsdRh7U+umm6/V3pEdKloW0ztZZ5X8xE1h+UBr6BfGPdh74mUJ8hTzy7xMTuwaLpqnIcl5xvo+YewAy+SZcoH33y8EV7Mp4Pmnv49TyFxFillM3kI4aYJUiy1EMXhg9AItSrbzY5OVtNjtIkK7n4SI4CBiAUq8dmugb1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldPP3ySS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D7E9C4AF48;
	Mon, 10 Jun 2024 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718022035;
	bh=dBGtLw+8X5xbuaTdkgiVWJbt1CyU5OtXpJiFTHcoTj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ldPP3ySSj2Ll8Wcwt2xAQu9Zu52A4W003763YlMOStc3ncGkzeOOSIK30b2s6kWBS
	 YpCiK/nFo0HyeSrQZJ8ZpZsbeooc3Eq4BUYm7wMkVXhshHIMyO0hGKySd0ovuYjGic
	 q4P9QQmwUckkreaGXoLuoEaey6TmtFf2pYmZ1bW9Q5BYao1XhIqTDkuIpn7LlJvfla
	 tKXIwRPh1oBusYbhJ0KVJkaS5VHCjgYDJNTgApuqdEEArAyPGuoQ+vaTWu1CfGtftD
	 ROFRxUuUX6gimSUk7HWu0sig3NYZyuR1p2cijk0I55PUd5W8tF703e6Gwyw/OXSOaF
	 1BKvzeHCfDqAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33E6BE7B609;
	Mon, 10 Jun 2024 12:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: dsa: hellcreek: Replace kernel.h with
 what is used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171802203520.2008.17697289847915988722.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 12:20:35 +0000
References: <20240606161549.2987587-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240606161549.2987587-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kurt@linutronix.de,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  6 Jun 2024 19:15:49 +0300 you wrote:
> kernel.h is included solely for some other existing headers.
> Include them directly and get rid of kernel.h.
> 
> While at it, sort headers alphabetically for easier maintenance.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] net: dsa: hellcreek: Replace kernel.h with what is used
    https://git.kernel.org/netdev/net-next/c/c917b26e1686

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



