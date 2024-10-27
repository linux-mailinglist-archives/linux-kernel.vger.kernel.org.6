Return-Path: <linux-kernel+bounces-383883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F79A9B215F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 00:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B577E2814D7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CD11865F6;
	Sun, 27 Oct 2024 23:31:45 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD243AAE
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730071905; cv=none; b=pPQWlITSNbXW+H4ID+fXMgrBRG7Apalw9mkDB+VqIOiT7kU9AD87tWr/mlO5dgz7dvL9Vg0nsLdg/FcctTCpcbLq7iSMiBFHyXl43UIprZonxT+hK5lfvmv7ypva0t9t8L0iW/iaAwcYvPfZEEQ+QLiGrcOG1S5f7G4n42cCfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730071905; c=relaxed/simple;
	bh=jwjn/61q6vzgnaw8czf9Nb8oMQOKAjZP50jDFJAI1UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlJsVEw9w17Ul/Cklb/NgftWvqg4OdZQOF8ZnJRMbscBoFVdBGRlOjb4/5w6xrPoyPzbngec0fR3qXLf6YrQZgtwjNrjkop5Whd+7ezxOEEqxvm/yyuGy1o7xe8nTOmnWmmc+TdxdB/Vatx9F7nRxYv5ju2hEBfkcrv3+jizzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Mon, 28 Oct 2024 07:31:39 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>
Cc: Yangyu Chen <cyy@cyyself.name>, Jisheng Zhang <jszhang@kernel.org>,
	Jesse Taube <mr.bossman075@gmail.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Meng Zhang <zhangmeng.kevin@spacemit.com>,
	Meng Zhang <kevin.z.m@hotmail.com>, soc@kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] MAINTAINERS: setup support for SpacemiT SoC tree
Message-ID: <20241027233139-GYA86372@gentoo>
References: <20241028-00-k1-maintainer-v2-1-272c9834220d@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-00-k1-maintainer-v2-1-272c9834220d@gentoo.org>

HI
On 07:04 Mon 28 Oct     , Yixun Lan wrote:
> Add myself as maintainer of SpacemiT's SoC tree, which
> suggested by Conor [1].
> 
> Link: https://lore.kernel.org/all/20241018234615-GYA2124001@gentoo/ [1]
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> This will setup proper maintainer info about Spacemit's kernel tree,
> which should help to take soc and device tree patches, and send the
> pull request up to Arnd's soc tree.
> 
> I asked Kevin to host the kernel tree under SpacemiT's account
> on github, which should help people to get access more easily,
> and promote the tree a little bit.
> 
> I could take this patch through this spacemit's soc tree if no objection,
> of cource, after got ACK.
> ---
> Changes in v2:
> - drop RISC-V exclude dts
> - add mailinglist info
> - Link to v1: https://lore.kernel.org/r/20241023-00-k1-maintainer-v1-1-c06b791cc2ee@gentoo.org
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9659a5a7fb3347d649855992a559e3526d18443..88fe4ca801537eff7eb5001406a611ef80632b5d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19814,6 +19814,15 @@ F:	arch/riscv/boot/dts/thead/
>  F:	drivers/clk/thead/clk-th1520-ap.c
>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>  
> +RISC-V SPACEMIT SoC Support
> +M:	Yixun Lan <dlan@gentoo.org>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +T:	git https://github.com/spacemit-com/linux
> +F:	arch/riscv/boot/dts/spacemit/
> +N:	spacemit
> +K:	spacemit
> +
strictly, I should put these before THEAD section, to keep it sorted
I will fix this while applying the patch if no other comments received..

>  RNBD BLOCK DRIVERS
>  M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
>  M:	Jack Wang <jinpu.wang@ionos.com>
> 
> ---
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> change-id: 20241023-00-k1-maintainer-46eb3f31e6f2
> 
> Best regards,
> -- 
> Yixun Lan <dlan@gentoo.org>

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

