Return-Path: <linux-kernel+bounces-447631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E925E9F352C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5029F16998E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4D14A4C7;
	Mon, 16 Dec 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="G72zPEjX"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAED53E23;
	Mon, 16 Dec 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364917; cv=none; b=CVr8z50VlDiCkN4kP343lPFRmBKmBnRhg40eItWD0/CzN5K9NSn5TbBBekheK27SxbZdrCDCkD4ysDOvTCxM9Mg5qFBo72YdQumAAQ2TxkJfQGeNmAB/8nO67cF4Fje+PGMMXQA5FM5GN+M4+LBxSVlnb24oF3hI/qIGJbytbis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364917; c=relaxed/simple;
	bh=YUZaXS6Vt4XLnH1O45Kl0gC/9P9dQbdNRSwa3HOflOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFGj7/V6lGT0JC3xqUOlyLxCQx3kMQxyRK40OtGWf5WVLw5EzTQFkCFDXVbuVkGHviL+vprQA0WMrFizndV6ZER6YbzfC4fU9yIcD2OrAtnqwFtidDG/gj8IKg7fc0uFTKAV4VBjVMG8D2HUw+/RLP1dvbl241i3dLOmxbIUkmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=G72zPEjX; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734364907; bh=yqsCxIHbjWGKkcn2WT4vA7e1SHVnhVYbcDANJ3Bx5XM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G72zPEjXP1VpHaQBAdr6oju7AqNtv8GEcnxfgRfRYbACn2sBnxfMHfLVtGwP1bbir
	 uVpZcRIijtNCrF76QNbEUTWBDBXniBBPMSJoaHoRxwAVCGVGlZIX2vsjX98D868bON
	 42+U9wF9SzyRgxyC2AJCnMZzIJ1R/ZBkSODTw1IU=
Received: from [IPV6:2408:8207:18a1:fd20:b8c3:9ed2:6671:4e49] ([2408:8207:18a1:fd20:b8c3:9ed2:6671:4e49])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 1806C3E; Tue, 17 Dec 2024 00:00:24 +0800
X-QQ-mid: xmsmtpt1734364824txr9h1ljv
Message-ID: <tencent_8F35B6F07D09566A873982E0E2C76085280A@qq.com>
X-QQ-XMAILINFO: Nr4sKL92GIu+ail8wIV4AJS6zsf5ZE8QPqWHcOkkko+6R74TiLehhg8KsJC771
	 mL1hZqM/nj0N69IfGvCEh8MuzFlLf7erlLtkrF4QP8qZkH9R46rJC3zvksFOo3obkRV0+aKu4SHn
	 upyCVd26TXjBxuoB9jpavw9ICCES77vHfPzlK79FLfZuxy8JNgqtal0+9OTmJogTMRdPb5a9nNAi
	 xm9z/bMHICi1CrOJIkjYihMJD8pEoW2z0hEgNSy4KdH03//bvlgspkYI2RdRI1igqxS3BPQYnoUm
	 tR8F+1M96o5b/8cq+zmKcxcRc13+BXKZ7da4CApR4NJKEPTEhWWoc/gF4Tf5gA8FTxx9PX2tlQyW
	 yJveZCleg1c03XKnG4nueB9UCCcgyk+cfy0bGfikU40oDIr2xeXP1+CSslYWCpf+1sE6mktkkNc8
	 BLWDM1wEVmn2mbepHJousbgdqh08TaMEbkgz9kekID9R6OciOr5XnOIEk1+oQMn4SMNNiirXzbOZ
	 Aoy9QhLRs5Dus79pfMf1Xn2IUBPqD7Jd+zrnrNIPzqLEGxXYnd+dpA94aWVy14sqyXhEhqzeeeP2
	 KrL9/qjZgreO/GmAqfzClJMdAwVx7fD7MNVHJqt+1pv7Zlsqwq7LW6NIOxKRSQ1p0Y/2K6xuSvRX
	 1ukgs86sREVWLwsuNqWBx9MfVt3S0/FNbwTM741VbUnOBy+s4v04V43ZfVjVs6GPJneE8jyk2rlm
	 Fd6RHcRXIccFOIGJRaJuEtVznba00a7plXP1g5xtyYMuXEmw6ymXSdpEgfq/mLKN2wQI3R8i1d8s
	 voy1HIED5xdEtvU68yVARCgsyb4Yurpb0Q5Y2lEeXZ7V8PZdXtEyOTq7HvbKJPKHNLqJ1m3WAICp
	 l+XKCaAEVadEBuVLDImcoihRv21U/CuiEL/r1Y8vxiWL08fFGm6/RuEfb5x/R94G+hqevZgM9FYn
	 zHzMNJbTlsEp6Ca7lFQw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-OQ-MSGID: <3c33d4d7-b11e-4f54-9b6b-767bf0495afd@cyyself.name>
Date: Tue, 17 Dec 2024 00:00:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] riscv: hwprobe: export bfloat16 ISA extension
To: Inochi Amaoto <inochiama@gmail.com>, Chen Wang
 <unicorn_wang@outlook.com>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Jesse Taube <jesse@rivosinc.com>,
 Andy Chiu <andybnac@gmail.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20241206055829.1059293-1-inochiama@gmail.com>
 <20241206055829.1059293-4-inochiama@gmail.com>
Content-Language: en-US
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20241206055829.1059293-4-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Possible conflict with: 
https://lore.kernel.org/linux-riscv/20241111-v5_user_cfi_series-v8-22-dce14aa30207@rivosinc.com/

On 12/6/24 13:58, Inochi Amaoto wrote:
> Export Zfbmin, Zvfbfmin, Zvfbfwma ISA extension through hwprobe.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Clément Léger <cleger@rivosinc.com>
> ---
>   Documentation/arch/riscv/hwprobe.rst  | 12 ++++++++++++
>   arch/riscv/include/uapi/asm/hwprobe.h |  3 +++
>   arch/riscv/kernel/sys_hwprobe.c       |  3 +++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 955fbcd19ce9..a9cb40e407a4 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -242,6 +242,18 @@ The following keys are defined:
>     * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
>          defined in version 1.0 of the RISC-V Pointer Masking extensions.
>   
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZFBFMIN`: The Zfbfmin extension is supported as
> +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> +       ("Added Chapter title to BF16").
> +
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFMIN`: The Zvfbfmin extension is supported as
> +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> +       ("Added Chapter title to BF16").
> +
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFWMA`: The Zvfbfwma extension is supported as
> +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> +       ("Added Chapter title to BF16").
> +
>   * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
>        :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
>        mistakenly classified as a bitmask rather than a value.
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 3af142b99f77..aecc1c800d54 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -73,6 +73,9 @@ struct riscv_hwprobe {
>   #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
>   #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
>   #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
> +#define		RISCV_HWPROBE_EXT_ZFBFMIN	(1ULL << 50)
> +#define		RISCV_HWPROBE_EXT_ZVFBFMIN	(1ULL << 51)
> +#define		RISCV_HWPROBE_EXT_ZVFBFWMA	(1ULL << 52)
>   #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>   #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>   #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index cb93adfffc48..bd215f58bd1b 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -131,6 +131,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>   			EXT_KEY(ZVE64D);
>   			EXT_KEY(ZVE64F);
>   			EXT_KEY(ZVE64X);
> +			EXT_KEY(ZVFBFMIN);
> +			EXT_KEY(ZVFBFWMA);
>   			EXT_KEY(ZVFH);
>   			EXT_KEY(ZVFHMIN);
>   			EXT_KEY(ZVKB);
> @@ -147,6 +149,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>   			EXT_KEY(ZCD);
>   			EXT_KEY(ZCF);
>   			EXT_KEY(ZFA);
> +			EXT_KEY(ZFBFMIN);
>   			EXT_KEY(ZFH);
>   			EXT_KEY(ZFHMIN);
>   		}


