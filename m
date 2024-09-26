Return-Path: <linux-kernel+bounces-340264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792479870A5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E4128538E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B31ACDE2;
	Thu, 26 Sep 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="N6d60AtI"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9F1A4B8F;
	Thu, 26 Sep 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344124; cv=none; b=HxrOt4H+pfmqGHU9DNyfmu+zvsXeLqp4aHC47EjjS3rnGtX4CpKk849v2fHRaISO5pL5LP6lJsiE8Y9ijE9rPGhIG4JvWnstkF+Nvbjqh/d0D2ITnzmgJ0fnqC0lCJJLKVEVN5QCQD5AgQAKnDK++tTTAmPBWw/n7ms9evSk3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344124; c=relaxed/simple;
	bh=iR+RMLxUi1/NM1IwtpX15nX6Z4nuN46vi8tXDNK8OQU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SYBHqoIj5qWBbKsoQn+QMzRhrgt6u5VsCbuBJLGOw8o0GrZbYkG8QyOJi7yqzD/I5fkDR0lBGOgERIWXdB5hWYKSAUSInVan9XQx2dNDh2v5u1Ums5IwZKJCtA8ADiLNThNh4bC2NzqorZ04v+0gBNR0z6Fc8FoDYJZuYyEnuy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=N6d60AtI; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727344092; x=1727948892; i=markus.elfring@web.de;
	bh=tRdsbJY25B3a8k8qKa0EJwZ/dzDVfGUya9eB7dbMVXw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N6d60AtIxf5OOL90zBizubDWpWb1K139rFzXGBpfdJli3ptI1rr1UEyyeEt3Zaw1
	 Q/zFcLLo41FXKeV5ukwU0dhofmpfbGYRrdap2WBV0uF7MrDXr2woqEoFPWDx3GZX9
	 TxfEcJiSvw9C6ABhOfALW0yflync2XhToyTTjX9H++ByRkaPmvsquvxwLV3oiNZ4o
	 v+Xh8myUSG//IbB36VZLovnk2AQu1hIIN4JtdysUBrk7sxeZRFWSU38iC/dabZVkx
	 8XjG/QcQwhOjL7guEU++b8VSK+nepVXRitOAXIoNir6HhXS8t/oOwPQQxTdyyOM2S
	 Lytc540h9X/3r/v5gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBS6v-1smHvY45oV-00A03x; Thu, 26
 Sep 2024 11:48:12 +0200
Message-ID: <ff787fb9-a9fc-4798-8460-3ec310e6cd9f@web.de>
Date: Thu, 26 Sep 2024 11:48:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] ubifs: Adjustments for ubifs_purge_xattrs()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SKo6e36D5dAX15LA2EoqmfyeK9m+ZMvHq5SxSQFIUZB7ZQcVHeU
 g5urHpUmbs0Kty7DAM+jw15DdBF2XGfaq1ofz62o9w1dDb8wyC6AuQH/isf0K12cV1iNmtv
 6kJo5sZXTcEwfcJTTZM+eerRUIBf9tS7cE5Fzfn4ETTWnvfQ75z7mq2ZvPkbKvFNHYhJ7Pj
 Hzry6Hm5kjzdmrxd03ASg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rN3/utJeV6I=;UpEzucDmePMbuFiBcP/MHq8KdvP
 aQf20N+Gfm02sm0eFEiecQHkpYbxpVUSKDoZAB9G6vMftVFgkyIiTSvYBnj5qLA2XHY6T9yix
 HImGe7FwPsGFIEJjs+Jtt2nfZ9FjPU0fwKrMnj3vmLyAhD/OwmvC1kCW3XEq3eQyI2fedGYG7
 GiBHHh/o3UK7fMPCSq6aztvhp2AJpYuVKBT4ijCOaYYs6oRsQ9L+Iq6pP30ipT+XJ70mGAfC3
 aopOI1VB6XsmPvyhM+jr+Vza+IXwozlNE1EAqoIickaPxyp+QAtpWt3hCr8kLDZTBTwgt/vZb
 2sggn9ui/q22a1/7jWMQRffzUnGOlfUgoSqL7mrNsO9LCLT6LsalIXoO+6NnuL7UjGdmASTdK
 o2kzfP+JC1jnmRs6TP+v9g7SrBBnRBFIUpPnGf5+EIDi0em5YQbsPxXMxhvQ6LtxEIdhUJW+a
 LIiM6NWEBs2ZaqtF4bF07V9HolJAUj/E8VI9+N/GdHvSTkJbzNFj6rVuiI+3Y2r8q3wjd/WvH
 Gp2MyiyFxxxsWCjbF4JzL1lUjnzPg7VMFqsrDL85qYPX0p+2M4XQJdOxQ5gCq02sn4V35WMJf
 552dFcWno25oq2EGhaaMXrK4E2Dr2uHLKz7xiXrKcHp+NqVgHhg/SJUMcXCjpSmq7hlhb0lW3
 Pr+32xLN5/RV+ti1zZiAvJA08I29samtLQ1smBmCs+kTuD37rSg4vncBOq5D14SmWnHgDNlN4
 j6Nys7KF6F2ljHQ0MwWH5TnuaVVhi03vV3D0GhAaAFtjeekjDC2Lj6oGRYmB+bUDlFYHB+tvi
 jFdE0xSaS06/rB+E+aD8knvw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Sep 2024 11:38:22 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Call iput(xino) only once
  Reduce kfree() calls

 fs/ubifs/xattr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

=2D-
2.46.1


