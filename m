Return-Path: <linux-kernel+bounces-530389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49289A432D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F82176C02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645338172A;
	Tue, 25 Feb 2025 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="EFE3Xvzn"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55D6EB4C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449273; cv=pass; b=Su9wmMFsUYQgm2+utS7KIYsL7CP0lCT3a4A0tfVL4oetrDBBMm3Rv+fqiUypViEmXmbwf6bAaRolyl3BRN11lBGtK7LX8bU+2nzsYXL2e2yvMFlizJnFmhjIWPc9PW4v2hQ0cslUChDttZWNr3NziD7GxEpcyI308L+TrFfUTpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449273; c=relaxed/simple;
	bh=QSBREAfPC2cBcJiV6Z6ErnCB7KVWOLRnp6Zvp62iV/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LU9JgAQc/xLkeVJapTztQ/T8/UFr8wA/6Stafa8PdSSc9SFNXniAy6onQqV2juBLuJENnFmYU1KIMI35FFyLXCjlS7s4oCVYax7LuY4zrfdg8ncM8C0u7ICloqn8QRUtU4HwBacRElo55+7xVRsSGI9GD6vffDVtVXmSukzwlM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=EFE3Xvzn; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1740449260; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ctMaYshhKAViVYmhi35VSTcCEPdynuESMYTGkoniXnPG1daZqPx6t/KikcKoqxAJ1ERGJ/+lDnmHr2ITxKERyrG9ZMtKLhEnRcZ9kwk+LW4bA5VxFv7GHvAPCvOAfvxyjuE+N76s7S6P9wGl29FTHQ1k4yWs9RQ6MqscWGhh3to=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740449260; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QSBREAfPC2cBcJiV6Z6ErnCB7KVWOLRnp6Zvp62iV/4=; 
	b=G40PjWNCsHQhdsFzGHJKcjzH8cQbb9KPPbvxiP9uXWXcrTGzGWGAFj/N1TKAeJBWUhGyhlT/0RzUgb0daOFUnRsbu/lgTjThEzv+F2Dcy8/qbJDxVHJ9j/MwcmJwpSoxZWKddVYhSz4BJNhneJwA2pridSnjUbv2/PGPEmoxn6U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740449260;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=QSBREAfPC2cBcJiV6Z6ErnCB7KVWOLRnp6Zvp62iV/4=;
	b=EFE3XvznyPbgmrBhXf+KnRD24ymQPxZ0akb45gr0nLgcbe9M8wxxUDUQKHiX0ATy
	BrOSVu1SkR+8/dUGIoH3E9+K1BTl1L+dDhy5J60QwShEK+E+RKW5JNod17OcOJB+2pd
	JOEhiqLcZUmZbnAy/io8KaAiQWspgJ5yqDQe6ESlg6vf8huCeXPqPs5+zzgi1nMCste
	pq4G8DyPas0AY5ydlWGXdAnoDQgNMFTAcg+QLVodGbCk905AN8XUgpTFZVwgI3DvWVK
	GR8j4VNTneKhQpHiKElqYia967rDkbnq4BjfYalQNLz8NjOUYD75WNsHFJdor5V91xE
	y8AUxUpQuw==
Received: by mx.zohomail.com with SMTPS id 1740449257618172.64096278561385;
	Mon, 24 Feb 2025 18:07:37 -0800 (PST)
Message-ID: <64ff1dcf9e46c15e062ccf05ae6f9efd3747f0fd.camel@icenowy.me>
Subject: Re: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
From: Icenowy Zheng <uwu@icenowy.me>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Feb 2025 10:07:31 +0800
In-Reply-To: <Z70MC0zoC0L-tOgO@kbusch-mbp>
References: <20250212170444.16138-1-uwu@icenowy.me>
	 <20250213055449.GB19370@lst.de> <Z70MC0zoC0L-tOgO@kbusch-mbp>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-02-24=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 17:17 -0700=EF=BC=
=8CKeith Busch=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Feb 13, 2025 at 06:54:49AM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 13, 2025 at 01:04:42AM +0800, Icenowy Zheng wrote:
> > > Here is a small patchset that is developed during my
> > > investigation of
> > > a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC
> > > D4502
> > > SSD), which is because of the SSD's too-small CMB block (512KB
> > > only).
> >=20
> > Hah, that's certainly and odd CMB configuration.
>=20
> Should be okay if it's just for submission queues. The driver has an
> arbitrary requirement that the queues have at least 64 entries for
> CMB,
> and 512k allows us to create 128 submission queues like that. That's
> enough for most systems.

Yes, but this configuration seems to not fit the current driver code
that utilizes PCIe P2P setup code. (Is there any driver that could
utilize this configuration now?)


