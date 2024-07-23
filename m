Return-Path: <linux-kernel+bounces-259978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5677C93A0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D51F23462
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A3A15351A;
	Tue, 23 Jul 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ4/6nre"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F715253B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739517; cv=none; b=oNl424ZAaPRcgY7lpcOt3gQYWtbOPt3IQgsDRxTgHyXwMcSgcopYDf36iM0gxIiLQrOfE4/rerzQn4xBETJ1IORdiSexQWWGmBjqFKmOoKcQlUYI0WjZPw7X5yLyBcl0onGnAzCJkEJCFiWViKhFeRhSulbAxiA9/3yN4hlUmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739517; c=relaxed/simple;
	bh=5hpcvR5Xt4goAw6G6QK1Xdoz4E8OWx4TKQcPvVsWF+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FSw+xvzZSJkRx0O+WCSJqSNjt7KEr7wkFdjtejTS/MOXKWgqj+4KY1cueSEgcBVCuKdnoJLbuj3vxxXvJ0suVnowgjUr/l25E5Dm/dZ1ekG7PDI54LvegeTakE+jwsz2D/Fn5V4G//wstswV4CxtwIa0r7NoLxYdFuTxjpt3YdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ4/6nre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87E93C4AF17;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721739516;
	bh=5hpcvR5Xt4goAw6G6QK1Xdoz4E8OWx4TKQcPvVsWF+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mQ4/6nreWGGgfLtTxtTa3Os9GZzMWpBKQpOYzwhNm8QFYH1ZOYh80rtGH2QppoMTy
	 ah/k5+rCTJZMEH07kbBSz37fAYC//ZiUfwdpTCIWo/9J/LT0KK2v3QPNl1Pp33bU3D
	 jD3bJrXIXWDI3KvoT9iIr5zWAH7vsJKjlvHxXjA97xmNIPR9RDF7oWMBU10Uto2WBP
	 RSYytsBqF3Wzrm3VlZC05Dj1GFRKBhndJP1XCrf9Z3Wn1tTGdAUJ9W3UV7Q+gMQ+X8
	 VBpyXh/zmpwtDup5b0coB/AW27Q+Je74OwK6NDIwNJFL+BVbwfHgfNgxitSgdBPpPW
	 BN2lqv2P9GNEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F55CC54BB5;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/4] riscv: Separate vendor extensions from standard
 extensions
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172173951651.10883.11801254450675807570.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 12:58:36 +0000
References: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
In-Reply-To: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor.dooley@microchip.com,
 evan@rivosinc.com, andy.chiu@sifive.com, linux-kernel@vger.kernel.org,
 peterlin@andestech.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 19 Jul 2024 09:15:17 -0700 you wrote:
> All extensions, both standard and vendor, live in one struct
> "riscv_isa_ext". There is currently one vendor extension, xandespmu, but
> it is likely that more vendor extensions will be added to the kernel in
> the future. As more vendor extensions (and standard extensions) are
> added, riscv_isa_ext will become more bloated with a mix of vendor and
> standard extensions.
> 
> [...]

Here is the summary with links:
  - [v3,1/4] riscv: Extend cpufeature.c to detect vendor extensions
    https://git.kernel.org/riscv/c/23c996fc2bc1
  - [v3,2/4] riscv: Add vendor extensions to /proc/cpuinfo
    https://git.kernel.org/riscv/c/9448d9accdd8
  - [v3,3/4] riscv: Introduce vendor variants of extension helpers
    https://git.kernel.org/riscv/c/0f2425411101
  - [v3,4/4] riscv: cpufeature: Extract common elements from extension checking
    https://git.kernel.org/riscv/c/d4c8d79f5199

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



