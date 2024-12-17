Return-Path: <linux-kernel+bounces-448401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FA29F3FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BDD1649C9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7CB1E505;
	Tue, 17 Dec 2024 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgcsgpcR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317358F77;
	Tue, 17 Dec 2024 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397392; cv=none; b=qz6p6U9FXuCZ3TDMTT7CVjxXrzxIha4hm7ct52/T/oku/i/axmQFOvCTbtEy1IrIsri9OLeoAJYKxA0egLgAxfE3v2jDbfDKLj0afV3PWLsB9RRqBFEyx+gSew1VXaozHKWS+pY3Vw0U+n+cbr/jsd7FboapJTjBPaqjuMNNLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397392; c=relaxed/simple;
	bh=85qnm0twUdriEANua6M9zWIJ2EUDnJi8YYiwyF62+cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4pwhtrqHUdiXOgmedGuTqNm7EEaKUwYQgW/bHv4mPS1D2O/bh8tHQDWXoaLL7l6FjNTnNvjTRQc1+ZnHympy4JwsOzBp5ar7aAdoW6/rIH92TvtCFpwmVlNyl1nywKfxT+ZegMXGWinomY36gnu565oiUQF5OwelraRZe6elsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgcsgpcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36901C4CED0;
	Tue, 17 Dec 2024 01:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734397391;
	bh=85qnm0twUdriEANua6M9zWIJ2EUDnJi8YYiwyF62+cw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PgcsgpcRnlAjQSnRs1RAdMVIdnZiF9YsZiqfYqS4jk3e/77rF/VA1SGqoI8fE3Qyh
	 Dj4KWfVEGhSF9SgfCESj77ebyFjo51u+kxhKF7SB8dG42CnYfIKA9Pwhq7N3uPQJJD
	 RDiWSbYKWhQGDEp0jsGeZmivlzJUORoYQK1amd2OnXzjIND6sL0BD74ao3/vtuR8PS
	 rLOcoPz8/K8uq7FAsYnHyF0lPlCZo/0hYgaIRrldy7hFNUbByu2E6JUdj2rEzYuLBp
	 cxZcRHNYAjstmHzu1vp++ZmeJyveHGXHjmmTqGCLT02YAFUx7QA9HQXSBZ2J/28RHw
	 8mZ8j+NMGMERg==
Message-ID: <f303ee53-7d74-45ad-9e4e-895177522759@kernel.org>
Date: Mon, 16 Dec 2024 19:03:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: altera: Remove unused and undocumented
 "snps,max-mtu" property
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241115193822.3623434-1-robh@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20241115193822.3623434-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 13:38, Rob Herring (Arm) wrote:
> Remove "snps,max-mtu" property which is both unused in the kernel and
> undocumented. Most likely they are leftovers from downstream.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
> index 0d837d3e65a5..34ccf8138f7b 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
> @@ -63,7 +63,6 @@ &gmac0 {
>   	status = "okay";
>   	phy-mode = "rgmii";
>   	phy-addr = <0xffffffff>;
> -	snps,max-mtu = <0x0>;
>   };
>   
>   &gmac1 {

Applied!

Thanks,
Dinh

