Return-Path: <linux-kernel+bounces-442265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065E09ED9FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0C1881364
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B420371D;
	Wed, 11 Dec 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpKNGYUJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B91F2C2F;
	Wed, 11 Dec 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956359; cv=none; b=crDkzdGoAMRFX10jAVjFt/SbllPkgows8jr3ZFm/N4nUxZkfUTjfn5JD6mXk+Mm2NSAJQsyBYh9qg7ARYo5i93Z0HabWO9ZYA8XLfGDXdZFb//17IdR4ygRmO1ke24tPMkzqmlJIDMQHHl/3C2+VVeOo4AbwOqu/drQ2qLLDcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956359; c=relaxed/simple;
	bh=Dtby0qiULUFzZD3soDB2ZMr1AJrfu0wubG7oLHi5HuA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GSSpMtyrCtTq4eoB1noWmYSEdyuNP8RA4RBOaLWpR3Veoo3PWP+MA8hEDC1bHMv3aeu7aVWYZTy48Fe4iUnQeMID1Kmy5yIq2+Q+4pRjvGfxLKXNkVqIWZoEaUG9/dUSwdoU9VLRfc1SNAPSOODJM/Um7QX7YkThRSrOga6SlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpKNGYUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5076C4CED3;
	Wed, 11 Dec 2024 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956358;
	bh=Dtby0qiULUFzZD3soDB2ZMr1AJrfu0wubG7oLHi5HuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GpKNGYUJHmYhkwBIdn+plUspHkFn0Zm8KfkjOjEsmfiPHLnb4H4Yb56CIsvTo6G3G
	 ro9RBbL5zJiakfLk7m7UodiGc2RsH0EnwN/ZPRQLgc17XoqXD+LtyuZthWWBgdEzn4
	 j3Or1LkCIf5Y1jeXRr5WHQ+ennorEs4Rvck1khiRUEO3Iv+46FlOpuMAUFg4rPOaus
	 bjVornFwVeBvkNGjhAVruAVtvygQ3KGbMrtbE5LbIgibGdUbhG5AXoAu3YYdYDMzxt
	 fBoOsk2KwL/VBSzheIgRwl4MtUE3yunXOfKzYmQ/fqdXslhdbhWk3b/CTFjJjXq0Fl
	 wz4UyZjCFfOBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD3380A965;
	Wed, 11 Dec 2024 22:32:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs/zh_CN: add the translation of kbuild/llvm.rst
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395637500.1729195.10613393812752938273.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:55 +0000
References: <20241023153235.1291567-1-dzm91@hust.edu.cn>
In-Reply-To: <20241023153235.1291567-1-dzm91@hust.edu.cn>
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: linux-riscv@lists.infradead.org, si.yanteng@linux.dev, alexs@kernel.org,
 siyanteng@loongson.cn, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to riscv/linux.git (fixes)
by Jonathan Corbet <corbet@lwn.net>:

On Wed, 23 Oct 2024 23:32:02 +0800 you wrote:
> Finish the translation of kbuild/llvm.rst and move llvm from TODO
> to the main body.
> 
> Update to commit 145082ebfcf0 ("Documentation/llvm: turn make command
> for ccache into code block")
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> [...]

Here is the summary with links:
  - docs/zh_CN: add the translation of kbuild/llvm.rst
    https://git.kernel.org/riscv/c/b934bc754265

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



