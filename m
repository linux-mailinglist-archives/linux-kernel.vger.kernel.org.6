Return-Path: <linux-kernel+bounces-439531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC1D9EB090
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AB1281240
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596021A255A;
	Tue, 10 Dec 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQX9gg5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ACD19F13B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832821; cv=none; b=DSKn6606JsmdKgSDBev60OolBNJjnF2GScGHael2Ns1Sysd9Jn41iLRo6eqHD06YHZes6DFJsmXbuq2OpZddKFet5atH/bJczfx40KyD9BBXEGAlB8PS8RhtttQ/ift24nV4A16jNbCHYnDxJY+ZchDMsq9r/t4e59WIYZEcQu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832821; c=relaxed/simple;
	bh=7cv4cgSj2LINmoadvDIPepo0a1M0FarsbVRgQxREo18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIrq0o7OO+qRqCg/T3g+N891KXoKue7eEKhO4ONFWr64lxDIGnCTMrezXo+frl0wGiG1CvM5ljUgJyNUhAqye2BzoxFFie2E+1h2XPTpO2dXtrnqnhdHlDNVNDbwuaZT/UyFamhwQEni79kbDZso+ABFtsvArBA2YPYiQzQFtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQX9gg5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69271C4CED6;
	Tue, 10 Dec 2024 12:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733832821;
	bh=7cv4cgSj2LINmoadvDIPepo0a1M0FarsbVRgQxREo18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQX9gg5A/cfEinEC7qVx1Wv4KAIGgjk2nFwPUsZJXpyvH5Gv/LRW6lR+EQwFzoNwF
	 FnzLW/CkSp3R0ofgs88/bo6Z9uLruoX75LkXkzMdptgm4kDYSJZoMKZlAFhK85kNCv
	 e1O00GUdWPu/JOY7ctO+pxPHhC0QwvNyaexZVsX4PwXJAR5kuWrxPNANp1MMC0be4P
	 uNhVJVG9kQgk8+/U0B+r0iIhjnk65BHouhvWuIwE5iLH/QWLb3GvcwdDmhbYtVtzwK
	 /i1ZtOUtUYd8ix64wolX8fxfJ0V4r/SHu/80il42zq5latAJDTAOFWFe+vVuqVIHi/
	 S4RYed+AjFasw==
Date: Tue, 10 Dec 2024 12:13:37 +0000
From: Will Deacon <will@kernel.org>
To: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove duplicate word
Message-ID: <20241210121336.GA15428@willie-the-truck>
References: <20241120045406.21537-1-RuffaloLavoisier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120045406.21537-1-RuffaloLavoisier@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Nov 20, 2024 at 01:54:04PM +0900, Ruffalo Lavoisier wrote:
> - Remove duplicate word, 'to'.
> ---
>  arch/arm64/include/asm/pgtable-prot.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please include a Signed-off-by line so that this can be applied.
More details are available in:

	Documentation/process/submitting-patches.rst

Will

