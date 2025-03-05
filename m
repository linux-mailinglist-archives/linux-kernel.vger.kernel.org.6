Return-Path: <linux-kernel+bounces-547698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D47A50C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88392171BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F42B255E43;
	Wed,  5 Mar 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKf3Mckm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B0254B10;
	Wed,  5 Mar 2025 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206416; cv=none; b=tPNf8BaIhRnbHDmrS42n5nm/odSbryeNedMOVq9BYdAX5sPNNQTwq39WJUq+zglxN9o0fPikqFJqeUrbKlUzzQN2BpbIn9AQ5cbQAl8zOEo9b7PA+TNEUCrtTNLh6F226rVze9dl+as9QUuTGLH7k0S1ZTKtCIQrde7rAexEvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206416; c=relaxed/simple;
	bh=JEFJDp2hZxLOrBDwuUNK7mVx/nx9Vm2rrb1sSMLKFsY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CWeGiwQKJbmkXEh92D1MtD9jyB3wp+F4TVxeUg1m4CW+6+1m92nP60K+9UxCGdWBlFQVZ9Z79BWCTzw/tByvb1h0ZtabiWjwzwfsOFd6DcKOxCSMVbGkwWZSuhMYhOfY6pSWyLLanKXDvRX1ExiO/l2w9XP32hdZA5ZD7VeHKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKf3Mckm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0E2C4CEE0;
	Wed,  5 Mar 2025 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741206416;
	bh=JEFJDp2hZxLOrBDwuUNK7mVx/nx9Vm2rrb1sSMLKFsY=;
	h=Date:From:To:Cc:Subject:From;
	b=sKf3Mckme/ViMkNIGclmOLzZ/SYtj5BLD+rozrDKVa+uTzogH5yfkoGzy4/PkWpI7
	 WTy/axxCf45m6LrZ5Hzs3hIjdrfq4k/X2Pl3swqYRyXaoAN2d0j99cRqhJRvlqpbQN
	 UJfqeYwUuYJbTxm3VDVD7qjvRlBMsf5QR0GSzD+NAAPkRHJEsVynvB60QYxkRs1dUI
	 M+bj9rRI1knYqY9xNg5wA+bXeJI0wl+ks00f/du5QZfcrbgM4ABmnYHGcvKo0yBlTd
	 dwvo4FotFbtcEV1I79uvzI6fa71uvFsD/bqS4un6+3IOF+vWe4MitY903XpENgHMmA
	 NLRchPM49qw1A==
Date: Wed, 5 Mar 2025 21:26:52 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 20.1.0 uploaded
Message-ID: <20250305202652.GA2791050@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 20.1.0 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 20.x
series is no longer supported.

Cheers,
Nathan

