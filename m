Return-Path: <linux-kernel+bounces-271775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090D94531D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4413B22C58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BBE1494C1;
	Thu,  1 Aug 2024 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUbO4zWo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17889143897;
	Thu,  1 Aug 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539296; cv=none; b=UlrKDm/dxOTuviKjD0VSXdpk/eGVE99sjC/km4YzMKr3TZX+SvO6CDSX3b1sxTT78z3qb8cegC29w9O0Ac3OTesnc/6r/eXLDbQBZW8pKh7JbgkCa3/wri9zBgu6NOFL9a/jbwbeQXcjwCylu5zLLMYGmrBBuRJP1pNZ4f0iq/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539296; c=relaxed/simple;
	bh=douCBZT7gMRGfuZXdxkKdoEJWupbLquDYpQTE3MSQTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLLH8jnlfUG1cTJki29asthxBzOjZ+pvZzcUQ/u9cMvk97efJ+ThaYN/1agVZNCAnusgmAyrp8UlntIkorb8/4OoSlmaAmNMVZ1yvOXuIZ1Ma/CwxkgXds3hNe5FxHvWjR0NiE4Tz075yng7TJrOy1eVLtAA0+MQgPq2cWBjC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUbO4zWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A314C32786;
	Thu,  1 Aug 2024 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722539295;
	bh=douCBZT7gMRGfuZXdxkKdoEJWupbLquDYpQTE3MSQTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUbO4zWoyZ/d+l1GTTi1R6B/2ylzeFQvNX07yZDxInSY7vdtgslWeyyLx7kBU2LvC
	 Y1QRkmDI5Y9XfY9fFffSB66sqFLyGfhZSTZSXjcGTDnMrwtn4Mb8FWhH60cpk5/YsP
	 PZ6S/qRJfiC2Wtb7OwD4HUYb4d/zMvJNg5D9SsF7SrJX2ODVUCQnrEMTTyWaj0h77/
	 cdUjMad6stI0AsUfYU5yub7ST1YYG7+vmXPwWnRamowsrwfqpOhNTtB4R1f+utAlig
	 Wwi8N9vf9mCqGTPMPoZrjpHuAL9K1cfp+nbKWNHDPHqyad0H50fGkq2xuEC1bkpDed
	 S2ubx/NOKVrnQ==
Date: Thu, 1 Aug 2024 12:08:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: kernel test robot <lkp@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
 include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
 requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
 sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of
 struct_group_tagged()
Message-ID: <20240801190813.GC122261@thelio-3990X>
References: <202408011956.wscyBwq6-lkp@intel.com>
 <138da3e5-0e24-41a6-bb35-df5d07045eb3@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <138da3e5-0e24-41a6-bb35-df5d07045eb3@embeddedor.com>

On Thu, Aug 01, 2024 at 06:47:58AM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 01/08/24 05:35, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc-2
> > head:   df15c862c1b93b6e1f6c90b0d7971f7a6ad66751
> > commit: e7cd9f429a852fb7e37a706c7d08fc36e7863e06 [11/18] RDMA/uverbs: Use static_assert() to check struct sizes
> > config: hexagon-randconfig-001-20240801 (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-lkp@intel.com/config)
> > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 430b90f04533b099d788db2668176038be38c53b)
> 
> 
> Clang 20.0.0?? (thinkingface)

Indeed, Clang 19 branched and main is now 20 :)

https://github.com/llvm/llvm-project/commit/8f701b5df0adb3a2960d78ca2ad9cf53f39ba2fe

Cheers,
Nathan

> --
> Gustavo
> 
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408011956.wscyBwq6-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >     In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
> >     In file included from drivers/infiniband/core/uverbs.h:46:
> >     In file included from include/rdma/ib_verbs.h:15:
> >     In file included from include/linux/ethtool.h:18:
> >     In file included from include/linux/if_ether.h:19:
> >     In file included from include/linux/skbuff.h:17:
> >     In file included from include/linux/bvec.h:10:
> >     In file included from include/linux/highmem.h:10:
> >     In file included from include/linux/mm.h:2228:
> >     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
> >       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
> >           |                               ~~~~~~~~~~~ ^ ~~~
> >     In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
> >     In file included from drivers/infiniband/core/uverbs.h:46:
> >     In file included from include/rdma/ib_verbs.h:15:
> >     In file included from include/linux/ethtool.h:18:
> >     In file included from include/linux/if_ether.h:19:
> >     In file included from include/linux/skbuff.h:17:
> >     In file included from include/linux/bvec.h:10:
> >     In file included from include/linux/highmem.h:12:
> >     In file included from include/linux/hardirq.h:11:
> >     In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
> >     In file included from include/asm-generic/hardirq.h:17:
> >     In file included from include/linux/irq.h:20:
> >     In file included from include/linux/io.h:14:
> >     In file included from arch/hexagon/include/asm/io.h:328:
> >     include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >       548 |         val = __raw_readb(PCI_IOBASE + addr);
> >           |                           ~~~~~~~~~~ ^
> >     include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >       561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
> >           |                                                         ~~~~~~~~~~ ^
> >     include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
> >        37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
> >           |                                                   ^
> >     In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
> >     In file included from drivers/infiniband/core/uverbs.h:46:
> >     In file included from include/rdma/ib_verbs.h:15:
> >     In file included from include/linux/ethtool.h:18:
> >     In file included from include/linux/if_ether.h:19:
> >     In file included from include/linux/skbuff.h:17:
> >     In file included from include/linux/bvec.h:10:
> >     In file included from include/linux/highmem.h:12:
> >     In file included from include/linux/hardirq.h:11:
> >     In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
> >     In file included from include/asm-generic/hardirq.h:17:
> >     In file included from include/linux/irq.h:20:
> >     In file included from include/linux/io.h:14:
> >     In file included from arch/hexagon/include/asm/io.h:328:
> >     include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >       574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
> >           |                                                         ~~~~~~~~~~ ^
> >     include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
> >        35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
> >           |                                                   ^
> >     In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
> >     In file included from drivers/infiniband/core/uverbs.h:46:
> >     In file included from include/rdma/ib_verbs.h:15:
> >     In file included from include/linux/ethtool.h:18:
> >     In file included from include/linux/if_ether.h:19:
> >     In file included from include/linux/skbuff.h:17:
> >     In file included from include/linux/bvec.h:10:
> >     In file included from include/linux/highmem.h:12:
> >     In file included from include/linux/hardirq.h:11:
> >     In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
> >     In file included from include/asm-generic/hardirq.h:17:
> >     In file included from include/linux/irq.h:20:
> >     In file included from include/linux/io.h:14:
> >     In file included from arch/hexagon/include/asm/io.h:328:
> >     include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >       585 |         __raw_writeb(value, PCI_IOBASE + addr);
> >           |                             ~~~~~~~~~~ ^
> >     include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >       595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
> >           |                                                       ~~~~~~~~~~ ^
> >     include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >       605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
> >           |                                                       ~~~~~~~~~~ ^
> >     In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
> >     In file included from drivers/infiniband/core/uverbs.h:49:
> >     In file included from include/rdma/uverbs_std_types.h:10:
> > > > include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of struct_group_tagged()
> >       643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
> >           | ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       644 |               "struct member likely outside of struct_group_tagged()");
> >           |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
> >        16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
> >           |                                 ^
> >     include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
> >        77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> >           |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
> >        78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> >           |                                                        ^~~~
> >     include/rdma/uverbs_ioctl.h:643:58: note: expression evaluates to '56 == 52'
> >       643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
> >           | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       644 |               "struct member likely outside of struct_group_tagged()");
> >           |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
> >        77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> >           |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
> >        78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> >           |                                                        ^~~~
> >     7 warnings and 1 error generated.
> > 
> > 
> > vim +643 include/rdma/uverbs_ioctl.h
> > 
> >     630	
> >     631	struct uverbs_attr_bundle {
> >     632		/* New members MUST be added within the struct_group() macro below. */
> >     633		struct_group_tagged(uverbs_attr_bundle_hdr, hdr,
> >     634			struct ib_udata driver_udata;
> >     635			struct ib_udata ucore;
> >     636			struct ib_uverbs_file *ufile;
> >     637			struct ib_ucontext *context;
> >     638			struct ib_uobject *uobject;
> >     639			DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
> >     640		);
> >     641		struct uverbs_attr attrs[];
> >     642	};
> >   > 643	static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
> >     644		      "struct member likely outside of struct_group_tagged()");
> >     645	
> > 
> 

