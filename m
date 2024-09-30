Return-Path: <linux-kernel+bounces-344644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC78A98AC46
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9422820D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FAB1991D3;
	Mon, 30 Sep 2024 18:43:53 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DF14A627;
	Mon, 30 Sep 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721832; cv=none; b=Sp/L2YeeqZNMFawvuZN8gQ7WwYU5txSHdPmuHRpRL2ixRrQ+6NCpHDD0LgQ1iBG1mIuheW3imwkw0Zaffzd2yVLPQ67KfdAvX5lGINx4BZL+jGTSP4mNHzBorlMcPlnwDr4NR5GwX1zqjuIJc4kicozs2uTlfWnpVnTvajvDqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721832; c=relaxed/simple;
	bh=O0+V9e/iDm2cJDhnR5sRzAjI5+c1nwpVnK1xf6sQeeQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=szEX4uDbYTD4wvZ7WqWIsto41nNgoAPbTIWCbEFcTX3UakFyre/pyZat3sUMboDSz0+F4QaXpcL2hpdbUlbtJJT0hyrGp2T3FUrrsr3rE/nzwCSe4TET4gdowtumw3c3070dalxO67n9ZV7RbW3RHXgn7FNnW6jNreOZy6hDvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4447664CD871;
	Mon, 30 Sep 2024 20:43:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Vt2OYhpY_iKE; Mon, 30 Sep 2024 20:43:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 807DA63CF3E7;
	Mon, 30 Sep 2024 20:43:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wo08-DoSlZS3; Mon, 30 Sep 2024 20:43:40 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5BA4264CD871;
	Mon, 30 Sep 2024 20:43:40 +0200 (CEST)
Date: Mon, 30 Sep 2024 20:43:40 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: chengzhihao1 <chengzhihao1@huawei.com>
Cc: Daniel Golle <daniel@makrotopia.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, robh <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, John Crispin <john@phrozen.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <364911897.123906.1727721820227.JavaMail.zimbra@nod.at>
In-Reply-To: <ed98871a-b41a-9755-4eed-18ad9e00869c@huawei.com>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org> <b43a7155f80995c3986893951c092291caf3a5f4.1727527457.git.daniel@makrotopia.org> <251386789.117942.1727612762462.JavaMail.zimbra@nod.at> <ed98871a-b41a-9755-4eed-18ad9e00869c@huawei.com>
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
Thread-Index: lFqEN+m/q9e+j70Sp4sOBoOPT5+Uhg==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>>> Von: "Daniel Golle" <daniel@makrotopia.org>
>>> Allow the boot firmware to define volumes which are critical for the
>>> system to boot, such as the bootloader itself if stored inside a UBI
>>> volume. Protect critical volumes by preventing the user from removing,
>>> resizing or writing to them, and also prevent the UBI device from
>>> being detached if a critical volume is present.
>>=20
>> I agree with the doubts raised in patch 1/2, if userspace is so hostile
>> to delete system partitions, there is little hope.
>> But I'm still open for discussion.
>=20
> Yes, I agree that it is meaningful to prevent user from operating
> volumes accidently. How about doing that by some existing methods? Eg.
> selinux(Design sepolicy for ioctl cmd).

Another thought, do we really need to enforce this in kernel space?
Teaching ubi-tools to be super careful with some volumes is also an option.

like a ubirmvol ... --i-know-what-im-doing.

Thanks,
//richard


