Return-Path: <linux-kernel+bounces-521051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C738A3B339
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C16116E231
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B651C4A2D;
	Wed, 19 Feb 2025 08:08:39 +0000 (UTC)
Received: from outbound22.service-now.com (outbound22.service-now.com [149.96.6.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B311C3BE2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.96.6.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952519; cv=none; b=npTNKtrRv93Wufx3/oP9UHfM7EXQeWXkve58NpJrVNAYnE7MLVLNzuj1blOtLhVYC2UU1JtX7nfkv63JJy+9sSdsvwjRYy+0gSa22VLRdSK638UziZ6gfbVodo4/2TiNqeieystY+MZTBrNnObF7oSbD9aCHeAOtwXaWn9qa33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952519; c=relaxed/simple;
	bh=d9hS4Ym2CA5h3FQPBwEjDHjipPL9KNmcD7YoFeLPQkc=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=bERJLPLgVXZO5iOjQqA/340JqTI9VlzYRDtI2TDw1YNtwx6W897TnFcaaCmLvqOmzVQUMzC6sOcQOh/u2oKM3m69ToMaplWXi/6qCG3KqJxLo7dePoVKSepXcOSnHM9I2ug+i8ZLbntMqxU9de5Y6bGygwfbtJO2G3IPcuZItNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=149.96.6.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from app132146.ycg201.service-now.com (unknown [10.248.3.236])
	by outbound22.service-now.com (Postfix) with ESMTP id E36D46000089;
	Wed, 19 Feb 2025 00:08:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 outbound22.service-now.com E36D46000089
Date: Wed, 19 Feb 2025 00:08:36 -0800 (PST)
From: Red Hat Product Security <secalert@redhat.com>
Reply-To: Red Hat Product Security <secalert@redhat.com>
To: syzkaller@googlegroups.com, liujingfeng@qianxin.com, shaggy@kernel.org,
	rkeshri@redhat.com, security@kernel.org,
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-ID: <1097140732.33089.1739952516920@app132146.ycg201.service-now.com>
Subject: Re: FW: GPF and null-ptr-deref caused by uninitialization of jfs
 module(INC3342348)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_33087_55735206.1739952516920"
X-ServiceNow-Source: Notification-ec04d32213ede300196f7e276144b04e
X-ServiceNow-SysEmail-Version: 2
Precedence: bulk
Auto-Submitted: auto-generated
X-ServiceNow-Generated: true

------=_Part_33087_55735206.1739952516920
Content-Type: multipart/alternative; 
	boundary="----=_Part_33088_26762839.1739952516920"

------=_Part_33088_26762839.1739952516920
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hello!

INC3389413 (FW: GPF and null-ptr-deref caused by uninitialization of jfs mo=
dule(INC3342348)) has been updated.

Opened for: liujingfeng@qianxin.com
Followers: security@kernel.org, shaggy@kernel.org, jfs-discussion@lists.sou=
rceforge.net, linux-kernel@vger.kernel.org, Rohit Keshri, syzkaller@googleg=
roups.com

A Guest updated your request with the following comments:

Reply from: liujingfeng@qianxin.com [mailto:liujingfeng@qianxin.com]
 > On Mon, Feb 10, 2025 at 10:09:54AM +0800, =E6=9F=B3=E8=8F=81=E5=B3=B0 wr=
ote:
> > Hello,Here is forward INC3342348 origin message
> >
> > I hope to receive updated response regarding this issue.
>=20
> We have no lack of syzbot reported issues, what we do have is a lack of p=
eople
> fixing them, so patches are always welcome, especially as you already hav=
e a
> working reproducer for the problem to test against.
>=20
> thanks,
>=20
> greg k-h
 Hello,I try to do it.
 TxBegin returns 0 because the file system is read-only, and TxBlock [tid=
=3D0] is a reserved block, so I tried to perform a read-only file system ch=
eck in the jfs_create function. This should prevent crashes, but I'm not su=
re if it affects the original logic. I hope developers can help check this =
patch.
  diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index d68a4e6ac345..4b6d85d47c3a 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -77,6 +77,10 @@ static int jfs_create(struct mnt_idmap *idmap, struct in=
oded,
 if (rc)
 goto out1;
+ if (isReadOnly(dip)){
+ rc=3D-EROFS;
+ goto out1;
+ }
 /*
 * search parent directory for entry/freespace
 * (dtSearch() returns parent directory page pinned)

How can I track and update my request?

To respond, reply to this email. You may also create a new email and includ=
e the request number (INC3389413) in the subject.

Thank you,
Product Security

Ref:MSG101796497
------=_Part_33088_26762839.1739952516920
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div><p style=3D"margin-top:0;margin-bottom:10px;"=
>Hello!</p><p style=3D"margin-top:0;margin-bottom:10px;">INC3389413 (FW: GP=
F and null-ptr-deref caused by uninitialization of jfs module(INC3342348)) =
has been updated.</p><p style=3D"margin-top:0;margin-bottom:10px;">Opened f=
or:&nbsp;liujingfeng@qianxin.com<br>Followers:&nbsp;security@kernel.org, sh=
aggy@kernel.org, jfs-discussion@lists.sourceforge.net, linux-kernel@vger.ke=
rnel.org, Rohit Keshri, syzkaller@googlegroups.com</p></div>
<p style=3D"margin-top: 10px; margin-bottom: 10px;">A Guest updated your re=
quest with the following comments:</p>
<div style=3D"padding: 10px 0 10px 10px; background-color: ivory;"><div>Rep=
ly from: <a target=3D"_blank" href=3D"mailto:liujingfeng@qianxin.com" rel=
=3D"noopener noreferrer nofollow">liujingfeng@qianxin.com</a></div><div>&nb=
sp;</div><div>&gt; On Mon, Feb 10, 2025 at 10:09:54AM +0800, =E6=9F=B3=E8=
=8F=81=E5=B3=B0 wrote:</div><div>&gt; &gt; Hello,Here is forward INC3342348=
 origin message</div><div>&gt; &gt;</div><div>&gt; &gt; I hope to receive u=
pdated response regarding this issue.</div><div>&gt; </div><div>&gt; We hav=
e no lack of syzbot reported issues, what we do have is a lack of people</d=
iv><div>&gt; fixing them, so patches are always welcome, especially as you =
already have a</div><div>&gt; working reproducer for the problem to test ag=
ainst.</div><div>&gt; </div><div>&gt; thanks,</div><div>&gt; </div><div>&gt=
; greg k-h</div><div>&nbsp;</div><div>Hello,I try to do it.</div><div>&nbsp=
;</div><div>TxBegin returns 0 because the file system is read-only, and TxB=
lock [tid=3D0] is a reserved block, so I tried to perform a read-only file =
system check in the jfs_create function. This should prevent crashes, but I=
'm not sure if it affects the original logic. I hope developers can help ch=
eck this patch.</div><div>&nbsp;</div><div>&nbsp;</div><div>diff --git a/fs=
/jfs/namei.c b/fs/jfs/namei.c</div><div>index d68a4e6ac345..4b6d85d47c3a 10=
0644</div><div>--- a/fs/jfs/namei.c</div><div>+++ b/fs/jfs/namei.c</div><di=
v>@@ -77,6 +77,10 @@ static int jfs_create(struct mnt_idmap *idmap, struct =
inoded,</div><div>        if (rc)</div><div>                goto out1;</div=
><div> </div><div>+       if (isReadOnly(dip)){</div><div>+               r=
c=3D-EROFS;</div><div>+               goto out1;</div><div>+       }</div><=
div>        /*</div><div>         * search parent directory for entry/frees=
pace</div><div>         * (dtSearch() returns parent directory page pinned)=
</div></div>
<div><p style=3D"margin-top:20px;margin-bottom:10px;"><strong>How can I tra=
ck and update my request?</strong></p><p style=3D"margin-top:0;margin-botto=
m:10px;">To respond, reply to this email. You may also create a new email a=
nd include the request number (INC3389413) in the subject.</p></div>
<p style=3D"margin-top: 14px; margin-bottom: 0;">Thank you,<br>Product Secu=
rity</p><div>&nbsp;</div><div style=3D"display:inline">Ref:MSG101796497</di=
v></body></html>
------=_Part_33088_26762839.1739952516920--

------=_Part_33087_55735206.1739952516920--

