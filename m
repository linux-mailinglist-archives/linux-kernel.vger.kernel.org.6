Return-Path: <linux-kernel+bounces-272424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D21945BC4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E587328233D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246F41DAC50;
	Fri,  2 Aug 2024 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="gMdc5ivB"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC161C69D;
	Fri,  2 Aug 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722593108; cv=none; b=f5S7wqgWMGi4dhm3k29158VPfR+7vIjs72Sqyx6BtFMZ3SGqAI35C6mCgh3tJEzUqqlgo+2kXehP/2nwJCOH7KhtuVpzqxdZdHpffhiw6V9ufoXyqNeHOuHKerQKOR4uf5lWIQrclKS9gSEQHp2zJaaDjDIWuFDGLgTHywEEeys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722593108; c=relaxed/simple;
	bh=QsN5/NZ66aTtsFvoL5pLZIv6o50us0fY8Yrb52ESz6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHokntJDP+dCLCM8CodpKKtpqu0X8M0C0moC+JNQDxlqtQUe/wbVe6hFypYtaw0eBnuH4dS0uLvdw6lIYg7Mf5EKQrHryDmsaYtodYILD1xHpHiYs8bHQNMC3hV9KWbIzGae9tWFSiiQAoHQMwbl615fHc0kQAU/IduTKGJaTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=gMdc5ivB; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id C661B40050C0; Fri,  2 Aug 2024 10:04:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su C661B40050C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1722593087;
	bh=QsN5/NZ66aTtsFvoL5pLZIv6o50us0fY8Yrb52ESz6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMdc5ivB/L+PDFudBOPTqscH5VEN4eYzXm6s23rVgX+fdPcqY5haJ1MmKpJ9mUvda
	 RIcP5kGJQOnLh2aMpmcQtnMgHDwGI+FU61ntph7HeLxrmaND+cn1+oUPwyERoRe6U0
	 7DXT4SvM5K8VtaFtL5+9C1vVk9GJUrXnrhyvCe8X/VP//PqodmM135l01bX5/Cfb8h
	 g9vXafFqVm3KTm5zRepfQqrDNaWCafKlnIBZr5qhwRlh6+Cb4a3MGiZTudmvTZoevy
	 hBIW+QAEKn45YG4k+5+EU9uiaiTi7LlsW06KpxpG0qp9MT1IeHrBh16vGS/WVmL1Ck
	 eQdcuyuh7xfEw==
Date: Fri, 2 Aug 2024 10:04:47 +0000
From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
To: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/2 RESEND] Add DTS for NanoPi R2S Plus
Message-ID: <20240802100447.GB18509@ветеран.su>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
 <20240801175736.16591-1-jin@mediatomb.cc>
 <756p9487-56pr-88p2-6o79-7oron3q8462n@yvfgf.mnoonqbm.arg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <756p9487-56pr-88p2-6o79-7oron3q8462n@yvfgf.mnoonqbm.arg>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi,

On Fri, Aug 02, 2024 at 09:46:40AM +0000, Bjoern A. Zeeb wrote:
> >I noticed, that a DTS for the R2S Plus is not yet available, while the
> >R2S is already there. The only difference is, that the Plus version has an
> >eMMC, so we can reuse the R2S definitions and only add an eMMC block, which
> >I copied from the DTS in the friendlyarm/uboot-rockchip repo.
> 
> The original has a
> 	// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> 
> please don't lose the OR MIT as other projects outside Linux do use the
> same dts files;  and the original r2s file also preserved it.

Uhm... I am confused now, I copy-pasted the emmc block from this file:
https://github.com/friendlyarm/uboot-rockchip/blob/nanopi4-v2017.09/arch/arm/dts/rk3328-nanopi-r2.dts#L7

The header does not have the "OR MIT" in there, it's just
"SPDX-License-Identifier:     GPL-2.0+" which is what I also copied
over, together with the (c) part.

The source which I was using is described in the commit message:

The eMMC configuration for the DTS has been extracted and copied from
rk3328-nanopi-r2.dts, v2017.09 branch from the friendlyarm/uboot-rockchip 
repository.

Maybe you looked at a different branch? Shall I still add the "OR
MIT" or leave it as in the original file which I copied it from?

Kind regards,
Sergey

