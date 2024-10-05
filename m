Return-Path: <linux-kernel+bounces-351948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 061FC991830
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4CE1F23013
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86F156C5E;
	Sat,  5 Oct 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UrTA+Hn2"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BAD3A8F0
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728145067; cv=none; b=ocFSoOT8Euztgd2+Hlr3YRj2xfWPzX/ondJT4X2u9QjjZ0V6Im0PdjDKAbbPaOwzhMRG96Fs3tBATUCtR++e4BCU2ZHIDPtPodpiqVRkiMnk/8Vz7zi4TJVE7l2bQo5JBvssmMlGpPa2bYTiy93ByLuYSlYGZCvcygY57CrAvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728145067; c=relaxed/simple;
	bh=sHKoS3BN9fpfLGjHRiJ8ZrcURaLtFw0T+ToIiKx8rFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skVUbnjNiWNG59JrWIDF/y73Gr2NphHzWaG2KZ2oSmPQCbWvOKgnqOmTEqQJSVRTbSykaohGwgzh+GKJ5nx91wQ1DzwaxoiaJl5IaHbGwoIesug6tbl8o1t3M+TXTHzarwFL9yJ/MaTyF/YTSzXMzLKzXGM36QHheXPpydA5uaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UrTA+Hn2; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=sPRYKTUuN9x9SJKdTcc6P4AJdIR5+O0ksRXcbg9ijpY=;
	b=UrTA+Hn2G0STLuNCz+V3K5dTG3yWuORr/sn6atCT1EHVsaWOilOGGD1S7wnjsE
	+bba64MYg8F0wfCPb3QaUdm0YchsYNH/V1DJycrRGV8RpCuCDcQxEvBWX+iJDFdu
	VyUHz+/DtHR0to07PfjEqUB08l1QaLNKIpiDJ1dWEP454=
Received: from localhost (unknown [36.5.132.7])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3PyaKZgFn6Ll+BA--.29823S2;
	Sun, 06 Oct 2024 00:17:15 +0800 (CST)
Date: Sun, 6 Oct 2024 00:17:14 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] KMSAN: uninit-value in inode_go_dump (5)
Message-ID: <ZwFmiv0lqP02xPtq@fedora>
References: <66fca31e.050a0220.f28ec.04e4.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fca31e.050a0220.f28ec.04e4.GAE@google.com>
X-CM-TRANSID:_____wD3PyaKZgFn6Ll+BA--.29823S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4REwZcDUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRdvamcBWa5-AQAAs4

#syz test

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 6678060ed4d2..d60d53810bc1 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1537,11 +1537,13 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
 	if (!ip)
 		return NULL;
 	ip->i_no_addr = 0;
+	ip->i_no_formal_ino = 0;
 	ip->i_flags = 0;
 	ip->i_gl = NULL;
 	gfs2_holder_mark_uninitialized(&ip->i_iopen_gh);
 	memset(&ip->i_res, 0, sizeof(ip->i_res));
 	RB_CLEAR_NODE(&ip->i_res.rs_node);
+	ip->i_diskflags = 0;
 	ip->i_rahead = 0;
 	return &ip->i_inode;
 }

-- 
Best,
Qianqiang Liu


