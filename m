Return-Path: <linux-kernel+bounces-264248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B4B93E0BF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34B6B21667
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC328E0F;
	Sat, 27 Jul 2024 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsw4+bL5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E01D69E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110277; cv=none; b=YPeXbpgmbcm9c4O/k37xUWtqBnlUTfB/aBZhCYsW5a9kkblkTQMB4un0d247VuRtzILlZRRmMrjuZ/g6CMCVGGpB8najePyI1C2RiUseKAHXl5RRPYH170qq9TJGUHJl31T2c+vqzzq6VPkq6MdaxqF+vpsCCg/BDZ67Fy5tgVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110277; c=relaxed/simple;
	bh=hVmuOSIG0RrhsmscMa6x6LwZms1KEmPKjao/X3qEsrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLkBCeibUSOdO+TFfiXdOT9duZEcMrrcAPuXdZlsrucOjJYSQPFlaviNlUGINQ9IoiazP5XReCdzcPHjr7T4aTvlowd+5i+ynPKz3eAFDoXTcy7FWRfIELdgQbcYIqupbBUbTakebUZJYhzZE8DnWkzi8OoFzcRXVzFDo8KtDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsw4+bL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A91C32781;
	Sat, 27 Jul 2024 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110277;
	bh=hVmuOSIG0RrhsmscMa6x6LwZms1KEmPKjao/X3qEsrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsw4+bL54/km2M4gHfJrNOe5GwYXKiIFFVJHZ5jJN0zHWsRIJvleoQiV9J4+6KJ34
	 ZhXKiz2a5J0M9pqjMIAHntbYZ4HhBjNVhL8WueQnEeXEDfCJhlpcBTwdzbrXNO7vQs
	 9G3ryQYBZtYun7LrprBs46xDb6sxnaSTUR4fw8C2PVGWsDsPThm39sTZwZfSpyzZgo
	 jDblFDQjpCDNBDf0zb8h8tuBsDjGCQQc405/ovUAHCs7yitOa5/ofexR/6XXwXnnIn
	 bpoUDhhmH1kRUA4wtw/DSZwu9yXZCrhOsgumrdQHmRl5dFyxYgLbqFp/bN7bbeL38A
	 OFG9OJTO8tsEQ==
Date: Sat, 27 Jul 2024 20:57:52 +0100
From: Will Deacon <will@kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v4] arm64: Rename to KERNEL_IMAGE_COMPRESSED_INSTALL kconfig
 for compressed kernel image
Message-ID: <20240727195752.GA30914@willie-the-truck>
References: <20240726201014.18484-1-sedat.dilek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726201014.18484-1-sedat.dilek@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jul 26, 2024 at 10:09:30PM +0200, Sedat Dilek wrote:
> The COMPRESSED_INSTALL kconfig does not sound very meaningful.
> 
> Rename from COMPRESSED_INSTALL kconfig to KERNEL_IMAGE_COMPRESSED_INSTALL.
> 
> Fixes: commit 4c7be57f2 ("arm64: allow installing compressed image by default")
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  arch/arm64/Kconfig  | 6 +++---
>  arch/arm64/Makefile | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Hmm, I'm not sure I see the point of this tbh. I think the code is fine
as it is.

Will

