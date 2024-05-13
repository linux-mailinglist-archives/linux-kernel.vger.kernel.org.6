Return-Path: <linux-kernel+bounces-177715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2CF8C4392
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8051F2451A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02D6AC0;
	Mon, 13 May 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlfm238f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFCC538A;
	Mon, 13 May 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612231; cv=none; b=pRBuk0gUIYX5kSI0bX01XGTQZbNhiTS2ttJnV/eWakp5jz37ASDCbwwS7xfECA9or/4fhCKJDH1lYArb6Mnj/wWs3MpzV5YdZyyzYIQIAtKbHZmywt1ej//lOkZ1LoRtMkwNQ52M+AzKwzwsQitrObvY+1VdZA72p8UX+9Fy/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612231; c=relaxed/simple;
	bh=0w9mbGT1UZZt1dOpgC8NPTR0pigL8NKPJ4Gx+UMc4No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/CXm8XbavvxDeOajNTV8LNSHhf583V7rlt58RJoJhtd6g/H0peu+tuPPbj73z8D58bjAFRw3FS6PJXecUXu9w5SKPWLGsRhWqqz75gdiC8ITaiosxitW25NA3d9W/ig0m2pPzaxEFZxtDmeFzGqm4x1sOMdrxV/z8bJzSOayZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlfm238f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E950DC113CC;
	Mon, 13 May 2024 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715612231;
	bh=0w9mbGT1UZZt1dOpgC8NPTR0pigL8NKPJ4Gx+UMc4No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlfm238fMGiVIDMNGnEKc97gNmE29hdsLp7YKC9Wpqq8IWVhjJOyzeE4d72H+4zii
	 8TMHr1INhhSxLq7XjhdouQqKS31hGdQMfWd6fOJ4zfJFAcgD0xMuX2jnSuWxJNA20x
	 t5G1Z194+qKS2gfSXhW/tHGhzSw/j45xXTtOKObCug+qUO0V1fditIlV7aHLJVd2qm
	 ZvkFm5erZ9XOw3zu/ucAuBs5LWwSL4FN4vIS4vWmwyNNZ6j3slga4IbqfjW5ULH7Hg
	 SNwPM57X0TwGJ7OgpyhhJQxHQ7CXyCcSZu5CPq97FNK6BPg7z5W2gfmLIojzFZM+a0
	 JEcbmHifAhrGw==
Date: Mon, 13 May 2024 09:57:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sunil V L <sunilvl@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v4] of: property: Add fw_devlink support for
 interrupt-map property
Message-ID: <171561222690.2595290.16864995832552950240.robh@kernel.org>
References: <20240509120820.1430587-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509120820.1430587-1-apatel@ventanamicro.com>


On Thu, 09 May 2024 17:38:20 +0530, Anup Patel wrote:
> Some of the PCI host controllers (such as generic PCI host controller)
> use "interrupt-map" DT property to describe the mapping between PCI
> endpoints and PCI interrupt pins. This is the only case where the
> interrupts are not described in DT.
> 
> Currently, there is no fw_devlink created based on "interrupt-map"
> DT property so interrupt controller is not guaranteed to be probed
> before the PCI host controller. This affects every platform where
> both PCI host controller and interrupt controllers are probed as
> regular platform devices.
> 
> This creates fw_devlink between consumers (PCI host controller) and
> supplier (interrupt controller) based on "interrupt-map" DT property.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> ---
> Changes since v3:
> - Added a comment about of_irq_parse_raw()
> - Removed redundant NULL assignments to sup_args.np
> Changes since v2:
> - No need for a loop to find #interrupt-cells property value
> - Fix node de-reference leak when index is greater than number
>   of entries in interrupt-map property
> Changes since v1:
> - Updated commit description based on Rob's suggestion
> - Use of_irq_parse_raw() for parsing interrupt-map DT property
> ---
>  drivers/of/property.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 

Applied, thanks!


