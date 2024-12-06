Return-Path: <linux-kernel+bounces-434465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A559E673C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F562168761
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED41A3042;
	Fri,  6 Dec 2024 06:16:42 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F517CA1D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465802; cv=none; b=KuVfmCtiwRMDEnBghCetBKzb2V5+1ij/S9gNKdTAdOxsQNdN/g9iy9AGtfP7ZFkob2tJP/O3B+y72WEh1CnqmpY6twwN45PKhkj/eMzDg44yjaKrfYjQNn5ZwrP4Z6Itzqd1jfMXIHzpewULKTMZ+aY0vdqcE6MryQ2oySexbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465802; c=relaxed/simple;
	bh=85wLyMC3xoj78MQpDKRagbX8Ir7dY6zubyDMZBXoJmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTmph9dMJynBSlrWcrgATGg83EKr54LuPs7AFrZkrVk/1w6lmz5ya7Fsu9gDJ/jOdijBgJVGatrI/MKe3FVisjtD+KS5/hNVm72Ro1ftKI8pNVaPv72rMsWK0XonC1AjpOHKyqv8tvCux3ZalP5i84wK/631wHIFTL83w2Feiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C7CBC0003;
	Fri,  6 Dec 2024 06:16:34 +0000 (UTC)
Message-ID: <a3e117ce-abe3-4bd9-aef5-90bbe173828d@ghiti.fr>
Date: Fri, 6 Dec 2024 07:16:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove Albert Ou from riscv
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20241205-remove_albert-v1-1-17eb850f1540@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241205-remove_albert-v1-1-17eb850f1540@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Charlie,

On 05/12/2024 23:46, Charlie Jenkins wrote:
> Albert is not an active maintainer and his inbox rejects all emails.
> Remove him from the maintainer's list to put an end to everybody who
> interacts with the riscv linux mailing list from getting spammed with
> rejection emails.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e930c7a58b1..8a5e12355850 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20104,7 +20104,6 @@ F:	include/linux/irqchip/riscv-imsic.h
>   RISC-V ARCHITECTURE
>   M:	Paul Walmsley <paul.walmsley@sifive.com>
>   M:	Palmer Dabbelt <palmer@dabbelt.com>
> -M:	Albert Ou <aou@eecs.berkeley.edu>
>   L:	linux-riscv@lists.infradead.org
>   S:	Supported
>   Q:	https://patchwork.kernel.org/project/linux-riscv/list/
>
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241205-remove_albert-b50c95e19306


I totally agree!

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


