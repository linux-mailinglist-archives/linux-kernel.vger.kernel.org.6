Return-Path: <linux-kernel+bounces-513712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0A5A34DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E0F3A3344
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCBA245021;
	Thu, 13 Feb 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2/6EKH5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416502066E5;
	Thu, 13 Feb 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471410; cv=none; b=NbOjtCl9Syd9VVlVg8CclQDcvfzPt5uK9L4g3jk9Qye0iC2UsPZNTcIxYILOoAH6ESt6Vp6QmOKVsARYpLNc0Ay5GlN6Lekse6vssfKRN+dkrJ5NS8J9pNPe9sPIFIu2PBb6QscO07/R8aB6ENPflXtpQzus02UZTILMGLvx9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471410; c=relaxed/simple;
	bh=nYiLZEWwxEDFeGSrJEI37JBzapCreCcmn3jtv+TxgNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b6RRAY1tukQTjfwX7jwSLZKPU0OqplWgeeWyC8vLST02xnjKdR/cdnPlOckchiRBey/f6wo/pbDk9gpwhOMMQKZVwDTqBdj23pclLkFQatIbTdTuWxLqMcDFsohDpZzJBV1dfhpk3DdUffSViZDPT1k/6qZLeA82rXu9+KGruy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2/6EKH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63BBC4CEE8;
	Thu, 13 Feb 2025 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739471409;
	bh=nYiLZEWwxEDFeGSrJEI37JBzapCreCcmn3jtv+TxgNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K2/6EKH5uuihdFdQQvWelxx30VCvTK7nhJXalWiyU2O70abv3GiMXT3L2xhj0q8Wq
	 aeWNaMrRW3AY+5+tN+6f8jYHpP7qxG/FjF1iR38X+vcwMtVT2naOmwTM/x2PkLOhHI
	 tSqX+mpxJs1FanrGvxBo9JKA8dC3GYamrh7CAqTIhuj0HHkQpeupYT67kD9ae52OHx
	 pn3RJ6kVckQrdbWWuVMYF0Hx6ER9nWDHna+F2Fhg0s9F0w3Td9L10p/cNTG3DA8BDD
	 QZL8IVd5/c6wlFjG7mqWAMU/vXoeaRg11UXLUwEwN4IBJoJbn8RQVRrWTRhb5McWHk
	 kx2IiwM/WyBXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F0F380CEEF;
	Thu, 13 Feb 2025 18:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Documentation: riscv: Remove KPROBES_ON_FTRACE
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173947143900.1330575.12977521291070529712.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:30:39 +0000
References: <20250108020342.4172-1-cp0613@linux.alibaba.com>
In-Reply-To: <20250108020342.4172-1-cp0613@linux.alibaba.com>
To: None <cp0613@linux.alibaba.com>
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  8 Jan 2025 10:03:42 +0800 you wrote:
> From: Chen Pei <cp0613@linux.alibaba.com>
> 
> Since commit 7caa9765465f60 ("ftrace: riscv: move from REGS to ARGS"),
> kprobe on ftrace is not supported by riscv.
> 
> And commit 3308172276db5d ("trace: riscv: Remove deprecated kprobe on
> ftrace support") removed the relevant code, but left out the
> documentation, so fix that.
> 
> [...]

Here is the summary with links:
  - Documentation: riscv: Remove KPROBES_ON_FTRACE
    https://git.kernel.org/riscv/c/ccc71244f95c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



