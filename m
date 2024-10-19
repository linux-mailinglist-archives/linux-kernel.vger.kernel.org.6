Return-Path: <linux-kernel+bounces-372733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2299A4C6F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237C0284F66
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D51DEFEF;
	Sat, 19 Oct 2024 08:56:46 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654AE1DFE2B;
	Sat, 19 Oct 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729328206; cv=none; b=TBC8DczUWDuoEnYL84eEVmcsU87+cI/5ozbrmRW+zgM9yEz0BYOjTse6VKnHy+xfk3db02/tyjjFyJmUaVs9gXumGvfZ00bsmbhT0XjOZCR3vf8yRvDcbN43xXvjc+JWGF25LC8kiX18kgHiP0y6sjXIWNrlkf0m9jPoqe/E7rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729328206; c=relaxed/simple;
	bh=1Y1cWCUn7nIsxbdoWoWZyyb/j3TesM4bqjp3xidoCFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXNnMBOCCptp4E7G/YLs+WAWYFSzjU40uNTx+j+8btUvaALCcon7dN2vGptxOWhuStZuPLRyN+ye0bea756hAu3W5MPzB3vT+SQ3cFI7wRI+wx0dir7bH9eDQw7cAZ03EFA65g/CUkct0mImSUfi77oiFdw8ImmqkWUO9+Ti2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrACHjjordBNn5Y8fCA--.46444S2;
	Sat, 19 Oct 2024 16:56:11 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wAH8UIMdBNnstxuAA--.62062S7;
	Sat, 19 Oct 2024 16:56:11 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	alexs@kernel.org,
	corbet@lwn.net,
	Yanteng Si <siyanteng@loongson.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] docs/zh_CN: update the translation of mm/page_owner.rst
Date: Sat, 19 Oct 2024 16:54:56 +0800
Message-ID: <38a9d8868e0f98dc5d2a08fb865313cc4db943a3.1729327831.git.dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729327831.git.dzm91@hust.edu.cn>
References: <cover.1729327831.git.dzm91@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrACHjjordBNn5Y8fCA--.46444S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyUKw43Wr4fJrW8Aw1DJrb_yoW5KrWrpa
	10kFy5C3W7A3WS9rWxGrs29FyrAan5Wa15GFn7J34kuwsxAanakrWqka4j9r47ZrWUJFWD
	ua1DCrWkJw4qy3DanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQqb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWrXVW3AwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0XVy3UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit f5c12105c15f ("mm,page_owner: fix refcount imbalance")

Documentation/translations/zh_CN/mm/page_owner.rst
commit f5c12105c15f ("mm,page_owner: fix refcount imbalance")
commit ba6fe5377244 ("mm,page_owner: update Documentation regarding
page_owner_stacks")
2 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../translations/zh_CN/mm/page_owner.rst      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/translations/zh_CN/mm/page_owner.rst b/Documentation/translations/zh_CN/mm/page_owner.rst
index b72a972271d9..c0d1ca4b9695 100644
--- a/Documentation/translations/zh_CN/mm/page_owner.rst
+++ b/Documentation/translations/zh_CN/mm/page_owner.rst
@@ -26,6 +26,9 @@ page owner是用来追踪谁分配的每一个页面。它可以用来调试内
 页面所有者也可以用于各种目的。例如，可以通过每个页面的gfp标志信息获得精确的碎片
 统计。如果启用了page owner，它就已经实现并激活了。我们非常欢迎其他用途。
 
+它也可以用来显示所有的栈以及它们当前分配的基础页面数，这让我们能够快速了解内存的
+使用情况，而无需浏览所有页面并匹配分配和释放操作。
+
 page owner在默认情况下是禁用的。所以，如果你想使用它，你需要在你的启动cmdline
 中加入"page_owner=on"。如果内核是用page owner构建的，并且由于没有启用启动
 选项而在运行时禁用page owner，那么运行时的开销是很小的。如果在运行时禁用，它不
@@ -60,6 +63,49 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
 
 4) 分析来自页面所有者的信息::
 
+	cat /sys/kernel/debug/page_owner_stacks/show_stacks > stacks.txt
+	cat stacks.txt
+	 post_alloc_hook+0x177/0x1a0
+	 get_page_from_freelist+0xd01/0xd80
+	 __alloc_pages+0x39e/0x7e0
+	 allocate_slab+0xbc/0x3f0
+	 ___slab_alloc+0x528/0x8a0
+	 kmem_cache_alloc+0x224/0x3b0
+	 sk_prot_alloc+0x58/0x1a0
+	 sk_alloc+0x32/0x4f0
+	 inet_create+0x427/0xb50
+	 __sock_create+0x2e4/0x650
+	 inet_ctl_sock_create+0x30/0x180
+	 igmp_net_init+0xc1/0x130
+	 ops_init+0x167/0x410
+	 setup_net+0x304/0xa60
+	 copy_net_ns+0x29b/0x4a0
+	 create_new_namespaces+0x4a1/0x820
+	nr_base_pages: 16
+	...
+	...
+	echo 7000 > /sys/kernel/debug/page_owner_stacks/count_threshold
+	cat /sys/kernel/debug/page_owner_stacks/show_stacks> stacks_7000.txt
+	cat stacks_7000.txt
+	 post_alloc_hook+0x177/0x1a0
+	 get_page_from_freelist+0xd01/0xd80
+	 __alloc_pages+0x39e/0x7e0
+	 alloc_pages_mpol+0x22e/0x490
+	 folio_alloc+0xd5/0x110
+	 filemap_alloc_folio+0x78/0x230
+	 page_cache_ra_order+0x287/0x6f0
+	 filemap_get_pages+0x517/0x1160
+	 filemap_read+0x304/0x9f0
+	 xfs_file_buffered_read+0xe6/0x1d0 [xfs]
+	 xfs_file_read_iter+0x1f0/0x380 [xfs]
+	 __kernel_read+0x3b9/0x730
+	 kernel_read_file+0x309/0x4d0
+	 __do_sys_finit_module+0x381/0x730
+	 do_syscall_64+0x8d/0x150
+	 entry_SYSCALL_64_after_hwframe+0x62/0x6a
+	nr_base_pages: 20824
+	...
+
 	cat /sys/kernel/debug/page_owner > page_owner_full.txt
 	./page_owner_sort page_owner_full.txt sorted_page_owner.txt
 
-- 
2.43.0


