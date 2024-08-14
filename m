Return-Path: <linux-kernel+bounces-286129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030789516F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362191C216D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA735148FFA;
	Wed, 14 Aug 2024 08:47:10 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E830143C41
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625230; cv=none; b=Fw1bcboNXznnaHhVhHsc1uRUvb4B0bdDhxAmNlIVV1t+YRmfpbkEMK+tn9I4AmHD6fkQfi4qLIPldYf2ZJLCQe6kNLG5oNuJ+CGkWJ87x6AQYZuig9W7eosMO7WRTKfiO/W+peHvHB1UWZrppvvaUTlnDHry4G7jHEemFI8hPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625230; c=relaxed/simple;
	bh=fAKF1GlX2BL3TbqVetcibtL4k/GTT07FVuHFv1TMZcM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A7O73Zhj31ch9a15NQdzy7DvekiTYOn7hXNOk9cf4v/fOE8DzMPiE0n3dPh/tija73gblo5DEn8nwne1GlRK8mnvZjNiwwZXps1UtsKNVFLB8ojuIAh+7Uy9GF/86Rc9R6MjjiA+2M7lEaYJewqq6iGCHObOh/ixLw+UD7ya4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WkMFH0w7wz1j6LY;
	Wed, 14 Aug 2024 16:42:11 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id CF0631402E1;
	Wed, 14 Aug 2024 16:47:02 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 16:47:01 +0800
Subject: Re: [PATCH -next] arm64/sve: Remove unused declaration
 read_smcr_features()
To: Yue Haibing <yuehaibing@huawei.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
	<mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240810093944.2587809-1-yuehaibing@huawei.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <db4aa7d7-d1fe-ac07-b81d-cd9dd07a0ed4@huawei.com>
Date: Wed, 14 Aug 2024 16:47:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240810093944.2587809-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/8/10 17:39, Yue Haibing wrote:
> Commit 391208485c3a ("arm64/sve: Remove SMCR pseudo register from cpufeature code")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  arch/arm64/include/asm/fpsimd.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index bc69ac368d73..f2a84efc3618 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -155,8 +155,6 @@ extern void cpu_enable_sme2(const struct arm64_cpu_capabilities *__unused);
>  extern void cpu_enable_fa64(const struct arm64_cpu_capabilities *__unused);
>  extern void cpu_enable_fpmr(const struct arm64_cpu_capabilities *__unused);
>  
> -extern u64 read_smcr_features(void);
> -
>  /*
>   * Helpers to translate bit indices in sve_vq_map to VQ values (and
>   * vice versa).  This allows find_next_bit() to be used to find the

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

