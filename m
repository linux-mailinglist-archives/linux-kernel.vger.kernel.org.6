Return-Path: <linux-kernel+bounces-400405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3C09C0D04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF95B1C2290C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470902170A7;
	Thu,  7 Nov 2024 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="E8dRmb2p"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A318FDAF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000996; cv=pass; b=MG89m6WW0y+CzNd4nsJKmfBlWQFUGQqUjQ+qzvP0VLLhlcU9xxlLndzjHLcKvjxRXT9FtRX1wLVJu7pm57i9REOrvXJ6RD+NKyv+8Ojiw7jHCHnNwaHCuImRFOMolDW8AoRZzi1L/XKNSR4wndifAGcMlR+/oZtpFTKMp/qvcRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000996; c=relaxed/simple;
	bh=tmi2nS1gdek7p67aDiDFxjBr8kVvPuBXwned2YzOIWk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sQSjK6gOVuQJRC4SqsPoqrSkOgPSVcrtqvj9d/ZqEjgo9ctY3UxtgTPgdK1BKm3NUnfevMmh0VA0pec0eQjT3uSx8Bp7x5W2M/FQKL/hpp2Ino/8QTL6Rh+mtsxPwga2FoPgNbOyQpTQP2N+G/nwI8EoDRPxb1hqsfKZvecL7BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=E8dRmb2p; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731000973; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WswQFc65ea2XwcO+AzVo7CwOc9qlyRNM963ccb0A6zeXtQ4+FNoaSFHEkxfSNsTPw04yZ7qSo45zMJS5njVK2muHQa+ddD0Enej3Q7UfBl7M8VwosfBNJ4lZjHjTm0Xfii/8eWGq7nFbp6sD5IqJ7i/IQBryv/Kw5ATUmjR0I8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731000973; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PdE4ykKNJSNlV1pRPYoOXM/Kn1pAZdReh7vgzLa8+BU=; 
	b=UE1e02WMQxXDaqrR6m9KRuV2f68nAPYVMOfJUYCOL33+gnn3O7Uh/LKc+yZ6kuba9IVihW0tAQjQjoBhr0nD2ESOHEEwu9V/FcfzGSzftnBoeXDPYkRNCQrtE2HfAFwpOq8DkhgVeKVpgAFFuSFk3y8xVEU32Xq8VIBc3wlBjcU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731000973;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PdE4ykKNJSNlV1pRPYoOXM/Kn1pAZdReh7vgzLa8+BU=;
	b=E8dRmb2p7qs43YSwYmzCW9k9mjTDeR6gL7jee+5btXiB2ITC3VGzQbdagqYYBh8z
	ra1xSbRavbSf0At/dCtBLa8inkl7+7E8PliQePOt/HY07nYo+1UrX5hgq6D8A0lMen8
	W03+cHA5NKJxix1Mra6Oa54ctb1nVmru1sMqW4po=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1731000942359211.08673613865676; Thu, 7 Nov 2024 09:35:42 -0800 (PST)
Date: Thu, 07 Nov 2024 17:35:42 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
	"Sagi Grimberg" <sagi@grimberg.me>, "kernel" <kernel@collabora.com>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19307b23f01.fcb555461012595.2202335253480073101@collabora.com>
In-Reply-To: <Zyz2oiQ2pco15HHT@kbusch-mbp>
References: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com>
 <20241107165131.3462171-1-bob.beckett@collabora.com> <Zyz2oiQ2pco15HHT@kbusch-mbp>
Subject: Re: [PATCH] nvme-pci: 512 byte dma pool segment quirk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail



 ---- On Thu, 07 Nov 2024 17:19:30 +0000  Keith Busch  wrote ---=20
 > On Thu, Nov 07, 2024 at 04:50:46PM +0000, Bob Beckett wrote:
 > > @@ -611,7 +612,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvm=
e_dev *dev,
 > >  =C2=A0=C2=A0=C2=A0=C2=A0}
 > > =20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0nprps =3D DIV_ROUND_UP(length, NVME_CTRL_PAGE=
_SIZE);
 > > -=C2=A0=C2=A0=C2=A0=C2=A0if (nprps <=3D (256 / 8)) {
 > > +=C2=A0=C2=A0=C2=A0=C2=A0if (nprps small_dmapool_seg_size / 8)) {
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pool =3D dev->prp_sma=
ll_pool;
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iod->nr_allocations =
=3D 0;
 > >  =C2=A0=C2=A0=C2=A0=C2=A0} else {
 >=20
 > We have a constant expression currently, and this is changing it a full
 > division in the IO path. :(

yeah, that's fair. Does it get high enough throughput that this is a signif=
icant issue here? (I have little intuition for this driver).
how about pre-computing the nprps threshold during pool creation where we d=
etect the quirk, it would then be variable comparison instead of a const co=
mparison, but no divide?

 >=20
 > Could we leave the pool selection check size as-is and just say the cost
 > of the quirk is additional memory overhead?
 >=20
 > > @@ -2700,8 +2701,9 @@ static int nvme_setup_prp_pools(struct nvme_dev =
*dev)
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
 > > =20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0/* Optimisation for I/Os between 4k and 128k =
*/
 > > -=C2=A0=C2=A0=C2=A0=C2=A0dev->prp_small_pool =3D dma_pool_create("prp =
list 256", dev->dev,
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
256, 256, 0);
 > > +=C2=A0=C2=A0=C2=A0=C2=A0dev->prp_small_pool =3D dma_pool_create("prp =
list small", dev->dev,
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dev->small_dmapool_seg_size,
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dev->small_dmapool_seg_size, 0);
 >=20
 > I think it should work if we only change the alignment property of the
 > pool. Something like this:
 >=20
 > =C2=A0=C2=A0=C2=A0=C2=A0if (dev->ctrl.quirks & NVME_QUIRK_SMALL_DMAPOOL_=
512)
 > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->prp_small_pool =3D =
dma_pool_create("prp list 256", dev->dev,
 > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0   =
   256, 512, 0);

I actually already tested a change of 512, 512 while keeping the 256 devisi=
on above during testing (i.e. waste half of the segment). I'll confirm with=
 a test again against latest and send a v2 assuming it tests fine.

 > =C2=A0=C2=A0=C2=A0=C2=A0else
 > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->prp_small_pool =3D =
dma_pool_create("prp list 256", dev->dev,
 > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0   =
   256, 256, 0);
 >=20


