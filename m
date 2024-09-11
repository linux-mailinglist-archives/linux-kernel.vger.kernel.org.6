Return-Path: <linux-kernel+bounces-324126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60E97482E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4571C254CE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F97727462;
	Wed, 11 Sep 2024 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QreBamiG"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325238DC0;
	Wed, 11 Sep 2024 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726021093; cv=none; b=XLFZXW9iXRhRHOFylXRthSVlnYGfquOyGnctJ8VjZK68Owkdt3RBXpa4pNlkAmKpTqeIBI+Fv90XYtRT4kM9LDUC0HhNjF2RU9WUzUx0puQLttseOLWbEOhJPoF3LxnTgBWcVEaQZZZVMBP8f5fUlmyRqeai2B5Jdvy28wM/x2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726021093; c=relaxed/simple;
	bh=IYSvGGZ9G5np/LJuLAoC5lTV4fIVLWtnM8Ezlv77i6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9e1Xc4Sb6wDlMnZN3oFjHsK0t+iVPvLt7PQnZotTGPCuLlbqHKA3D4URewobgr7jJwQhw1gbeK0TpZMYy8neaR+eIfo2KAzrmNIm74W/ZRkAwJNu3nplcCq01wjLOCVP7Jh/zxCSwW3mgD4TCjd1GfcVVVbiO27Lo0DEy8OjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QreBamiG; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6ad87d5f-a1c6-4d41-9ca4-41bd84907463@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726021086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrJ64KEjJe7IsD3GJtLcFAtmCl970cq1ZQJ0anSlHGM=;
	b=QreBamiGMWiwvXJ/SzMOgl4maWdKPrmdSTVdSk3qAmSHdoU/J54cpsBrT8dFKGrfZJW0qZ
	ouMseVrs24YAeLeYh8WKZ8Kx5NcvFDfBoo5rdf6Kmb5oL+aJQcG+D+AsramZ6On+4dt9Ox
	DZvoMCW3iJk5bCSqM6E9zqP38B6TJDM=
Date: Wed, 11 Sep 2024 10:17:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] Documentation/mm: Translate physical_memory.rst to
 Simplified Chinese
To: jiang.kun2@zte.com.cn, alexs@kernel.org, siyanteng@loongson.cn,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
References: <20240904112020232OieLhsFZ_M10gBxJtUieP@zte.com.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: YanTeng Si <si.yanteng@linux.dev>
In-Reply-To: <20240904112020232OieLhsFZ_M10gBxJtUieP@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


Would you mind changing the subject prefix? For example：

Docs/zh_CN: Translate physical_memory.rst to Simplified Chinese

在 2024/9/4 11:20, jiang.kun2@zte.com.cn 写道:
> From: Yaxin Wang <wang.yaxin@zte.com.cn>
>
> This patch translates the "physical_memory.rst" document into
> Simplified Chinese to improve accessibility for Chinese-speaking
> developers and users.
>
> The translation was done with attention to technical accuracy
> and readability, ensuring that the document remains informative
> and useful in its translated form.
Let's add a commit tag so that the scripts/checktransupdate.py can 
recognize it.

Thanks,
Yanteng
>
> Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
> ---
> v1->v2:
> Some fixes according to:
> https://lore.kernel.org/all/1add7be9-0da0-4463-a3ea-80e2fd99bd19@gmail.com/
>
>   .../translations/zh_CN/mm/physical_memory.rst | 285 ++++++++++++++++++
>   1 file changed, 285 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/mm/physical_memory.rst
>
> diff --git a/Documentation/translations/zh_CN/mm/physical_memory.rst b/Documentation/translations/zh_CN/mm/physical_memory.rst
> new file mode 100644
> index 000000000000..810606605c6c
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/mm/physical_memory.rst
> @@ -0,0 +1,285 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Original: Documentation/mm/physical_memory.rst
> +
> +:翻译:
> +
> + 王亚鑫 Yaxin Wang <wang.yaxin@zte.com.cn>
> +
> +===============
> +物理内存
> +===============
> +
> +Linux可用于多种架构，因此需要一个与架构无关的抽象来表示物理内存。本章描述了管理运行系统
> +中物理内存的结构。
> +
> +第一个与内存管理相关的主要概念是`非一致性内存访问(NUMA)<https://en.wikipedia.org/
> +wiki/Non-uniform_memory_access>`
> +
> +在多核和多插槽机器中，内存可能被组织成不同的存储区，这些存储区根据与处理器的“距离”不同而有不同的
> +访问开销。例如，可能为每个CPU分配内存存储区，或者为外围设备在附近分配一个非常适合DMA的内存存储区。
> +
> +每个存储区被称为一个节点，节点在Linux中表示为 ``struct pglist_data``，即使是在UMA架构中
> +也是这样表示。该结构总是通过 ``pg_data_t``来引用。特定节点的 ``pg_data_t`` 结构体可以通过
> +NODE_DATA(nid)引用，其中nid被称为该节点的ID。
> +
> +对于非一致性内存访问（NUMA）架构，节点数据结构在引导时由特定于架构的代码早期分配。通常，这些
> +结构在他们所在的内存区上本地分配。对于一致性内存访问（UMA）架构，只使用一个静态的 ``pg_data_t``
> +结构体，称为 ``contig_page_data``。节点将会在ref:`Nodes <nodes>`章节中进一步讨论。
> +
> +整个物理内存被划分为一个或多个被称为区域的块，这些区域表示内存的范围。这些范围通常由访问内存
> +的架构限制来决定。在节点内，与特定区域对应的内存范围由 ``struct zone`` 结构体描述，该结构被定义为
> +``zone_t``，每种区域都属于以下描述类型的一种。
> +
> +* ``ZONE_DMA``和 ``ZONE_DMA32``在历史上代表适用于DMA的内存，这些内存由那些不能访问所有可寻址内存的
> +外设访问。多年来，已经有了更好、更稳固的接口来获取满足特定DMA需求的内存（这些接口由Documentation/
> +core-api/dma-api.rst文档描述），但是 ``ZONE_DMA``和 ``ZONE_DMA32``仍然表示访问受限的内存范围。
> +
> +取决于架构的不同，这两种区域可以在构建时通过关闭 ``CONFIG_ZONE_DMA``和 ``CONFIG_ZONE_DMA32``配置选项
> +来禁用。一些64位的平台可能需要这两种区域，因为他们支持具有不同DMA寻址限制的外设。
> +
> +* ``ZONE_NORMAL`` 是普通内存的区域，这种内存可以被内核随时访问。如果DMA设备支持将数据传输到
> +所有可寻址的内存区域，那么可以在该区域的页面上执行DMA操作。 ``ZONE_NORMAL`` 总是开启的。
> +
> +* ``ZONE_HIGHMEM`` 是指那些没有在内核页表中永久映射的物理内存部分。该区域的内存只能通过临时映射
> +被内核访问。该区域只在某些32位架构上可用，并且是通过 ``CONFIG_HIGHMEM`` 选项开启。
> +
> +* ``ZONE_MOVABLE`` 是用于可访问的普通内存区域，就像 ``ZONE_NORMAL`` 一样。不同之处在于 ``ZONE_MOVABLE``
> + 中的大多数页面内容是可移动的。这意味着这些页面的虚拟地址不会改变，但它们的内容可能会在不同的物理
> + 页面之间移动。通常，在内存热插拔期间填充 ``ZONE_MOVABLE``，但在启动时也可以使用 ``kernelcore``、
> + ``movablecore`` 和 ``movable_node`` 这些内核命令行参数来填充。有关更多详细信息，请参阅内核文档
> + Documentation/mm/page_migration.rst 和 Documentation/admin-guide/mm/memory-hotplug.rst。
> +
> +* ``ZONE_DEVICE`` 表示位于诸如持久性内存（PMEM）和图形处理单元（GPU）等设备上的内存。它与RAM区域类型有
> +不同的特性，并且它的存在是为了提供:ref:`struct page <Pages>` 结构和内存映射服务，以便设备驱动程序能识别物理地址
> +范围。 ``ZONE_DEVICE`` 通过配置选项 ``CONFIG_ZONE_DEVICE`` 开启。
> +
> +需要注意的是，许多内核操作只能使用 ``ZONE_NORMAL`` 来执行，因此它是性能最关键区域。区域在
> +:ref:`Zones <zones>` 节中有更详细的讨论。
> +
> +节点和区域范围之间的关系由固件报告的物理内存映射决定，另外也由内存寻址的架构约束以及内核命令行中的某些参数决定。
> +
> +例如，在具有2GB RAM的x86统一内存架构（UMA）机器上运行32位内核时，整个内存将位于节点0，并且将有三个
> +区域： ``ZONE_DMA``、 ``ZONE_NORMAL`` 和 ``ZONE_HIGHMEM``。
> +
> +  0                                                            2G
> +  +-------------------------------------------------------------+
> +  |                            node 0                           |
> +  +-------------------------------------------------------------+
> +
> +  0         16M                    896M                        2G
> +  +----------+-----------------------+--------------------------+
> +  | ZONE_DMA |      ZONE_NORMAL      |       ZONE_HIGHMEM       |
> +  +----------+-----------------------+--------------------------+
> +
> +
> +在内核构建时关闭 ``ZONE_DMA`` 开启 ``ZONE_DMA32``，并且在具有16GB RAM平均分配在两个节点上的arm64
> +机器上，使用 ``movablecore=80%`` 参数启动时， ``ZONE_DMA32``、 ``ZONE_NORMAL`` 和
> +``ZONE_MOVABLE`` 位于节点0，而 ``ZONE_NORMAL`` 和 ``ZONE_MOVABLE`` 位于节点1。
> +
> +
> + 1G                                9G                         17G
> +  +--------------------------------+ +--------------------------+
> +  |              node 0            | |          node 1          |
> +  +--------------------------------+ +--------------------------+
> +
> +  1G       4G        4200M          9G          9320M          17G
> +  +---------+----------+-----------+ +------------+-------------+
> +  |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
> +  +---------+----------+-----------+ +------------+-------------+
> +
> +
> +内存存储区可能位于交错的节点。在下面的例子中，一台x86机器有16GB的RAM分布在4个内存存储区上，偶数编号的内存存储区
> +属于节点0，奇数编号的内存条属于节点1::
> +
> +  0              4G              8G             12G            16G
> +  +-------------+ +-------------+ +-------------+ +-------------+
> +  |    node 0   | |    node 1   | |    node 0   | |    node 1   |
> +  +-------------+ +-------------+ +-------------+ +-------------+
> +
> +  0   16M      4G
> +  +-----+-------+ +-------------+ +-------------+ +-------------+
> +  | DMA | DMA32 | |    NORMAL   | |    NORMAL   | |    NORMAL   |
> +  +-----+-------+ +-------------+ +-------------+ +-------------+
> +
> +在这种情况下，节点0将覆盖从0到12GB的内存范围，而节点1将覆盖从4GB到16GB的内存范围。
> +
> +.. _nodes:
> +
> +节点
> +=====
> +
> +正如我们所提到的，内存中的每个节点都由 ``pg_data_t`` 描述，它是由 ``struct pglist_data`` 结构体的类型定义。
> +在分配页面时，默认情况下，Linux使用节点本地分配策略，从离当前运行CPU的最近节点分配内存。由于进程倾向于
> +在同一个CPU上运行，很可能会使用当前节点的内存。分配策略可以由用户控制，如内核文档 Documentation/admin-guide
> +/mm/numa_memory_policy.rst 中所述。
> +
> +大多数NUMA（非统一内存访问）架构维护了一个指向节点结构的指针数组。这些实际的结构在启动过程中的早期被分配，
> +这时特定于架构的代码解析了固件报告的物理内存映射。节点初始化的大部分工作是在由 free_area_init()实现的启
> +动过程之后完成，该函数在后面的小节 :ref:`Initialization <initialization>` 中有详细描述。
> +
> +除了节点结构，内核还维护了一个名为 ``node_states`` 的 ``nodemask_t`` 位掩码数组。这个数组中的每个位掩码代表一组
> +特定属性的节点，这些属性由 ``enum node_states`` 定义，定义如下：
> +
> +``N_POSSIBLE``
> +节点可能在某个时刻上线。
> +
> +``N_ONLINE``
> +节点已经上线。
> +
> +``N_NORMAL_MEMORY``
> +节点拥有普通内存。
> +
> +``N_HIGH_MEMORY``
> +节点拥有普通或高端内存。当关闭 ``CONFIG_HIGHMEM`` 配置时，也可以称为 ``N_NORMAL_MEMORY`` 。
> +
> +``N_MEMORY``
> +节点拥有（普通、高端、可移动）内存。
> +
> +``N_CPU``
> +节点拥有一个或多个CPU。
> +
> +对于具有上述属性的每个节点， ``node_states[<property>]``掩码中对应于节点ID的位会被置位。
> +
> +例如，对于具有常规内存和CPU的节点2，第二个bit将被设置::
> +
> +  node_states[N_POSSIBLE]
> +  node_states[N_ONLINE]
> +  node_states[N_NORMAL_MEMORY]
> +  node_states[N_HIGH_MEMORY]
> +  node_states[N_MEMORY]
> +  node_states[N_CPU]
> +
> +有关使用节点掩码（nodemasks）可能进行的各种操作，请参考 ``include/linux/nodemask.h``。
> +
> +除此之外，节点掩码（nodemasks）提供用于遍历节点的宏，即 ``for_each_node()`` 和
> + ``for_each_online_node()``。
> +
> +例如，要为每个在线节点调用函数 foo()，可以这样操作：
> +
> +  for_each_online_node(nid) {
> +		  pg_data_t *pgdat = NODE_DATA(nid);
> +
> +		  foo(pgdat);
> +	}
> +
> +节点数据结构
> +--------------
> +
> +节点结构 ``struct pglist_data`` 在 ``include/linux/mmzone.h`` 中声明。这里我们
> +将简要描述这个结构体的字段：
> +
> +通用字段
> +~~~~~~~
> +
> +``node_zones``
> +该节点的区域列表。并非所有区域都可能被填充，但这是完整的列表。它被该节点的node_zonelists以及其它
> +节点的node_zonelists引用。
> +
> +``node_zonelists``
> +所有节点中所有区域的列表。此列表定义了分配内存时首选的区域顺序。 ``node_zonelists`` 在核心内存管理
> +结构初始化期间，由 ``mm/page_alloc.c`` 中的 ``build_zonelists()`` 函数设置的。
> +
> +``nr_zones``
> +此节点中已填充区域的数量。
> +
> +``node_mem_map``
> +对于使用FLATMEM内存模型的UMA系统，0号节点的 ``node_mem_map`` 表示每个物理帧的 struct pages 数组。
> +
> +``node_page_ext``
> +对于使用FLATMEM内存模型的UMA系统，0号节点的 ``node_page_ext`` 是struct pages的扩展数组。
> +只有在构建时开启了 ``CONFIG_PAGE_EXTENSION`` 选项的内核中才可用。
> +
> +``node_start_pfn``
> +此节点中起始页面帧的页面帧号。
> +
> +``node_present_pages``
> +此节点中存在的物理页面的总数。
> +
> +``node_spanned_pages``
> +包括空洞在内的物理页面范围的总大小。
> +
> +``node_size_lock``
> +一个保护定义节点范围字段的锁。仅在开启了 ``CONFIG_MEMORY_HOTPLUG`` 或
> +``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` 配置选项中的某一个时才定义。提供了
> +``pgdat_resize_lock()`` 和 ``pgdat_resize_unlock()`` 用来操作 ``node_size_lock``，
> +而无需检查 ``CONFIG_MEMORY_HOTPLUG`` 或 ``CONFIG_DEFERRED_STRUCT_PAGE_INIT``选项。
> +
> +``node_id``
> +节点的节点ID（NID），从0开始。
> +
> +``totalreserve_pages``
> +这是每个节点保留的页面，这些页面不可用于用户空间分配。
> +
> +``first_deferred_pfn``
> +如果大型机器上的内存初始化被推迟，那么第一个PFN（页帧号）是需要初始化的。仅在开启了
> +``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` 选项时定义。
> +
> +``deferred_split_queue``
> +每个节点的大页队列，这些大页的拆分被推迟了。仅在开启了 ``CONFIG_TRANSPARENT_HUGEPAGE``
> +配置选项时定义。
> +
> +``__lruvec``
> +每个节点的lruvec持有LRU（最近最少使用）列表和相关参数。仅在禁用了内存控制组（cgroups）
> +时使用。它不应该直接访问，而应该使用 ``mem_cgroup_lruvec()`` 来查找 lruvecs。
> +
> +回收控制
> +~~~~~~~~~~~~~~~
> +
> +另见内核文档 Documentation/mm/page_reclaim.rst 文件。
> +
> +``kswapd``
> +每个节点的kswapd内核线程实例。
> +
> +``kswapd_wait``, ``pfmemalloc_wait``, ``reclaim_wait``
> +同步内存回收任务的工作队列。
> +
> +``nr_writeback_throttled``
> +等待写回脏页时，被限制的任务数量。
> +
> +``kswapd_order``
> +控制kswapd尝试回收的order。
> +
> +``kswapd_highest_zoneidx``
> +kswapd线程可以回收的最高区域索引。
> +
> +``kswapd_failures``
> +kswapd无法回收任何页面的运行次数。
> +
> +``min_unmapped_pages``
> +无法回收的未映射文件支持的最小页面数量。由 ``vm.min_unmapped_ratio`` 系统控制台（sysctl）
> +参数决定。仅在开启 ``CONFIG_NUMA`` 配置时定义。
> +
> +``min_slab_pages``
> +无法回收的SLAB页面的最少数量。由 ``vm.min_slab_ratio`` 系统控制台（sysctl）参数决定。仅在
> +开启 ``CONFIG_NUMA`` 时定义。
> +
> +``flags``
> +控制回收行为的标志位。
> +
> +内存压缩控制
> +~~~~~~~~~~~~~~~~~~
> +
> +``kcompactd_max_order``
> +kcompactd应尝试实现的页面order。
> +
> +``kcompactd_highest_zoneidx``
> +kcompactd可以压缩的最高区域索引。
> +
> +``kcompactd_wait``
> +同步内存压缩任务的工作队列。
> +
> +``kcompactd``
> +每个节点的kcompactd内核线程实例。
> +
> +``proactive_compact_trigger``
> +决定是否使用主动压缩。由 ``vm.compaction_proactiveness`` 系统控制台（sysctl）参数控制。
> +
> +统计信息
> +~~~~~~~~~~
> +
> +``per_cpu_nodestats``
> +节点的Per-CPU虚拟内存统计信息。
> +
> +``vm_stat``
> +节点的虚拟内存统计数据。


