Return-Path: <linux-kernel+bounces-333840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B021697CED0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 23:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C201C210E0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8A14B064;
	Thu, 19 Sep 2024 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="AyCe8Ub/"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A4142E70
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782127; cv=none; b=LGNzGa+HiQPLv1pwPE36DfTyeWDk77pdLs9OFi+UL0KwrJ/6YGhr9251ZHhOtOMcVdypS1Ti6R3p9WGDUb2S6n4iApUU9FBTjsIJ+zed5q7Jyx5QeQOWm3XFZ8z1yoEYUI73OF/ke6Agryt4CG3EIdaRWShDov/D2tgJjx7qx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782127; c=relaxed/simple;
	bh=H3Gfc7/NfiUYmOSniISLj/4W7ulKvEWVwUplZ/sI+V4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgVxED48k1QKHdDqWPy/eIpYPS4HSJRJdzqqMSxFEjkrhHEwNZcrqSd4/tXM14CpDLUfOe251cXN76Bapq8iXWw46JS4Gmp/A2BOtkt/vvZUBnmX7KFKhloXKdMNmUmhY3xHGMqYWQBYYJ0fo56jStHNtxNtxd8ZLenKmJ0NTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=AyCe8Ub/; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1726782118;
	bh=Raz54aG1zgUyZraYZSatA/MqcN1Hk1jxeUkiH9MOpP8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AyCe8Ub/UEEmunZ08gUI9iBQ/vWPjbBBwIxlTAoATQo/I75XfkST3yD2IG9WKJ0W6
	 F1H6QPqjuJ89vrsL/aqGC+ZTqtsRrO7rwG48+7Ico3Dmrs6g6QF/6Bb8JdG6+BB/Ce
	 NGV4qHmz/8ZARFRPY3EHMt4X8GMd1B2ndgD5VGhQ=
Received: from [IPv6:240e:358:1137:8c00:dc73:854d:832e:6] (unknown [IPv6:240e:358:1137:8c00:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 3515E1A3FAF;
	Thu, 19 Sep 2024 17:41:55 -0400 (EDT)
Message-ID: <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
From: Xi Ruoyao <xry111@xry111.site>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Date: Fri, 20 Sep 2024 05:41:51 +0800
In-Reply-To: <ZuvYnXzbM2qfXQPT@infradead.org>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-19 at 09:54 +0200, Christoph Hellwig wrote:
> The following changes since commit 47ac09b91befbb6a235ab620c32af719f82083=
99:
>=20
> =C2=A0 Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)
>=20
> are available in the Git repository at:
>=20
> =C2=A0 git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping=
-6.12-2024-09-19
>=20
> for you to fetch changes up to a5fb217f13f74b2af2ab366ffad522bae717f93c:
>=20
> =C2=A0 dma-mapping: reflow dma_supported (2024-09-12 16:28:00 +0200)
>=20
> ----------------------------------------------------------------
> dma-mapping updates for linux 6.12
>=20
> =C2=A0- support DMA zones for arm64 systems where memory starts at > 4GB
> =C2=A0=C2=A0 (Baruch Siach, Catalin Marinas)
> =C2=A0- support direct calls into dma-iommu and thus obsolete dma_map_ops=
 for
> =C2=A0=C2=A0 many common configurations (Leon Romanovsky)
> =C2=A0- add DMA-API tracing (Sean Anderson)
> =C2=A0- remove the not very useful return value from various dma_set_* AP=
Is
> =C2=A0=C2=A0 (Christoph Hellwig)
> =C2=A0- misc cleanups and minor optimizations (Chen Y, Yosry Ahmed,
> =C2=A0=C2=A0 Christoph Hellwig)

Hi Christoph and Linus,

This breaks using my laptop camera with gstreamer (with "gst-launch-1.0
v4l2src ! videoconvert ! autovideosink" or GNOME snapshot).

"git bisect" gives:

The first bad commit could be any of:
b5a73bf4d1de95e620bf5f592557b81f71c76f0e
833bd284a45448f04ab9fcd4fdf7ef594d458eed
c42a01264ba1497eb3193c08ff3c2656d98250a6
560a861ab4174b42240157ab5cebe36b8c7bc418
b5c58b2fdc427e7958412ecb2de2804a1f7c1572
334304ac2baca7f3e821c47cf5129d90e7a6b1e6

(I had to use "git bisect skip" several times because I encountered
kernel panic on boot at some revisions.)

Reverting the merge fixes the issue.  I'm not sure if this is related to
the camera model (I can borrow another camera to test tomorrow).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

