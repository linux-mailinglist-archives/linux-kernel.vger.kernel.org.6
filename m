Return-Path: <linux-kernel+bounces-349234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924B98F2D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B28E1C210CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAA61A7AF7;
	Thu,  3 Oct 2024 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jPhQoGyC"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393901A7AE3;
	Thu,  3 Oct 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970102; cv=none; b=MkM8KH6vVxgvkrS14W8wXnS2SVnWxncA7GJaUFHF3oKhZMPS1RVmZ0cgzIu4karscO3VCjCV/cnFSXSAQEgdnWAeUkfamaU3yerbEVrtjf6/x5pkvz3x39xwgSJQZBUq1gKjnRV8lniL8V5OXATqSFvq1jCSnZf8dwXgQ9rkaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970102; c=relaxed/simple;
	bh=T09s7CEm776l1o8pV7+Nxz8F8aawlsJfHEmy4sVirnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJC/p01Ha3t6nvCPad7L4URwz3diyT0jNH1eOiLXm/GFNhojwvOjvuHdJtB4i2APDO5kdGkXnS45L+0V+7R2UH5NzuNlqNmVH5bj5bxzzJUm0KJ2Ux3iFkjBh6/mIGuoq6ZxLeW7/HyNoCov1ihAMvNn7dmvt1cmWhSnz1hEAhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jPhQoGyC; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=WNxCnh/GMRkWLdjB68egofWsB2M7uQzqy5gg+C9ZsBo=;
	b=jPhQoGyCde6czcsdkqKFRQgU0WrNoCkSQykLrheO0eUjN6bMYsp2bQOfqtibmM
	/WA5znQsWmR26r4X37+Zi7nclzttS4ZV5/q4jSfE5xWMvnr7S6cpyIgIrBUrbqYY
	BvM1/UXqMhLjpEn8BwRDl8kXcdN59UnZyx6GYiS6WYOKo=
Received: from localhost (unknown [36.5.132.7])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3fwsmu_5mKB86Aw--.37596S2;
	Thu, 03 Oct 2024 23:41:26 +0800 (CST)
Date: Thu, 3 Oct 2024 23:41:25 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 set_powered_sync
Message-ID: <Zv67JUPfzgQp7Kgf@fedora>
References: <Zv6qDfzdXMrSjGkE@fedora>
 <66feadf0.050a0220.9ec68.0042.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66feadf0.050a0220.9ec68.0042.GAE@google.com>
X-CM-TRANSID:_____wD3fwsmu_5mKB86Aw--.37596S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW5uF1UKrW3GrWxAw4DXFb_yoW3KFcE9r
	1Yvay3urWUXry5JF4j9r47ur4fJFs5KFn7Ww1SqFWUW3s8Ga1UJr4xXrn3ZF13uanrAF13
	Arn8CF92q3y8KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRyv37UUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLwttamb+p1TtwQAAsk

#syz test

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5533e6f561b3..353fa423c36c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -321,7 +321,7 @@ static void hci_cmd_sync_work(struct work_struct *work)
 
 		bt_dev_dbg(hdev, "entry %p", entry);
 
-		if (entry->func) {
+		if (entry->func && entry->data) {
 			int err;
 
 			hci_req_sync_lock(hdev);
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 0115f783bde8..eccc51bfaf2e 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -307,6 +307,7 @@ void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
 	sock_put(cmd->sk);
 	kfree(cmd->param);
 	kfree(cmd);
+	cmd = NULL;
 }
 
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)

-- 
Best,
Qianqiang Liu


