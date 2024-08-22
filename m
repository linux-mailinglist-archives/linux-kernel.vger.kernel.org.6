Return-Path: <linux-kernel+bounces-296922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A70A695B0A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517D31F24AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB2717BB19;
	Thu, 22 Aug 2024 08:35:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB81802E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315725; cv=none; b=Guvrl/zwrhY0ejMz+CPNNlQ/J/nOjcYM+++OSvL6PNfLdc+m3lSjNDF9j4KPGT85wCTdeOia/fM1lc0tC7dH1aW0JpA9k8RI4df8bdsJwTGUKge6L2ukshANDo81RwsQ/jFEuEgWmX130tQXiPgU+QsdRWveH3Am22QcTpE84t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315725; c=relaxed/simple;
	bh=YqLcyFL83zLUuY5IZksXp2ynpkDkgNmftEiAc6BJwdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHir3STg3nNLtZvgFUCFPLEmRD/G2oDvgAkueBKqJWMQzwH1Jlf7pq3LwTLPV6KwEEEdMa2mWTLFmQqIDKx57wmLlv+Et015poFBYuL+O7xq+UKkmRlKhkv6R4YZCUdAHNaDzjtDQsbyUUzGDDJEREoG0wrzctFdARXWvTgosYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D041C4AF09;
	Thu, 22 Aug 2024 08:35:24 +0000 (UTC)
Date: Thu, 22 Aug 2024 09:35:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/kmemleak: Use IS_ERR_PCPU() for pointer in the
 percpu address space
Message-ID: <Zsb4Sv7NksEhRH7c@arm.com>
References: <20240818210235.33481-1-ubizjak@gmail.com>
 <20240818210235.33481-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818210235.33481-2-ubizjak@gmail.com>

On Sun, Aug 18, 2024 at 11:01:52PM +0200, Uros Bizjak wrote:
> Use IS_ERR_PCPU() instead of IS_ERR() for pointers in the percpu address
> space. The patch also fixes following sparse warnings:
> 
> kmemleak.c:1063:39: warning: cast removes address space '__percpu' of expression
> kmemleak.c:1138:37: warning: cast removes address space '__percpu' of expression
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

