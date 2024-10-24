Return-Path: <linux-kernel+bounces-380638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D89AF3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0C31C2272B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5602170C0;
	Thu, 24 Oct 2024 20:44:44 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B571AF0B8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802683; cv=none; b=kP71V7RmxEvjmgbyXkJCVi9Z6f6vf3po0HZfZSGLKPDOJDc0KL9RV2aY9mILntNoCu4qQPBc61WVmm7hCC7nIejXE6zckgEqSivvwpX9ONgN982uw7GQ7rpmiahPCd7wrNKSdmjF1X5JAMOSGZG68vRubjcs2+NAdzNd56XNyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802683; c=relaxed/simple;
	bh=DyFKr23Q2Yw563nWLD9+RlGj2Qjyg1AJBEd4bKnMFms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIzw/uM0NN5xpvPh3bcbTMweR1UGLBhLnw9HKBXndoE1NWsWwtyx8zT6xf9tOMfcI3hb7JvYlpLJMav6L4zkfS+yfnEDF0TELvSq87EoRosz4/il/+EzcKuUgScpSqXYRNeSGs/+z6iZDLx9By446zS2zUAi0W/l4gPtEDE9fUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 25 Oct 2024 04:44:36 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Yangyu Chen <cyy@cyyself.name>,
	Jisheng Zhang <jszhang@kernel.org>,
	Jesse Taube <mr.bossman075@gmail.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Meng Zhang <kevin.z.m@hotmail.com>, soc@kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: setup support for SpacemiT SoC tree
Message-ID: <20241024204436-GYB1356851@gentoo>
References: <20241023-00-k1-maintainer-v1-1-c06b791cc2ee@gentoo.org>
 <20241024-penpal-skillet-c44a389e0d4d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-penpal-skillet-c44a389e0d4d@spud>

Hi Conor:

once more thing, I'd like to add one additonal mailinglist info,
which make sure all spacemit future patches flow to linux-riscv mailinglist

L: linux-riscv@lists.infradead.org

let me know if this is not ok?

On 16:31 Thu 24 Oct     , Conor Dooley wrote:
> On Wed, Oct 23, 2024 at 12:18:19PM +0800, Yixun Lan wrote:
> > Add myself as maintainer of SpacemiT's SoC tree, which
> > suggested by Conor [1].
> > 
> > Link: https://lore.kernel.org/all/20241018234615-GYA2124001@gentoo/ [1]
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> > This will setup proper maintainer info about Spacemit's kernel tree,
> > which should help to take soc and device tree patches, and send the
> > pull request up to Arnd's soc tree.
> > 
> > I asked Kevin to host the kernel tree under SpacemiT's account
> > on github, which should help people to get access more easily,
> > and promote the tree a little bit.
> 
> What do you mean by "get access more easily"?
> 
I'd collect all patches of spacemit (including those sent by others)
and put them into a staging WIP branch, for people who interested to
download/test (not strongly related to upstream work..)

for not hosting the tree at my personal account, as I'd wish more
people to join as the maintainer, which would be easy to manage this..

> In case it is not clear, noone other than those listed in the
> maintainers entry should be pushing content to the fixes/next
> branches and all patches must go through the mailing lists and review
yes, I understand

> process. I'm sure you're well aware of this, but I've never interacted
> with spacemit and don't know if they are.
> 
yes, I will make sure them aware of this.

> Make sure you add the fixes/next branches to linux-next when you have
> the branches established.
> 
ok, I will send email to Stephen once this patch accepted

> > I could take this patch through this spacemit's soc tree if no objection,
> > of cource, after got ACK.
> 
> Yes, do it along with the base series, when that goes in.
> 
sure, will take it along with initial DT series

> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e9659a5a7fb3347d649855992a559e3526d18443..4087023593f7a0b2d5c5827df682230c329f82a9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19791,6 +19791,7 @@ F:	arch/riscv/boot/dts/
> >  X:	arch/riscv/boot/dts/allwinner/
> >  X:	arch/riscv/boot/dts/renesas/
> >  X:	arch/riscv/boot/dts/sophgo/
> > +X:	arch/riscv/boot/dts/spacemit/
> >  X:	arch/riscv/boot/dts/thead/
> 
> Huh, this is not meant to look like that. Looks like the patch went
> missing. I'll have to rectify that. You can drop this hunk. I'm going
> to invert it:
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=riscv-soc-fixes
> 
ok
> >  
> >  RISC-V PMU DRIVERS
> > @@ -21578,6 +21579,14 @@ W:	https://linuxtv.org
> >  Q:	http://patchwork.linuxtv.org/project/linux-media/list/
> >  F:	drivers/media/dvb-frontends/sp2*
> >  
> > +SPACEMIT SoC Support
> > +M:	Yixun Lan <dlan@gentoo.org>
> 
> I'd like to see someone else here, but if noone is volunteering
> themselves, we can hardly force them!
> 
sure, let's give people some time to consider, and I will send an updated version
next week..

> > +S:	Maintained
> > +T:	git https://github.com/spacemit-com/linux
> > +F:	arch/riscv/boot/dts/spacemit/
> > +N:	spacemit
> > +K:	spacemit
> > +
> >  SPANISH DOCUMENTATION
> >  M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> >  R:	Avadhut Naik <avadhut.naik@amd.com>
> > 
> > ---
> > base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> > change-id: 20241023-00-k1-maintainer-46eb3f31e6f2
> > 
> > Best regards,
> > -- 
> > Yixun Lan <dlan@gentoo.org>
> > 



-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

