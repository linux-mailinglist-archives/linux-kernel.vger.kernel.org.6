Return-Path: <linux-kernel+bounces-576075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE79A70AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DBC1889C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED771F12EB;
	Tue, 25 Mar 2025 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts6oedkg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05281CAA9C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932140; cv=none; b=dWrnCIi9A7LlOEamHveCYErwOed/E2Wq9GL7JQJfyfj6mldYXLghm3oRNQC79BIgj2NsUi86Kq+bey4NEgG2MkyDlKrtUdwuHuRHBsZGT6YijZkrnS0LEG2J5LthNEnYNgyYPRoU/q7ey4uOpkigcO+Vh4zTxv+7M3ptFRMIgUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932140; c=relaxed/simple;
	bh=T2tfIj0EMqxgBkrFEZ8g8NogOAZa1Xyq2LGTgPKCosk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUNvunqxixqkdwO32OyYUPWABOhO7tlsP2Cizv6ZvvitKpE4y3S45YKpGf6ijIJFxi7w+Fu2qTMCGy35LycWQdF6vVmMBHpG0QINXNwGEtcNervYvmP+DKLMm2XDMzSceGxqeo/LZ8qIX6XEmKcEtSeBQ0wwmWuaQvYWa/Xo6ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts6oedkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43231C4CEE4;
	Tue, 25 Mar 2025 19:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742932140;
	bh=T2tfIj0EMqxgBkrFEZ8g8NogOAZa1Xyq2LGTgPKCosk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ts6oedkgny1/hghDURxtPRinRxWEURcWTacNJv5E8lF1HzjvjXFbjQi2LMdWEN7ht
	 XVFofZhWEaximlufpe5XG9Bhsrc+OEwRBaHCXjfS1/vP0XWzg+9IyTgG2iHuXmp9Nv
	 EmNS2jdABTQhekWa/y0y8/GETjy7MTlyVU8l+nRa4QKshJd87JzGFeOoVwaLm7jnDv
	 lJOH570C0vdIkoJOP/DUxwV4HDvbGPkbxuTPc+Jzb9whIM6/yPWLtw5vsHiiIB6zow
	 zEqPrGdJW+lmlv2k8O7e59WDn87zS1mepzrhEJ85Knk9XGe4D6qkJ8GcOiOtAMECoa
	 0FQZSxLbIA1oA==
Date: Tue, 25 Mar 2025 12:48:57 -0700
From: Kees Cook <kees@kernel.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "tamird@gmail.com" <tamird@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printf: add tests for generic FourCCs
Message-ID: <202503251247.086BD45C@keescook>
References: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>

On Fri, Mar 14, 2025 at 03:45:01AM +0000, Aditya Garg wrote:
> From: Aditya Garg <gargaditya08@live.com>
> 
> Format specifiers for printing generic 32-bit FourCCs were recently added
> to vsprintf. They are going through the DRM tree alongwith the appletbdrm
> driver. Since the printf tests are being converted to kunit, this separate
> patch for the tests should make it easier to rebase when the merge window
> opens.
> 
> Link: https://lore.kernel.org/dri-devel/79FA3F41-FD7A-41D9-852B-D32606AF5EB4@live.com/T/#u
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  lib/tests/printf_kunit.c | 39 ++++++++++++++++++++++++++++++++-------

Linus has applied the kunit /lib move tree, so this patch can land via
regular trees now. Who should take it?

-- 
Kees Cook

