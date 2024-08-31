Return-Path: <linux-kernel+bounces-309655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F4966E70
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 03:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7A21C21F35
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF383249E5;
	Sat, 31 Aug 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQRJ6MOd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25323FC2;
	Sat, 31 Aug 2024 01:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725067728; cv=none; b=CwcaIb2wLXozuNjoceBLnQ6OcEb4YX3gDURPGWf2Ff758wYDCGcltvvJ6YeSlYRtVPHQNBpv6o1jGxzDdMYhGpOG9f+4HSgtVDB7k50C1rwJDzqCKu2HwiWMo8uJhzij1rBb49BgnHZo7mKIcaHZgqMTnNAESj0FW05KZ+lri04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725067728; c=relaxed/simple;
	bh=/oIGIDZx1EL02vEkq3oxHjcflX1plTu8Qt53MH7r1RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP0mU1/QfDt+CbDSRcb7lQyskS21UKN8t6iwjlZW7es36slweOjytCbPUBy/j6cZ3jm1LLop5E/ETzk2EX3t1G0A014s+wNChGt4zLkC8n8omvKGz/NT9lOngO63Dp8NBDF/UrXvJ+6en6xmHdELTxOlty3X9mTW0s9uYb4JfQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQRJ6MOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE424C4CEC2;
	Sat, 31 Aug 2024 01:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725067727;
	bh=/oIGIDZx1EL02vEkq3oxHjcflX1plTu8Qt53MH7r1RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQRJ6MOdEtrMwpjTXOeOKZjY7iYkZVdKz/t1kSB2S2micXC7NijpqBiChwUeMXAfB
	 VuoHIXO77FXSh8wHPVmXu8mYY9ZAfd4NIqxzm1PcOFQYUPNPVGnsAKtTtoKUrGfFsw
	 pa38RfrH6AGyeCsBCyWJA+xqsjc3uTF0fj2756KF/bIv50NTP94a/mR79qUaivVhV2
	 ZSRTnttMSClZJRzb5hsEgpDmEskXgtTWkJP+UUavoqhePADZ39of7LxokpQtsi7drX
	 XL8aTaV6dB1ID/toAVbcMwU9Rju4iQY0GarEPljT6Iup5ESUVj/HBoq8g1Kvf7mst6
	 KqDrYD01NjWQw==
Date: Fri, 30 Aug 2024 18:28:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: lib/maple_tree.c:330:20: error: unused function 'mte_set_full'
Message-ID: <20240831012845.GA2993938@thelio-3990X>
References: <202408310728.S7EE59BN-lkp@intel.com>
 <20240830175015.3569d261b0d48d46eb6ec1cf@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830175015.3569d261b0d48d46eb6ec1cf@linux-foundation.org>

On Fri, Aug 30, 2024 at 05:50:15PM -0700, Andrew Morton wrote:
> On Sat, 31 Aug 2024 07:42:38 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > All errors (new ones prefixed by >>):
> > 
> > >> lib/maple_tree.c:330:20: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
> >      330 | static inline void mte_set_full(const struct maple_enode *node)
> >          |                    ^~~~~~~~~~~~
> > >> lib/maple_tree.c:335:20: error: unused function 'mte_clear_full' [-Werror,-Wunused-function]
> >      335 | static inline void mte_clear_full(const struct maple_enode *node)
> >          |                    ^~~~~~~~~~~~~~
> >    2 errors generated.
> 
> afaict these have never been used.  It's odd that this was just detected.

I don't think it has just now been detected, as these functions have
been flagged before:

https://lore.kernel.org/20240503160821.GB3960118@thelio-3990X/

> Should we just zap them or is there some reason to retain?

From the above thread, Liam and Matthew seem to want to retain them.
Perhaps just wrapping them in '#if 0' and a comment that says these will
eventually see use would be a happy compromise between outright removal
and doing nothing about this warning?

> --- a/lib/maple_tree.c~a
> +++ a/lib/maple_tree.c
> @@ -348,21 +348,6 @@ static inline void *mte_safe_root(const
>  	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
>  }
>  
> -static inline void *mte_set_full(const struct maple_enode *node)
> -{
> -	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
> -}
> -
> -static inline void *mte_clear_full(const struct maple_enode *node)
> -{
> -	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
> -}
> -
> -static inline bool mte_has_null(const struct maple_enode *node)
> -{
> -	return (unsigned long)node & MAPLE_ENODE_NULL;
> -}
> -
>  static __always_inline bool ma_is_root(struct maple_node *node)
>  {
>  	return ((unsigned long)node->parent & MA_ROOT_PARENT);
> _
> 
> 
> 

