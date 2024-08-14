Return-Path: <linux-kernel+bounces-285795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A79512E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFB52820CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918C3611E;
	Wed, 14 Aug 2024 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEn8GL0A"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B533D8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723604856; cv=none; b=AyY84w9LqtQb2e7HMvEiAQszySLLeveUPkXcWslJn1X/NlDYJafDVR3OzjGj5k0/DtnXT/EU17H0bwfSdz719rbfN1qNyy5RdPntSyzQRde+CV9Y2Y0E8RXQzdUPPBAmkm/0bfro6UvWNIkeYla8kg1j4vrR3a4kpVrh0H50DSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723604856; c=relaxed/simple;
	bh=ehcXTtIsRvWsTJpwepDKVhd3bW//F8/wErpWQEowDJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0dmJzR7vsU42OE/DCXQZKvPlvqjDhF80Xb9vPxS2/EdApXPgDZUNXMCHAMIE+knUhGQVaNs4LPEAXSZ0wfvCoZyVY5ZNlR7hrMitZNjy++sLg0/gL/aEXEigj91N85Ft+u9caBAEf6yzQIVRAJbvx2R295F4+eBgxXyaSNpvC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oEn8GL0A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4tUIIV2u+4BW/cpTHPofPM48I5VDRU+DyCq2ynBKo3w=; b=oEn8GL0AJ+jNE9+8CEi4lzKfrb
	7pMvpCSRdh0xWIIh6IgwaauDW8RZoFlHObRWguKP6JxUeTqW8yy7JUgojFM8KEGxoYOxrsP7hi14Z
	7+IiRQZs1tio8pKFWFjT1wdJ02/vE/UUkRsEpBuokEhMw/q1xcpgkJ+uqiTRRjG/ohjfuGOmpZbGZ
	JJiQFyNgb5h7Rj7oJHpD53t6GnEftJpWqi/VewHJFCIQymm7T5hO7VChblYjs++Z6IgbklnEcsfvk
	mcaCYnJE2ZUE0BrnOlpcj0xmCMlN43TVGog3o6uqohO123LiaWGpgCn1VtVDzsw6sB9i/mrokvQcp
	GfPzxk+g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se4MC-0000000HR9w-0YEA;
	Wed, 14 Aug 2024 03:07:28 +0000
Date: Wed, 14 Aug 2024 04:07:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: clean up kernel doc
Message-ID: <ZrwfcFr4vN1Hnw39@casper.infradead.org>
References: <20240814022509.3806-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814022509.3806-1-richard.weiyang@gmail.com>

On Wed, Aug 14, 2024 at 02:25:09AM +0000, Wei Yang wrote:
> Went through the kernel doc in maple_tree.c, there are several points
> needs to be cleaned.
> 
>   * kernel-doc should start with '/**'

No, wrong.  These are static functions, and the documentation for them
doesn't need to be kernel-doc.


