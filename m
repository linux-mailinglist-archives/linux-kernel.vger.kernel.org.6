Return-Path: <linux-kernel+bounces-330888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3228797A5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662E81F29D25
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F1015AADE;
	Mon, 16 Sep 2024 16:06:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B815A876;
	Mon, 16 Sep 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502808; cv=none; b=rfGFiZOGke/RtHr3k9KiBeRFlIVpGH6sUEmuaEgDsV2DmWlFYAdFTTSG8dviyPlPuRXZbyDwumBj5P/3fsSsoZ7cDfsj0oFtNMbZhJ2LAgG3GC1G1FpKW5kJI/SgT+CycRpfxVooHQhyvBN78R/JmUBdLZhWGkJwUVVvyfZ15AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502808; c=relaxed/simple;
	bh=hhus5HA0OQNV9tB/IzLXvfJrYy1c5KgPeSHi+94cWn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAQikCHjobetnWVWzKxE4yrdduJgJGMMoMeKpM3PLm7jhg8W19aegHZnGOI3FBijaNNZuQ1SngI9oG+7Ni0XeVG5xu96NV5qydmtXAB36UZSlb1KbFJQ9RUgn3EnNzwhF7razLib0EOIG6G8SSBV6cMxWUSstRQmxGbw/xnmF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3126C4AF09;
	Mon, 16 Sep 2024 16:06:45 +0000 (UTC)
Date: Mon, 16 Sep 2024 17:06:43 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
	Yann Sionneau <ysionneau@kalrayinc.com>
Subject: Re: [PATCH v3 1/4] Consolidate __memcpy_{to,from}io and __memset_io
 into a single lib
Message-ID: <ZuhXkzGJ6QHpdXVp@arm.com>
References: <20240910134341.2537407-1-jvetter@kalrayinc.com>
 <20240910134341.2537407-2-jvetter@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910134341.2537407-2-jvetter@kalrayinc.com>

On Tue, Sep 10, 2024 at 03:43:38PM +0200, Julian Vetter wrote:
> Various architectures have almost the same implementations for
> __memcpy_{to,from}io and __memset_io functions. So, consolidate them and
> introduce a CONFIG_GENERIC_IO_COPY flag to build the given
> lib/io_copy.c.
> 
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>

The code looks correct:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

