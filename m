Return-Path: <linux-kernel+bounces-567449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C30A68625
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A2C4206F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEEA24EF78;
	Wed, 19 Mar 2025 07:51:39 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D2207DEA;
	Wed, 19 Mar 2025 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370699; cv=none; b=hs/rdvT7TySP9fHETu3FlsUmKGXVBKSG3V9inL+wkAq2x+SOySd2+Pwwd6sWJprYmK/No7Ld/Q3pRtXGX+PVOyX1iDwcdERAniYKer/JAzYp2O8BBREV7AZUaqg+YfBJmDAsnYNpEQWNgpLuCRMjvgiywjgJiQr3TXt1aQse36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370699; c=relaxed/simple;
	bh=a4bzULXAGLgt34aDN7C8Aa76N4nccXRuPU+2ejc805I=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=oZPVkZQz5LwRYybd0E4F9CTiAajkZDEjL2ccJbj+YU0Ki4gLYkd2FBS9ZlyDS+2TScFeWGxYM5ZldukxQDs9jon2yaQH7rhVJhmWthaFDz8ajdvhtKocux1ZALB77bFMNwFeRy+RVSYYqIlfwQZ+25CcHv4lKr/gGBisccxTgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZHgrT4XhRz8R041;
	Wed, 19 Mar 2025 15:51:21 +0800 (CST)
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl2.zte.com.cn with SMTP id 52J7p8Qt038955;
	Wed, 19 Mar 2025 15:51:08 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njy2app01[null])
	by mapi (Zmail) with MAPI id mid204;
	Wed, 19 Mar 2025 15:51:10 +0800 (CST)
Date: Wed, 19 Mar 2025 15:51:10 +0800 (CST)
X-Zmail-TransId: 2af967da776e0c2-0f22a
X-Mailer: Zmail v1.0
Message-ID: <20250319155110884FL0FcZmsjNzP1NnAC70Zs@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <alexs@kernel.org>, <si.yanteng@linux.dev>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4IG5leHQgMS8yXSBEb2NzL3poX0NOOiBUcmFuc2xhdGUgaW5kZXgucnN0CiB0byBTaW1wbGlmaWVkIENoaW5lc2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52J7p8Qt038955
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67DA7779.000/4ZHgrT4XhRz8R041

From: Wang Yaxin <wang.yaxin@zte.com.cn>

translate the "index.rst" into Simplified Chinese.

Update to commit e793b86ae44e("Documentation: networking: add
Twisted Pair Ethernet diagnostics at OSI Layer 1")

Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: He Peilin <he.peilin@zte.com.cn>
---
 .../translations/zh_CN/networking/index.rst   | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/networking/index.rst

diff --git a/Documentation/translations/zh_CN/networking/index.rst b/Documentation/translations/zh_CN/networking/index.rst
new file mode 100644
index 000000000000..5c7d01cf3fc0
--- /dev/null
+++ b/Documentation/translations/zh_CN/networking/index.rst
@@ -0,0 +1,159 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/networking/index.rst
+
+:翻译:
+
+ 王亚鑫 Wang Yaxin <wang.yaxin@zte.com.cn>
+
+:校译:
+
+网络
+====
+
+有关网络设备（netdev）开发过程的详细指南，请参考：:ref:`netdev-FAQ`
+
+目录：
+
+.. toctree::
+   :maxdepth: 2
+
+Todolist:
+
+*   af_xdp
+*   bareudp
+*   batman-adv
+*   can
+*   can_ucan_protocol
+*   device_drivers/index
+*   diagnostic/index
+*   dsa/index
+*   devlink/index
+*   caif/index
+*   ethtool-netlink
+*   ieee802154
+*   iso15765-2
+*   j1939
+*   kapi
+*   msg_zerocopy
+*   failover
+*   net_dim
+*   net_failover
+*   page_pool
+*   phy
+*   sfp-phylink
+*   alias
+*   bridge
+*   snmp_counter
+*   checksum-offloads
+*   segmentation-offloads
+*   scaling
+*   tls
+*   tls-offload
+*   tls-handshake
+*   nfc
+*   6lowpan
+*   6pack
+*   arcnet-hardware
+*   arcnet
+*   atm
+*   ax25
+*   bonding
+*   cdc_mbim
+*   dccp
+*   dctcp
+*   devmem
+*   dns_resolver
+*   driver
+*   eql
+*   fib_trie
+*   filter
+*   generic-hdlc
+*   generic_netlink
+*   netlink_spec/index
+*   gen_stats
+*   gtp
+*   ila
+*   ioam6-sysctl
+*   ip_dynaddr
+*   ipsec
+*   ip-sysctl
+*   ipv6
+*   ipvlan
+*   ipvs-sysctl
+*   kcm
+*   l2tp
+*   lapb-module
+*   mac80211-injection
+*   mctp
+*   mpls-sysctl
+*   mptcp
+*   mptcp-sysctl
+*   multiqueue
+*   multi-pf-netdev
+*   napi
+*   net_cachelines/index
+*   netconsole
+*   netdev-features
+*   netdevices
+*   netfilter-sysctl
+*   netif-msg
+*   netmem
+*   nexthop-group-resilient
+*   nf_conntrack-sysctl
+*   nf_flowtable
+*   oa-tc6-framework
+*   openvswitch
+*   operstates
+*   packet_mmap
+*   phonet
+*   phy-link-topology
+*   pktgen
+*   plip
+*   ppp_generic
+*   proc_net_tcp
+*   pse-pd/index
+*   radiotap-headers
+*   rds
+*   regulatory
+*   representors
+*   rxrpc
+*   sctp
+*   secid
+*   seg6-sysctl
+*   skbuff
+*   smc-sysctl
+*   sriov
+*   statistics
+*   strparser
+*   switchdev
+*   sysfs-tagging
+*   tc-actions-env-rules
+*   tc-queue-filters
+*   tcp_ao
+*   tcp-thin
+*   team
+*   timestamping
+*   tipc
+*   tproxy
+*   tuntap
+*   udplite
+*   vrf
+*   vxlan
+*   x25
+*   x25-iface
+*   xfrm_device
+*   xfrm_proc
+*   xfrm_sync
+*   xfrm_sysctl
+*   xdp-rx-metadata
+*   xsk-tx-metadata
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
-- 
2.25.1

