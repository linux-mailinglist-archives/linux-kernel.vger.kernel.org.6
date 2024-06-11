Return-Path: <linux-kernel+bounces-210570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE46A9045AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D00281F69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D19014535A;
	Tue, 11 Jun 2024 20:19:09 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE831534FB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137149; cv=none; b=PK4C0RtfKUuAEMBZsdb4xBqSmQCXPatdZq4Ahiac5QY2B0oxuaFOTpZ3IdyG0QMT51nwiNTp6NmQpnr17jdgJf6d2pMbr7Y0iXibFYqR26CFV2pymy8gmmRzaa1w+4B4wRGrOH1ZodU/+FfJq0zfbMDdQ59qdlZqxA/335+PYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137149; c=relaxed/simple;
	bh=RudqBTNT9j5reE6QOukW7HQMsv1XXfJYtnbSnLSsNd8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eDqQhXdwidCADaosK7tuRYoYYNcuSI2P8ij8QnxtXieiorbRBUynKVdSbwp6R1u2/Cvcnog3+a2mLomQ2dE4ohV3LE68uWHR7kROQoiPZCHMMaLFSScbbs7L9buuyYD73G0cgJqNUgEtFl3bh89YXOcejyIOrHlOELMP2Bedrp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AF47061966B5;
	Tue, 11 Jun 2024 22:19:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id X-qeMHHyOscx; Tue, 11 Jun 2024 22:19:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C464D61966BF;
	Tue, 11 Jun 2024 22:19:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y9093tRPmx8Q; Tue, 11 Jun 2024 22:19:02 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id A1B3F61966B8;
	Tue, 11 Jun 2024 22:19:02 +0200 (CEST)
Date: Tue, 11 Jun 2024 22:19:02 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Hongbo Li <lihongbo22@huawei.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2144113714.220205.1718137142446.JavaMail.zimbra@nod.at>
In-Reply-To: <20240611-hostfs-fix-mount-api-conversion-v1-1-ef75bbc77f44@kernel.org>
References: <20240611-hostfs-fix-mount-api-conversion-v1-1-ef75bbc77f44@kernel.org>
Subject: Re: [PATCH] hostfs: Add const qualifier to host_root in
 hostfs_fill_super()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: Add const qualifier to host_root in hostfs_fill_super()
Thread-Index: y+ZRrqRbHMaINlAXXO3Imv4O2bKOCA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Nathan Chancellor" <nathan@kernel.org>
> An: "Christian Brauner" <brauner@kernel.org>
> CC: "Hongbo Li" <lihongbo22@huawei.com>, "richard" <richard@nod.at>, "ant=
on ivanov" <anton.ivanov@cambridgegreys.com>,
> "Johannes Berg" <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.i=
nfradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Nathan Chancellor" <nathan@kernel.org>
> Gesendet: Dienstag, 11. Juni 2024 21:58:41
> Betreff: [PATCH] hostfs: Add const qualifier to host_root in hostfs_fill_=
super()

> After the recent conversion to the new mount API, there is a warning
> when building hostfs (which may be upgraded to an error via
> CONFIG_WERROR=3Dy):
>=20
>  fs/hostfs/hostfs_kern.c: In function 'hostfs_fill_super':
>  fs/hostfs/hostfs_kern.c:942:27: warning: initialization discards 'const'
>  qualifier from pointer target type [-Wdiscarded-qualifiers]
>    942 |         char *host_root =3D fc->source;
>        |                           ^~
>=20
> Add the 'const' qualifier, as host_root will not be modified after its
> assignment. Move the assignment to keep the existing reverse Christmas
> tree order intact.
>=20
> Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

