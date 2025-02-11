Return-Path: <linux-kernel+bounces-510197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDD4A31999
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C95E167CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B2F263887;
	Tue, 11 Feb 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKLL61fw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD827291F;
	Tue, 11 Feb 2025 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316886; cv=none; b=KxIDfQUf1wHdUvHjVjBbDZxkaPI3UkE1/L9Je9As9hh69Ea+mC3bLIHn2dYTqq2QN6dxco2NV7DckyIis0ix6SarqHp+wlDR0rlJjTgpE+vzYjMk6u2ZIza2Wwysi4JGe8ON0dUmMi4wLNJs47WcjhBkDL/PPFryHUXLlfVA8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316886; c=relaxed/simple;
	bh=PXjOkztQtS20D6Nh1IncoMXQ5YlWhRlg8ZJHVtBRdtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9k+6awJu0UfUGWNrgzwBPTJrqdHC/K2GWn7OeQpuKlg6G1AauRiw41F2r1qBJzD+cF1DdXIW30P4x2ufi44dDC4naRQ/pHur+DstKcumiQ2boQNFDYARa8dR1LoEQz8qpSssu68r8rYvC2vwTriATGS9t8rkxOEa0ZyJQEOPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKLL61fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B85CC4CEDD;
	Tue, 11 Feb 2025 23:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739316886;
	bh=PXjOkztQtS20D6Nh1IncoMXQ5YlWhRlg8ZJHVtBRdtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKLL61fwRbfWBU4Fm1uWF3wSUkGkVyN4BcEy6w45cicRmzuTkyvVP6B8ws+bi6srS
	 twx1aTHOjA9SrFr1dE6qi2MByeLocSUuAwW1QbkJKy7GscJBE/2yYWG3HC1wjRoWHq
	 2WAk+GT26ywwzvsYqAQrMx2AIzVVgIEEDKnbfkriUJ8lQ5KP98awdQ5IcdnyacKXqv
	 3PnOMmQ3+WLO2Iw5URjBwIECbOyMK5jcLQsA9qBgUJru+RlkQrFGjSuaD1WZgaWp4Q
	 gbJkI+UslNwsJGrh8aJZnguj2CiAfFjfQw5MoF1F6WDXfZoIeOT+YCh8tAslHtvdCk
	 FQb+MzoKqwzbQ==
Date: Tue, 11 Feb 2025 15:34:44 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kexy Biscuit <kexybiscuit@aosc.io>
Cc: yangtiezhu@loongson.cn, amd-gfx@lists.freedesktop.org,
	chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, peterz@infradead.org
Subject: Re: [PATCH] objtool: remove duplicate case value R_PPC64_REL32
Message-ID: <20250211233444.nt6nvks4jim753bk@jpoimboe>
References: <20241217010905.13054-3-yangtiezhu@loongson.cn>
 <20250211141956.553850-2-kexybiscuit@aosc.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211141956.553850-2-kexybiscuit@aosc.io>

On Tue, Feb 11, 2025 at 10:19:57PM +0800, Kexy Biscuit wrote:
> In arch/powerpc/include/uapi/asm/elf.h, R_PPC64_REL32 is defined as a
> macro to R_PPC_REL32, makes the case value here being duplicate and
> creates the following error...
> 
> arch/powerpc/decode.c: In function ‘arch_reloc_size’:
> arch/powerpc/decode.c:114:9: error: duplicate case value
>   114 |         case R_PPC64_REL32:
>       |         ^~~~
> arch/powerpc/decode.c:113:9: note: previously used here
>   113 |         case R_PPC_REL32:
>       |         ^~~~
> 
> Remove the duplicate case value to fix the error.
> 
> Fixes: "FROMLIST: objtool: Handle different entry size of rodata"
> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
> ---
> This patch is required for this series to build on powerpc, however I'm
> not sure if it's the preferred way... Please advise.

If there are no objections, I'll squash this into the original patch to
avoid breaking bisection.

-- 
Josh

