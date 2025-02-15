Return-Path: <linux-kernel+bounces-516073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D7A36CA7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F8E1895892
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285AA19CC31;
	Sat, 15 Feb 2025 08:36:18 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF2DDA8;
	Sat, 15 Feb 2025 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739608577; cv=none; b=oQoU74fs/46lYutPkkwmlvKtrfaipsLkXtDvqvUqJvHze6pc7E+xR5S86XXY36L7hOWbHxBhM/NtMzmumJCjw2GzT9RkYV9Eiu1LMKgym7fPKT+J7Z7TLEnLj9hBL0XSFQsWA6hqmSJudYs251cJxyJ6BXbnzcp08ERzQ+VV4Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739608577; c=relaxed/simple;
	bh=zQT+HSANdvkFyi6Kvrys7mk8ccl9HamdLO1bbQatn4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hy6O9X5TDTHl61f8cpS4Mbs3icPUH0/2piKJFGUfO1Cor9eT7JztjKGCwbUo+zqD/1vorRRjf8iWaMAYDiJTrmG/1vBXPevDDLJmdreztMg8SIZYEI+2AsAzAPeKIXF2WZfW5H1bYR6SwOkAqPPvy0gM1Dpxk2VgPhtEL2zVb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.172.76.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 8E3BC341707;
	Sat, 15 Feb 2025 08:36:14 +0000 (UTC)
Date: Sat, 15 Feb 2025 08:36:07 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, javier@dowhile0.org, rjones@redhat.com,
	abologna@redhat.com, spacemit@lists.linux.dev,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/2] riscv: dts: spacemit: Add initial support for Milk-V
 Jupiter
Message-ID: <20250215083607-GYA22673@gentoo>
References: <20250214151700.666544-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214151700.666544-1-javierm@redhat.com>

Hi Javier:

On 16:16 Fri 14 Feb     , Javier Martinez Canillas wrote:
> Hello,
> 
> This patch-set adds a minimal support for the Milk-V Jupiter board.
> which is a Mini ITX computer based on the SpacemiT K1/M1 RISC-V SoC.
> 
> The DTS is very basic but at least allows to boot into a serial console
> and get UART output, similar to what exists for other K1 based boards
> such as the BananaPi BPI-F3.
> 
> Patch #1 just adds the compatible string for the Milk-V Jupiter to the
> SpacemiT bindings and patch #2 adds the minimal DTS for this computer.
> 
> Best regards,
> Javier
> 
> 
> Javier Martinez Canillas (2):
>   dt-bindings: riscv: spacemit: Add Milk-V Jupiter board compatible
>   riscv: dts: spacemit: Add Milk-V Jupiter board device tree
> 

Reviewed-by: Yixun Lan <dlan@gentoo.org>

>  .../devicetree/bindings/riscv/spacemit.yaml   |  1 +
>  arch/riscv/boot/dts/spacemit/Makefile         |  1 +
>  .../boot/dts/spacemit/k1-milkv-jupiter.dts    | 27 +++++++++++++++++++
>  3 files changed, 29 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
> 
> -- 
> 2.48.1
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

