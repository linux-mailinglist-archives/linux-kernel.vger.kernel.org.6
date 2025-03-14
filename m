Return-Path: <linux-kernel+bounces-560605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520DDA606FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A44880C57
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DCADF60;
	Fri, 14 Mar 2025 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="B6XOSJ2S"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B3195
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741915126; cv=none; b=Oa5g478zjnHAUHtTma/KEfgWb6cXtcglFWeWUsjaPMqWXXHe6F+vdTFWCYgV9YWRZF7qvVIVHI0yyX6nSRIbu/+xIU4Uht7n0UkkR/z0AhP/bty4d9Or+Wp02mZGdWGtHwjC5z0Ffv8tZbx+nxuoSNuaJQF0f9cFufhm0vlIXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741915126; c=relaxed/simple;
	bh=bvZBVOphAeXvJeC3fuWi6TxH2NcsrlnUVJ0ofZB+qIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMFU9IINR2TC6uYI0Y0hDL418lprMypCEnwoZV0fceFSxj1G/qiD0Nu5hzTbMh6hW0bWSSJWvMmCzJjzXp3OxGOA7KFhQ9GraZ2OIN6DWmnbspVXdsmu3l3ndP0PpPIiJCRRMhYohEszYYQqCnpyeBLgg/JdqqoLMQdSXwedXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=B6XOSJ2S; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ry4gFxfaLIU9dlkpgCTGmswrJ2BJRDyfFewPBEA2HZc=; b=B6XOSJ2SYqe++FqdfY1EjPuGb7
	k1j2NyJhYkUt/P+wvkfSQwYPET0zzN1HY+A+1fp2hEpIw+1LFpqrkQoUUd+elVMlEpcrgAcT2cpA1
	5ZbiADb0ZsaA5YdQw1bKOoZeiw4iku7gxk4xpq1b1wA1kZtKSSov/+Kup44GItlYsE3JhRh5MPIns
	4aHwz1JhJS32XpbsGCs/ywLLbi9z0MkjjhLV43cxDPF3hokrISQ1Mp/w+yETXX8HqjZtl3zJlCmoK
	CRNh8xgRkGHvc7tOTNtyXILw8oDMhPrafMAUZZkHe5SobB6wW5HK5CVk44g4xe01N2beuPW4EWEs0
	LlqDfX0g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tstgy-006Q35-2e;
	Fri, 14 Mar 2025 09:18:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 09:18:28 +0800
Date: Fri, 14 Mar 2025 09:18:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Zi Yan <ziy@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] mm: Move nth_page from folio_page into folio_next
Message-ID: <Z9OD5MsHZnzG4Smt@gondor.apana.org.au>
References: <Z9JhwhMIn4uhkHrI@gondor.apana.org.au>
 <Z9LOzj17FDFDw7JM@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9LOzj17FDFDw7JM@casper.infradead.org>

On Thu, Mar 13, 2025 at 12:25:50PM +0000, Matthew Wilcox wrote:
>
> That isn't true.  HugeTLB can construct a folio which crosses a
> contiguity boundary.

Thanks.  So thea means we do need to use nth_page when iterating
through a folio or a scatterlist generated from a folio.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

