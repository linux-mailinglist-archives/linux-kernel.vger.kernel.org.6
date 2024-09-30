Return-Path: <linux-kernel+bounces-344725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D46F98AD77
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82A3282A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C9B19DF4F;
	Mon, 30 Sep 2024 19:54:13 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEC14F9D9;
	Mon, 30 Sep 2024 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726053; cv=none; b=dRljzEELEMo1gE88/bxJ8P9eJyPbflXjl4pa84vUvICMcYPYBCexhZRid7/oOLJ+AqwACz7U1b480EPXehlGLzkigEZeTCPAD2kETWD9E4dfJkyYz8VuvMi4RrMB/0O+MCm1Bn/bUnY3sbV1/n0U6Lns9Pjpbq/zZP0w4VISDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726053; c=relaxed/simple;
	bh=RbHXxABmTEXZ06KmbyemtTfZCSrMOmq194z3V+gF2Bw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EdA95OrGzGNY8ajUdEvxugOL9TcIL4l/9x/bPeM1fhDVTDLHhkCrOvmYekZV/EgRdFxAcuNRrRDT8vFI+Db4YjqCfc5OX14aIVrX6NXbuGBCK+brv3YmQOaQ83hZne1pbq6wnv4JF7WSptI/e8xHL/nobmqOH8jxj/pdEMb9qZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 665C463CF3E8;
	Mon, 30 Sep 2024 21:54:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PkYbUnff558D; Mon, 30 Sep 2024 21:54:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CFEF963CF3E7;
	Mon, 30 Sep 2024 21:54:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GHvTMUPSlfO9; Mon, 30 Sep 2024 21:54:07 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9286964CD87E;
	Mon, 30 Sep 2024 21:54:07 +0200 (CEST)
Date: Mon, 30 Sep 2024 21:54:07 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Daniel Golle <daniel@makrotopia.org>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, robh <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, John Crispin <john@phrozen.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1249604143.124110.1727726047386.JavaMail.zimbra@nod.at>
In-Reply-To: <Zvr-hOM2DfveaqeC@makrotopia.org>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org> <b43a7155f80995c3986893951c092291caf3a5f4.1727527457.git.daniel@makrotopia.org> <251386789.117942.1727612762462.JavaMail.zimbra@nod.at> <ed98871a-b41a-9755-4eed-18ad9e00869c@huawei.com> <364911897.123906.1727721820227.JavaMail.zimbra@nod.at> <Zvr-hOM2DfveaqeC@makrotopia.org>
Subject: Re: [PATCH RFC 2/2] mtd: ubi: add support for protecting critical
 volumes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Topic: add support for protecting critical volumes
Thread-Index: aeGJjhImZZ32HQn7G/dgrummX5ojmQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
>> like a ubirmvol ... --i-know-what-im-doing.
>=20
> True, enforcement doesn't need to happen in kernel (though I think it's
> nicer, but really just a matter of taste, I guess). ubi-tools would still
> need to be able to recognize critical volumes somehow, and that could be
> done by checking if the 'volume-is-critical' property is present in
> /sys/class/ubi/ubi*_*/of_node/

Exactly.
I also don't mind adding a in-memory 'volume-is-critical' property to
UBI directly. I'm just a little hesitated to change the UAPI or the on-disk
data structures for this features.
=20
> If you prefer going down that road instead I will work on patches for
> git.infradead.org/mtd-utils.git instead.

Yes. When done in userspace, it's also much easier to offer the --i-know-wh=
at-im-doing
flag to still remove a critical volume.
No need to touch UAPI.

Zhihao Cheng, what do you think about this approach?

Thanks,
//richard

