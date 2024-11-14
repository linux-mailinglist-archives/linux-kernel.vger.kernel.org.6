Return-Path: <linux-kernel+bounces-409663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB73C9C8FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F5CB37CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50AF198856;
	Thu, 14 Nov 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="NSet1NUl"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4EA18BC28
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601780; cv=pass; b=K7gxsoIw/MKQnwZFls2JcJPIoi/+XiZcLls7eA3clOlSwlmnW0INNVN/ISAhmCCcEA42HU2M9rzxhjPpU/WkM9SglPk7R4IdeA/bRcGhpEnKnjoUDyGjGUtWiP2m/hj2HUsaubzyLaONs3YfXGhhMYBNkUR/rV3l7XSaTlcuHnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601780; c=relaxed/simple;
	bh=f24Vt4LatTOq01AGLPGizx+jZiPnzQU3NiYqJW56W9s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QR0QBx9TUZQlssTjcvFheLzIj4kSVwky00xSbHIfxpeb4udNt38HDLyc4ZVm2c9freMutHNh73NXlP2xyyzz20asahD5ZDG+mG9eGuclGNpiHXbOYhnaVsVzlNL9f3sAj/rvpoXU3kGMJBsb6fMq/xXYmQiCJU0ZPOr1X6hfRxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=NSet1NUl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731601761; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EiH/yIcICioce9zkgSAHj/SkSb/irerjPe7SHMsaSLsBwZQGMbyXJXFwS1na94Ndhbyd0223LaH3lyVMJ9ZlerM4XpMLIygu3DevQyKKCAXPixxZ+SbfVxy6sNraaXyBdk6gelrKGqkDv3OL0kLE4SJbcPU/8VMleyTJw/bHz4s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731601761; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jux1/7Oq5sSkRciDkevQ8m08gKvHuH9OPN15mEl8DU4=; 
	b=NJwf4eexMx6RXkqECTZaR2vW9JriGqvIGXSqguBr0iHhx0gMk0efPg3gq5DCuEIAp9j02LKcVRuSPDeQxzZAlnR/nMzT81MUC30e/ZKWBcifoQZe7RQheKYB/tKLkGt/jnd6JMZnz0qFyJn1g6QEYmItFFEr5nSeBR/4rjrLxss=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731601761;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jux1/7Oq5sSkRciDkevQ8m08gKvHuH9OPN15mEl8DU4=;
	b=NSet1NUlM1MOcekLKZ8Qs/5gf59RfLPhLO7mFEbPmLS+pyxOd+mamtB8Nt1TbYDv
	opjtRo/TjjPJ/wBa7VGUylrEd2DLFnniXiIKIVkB5byT55OAw7EPSQjnm2vPJuE0UB+
	5pVudpd/3vyeQ4t3lvS8VOg+qg4eIcA3nfiaoTR8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17316017283191001.8873990884078; Thu, 14 Nov 2024 08:28:48 -0800 (PST)
Date: Thu, 14 Nov 2024 16:28:48 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: =?UTF-8?Q?=22Pawe=C5=82_Anikiel=22?= <panikiel@google.com>
Cc: "axboe" <axboe@kernel.dk>, "hch" <hch@lst.de>,
	"kbusch" <kbusch@kernel.org>, "kernel" <kernel@collabora.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"sagi" <sagi@grimberg.me>
Message-ID: <1932b818328.ad02576784895.6204301822664878956@collabora.com>
In-Reply-To: <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com> <1932ad8722a.102613bdb3737.769617317074446742@collabora.com> <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
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



 ---- On Thu, 14 Nov 2024 14:13:52 +0000  Pawe=C5=82 Anikiel  wrote ---=20
 > On Thu, Nov 14, 2024 at 2:24=E2=80=AFPM Robert Beckett
 > bob.beckett@collabora.com> wrote:
 > > This is interesting.
 > > I had the same idea previously. I initially just changed the hard code=
d 256 / 8 to use 31 instead, which should have ensured the last entry of ea=
ch segment never gets used.
 > > When I tested that, it not longer failed, which was a good sign. So th=
en I modified it to only do that on the last 256 byte segment of a page, bu=
t then is started failing again.
 >=20
 > Could you elaborate the "only do that on the last 256 byte segment of
 > a page" part? How did you check which chunk of the page would be
 > allocated before choosing the dma pool?
 >=20
 > > I never saw any bus error during my testing, just wrong data read, whi=
ch then fails image verification. I was expecting iommu error logs if it wa=
s trying to access a chain in to nowhere if it always interpreted last entr=
y in page as a link. I never saw any iommu errors.
 >=20
 > Maybe I misspoke, the "bus error" part was just my speculation, I
 > didn't look at the IOMMU logs or anything like that.
 >=20
 > > I'd be glad to if you could share your testing method.
 >=20
 > I dumped all the nvme transfers before the crash happened (using
 > tracefs), and I saw a read of size 264 =3D 8 + 256, which led me to the
 > chaining theory. To test this claim, I wrote a simple pci device
 > driver which creates one IO queue and submits a read command where the
 > PRP list is set up in a way that tests if the controller treats it as
 > a chained list or not. I ran it, and it indeed treated the last PRP
 > entry as a chained pointer.
hmm, I guess a simple debugfs trigger file could be used to construct speci=
ally formulated requests. Would work as a debug tool.
Though at this point, the simple dmapool alignment param usage fixes both o=
f these scenarios, so it will be kind of academic to continue putting effor=
t in to understand this. I am trying to get answers out of the vendor to co=
nfirm any of these theories, which I hope will be more conclusive than our =
combined inference from testing.
 >=20
 > It is possible that this is not the only thing that's wrong. Could you
 > share your patch that checks your "only do that on the last 256 byte
 > segment of a page" idea?
 >=20
Unfortunately I have already rebased away that change with the new one.
I can go hunting in my reflog to see if I can find it again, but probably e=
asier to just implement it again.
I just hacked in a threshold parameter to the dmapool allocator that told i=
t to allocate a different segment if it was the last in a page and the size=
 was over the threshold.


