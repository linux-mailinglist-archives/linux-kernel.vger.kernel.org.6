Return-Path: <linux-kernel+bounces-216900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D9390A83E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7D61C254FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9B4190076;
	Mon, 17 Jun 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="LhQDYkLR"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091307492;
	Mon, 17 Jun 2024 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612151; cv=pass; b=VfZs/2qWS/5PUJ5G7T7M7naS8qOhTdIfX5s/h3DfmLHKw4NF3OYm3+sv3/SsujycQMP0OFkvxMCenCH67QTwClOsPnXyDwPDHY294JGeWWHpXrWXkTn8r8e0GRU1ycn/pQwoN6BIK5LE3IBFXD75R5U13mlw21UByuBXoYs5Tiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612151; c=relaxed/simple;
	bh=oEw09u6puwEe1Nbazpi+FHtU6JyGgtK0P587AGGRiXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CJlJEfL7jyMvkuS1kpDc7qLNHRuq3xy4gzI+fl+0a6TcWQYHW5GaWuDFinZWPGN3JeNDNCc8Qu0Nk28yZpCyw3pS04iFlamDeUCqIqaPDC7r+6bAPEl597zoUMjPxkjDFYKC0kqHuHmH4KN42CjiR6DO/e4B1fESCvhxkkqmO2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=LhQDYkLR; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1718612132; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bGcBqaIfCHRKICOs3rvbDy12lUk9nOlPk6eMD/0DFh7XP/Vhb4GMMUEOJ0DrwlCrlfBrhK7EXrtVzFFtmcc/1msp+h3bJ4Z3SZ0dEZvZ9XEDKMQNNGO46P4GsfuZ+NyCFAf45aD6jK3IACYJXbo4/fg5u2VK4FND1Cnq1IR61rM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1718612132; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oEw09u6puwEe1Nbazpi+FHtU6JyGgtK0P587AGGRiXE=; 
	b=D2SzVnPXEf4IGkJECZ6ycJwSvArQCAh6UntfciC9i6XptbdCPk66KDgqrFDG/a/Lv4I6s/y3xOqWzfj0E62pZifgAmJ/zufdJmwbpvkFEpQ23i45vhYudeVprvVHeXxlqla88C34gqJSRzJuw1gJtRw87K50QlFbzSVtnWGQgoI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1718612132;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=oEw09u6puwEe1Nbazpi+FHtU6JyGgtK0P587AGGRiXE=;
	b=LhQDYkLRsNYhoyW+O7FQz6xPOO9x0ur4QOCLqgXaETHdqkjBBoGZqDPNcdYAYXv6
	CXe7/HkHDcdU8zlDlCAMdFzZpuzuZDYXogHTgGBfL7eEXpI6PPEa0yRgW1Xvw9GkveB
	sV5IqQbz136iu55t4LTJ9ILjV1h32EjvW6QKN6KQdI+H1Qe/5DKNJUjMHA+S8fS+3Ch
	82asOB9xMwQkwEvQkyzbV89SaFD8LrqRna8gdLzLjUox8Kq7XvL+H/iPypO4MSpSXs8
	eqdKidOldX8snJfkT6ibvY/2fzmamPNC/Gmr6LEehwHwiKUzoVIL7GF+fduRyz5K1hx
	ZGKev4fJtQ==
Received: by mx.zohomail.com with SMTPS id 1718612130295190.36232977173415;
	Mon, 17 Jun 2024 01:15:30 -0700 (PDT)
Message-ID: <60e610782212128d73dab9b1120708d81d809680.camel@icenowy.me>
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
From: Icenowy Zheng <uwu@icenowy.me>
To: Yangyu Chen <cyy@cyyself.name>, Conor Dooley <conor@kernel.org>
Cc: Yixun Lan <dlan@gentoo.org>, linux-riscv@lists.infradead.org, Conor
 Dooley <conor+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Samuel Holland
 <samuel.holland@sifive.com>, Anup Patel <anup.patel@wdc.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Jesse Taube <jesse@rivosinc.com>
Date: Mon, 17 Jun 2024 16:15:25 +0800
In-Reply-To: <tencent_2ABAC5E885F8354EF1F9084A6B5B398EE00A@qq.com>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
	 <20240616-exorcism-computing-e11e26084a62@spud>
	 <20240616224811.GC3983622@ofsar>
	 <tencent_2ABAC5E885F8354EF1F9084A6B5B398EE00A@qq.com>
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

=E5=9C=A8 2024-06-17=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 10:00 +0800=EF=BC=
=8CYangyu Chen=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > On Jun 17, 2024, at 06:48, Yixun Lan <dlan@gentoo.org> wrote:
> >=20
> > Hi Conor
> > Thanks for bringing this up
> >=20
> > On 19:35 Sun 16 Jun=C2=A0=C2=A0=C2=A0=C2=A0 , Conor Dooley wrote:
> > > On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:
> > >=20
> > > No MAINTAINERS update, so I figure that means you don't want to
> > > maintain
> > > it going forwards? If there's someone out that that does care
> > > about the
> > > spacemit k1 (Jesse maybe?), then I'd be more than happy to have
> > > them
> > > look after it.
>=20
> Actually, I don=E2=80=99t know how to be a maintainer. Should I have to
> provide a new git tree and all the new patches merged to my tree
> and then submit a git pull? Or reuse the RISC-V mailing list and
> just give a review, and the patches come to soc misc tree? I would
> like the latter one.

Well I think for these SoCs the latter is the case.

BTW I could volunteer as a maintainer, or at least a reviewer here.

>=20
> > Yangyu kind of has limited time, too many stuff for him..
> >=20
>=20
> True. Maybe I can have a review and test the patch in one week.
> However, providing a review and test in 2-3 days is sometimes hard
> for me.
>=20
> > I'd volunteered to help on this if it can fill the gap
> > Also I'd be more than happy if anyone willing step forward to co-
> > maintain..
> >=20
>=20
> Thanks. Really appreciate it.
>=20
> Should I provide a diff like this:
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..718d30996f12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19306,6 +19306,7 @@ F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/riscv/boot/=
dts/
> =C2=A0X:=C2=A0=C2=A0=C2=A0=C2=A0 arch/riscv/boot/dts/allwinner/
> =C2=A0X:=C2=A0=C2=A0=C2=A0=C2=A0 arch/riscv/boot/dts/renesas/
> =C2=A0X:=C2=A0=C2=A0=C2=A0=C2=A0 arch/riscv/boot/dts/sophgo/
> +X:=C2=A0=C2=A0=C2=A0=C2=A0 arch/riscv/boot/dts/spacemit/
> =C2=A0
> =C2=A0RISC-V PMU DRIVERS
> =C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0 Atish Patra <atishp@atishpatra.org>
> @@ -21004,6 +21005,13 @@ W:=C2=A0=C2=A0=C2=A0=C2=A0 https://linuxtv.org
> =C2=A0Q:=C2=A0=C2=A0=C2=A0=C2=A0 http://patchwork.linuxtv.org/project/lin=
ux-media/list/
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0 drivers/media/dvb-frontends/sp2*
> =C2=A0
> +SPACEMIT DEVICETREES and DRIVERS
> +M:=C2=A0=C2=A0=C2=A0=C2=A0 Yangyu Chen <cyy@cyyself.name>
> +M:=C2=A0=C2=A0=C2=A0=C2=A0 Yixun Lan <dlan@gentoo.org>
> +S:=C2=A0=C2=A0=C2=A0=C2=A0 Maintained
> +F:=C2=A0=C2=A0=C2=A0=C2=A0 Documentation/devicetree/bindings/riscv/space=
mit.yaml
> +F:=C2=A0=C2=A0=C2=A0=C2=A0 arch/riscv/boot/dts/spacemit/
> +
> =C2=A0SPANISH DOCUMENTATION
> =C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0 Carlos Bilbao <carlos.bilbao.osdev@gmail=
.com>
> =C2=A0R:=C2=A0=C2=A0=C2=A0=C2=A0 Avadhut Naik <avadhut.naik@amd.com>
>=20
> Thanks,
> Yangyu Chen
>=20
> > --=20
> > Yixun Lan (dlan)
> > Gentoo Linux Developer
> > GPG Key ID AABEFD55
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


