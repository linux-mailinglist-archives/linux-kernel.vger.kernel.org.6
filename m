Return-Path: <linux-kernel+bounces-327319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FAD977423
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C88B2228A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913E91C2325;
	Thu, 12 Sep 2024 22:12:55 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73084148FF7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179175; cv=none; b=plqrLPI/RDUQhwFmoriptoay7xfNOlvLd4jM5O8P3XuAxns6/f4v4XClc0M4R5LNxtq+PDM7JBlubMRHEfYZ/RcU9qBPzlqSB0Rrl/CHlG0fWo9FOasRxkgqsZOwB/NcsJxLRRhVYN/ScPzUTFF5YNUNC9M+3fZbfW9f8EjrM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179175; c=relaxed/simple;
	bh=esWmPrK4J3cvVJkCNyOlPvWdAToFHNcs4bRi2lSr5k0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mFM06X09CPMP0FsU8tMXiT3aX0sIDFF5MkOiKy7TUfwHGBRH5LL0YWfSmj5ZkqKRaGKZl1csVBSAQncBFLEQBWqqUVUjyXw3xC+uIrZxJVGsGfxmsX86fpXanAFq+GDQa5We0nPkXJqJ/SszWZ//qQCH29miq1/kBOuU5tuEg2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0360D92009C; Fri, 13 Sep 2024 00:12:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id F13E792009B;
	Thu, 12 Sep 2024 23:12:44 +0100 (BST)
Date: Thu, 12 Sep 2024 23:12:44 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: WangYuli <wangyuli@uniontech.com>
cc: paul.walmsley@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>, 
    aou@eecs.berkeley.edu, samuel.holland@sifive.com, 
    conor.dooley@microchip.com, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, atish.patra@wdc.com, anup@brainfault.org, 
    guanwentao@uniontech.com, zhanjun@uniontech.com
Subject: Re: [RESEND. PATCH] riscv: Use '%u' to format the output of 'cpu'
In-Reply-To: <E4CA32D7942C8637+20240912134946.163833-1-wangyuli@uniontech.com>
Message-ID: <alpine.DEB.2.21.2409122309090.40372@angie.orcam.me.uk>
References: <E4CA32D7942C8637+20240912134946.163833-1-wangyuli@uniontech.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Sep 2024, WangYuli wrote:

> 'cpu' is an unsigned integer, so its placeholder should be %u, not %d.

 NB the proper ISO C and POSIX term for `%u', `%d', etc. is "conversion 
specifier" rather than "placeholder".

  Maciej

