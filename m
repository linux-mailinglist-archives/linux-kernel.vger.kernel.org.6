Return-Path: <linux-kernel+bounces-513121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED47AA341CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C8C3AC401
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C2281365;
	Thu, 13 Feb 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRjV4tzV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5101E281346
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456404; cv=none; b=VmsDXc9+evia1Cfzoe0IV3hBjm8wvkGY1p/wEc5vJAleMF6WsOixsvgTUwtCYspuUkTqyk+2UD5dhj9NAVkg+Bwsc4up0Xcp7ZvopttWKwx3rs2cebuIwMs7xAkIkirkgg5uveGBP36alF17Bp9VIgTECRXN/8SogNC6W0T9Nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456404; c=relaxed/simple;
	bh=V8+Clgqse8ENFo8knptwLB4lPlpVnfFwyIe+UDRqwXw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h++eGFGLLyG4ixMpvglQoz1rdt7eZCqm7NwYgRvFse/kNXqAXlfMFVRKDK5k6ho7pxnzUz8XNyOvOa3MsD7ZYOXBAQDd7OuGd8mmzaXD7NiKJ8SKkkivvqU/a3Fue8BkrE9AeCCxQ5y5UHkS0sYNf7RdvGQbP0UoQLi8PNs5zvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRjV4tzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C572DC4CED1;
	Thu, 13 Feb 2025 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739456403;
	bh=V8+Clgqse8ENFo8knptwLB4lPlpVnfFwyIe+UDRqwXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mRjV4tzVPubzdRqCe54H2nXVBR22GW9VACNGUinJFtS7vBw14jHeBcBvEMqpcgtZ9
	 oVxe5eJszmDOazva6G8ixns2nApVyzHxyF0GLDX0IKnmvVegBTWy6qe/WHI4M0w28e
	 lfDVyxv5bDRqFeHhrGull3cqXE4HiOPDk1M8k+c3FnRPYqU3Too3K1VCrAkULkjaYF
	 4yTk7dejENnrUEG1Kk4UpT4o80C0Mz5BP1KHfhomiCGR2x4y8LeRcnHp3wKjUsmHkS
	 rJH6h0fyRHyINX5hvY91eujX10hN800YsvMtTC9LkhwFd2fDYjOcqF8aRWiXXxWZZ9
	 FNeZISWJVOnTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35E77380CEEF;
	Thu, 13 Feb 2025 14:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v2] riscv: cacheinfo: Use of_property_present() for
 non-boolean properties
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173945643302.1243861.3231883828583591260.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 14:20:33 +0000
References: <20241231161400.214307-1-robh@kernel.org>
In-Reply-To: <20241231161400.214307-1-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, cleger@rivosinc.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 31 Dec 2024 10:13:59 -0600 you wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> Reviewed-by: Clément Léger <cleger@rivosinc.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [RESEND,v2] riscv: cacheinfo: Use of_property_present() for non-boolean properties
    https://git.kernel.org/riscv/c/b9524a73725d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



