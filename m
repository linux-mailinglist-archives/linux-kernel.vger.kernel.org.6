Return-Path: <linux-kernel+bounces-266126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780C893FB7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F3EB23356
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02090186E35;
	Mon, 29 Jul 2024 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCzN9v2g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767D150981
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271180; cv=none; b=Y6G2CibJR5ihOZkluBWwwDGL9lUUSSd7Xyjh9gY0J2wIv6RgTqoUt9aIqTmHaHY4MAymmz/NG9gcKud6n6ZNqJJMImMVMABPZWKU9FJ4+JuTTKyEG4OBm1dWhmtb7mooiCMEBphBcS2KsH9SqKP00tpV7pHJNI9JDx66aMjQ7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271180; c=relaxed/simple;
	bh=tV0WP6zuukv/K7rpCEKp9CjVyvve7l3T8OQ4RSahhJA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vfa8r8scW4MsZRqPV/JlVLa81AzzmzeDgn5o04zRHlE8Mvlkuin+EeoQW9T9dceb4wJMrvBMv4wv51Y9XzagFaOMfyAEU6uJC4KbPgF0YJhdw5gOthevbkg015xTts6c5N1Ft6Kw1SUEvAW0golJoJsU09Os3rcZ2qTmNAptZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCzN9v2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2731C4AF0A;
	Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722271179;
	bh=tV0WP6zuukv/K7rpCEKp9CjVyvve7l3T8OQ4RSahhJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WCzN9v2gTw/VXhcnzDeDSTwz3IOxts6+aG/u1k3IUN8HNNTS6E3qdvgkUB/vjLb2V
	 wWGyJk/Im5VCJ/TfiAnj+rQ4oIXTVoUAggkZdUCLJW15u2uzcEvzRpX4ng97U59mMO
	 mJ0llnZYgLLOXoQQrNFPe+CaAIZZRgw6ZRXoCXsYfP3Xrajf+uUlhxG3/b9yUSXApm
	 qbDRNCExeu74cYZvak5zlSR3Tcish5YKTDh9kMUT2A5ldLGrtkmv6w3Dgief//IO9X
	 GZxkEbHXTSJRulnR7M7gzmMXnfurpbMDoWMWXisooaga9+qr+Jjxa0O/Q7nsyRRxr0
	 jflGvgmgnphrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB457C43443;
	Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Remove unnecessary int cast in variable_fls()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172227117982.3603.14088911643823119013.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 16:39:39 +0000
References: <20240710202416.710880-3-thorsten.blum@toblux.com>
In-Reply-To: <20240710202416.710880-3-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux-riscv@lists.infradead.org, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Yury Norov <yury.norov@gmail.com>:

On Wed, 10 Jul 2024 22:24:18 +0200 you wrote:
> __builtin_clz() returns an int and casting the whole expression to int
> is unnecessary. Remove it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  arch/riscv/include/asm/bitops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - riscv: Remove unnecessary int cast in variable_fls()
    https://git.kernel.org/riscv/c/fb9086e95ad8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



