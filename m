Return-Path: <linux-kernel+bounces-260499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834493AA48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233DB283C59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C095234;
	Wed, 24 Jul 2024 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vd1Ybtbb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3894C62;
	Wed, 24 Jul 2024 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721782993; cv=none; b=rQgCcU93K667v4wXWaAOG9KBLbm9QL9UiC8/WyJa5PVqe9ZEg1Lr1JYMtSFcLeY9YCAeot2EMdRTaOkpdHd+L7s+FhpSyDLoVwDGsP7mzzoHS+faOONFVF3s4JHV8STZn91sb5wqQZMzQbUj/X7Xu+lm7dcYTyz5Nel5vu5CeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721782993; c=relaxed/simple;
	bh=yxrIu1xngEPxAcrzQt77AOV50WGwURowajCIKoGNEzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sns1xNVBT8pshmwPyQxEnOYhETFEgBD2vzOlKtxoqKyxFViInaKnalSXWtj7ApBwnVgjocTpcYzrY7mGU6kTjeSY1SNdzAHlOo9S2sdIU7Eo8AnkF3gPs8nn6qcaVPAcf0f1urcAtf9/JIVdpgYvInmXrFcM+bSrsqbwpxqcioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vd1Ybtbb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Fe8f9CbwpcqNOu4PnQKEhO5KzM9aQsHv+b66XhuvSto=; b=Vd1YbtbbIZTBmLEzBVRp33wU30
	w61xu+urqttBDk/4CE3RY3YucS/mQQWz2X7UimApSqFKw5/ySht9Tevx6dHDe5KEUXfb7f53MbC08
	MILnGQtDz4Y99LjC2ikAIIOdwP98qGiPlE7KPjEaOEYgAJrlZZUsGQnqs8aAllYz84pDpZrZMr3XF
	nTdwDnWmS9YkSpC7If6v24301ZTR7H4ua+2LPgf1X+SOTm2Gzjc7pqVT5LiVNe78ODL9Vxcn9V++T
	9NTPZU4/or0VAZFxigpygS+JlnaUQwlU4AIy+vuDOZZvYyYYnScvEpMOzWgELA9DoDH5amPEj3T8q
	7soQ1WPA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWQPL-00000007McU-2KUX;
	Wed, 24 Jul 2024 01:03:07 +0000
Date: Wed, 24 Jul 2024 02:03:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: fs/reiserfs/inode.o: warning: objtool:
 reiserfs_write_folio+0x394: unreachable instruction
Message-ID: <ZqBSy1-kmS28JVH8@casper.infradead.org>
References: <202407240856.rcNo0xl1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407240856.rcNo0xl1-lkp@intel.com>

On Wed, Jul 24, 2024 at 08:56:24AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5ad7ff8738b8bd238ca899df08badb1f61bcc39e
> commit: 4f8cf60ac18bee62e8c58654a300eb44b96caf09 reiserfs: Convert to writepages
> date:   3 months ago
> config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240724/202407240856.rcNo0xl1-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240856.rcNo0xl1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407240856.rcNo0xl1-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    fs/reiserfs/inode.o: warning: objtool: restart_transaction+0x38: unreachable instruction
>    fs/reiserfs/inode.o: warning: objtool: reiserfs_write_begin+0x90: unreachable instruction
>    fs/reiserfs/inode.o: warning: objtool: __reiserfs_write_begin+0x88: unreachable instruction
> >> fs/reiserfs/inode.o: warning: objtool: reiserfs_write_folio+0x394: unreachable instruction
>    fs/reiserfs/inode.o: warning: objtool: reiserfs_new_inode+0x8c: unreachable instruction

I don't care.  I doubt anyone cares.  Either about loongarch or
reiserfs.

