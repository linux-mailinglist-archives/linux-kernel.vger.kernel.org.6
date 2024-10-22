Return-Path: <linux-kernel+bounces-376169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6424C9AA112
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A731F241F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F319AD7D;
	Tue, 22 Oct 2024 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Qojm7Q3M"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C14199FD7;
	Tue, 22 Oct 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596231; cv=none; b=Tv43Q3FXFAGF2UiABYFbuW8czhPUrhUXQrxQ6kxltRVmd+CJNSKMZif0+2312sjZ4mb56pNL0uMm0TkZ5FTN4Bib/K+15145XbVLJO/2W5GzMmXxoLc8CziNKSO1/M9vakANekelcQ+weA7p11eo9UE4uy/iqHCRamCHXXdyQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596231; c=relaxed/simple;
	bh=XIaeZDkuM54vMToIddaRH7EUZ/3HGuH4c4AwgYOup68=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Nt4LdEvxCQ7Qw+tyiOXp+DwZcIKQz/+hFlzpPW0UG/XMXz73DzZd7pFZ3GSLhN/l5yp+DQUK5LuM5ryqNrHsipGjqpbkHr/jUNUw4j7CYNzMvrnpUZz323pYEslfg2BKUGTHImL+s4nyshXeAlfhFa5msuASOZm6c37VSn0hqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Qojm7Q3M; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:From:Mime-Version:Subject:Date:
	Message-Id; bh=g3EQkqtxNAjH2cWX8C1ziG2yXvTj3iiRh8WSKmKQiFM=; b=Q
	ojm7Q3M/G+TyIuztRsnOIZJiPM9X3VMfdc0QUFw6TzMq0P+fkkltMwdCwBbwslYD
	uUHodi+F1Weat4pD3DGfVU8eFbuHTZfQYmOhkv+bmjp1j9/mFT1VaT9YY5PAmZ6k
	jmQACcPfvzQhAzPqbhI6C9gT5HSiI2d5BQQbV5ic0Y=
Received: from smtpclient.apple (unknown [39.144.240.214])
	by gzsmtp3 (Coremail) with SMTP id sigvCgAXn_goixdnTjvvBA--.43844S2;
	Tue, 22 Oct 2024 19:23:20 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Qianqiang Liu <qianqiang.liu@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: linux-next: Signed-off-by missing for commit in the gfs2 tree
Date: Tue, 22 Oct 2024 19:23:09 +0800
Message-Id: <F1F8682B-9B60-4674-BF91-ADD15A429F1D@163.com>
References: <20241022075004.3369d8ec@canb.auug.org.au>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 Steven Whitehouse <swhiteho@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org
In-Reply-To: <20241022075004.3369d8ec@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: iPhone Mail (22A3370)
X-CM-TRANSID:sigvCgAXn_goixdnTjvvBA--.43844S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVdbbDUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRqAamcXhfZeBwABsu

Hi Stephen,

> Commit
>=20
>  507da2cb5d8a ("KMSAN: uninit-value in inode_go_dump (5)")
>=20
> is missing a Signed-off-by from its author.
>=20
> --
> Cheers,
> Stephen Rothwell
> <mime-attachment>

Yes, you=E2=80=99re right!

Do you how to solve this? The commit is already in linux-next tree.

=E2=80=94
Best,
Qianqiang Liu=


