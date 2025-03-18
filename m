Return-Path: <linux-kernel+bounces-565444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77918A6682B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C0519A01D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF13482EF;
	Tue, 18 Mar 2025 04:19:33 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B93FC3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271573; cv=none; b=u8/wawy62fTdrwLSbVi5Orfm1QyDzPzMYvYRGXZrb0VIWLW6XpxQDbXxFuvUgyNngf2kDoURoBh3haomfaT0vVL83qnioiAr5alKuBasjnx/VfKqLggrrIqB7r4GhwMKPq/kBq063FaumV/698fsp3A6MO4j91d6bIzckirYTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271573; c=relaxed/simple;
	bh=pII1N7bc9duBPXP5BmZ6emkSB47E/v26S7V9abX9bDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTaV9TJYY7D156f/Ajlvx2O6YnT3flzTM+crq+6Ip3j08lBa07YFSGzoVzAQD11ee4zC0j+VaWBtjEL6y+lPvsSj3dLRSgomNbOk4pVh/7tiMn3QvZ9nlGZHTDemQkmwQigzYQ/lh+9KPDvn2vWeRlx9HyuoDgqZS5/40SIzN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I4JJfk020785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 00:19:21 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 69AA22E010B; Tue, 18 Mar 2025 00:19:19 -0400 (EDT)
Date: Tue, 18 Mar 2025 00:19:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the ext4 tree
Message-ID: <20250318041919.GD787758@mit.edu>
References: <20250318000658.29a791b4@canb.auug.org.au>
 <20250318080951.71772135@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318080951.71772135@canb.auug.org.au>

On Tue, Mar 18, 2025 at 08:09:51AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 18 Mar 2025 00:06:58 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Commits
> > 
> >   400bb71a00da ("ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()")
> >   4d6eb75d2364 ("ext4: introduce ITAIL helper")
> > 
> > are missing a Signed-off-by from their committer.
> 
> These are now commits
> 
>   850d8d9ff97a ("ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()")
>   8bffe40e9e9c ("ext4: introduce ITAIL helper")

Thanks for pointing that out.  Fixed now.

       	     	 	       	     	 - Ted

