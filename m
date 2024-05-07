Return-Path: <linux-kernel+bounces-171562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487B8BE5C3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E9128CD1C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE81B16C444;
	Tue,  7 May 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="SAnUNbzE"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30316C434;
	Tue,  7 May 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091674; cv=none; b=lNmHN0w69Q+KJ38+n0nuj+oBSzw3iukiuxSeUdI7AJy4kwy29sX0LoAQzJ0XkkFxv3SbAMdaXqi8lzuUNqwnbE2i8yB49xhPxU5Br0ObMG6bHQsO0BFetlgcqIdrOct0EekCpa8BzXoiVbiZZBBoKkDbTKucqoR6gdMNVU8DKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091674; c=relaxed/simple;
	bh=KuPguweerCAeDeFcHUy2Ym+qHGosgURq8HC0Jlhat0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FC2gyQNIdPT1FsaXiLcTX0M7Hd8pHJc5votZxQQCvZo6rY2WFJVtBcC3y66cfV7vqtXFNrAczlSWqS0gn0gPiaXGD/2+k4tKX2gH9m9PLElKISw6kgln/vniadR8EzBqD/NbTDaBMEcbwxEr5ecNijuoqjE/ynwGo9hbgAGyXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=SAnUNbzE; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1715091664;
	bh=KuPguweerCAeDeFcHUy2Ym+qHGosgURq8HC0Jlhat0k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SAnUNbzEABYCaE148HVT/5Kc4c/5dt5/BW8DXzOR1++aF+l+/mjwKH+6T7FEc3FIp
	 T9BRfDKtYojdJP+XCKnBUJCMq8+Y6QmdObldwQCWw/KfSZyHXblBYUrnCpHV4WH7H9
	 olguVMaRtysU2TO3gu3pLu1vDfFeanhezIxj2Wiw=
Received: from [IPv6:240e:456:1030:3f01:af89:88e3:556c:eacb] (unknown [IPv6:240e:456:1030:3f01:af89:88e3:556c:eacb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id DFBE266916;
	Tue,  7 May 2024 10:20:48 -0400 (EDT)
Message-ID: <a0a896fef1aca8958a190801ab5355e22373081d.camel@xry111.site>
Subject: Re: [PATCH 2/2] Loongarch:Support loongarch avec
From: Xi Ruoyao <xry111@xry111.site>
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org, 
	kernel@xen0n.name, tglx@linutronix.de, jiaxun.yang@flygoat.com, 
	gaoliang@loongson.cn, wangliupu@loongson.cn, lvjianmin@loongson.cn, 
	yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org, 
	dianders@chromium.org, maobibo@loongson.cn, zhaotianrui@loongson.cn, 
	nathan@kernel.org, yangtiezhu@loongson.cn, zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 07 May 2024 22:20:42 +0800
In-Reply-To: <20240507125953.9117-1-zhangtianyang@loongson.cn>
References: <20240507125953.9117-1-zhangtianyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-07 at 20:59 +0800, Tianyang Zhang wrote:
> +static inline void loongarch_avec_ack_irq(struct irq_data *d)
> +{
> +}
> +
> +static inline void loongarch_avec_unmask_irq(struct irq_data *d)
> +{
> +}
> +
> +static inline void loongarch_avec_mask_irq(struct irq_data *d)
> +{
> +}

"inline" has no use here because these functions are only called via
function pointers, thus such calls cannot be inline-able.  I'd suggest
to remove "inline" for them.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

