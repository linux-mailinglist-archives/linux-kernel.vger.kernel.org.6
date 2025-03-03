Return-Path: <linux-kernel+bounces-545293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EF4A4EC0B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB208E79DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2E27CCE4;
	Tue,  4 Mar 2025 18:04:32 +0000 (UTC)
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D9234994
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111472; cv=fail; b=Hgj9LGEP0CqgAI1a4pvDXl55ohaQ6BjQrU06kC9tiHLCSDr01DpboUtZ/Y0md2juLAjVMXHqdhmmmTf1xck/jOEQwGIthulXAAvnSp6QyVBl9tzkdM7wxh6x6g0D9RgT6sE9JiIieDyZIZh94tyr+q2IMiTdUqJmousc8M6pSLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111472; c=relaxed/simple;
	bh=LGItdhY9jW+7v3xRdQU2H/xD+eO5q2oPt2Hb7jL8P6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk71JyWqXmZ8w5RHFYzVD8AgHXoGaO5jAwQScQTjN283LtWJKJAdfwgiLNnSL+JPbtdgPNHExN6gV2onfMEuKK0LFyDT0AX1uqO6M7LnKIVjDmYuphG/r/PphEsKzg0kdLOxkpqUwpMNb9/oxRndNvtkirQEL3/jLUjGncsnoTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=218.30.114.240; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 6FA5A40891A2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:04:28 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fXj0MlTzFySq
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:21:25 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8824842721; Tue,  4 Mar 2025 18:21:24 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541476-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 693AE42AEE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:03:28 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 448223064C1A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:03:28 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D630C18893C4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3A1F1516;
	Mon,  3 Mar 2025 11:00:03 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230B1F4C9D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999601; cv=none; b=NpjMOLt19FanGTuDa4wAeis2287SzsbchFPp7VbgGNVJfY1gwIw9MwXAmreLfpYfPYrEbYjVdexTFA+LioEJpELpL7fmOl2GHEYhI09gTnMqRfk4m6WOeZNgCEwDC4PWf9RRUDzQ51RHqv5/83b8QM7L6Ov8xQEkIMCugxINYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999601; c=relaxed/simple;
	bh=Dtq3yE+UNHEsj6x2wPixGnasokmKm3LElA9fktZdOWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bouwoEV6gJbb0zyZxCuTAMz3e8v+dNfFDKHf1pI15p8wdOEopAza/K9fkzX5oIAqCVHLqy7v6uFP4kV+uePBYLw0F5ULG8S57xT23IzyfS6AqfSD/HI8hBF5dF7jyuVioHsW60lZvUbyLtdVsnV9Z+haUNQnTKdKMhc0zFC2lo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.87])
	by sina.com (10.185.250.23) with ESMTP
	id 67C58A5F0000477C; Mon, 3 Mar 2025 18:54:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3596408913434
X-SMAIL-UIID: 4DE9BD4B872042298C567D4F95590111-20250303-185425-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work (2)
Date: Mon,  3 Mar 2025 18:54:12 +0800
Message-ID: <20250303105413.2938-1-hdanton@sina.com>
In-Reply-To: <67c447a7.050a0220.55417.04d3.GAE@google.com>
References: 
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fXj0MlTzFySq
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716143.49031@CLmucZOmp1V1jGVm917VqA
X-ITU-MailScanner-SpamCheck: not spam

On Sun, 02 Mar 2025 03:57:27 -0800
> syzbot found the following issue on:
>=20
> HEAD commit:    03d38806a902 Merge tag 'thermal-6.14-rc5' of git://git.=
ker..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D155128b79=
80000

#syz test

--- x/net/netfilter/nf_tables_api.c
+++ y/net/netfilter/nf_tables_api.c
@@ -10654,6 +10654,10 @@ static int nf_tables_commit(struct net *
 		mutex_unlock(&nft_net->commit_mutex);
 		return 0;
 	}
+	if (nft_net->flushed) {
+		mutex_unlock(&nft_net->commit_mutex);
+		return -EAGAIN;
+	}
=20
 	nft_ctx_init(&ctx, net, skb, nlh, NFPROTO_UNSPEC, NULL, NULL, NULL);
=20
@@ -11251,6 +11255,7 @@ static int nf_tables_abort(struct net *n
 	else
 		nf_tables_module_autoload_cleanup(net);
=20
+	nft_net->flushed =3D 0;
 	mutex_unlock(&nft_net->commit_mutex);
=20
 	return ret;
@@ -11854,6 +11859,7 @@ static int nft_rcv_nl_event(struct notif
 	gc_seq =3D nft_gc_seq_begin(nft_net);
=20
 	nf_tables_trans_destroy_flush_work();
+	nft_net->flushed =3D 1;
 again:
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (nft_table_has_owner(table) &&
@@ -11903,6 +11909,7 @@ static int __net_init nf_tables_init_net
 	nft_net->base_seq =3D 1;
 	nft_net->gc_seq =3D 0;
 	nft_net->validate_state =3D NFT_VALIDATE_SKIP;
+	nft_net->flushed =3D 0;
=20
 	return 0;
 }
--- x/include/net/netfilter/nf_tables.h
+++ y/include/net/netfilter/nf_tables.h
@@ -1915,6 +1915,7 @@ struct nftables_pernet {
 	unsigned int		base_seq;
 	unsigned int		gc_seq;
 	u8			validate_state;
+	u8			flushed;
 };
=20
 extern unsigned int nf_tables_net_id;
--


