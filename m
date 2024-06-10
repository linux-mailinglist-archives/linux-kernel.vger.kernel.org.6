Return-Path: <linux-kernel+bounces-208693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D58902832
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD18C1F2257B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A051422C4;
	Mon, 10 Jun 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F87/OmRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECFD1DFFB;
	Mon, 10 Jun 2024 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042599; cv=none; b=AWQzm2Qr9Teau7sNLLZfRZDwX1kC49IisYm84emELy7WOD+h0VbxApZwI01GByPus2Tx3xnPTVJ9rwLDT+k8mk5aiBOMdQM0/3A4XXe4dlTY8J4nb9m3ipqiP7Fp2ZfjOMvtLAKC908YuyZa+b9TNySqxlCq0xMLLTSAYlNaLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042599; c=relaxed/simple;
	bh=lgBRGdnoizZmnjSmWakPVrgEZGNpul7avwjxOGtzGes=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PyuHEr0ac5VTv4zDDQbynK6z8G2VEyauIaygUiacptaSdq4y7dkANt6M07aK4aodqA7KCztqMJXZ5Zjdn2QixVdCiLWj7AV8TKWlCh8iKgv1L88qqZ57J9/hAPTnf/kxAI5mWLzZHcllaRh6Nq/gAKgUKGieZgsNd5YlYPf6Jko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F87/OmRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F69C2BBFC;
	Mon, 10 Jun 2024 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718042599;
	bh=lgBRGdnoizZmnjSmWakPVrgEZGNpul7avwjxOGtzGes=;
	h=Date:From:To:Cc:Subject:From;
	b=F87/OmRO/9wJMxBr8lCxSsRHUj+9VS8qmXbLBff+eSpDqEQZMi1p/PmpY/p5d/Br0
	 v6eFR42VhnPx+efjuqI9RTiwp9dBslGiR0WAZDWcdYeGguvUzl2UlF11CKTK8DApLE
	 CSzdy0ogz5aX2TngW3Mu2HYP+l9dSSdju7T00EEOaGKvAxxYsISrf/c288zIBr1V6X
	 D/+PAMQG+Y6eeBaX+pF20UbjJ/4mCDFe2K94eF33UkoLJxfd/nbg5yjobrADxbuhmu
	 Y9THSkzBaaf31b2C+1dioXaLfmnvleLUcGRVAWWjaLCjoEsc61UfQnz8ehCAcCjKSz
	 wSiWNG/QeXFHw==
Date: Mon, 10 Jun 2024 11:03:17 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 18.1.7 uploaded
Message-ID: <20240610180317.GA810381@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 18.1.7 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

A couple of critical bugs were detected in 18.1.6 (which was supposed to be the
last 18.x release) but none of them should be relevant for these toolchains:

https://discourse.llvm.org/t/18-1-7-released/79433

So if 18.1.6 works for you, feel free to continue using it. If there are any
issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new.

Cheers,
Nathan

