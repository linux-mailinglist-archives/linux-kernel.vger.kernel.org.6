Return-Path: <linux-kernel+bounces-309646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F30A966E4C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14F6B25160
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1CA210F8;
	Sat, 31 Aug 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QPhozql+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237B14295;
	Sat, 31 Aug 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725065417; cv=none; b=iW8vUQQqkbamATjJ0S4ToaTN4yYWBKrm4fSDolBsbVQOB/8Qneto3eSwPIIvhp2wBxliRoZBBjEPsyic+Bg/nYzu6CvxiZIzPR5ws49CvQXtVFXipBrPDaamPfupmYD3DmMq6elPKkimc1UlalLKX3pn9OsM6BImHW1sTcjjxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725065417; c=relaxed/simple;
	bh=dArAaDyNKHpopF5ls6/ZjblTvjXOQ4qnRUSDMkJfEgg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g33aj1DdX3I6Qs1MzDN5f1yGC1Lj6YbPQyTTw8KzqtG4h6/Aa9Gv1e6ODkfcrSG02UZyk3C/Om8GSv3/uTKEPZELRUEpb1dhdwpKVGM4DlHLWXqazQpVxAXq3nn93S60Fu9Zb04sGklIFNF5AQITR2tx/VkgRgxnHaoR1l1fwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QPhozql+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638C8C4CEC2;
	Sat, 31 Aug 2024 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725065416;
	bh=dArAaDyNKHpopF5ls6/ZjblTvjXOQ4qnRUSDMkJfEgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QPhozql+04RQSZygVYg5aef32ibi/+VO4TLy45nz63AZPz+B/o09xsvspbJuDhf6t
	 UnKS+L/aJ981ixFUrITnabMh5CsTZwMpS01Koj7Ai2IICQqLYgRhJXoQhbWVsV1+dr
	 NegpmlC313N5m6G9XNcQwh9LnDSntIFdFEqsbBkU=
Date: Fri, 30 Aug 2024 17:50:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Linux Memory
 Management List <linux-mm@kvack.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>
Subject: Re: lib/maple_tree.c:330:20: error: unused function 'mte_set_full'
Message-Id: <20240830175015.3569d261b0d48d46eb6ec1cf@linux-foundation.org>
In-Reply-To: <202408310728.S7EE59BN-lkp@intel.com>
References: <202408310728.S7EE59BN-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Aug 2024 07:42:38 +0800 kernel test robot <lkp@intel.com> wrote:

> All errors (new ones prefixed by >>):
> 
> >> lib/maple_tree.c:330:20: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
>      330 | static inline void mte_set_full(const struct maple_enode *node)
>          |                    ^~~~~~~~~~~~
> >> lib/maple_tree.c:335:20: error: unused function 'mte_clear_full' [-Werror,-Wunused-function]
>      335 | static inline void mte_clear_full(const struct maple_enode *node)
>          |                    ^~~~~~~~~~~~~~
>    2 errors generated.

afaict these have never been used.  It's odd that this was just detected.

Should we just zap them or is there some reason to retain?

--- a/lib/maple_tree.c~a
+++ a/lib/maple_tree.c
@@ -348,21 +348,6 @@ static inline void *mte_safe_root(const
 	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
 }
 
-static inline void *mte_set_full(const struct maple_enode *node)
-{
-	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
-}
-
-static inline void *mte_clear_full(const struct maple_enode *node)
-{
-	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
-}
-
-static inline bool mte_has_null(const struct maple_enode *node)
-{
-	return (unsigned long)node & MAPLE_ENODE_NULL;
-}
-
 static __always_inline bool ma_is_root(struct maple_node *node)
 {
 	return ((unsigned long)node->parent & MA_ROOT_PARENT);
_



