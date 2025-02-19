Return-Path: <linux-kernel+bounces-521073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A2DA3B38E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C231816FE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A3F1C07D8;
	Wed, 19 Feb 2025 08:21:27 +0000 (UTC)
Received: from hmat.qianxin.com (hmat.qianxin.com [220.181.41.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF0180A80
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.41.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953286; cv=none; b=ShuqJL+arIIO3VVjWbo1dlkwWxDzgMDsuy5BAtU2ZPNGf3iTh9gIjTD8L6mO+lJu4VMAO+H23NM2Jr+PTxHivh6dPBPi7ErjvB8BCR6XiPVaDv6phc4ah9ML8ZRX/1CZOwe/JfQIUjvFRceilJPF9VEc2aT2xxNDkU1fAxD7tfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953286; c=relaxed/simple;
	bh=JYp4OK0U+b4qOG4P0pETiqrI1nIPYBpaJeHMfAoAt8g=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=L4XCamSebEzKhnbI8k5uuKY25GI+5Fb92OY4uVmABzj+Q9jo0qMdnzrIyudIRC/SuV7QntXGx9fqqrT92SD37nOD1rZ53Jh1zwYyvf1E/W63ifD0iF85JnX4x4W6r+VyvqhF0HJ/SVKCHu3h6b65pynFgH6wXDkch90Kah1mPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=qianxin.com; spf=pass smtp.mailfrom=qianxin.com; arc=none smtp.client-ip=220.181.41.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=qianxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qianxin.com
Received: from hmat.qianxin.com (unknown [10.44.121.98])
	by hmat.qianxin.com (SkyGuard) with ESMTPS id 4YyTTM2Ll0z2MWkC;
	Wed, 19 Feb 2025 16:05:11 +0800 (CST)
Received: from BJ3TS063 (10.110.199.9) by qax-bjmail06.ESG.360ES.CN
 (2402:d040:0:8425:2849:52e7:3abe:7096) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 19 Feb 2025 16:05:11 +0800
Return-Receipt-To: =?UTF-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
From: =?UTF-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
To: 'Greg KH' <gregkh@linuxfoundation.org>
CC: <security@kernel.org>, <shaggy@kernel.org>,
	<jfs-discussion@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<rkeshri@redhat.com>, <syzkaller@googlegroups.com>, <secalert@redhat.com>
References: <!&!AAAAAAAAAAAuAAAAAAAAAKIhlVZMQAxHpE33aCjXyrEBAMO2jhD3dRHOtM0AqgC7tuYAAAAAAA4AABAAAADjUO4EdW0hQ4941fq05lF+AQAAAAA=@qianxin.com> <2025021052-alfalfa-unwrapped-c53a@gregkh>
In-Reply-To: <2025021052-alfalfa-unwrapped-c53a@gregkh>
Subject: RE: FW: GPF and null-ptr-deref caused by uninitialization of jfs module(INC3342348)
Date: Wed, 19 Feb 2025 16:05:11 +0800
Message-ID: <!&!AAAAAAAAAAAuAAAAAAAAAKIhlVZMQAxHpE33aCjXyrEBAMO2jhD3dRHOtM0AqgC7tuYAAAAAAA4AABAAAABTrGeEs4SaSZ6/Js27w/JiAQAAAAA=@qianxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI7GIlFtJ/6vr9lkfloK3CXuqMOXQIrIPt0sn28c+A=
Content-Language: zh-cn
Disposition-Notification-To: =?UTF-8?B?5p+z6I+B5bOw?=
	<liujingfeng@qianxin.com>
X-ClientProxiedBy: qax-bjmail02.ESG.360ES.CN
 (2402:d040:0:8425:80c4:a21f:47a:b645) To qax-bjmail06.ESG.360ES.CN
 (2402:d040:0:8425:2849:52e7:3abe:7096)

> On Mon, Feb 10, 2025 at 10:09:54AM +0800, =E6=9F=B3=E8=8F=81=E5=B3=B0 =
wrote:
> > Hello,Here is forward INC3342348 origin message
> >
> > I hope to receive updated response regarding this issue.
>=20
> We have no lack of syzbot reported issues, what we do have is a lack =
of people
> fixing them, so patches are always welcome, especially as you already =
have a
> working reproducer for the problem to test against.
>=20
> thanks,
>=20
> greg k-h

Hello,I try to do it.

TxBegin returns 0 because the file system is read-only, and TxBlock =
[tid=3D0] is a reserved block, so I tried to perform a read-only file =
system check in the jfs_create function. This should prevent crashes, =
but I'm not sure if it affects the original logic. I hope developers can =
help check this patch.


diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index d68a4e6ac345..4b6d85d47c3a 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -77,6 +77,10 @@ static int jfs_create(struct mnt_idmap *idmap, struct =
inoded,
        if (rc)
                goto out1;
=20
+       if (isReadOnly(dip)){
+               rc=3D-EROFS;
+               goto out1;
+       }
        /*
         * search parent directory for entry/freespace
         * (dtSearch() returns parent directory page pinned)


