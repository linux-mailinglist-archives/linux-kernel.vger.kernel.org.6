Return-Path: <linux-kernel+bounces-271254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA03944BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C679B21AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F47189B95;
	Thu,  1 Aug 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WDlTBczI"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36B1946A9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516489; cv=none; b=rqQKuOUIzsq+CXMr3sorrG7yP/fL5Nr8zO0WAklocIXOrTVbWoCNfFgzrbvOP4K372gb1zSx3GWaP6D/rvCesT/bfSTNAV8NhUQOoYhz5A/VWcyLMVg+1CSqM0cPs3Y7XmkzboSVFp4vRS45ZdBHyxx+A98hqlPYqg7djGfrMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516489; c=relaxed/simple;
	bh=DOmooirTymBtlbbAC/NIyABKVfiwjnuJGJR16zYopF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esw5ykDRK/JyESvtza80R0SqCTGXQIcuxHvFNc8Qml9fc3XkgE4+JaYsT+x6c5M8qHZK9iQFvoaEFtcWDJak57TEsIVJfO0BoX8ffvJo4ACyAM6vCGAztgIcBsShHNyjUlumJSORDJbQb/XxGh8veBs4uFdK/7Go2eZbvpepA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=WDlTBczI; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id ZT4OsLmDQvH7lZVDtsVXhx; Thu, 01 Aug 2024 12:48:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ZVDrsRqR0O7CrZVDssosai; Thu, 01 Aug 2024 12:48:00 +0000
X-Authority-Analysis: v=2.4 cv=Pco0hThd c=1 sm=1 tr=0 ts=66ab8400
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8
 a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=C8vIXaMZh2Vcq6t1_VcA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=mmqRlSCDY2ywfjPLJ4af:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oX69fdnJwQqc1oo+K3oL1khcvjXtDvO+Ong0/slAk4g=; b=WDlTBczIfHuxr9gcUnvR017143
	n2N/Sq8V9jLcK4n4lpLHrbALHNsk00sIho82HaDUOaMp1UyuNNqRp+qI9xNIz0xJF9fJcZ1zOIkkB
	vbh/jUEN3ynEM+fnuW7VgEMhEY0wWr4ScLmsuSiSqTiZX9d63+MYherl786D74CJk5QdPurGjW1/1
	mSW5mIz/The8I0O6RMTLbtKNjjLRcoMm8kGkSUgib5dGi4RSu/sFq67uY1Oyvhd+yhR2tHGYc8PGP
	CP5we7IeiHq3MX5roz6r8+JA95sp/y0+J8tWaxNhwYJ0KeWQkAWeujmJnDhE85klEETdHY4tpuugM
	8JiKmH2g==;
Received: from [201.172.173.139] (port=55564 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sZVDr-000FR7-16;
	Thu, 01 Aug 2024 07:47:59 -0500
Message-ID: <138da3e5-0e24-41a6-bb35-df5d07045eb3@embeddedor.com>
Date: Thu, 1 Aug 2024 06:47:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
 include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
 requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
 sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of
 struct_group_tagged()
To: kernel test robot <lkp@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
References: <202408011956.wscyBwq6-lkp@intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202408011956.wscyBwq6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sZVDr-000FR7-16
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:55564
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKZscJlHfG9ZO7kRII4Lr3yAt8RAVEN2yYdSxTHVEvrDHdIiNY/D+tZ/aqRYbDQS1mRJRMuYAbeNS0thPqvu4SRM4C5cLE1SyXfyYCX+Xe/6v5H+ruQM
 Vn3O4YUH6jYCY0uEJ/TgkSGhHUrFFTxQsEyVNCsBQdz1hoZiCWVi86+XQwwy944w9N6D4AAL0x2E+O8ib/lNFjEBsEa3b62B+/Fqf8fK6wbk/8NUsLnVqiXP



On 01/08/24 05:35, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc-2
> head:   df15c862c1b93b6e1f6c90b0d7971f7a6ad66751
> commit: e7cd9f429a852fb7e37a706c7d08fc36e7863e06 [11/18] RDMA/uverbs: Use static_assert() to check struct sizes
> config: hexagon-randconfig-001-20240801 (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 430b90f04533b099d788db2668176038be38c53b)


Clang 20.0.0?? (thinkingface)

--
Gustavo

> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408011956.wscyBwq6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
>     In file included from drivers/infiniband/core/uverbs.h:46:
>     In file included from include/rdma/ib_verbs.h:15:
>     In file included from include/linux/ethtool.h:18:
>     In file included from include/linux/if_ether.h:19:
>     In file included from include/linux/skbuff.h:17:
>     In file included from include/linux/bvec.h:10:
>     In file included from include/linux/highmem.h:10:
>     In file included from include/linux/mm.h:2228:
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
>     In file included from drivers/infiniband/core/uverbs.h:46:
>     In file included from include/rdma/ib_verbs.h:15:
>     In file included from include/linux/ethtool.h:18:
>     In file included from include/linux/if_ether.h:19:
>     In file included from include/linux/skbuff.h:17:
>     In file included from include/linux/bvec.h:10:
>     In file included from include/linux/highmem.h:12:
>     In file included from include/linux/hardirq.h:11:
>     In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:14:
>     In file included from arch/hexagon/include/asm/io.h:328:
>     include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       548 |         val = __raw_readb(PCI_IOBASE + addr);
>           |                           ~~~~~~~~~~ ^
>     include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>        37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>           |                                                   ^
>     In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
>     In file included from drivers/infiniband/core/uverbs.h:46:
>     In file included from include/rdma/ib_verbs.h:15:
>     In file included from include/linux/ethtool.h:18:
>     In file included from include/linux/if_ether.h:19:
>     In file included from include/linux/skbuff.h:17:
>     In file included from include/linux/bvec.h:10:
>     In file included from include/linux/highmem.h:12:
>     In file included from include/linux/hardirq.h:11:
>     In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:14:
>     In file included from arch/hexagon/include/asm/io.h:328:
>     include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>        35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>           |                                                   ^
>     In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
>     In file included from drivers/infiniband/core/uverbs.h:46:
>     In file included from include/rdma/ib_verbs.h:15:
>     In file included from include/linux/ethtool.h:18:
>     In file included from include/linux/if_ether.h:19:
>     In file included from include/linux/skbuff.h:17:
>     In file included from include/linux/bvec.h:10:
>     In file included from include/linux/highmem.h:12:
>     In file included from include/linux/hardirq.h:11:
>     In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:14:
>     In file included from arch/hexagon/include/asm/io.h:328:
>     include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       585 |         __raw_writeb(value, PCI_IOBASE + addr);
>           |                             ~~~~~~~~~~ ^
>     include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     In file included from drivers/infiniband/core/ib_core_uverbs.c:8:
>     In file included from drivers/infiniband/core/uverbs.h:49:
>     In file included from include/rdma/uverbs_std_types.h:10:
>>> include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of struct_group_tagged()
>       643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
>           | ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       644 |               "struct member likely outside of struct_group_tagged()");
>           |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
>        16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>           |                                 ^
>     include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
>        77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>           |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
>        78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>           |                                                        ^~~~
>     include/rdma/uverbs_ioctl.h:643:58: note: expression evaluates to '56 == 52'
>       643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
>           | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       644 |               "struct member likely outside of struct_group_tagged()");
>           |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
>        77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>           |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
>        78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>           |                                                        ^~~~
>     7 warnings and 1 error generated.
> 
> 
> vim +643 include/rdma/uverbs_ioctl.h
> 
>     630	
>     631	struct uverbs_attr_bundle {
>     632		/* New members MUST be added within the struct_group() macro below. */
>     633		struct_group_tagged(uverbs_attr_bundle_hdr, hdr,
>     634			struct ib_udata driver_udata;
>     635			struct ib_udata ucore;
>     636			struct ib_uverbs_file *ufile;
>     637			struct ib_ucontext *context;
>     638			struct ib_uobject *uobject;
>     639			DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
>     640		);
>     641		struct uverbs_attr attrs[];
>     642	};
>   > 643	static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
>     644		      "struct member likely outside of struct_group_tagged()");
>     645	
> 

