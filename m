Return-Path: <linux-kernel+bounces-192723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE68D2146
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5E21F25262
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AB173338;
	Tue, 28 May 2024 16:08:42 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DDA172762;
	Tue, 28 May 2024 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912522; cv=none; b=mN1qLsnyBY5BaYIhAU/72+eayBuI0OHjniQ7c5IuCdWKa0DX/sIlYlRPqt2QEeu9PfMnJIRQYL6G/DvhT8i+n9mNCRGB0wdmvpxbLHFyqiljE/BbuBKrtItAk1BYZMsUiKvmvBZntYNhdv8yatsfVoOOHDqIMB3/f3H5FslhUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912522; c=relaxed/simple;
	bh=bsKmqZdJDKie65RdVR6LNfLZoJpvxeKgk1t+ao8Ji5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t34Y46NzOvzguR0Y0zBptVjc/qGg9ep0WmMwZwMN+C0LeePuo3HMAKMemA8Md/1Krm9/NU5Ak9drSIjURdBMPdLaeek1dgi75jxmnxCx5zqZucp6+hILY4+Z5yd4gC73k02t8mhFrApx9/GPDIWFP76rVmHOtR2WkLY8uS7WveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso14391531fa.2;
        Tue, 28 May 2024 09:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716912518; x=1717517318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YoSfwcLmd/CqrDTou7v+s7TkGMZevLZ6k2fTsWjn6zg=;
        b=kXG86l9iqv0t44utRhwsy6q93pHQ/0BFOGzUwxcP82vp9zTzAYel813W+dp4WPZAN4
         YSzjGo6EmWJDYzHAxKqeoUwHy7y8WGfRAMmvvkHxBliSjOO56UrvosqsKq1Q1lUuLYkA
         HUDIKYDLpEeejOaTMcvjH874Hkm36SpLSmtDBbQ51Pgs32rQnRelUHQyU2METOURuNcX
         TXYmmppQWD2eOXxgUFQuDHZMGr83EqzMHEZrCJ9RSHZcQCja7HPzMlmfBj77RlzOiG+h
         DpOFWyn2hZA3AFsl7DotbHyyndnpF+qRe+XdLhhdtvLnK/OE1oExNhrWykSx2zaX1jxO
         OcMg==
X-Forwarded-Encrypted: i=1; AJvYcCUnxfa01Qwro9B/BHAMygdoP4gJ0uwbczFjLRsLcOjYPqN3WsLUxjy/GZ6w+dIu4gZ0SYz5zp7waxunw2d4mY4fndQR8spEL2fnZl7S509A4LHkyphKcXHkWf5zM6Y2skvXcW7vJcSbew==
X-Gm-Message-State: AOJu0YwNTYE5BtojKrlVG44irCWTCxHBxf4iFHTDv4Gh6qNJozAiaTj4
	yegkbjw/uOnLG52OKBvbP92ll41qpu8wQRF8uHfy/3sf7dtHvJPCfrMLXf1o
X-Google-Smtp-Source: AGHT+IFASqB07gLVwWidmSChouSBNQtbsCwcI3raY8e1nQ5VCq1i4x+6OfGZ2vN7BPjYYBdoroJJUA==
X-Received: by 2002:a2e:a304:0:b0:2e1:a504:f9ec with SMTP id 38308e7fff4ca-2e95b0c1546mr100885191fa.23.1716912517565;
        Tue, 28 May 2024 09:08:37 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc4ae2sm22512671fa.21.2024.05.28.09.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 09:08:37 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so20257731fa.0;
        Tue, 28 May 2024 09:08:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlxT5czgj1RF1qLRa+RAfvSSD2gHuYPs5u15wCmmYxjYoCuv2UMRZu4wzmBynbDUbkVuqo1IImuBXjT52Soe+/8QI2BdjD7cQfnzQy7RugLpf9hN0EVI9eXatfuZxIo8+Oz1wWCOt3jg==
X-Received: by 2002:a2e:968a:0:b0:2e1:c448:d61e with SMTP id
 38308e7fff4ca-2e95b096f52mr96976121fa.15.1716912517177; Tue, 28 May 2024
 09:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9d52e6d338a059618d894abb0764015043330c2b.1714727227.git.dsimic@manjaro.org>
In-Reply-To: <9d52e6d338a059618d894abb0764015043330c2b.1714727227.git.dsimic@manjaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 29 May 2024 00:08:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v67_4MHEZned0X1sFxisySahemHYo6sjn9sttQY+RO=VQw@mail.gmail.com>
Message-ID: <CAGb2v67_4MHEZned0X1sFxisySahemHYo6sjn9sttQY+RO=VQw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H616
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-sunxi@lists.linux.dev, jernej.skrabec@gmail.com, samuel@sholland.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 5:09=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> Add missing cache information to the Allwinner H616 SoC dtsi, to allow
> the userspace, which includes lscpu(1) that uses the virtual files provid=
ed
> by the kernel under the /sys/devices/system/cpu directory, to display the
> proper H616 cache information.
>
> Adding the cache information to the H616 SoC dtsi also makes the followin=
g
> warning message in the kernel log go away:
>
>   cacheinfo: Unable to detect cache hierarchy for CPU 0
>
> Rather conspicuously, almost no cache-related information is available in
> the publicly available Allwinner H616 datasheet (version 1.0) and H616 us=
er
> manual (version 1.0).  Thus, the cache parameters for the H616 SoC dtsi w=
ere
> obtained and derived by hand from the cache size and layout specification=
s
> found in the following technical reference manual, and from the cache siz=
e
> and die revision hints available from the following community-provided da=
ta
> and memory subsystem benchmarks:
>
>   - ARM Cortex-A53 revision r0p4 TRM, version J
>   - Summary of the two available H616 die revisions and their differences
>     in cache sizes observed from the CSSIDR_EL1 register readouts, provid=
ed
>     by Andre Przywara [1][2]
>   - Tinymembench benchmark results of the H616-based OrangePi Zero 2 SBC,
>     provided by Thomas Kaiser [3]
>
> For future reference, here's a brief summary of the available documentati=
on
> and the community-provided data and memory subsystem benchmarks:
>
>   - All caches employ the 64-byte cache line length
>   - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative instructi=
on
>     cache and 32 KB of L1 4-way, set-associative data cache
>   - The size of the L2 cache depends on the actual H616 die revision (the=
re
>     are two die revisions), so the entire SoC can have either 256 KB or 1=
 MB
>     of unified L2 16-way, set-associative cache [1]
>
> Also for future reference, here's the relevant excerpt from the community=
-
> provided H616 memory subsystem benchmark, [3] which confirms that 32 KB a=
nd
> 256 KB are the L1 data and L2 cache sizes, respectively:
>
>     block size : single random read / dual random read
>           1024 :    0.0 ns          /     0.0 ns
>           2048 :    0.0 ns          /     0.0 ns
>           4096 :    0.0 ns          /     0.0 ns
>           8192 :    0.0 ns          /     0.0 ns
>          16384 :    0.0 ns          /     0.0 ns
>          32768 :    0.0 ns          /     0.0 ns
>          65536 :    4.3 ns          /     7.3 ns
>         131072 :    6.6 ns          /    10.5 ns
>         262144 :    9.8 ns          /    15.2 ns
>         524288 :   91.8 ns          /   142.9 ns
>        1048576 :  138.6 ns          /   188.3 ns
>        2097152 :  163.0 ns          /   204.8 ns
>        4194304 :  178.8 ns          /   213.5 ns
>        8388608 :  187.1 ns          /   217.9 ns
>       16777216 :  192.2 ns          /   220.9 ns
>       33554432 :  196.5 ns          /   224.0 ns
>       67108864 :  215.7 ns          /   259.5 ns
>
> The changes introduced to the H616 SoC dtsi by this patch specify 256 KB =
as
> the L2 cache size.  As outlined by Andre Przywara, [2] a follow-up TF-A p=
atch
> will perform runtime adjustment of the device tree data, making the corre=
ct
> L2 cache size of 1 MB present in the device tree for the boards based on =
the
> revision of H616 that actually provides 1 MB of L2 cache.
>
> [1] https://lore.kernel.org/linux-sunxi/20240430114627.0cfcd14a@donnerap.=
manchester.arm.com/
> [2] https://lore.kernel.org/linux-sunxi/20240501103059.10a8f7de@donnerap.=
manchester.arm.com/
> [3] https://raw.githubusercontent.com/ThomasKaiser/sbc-bench/master/resul=
ts/4knM.txt
>
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Helped-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h616.dtsi
> index b2e85e52d1a1..4faed88d8909 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -26,30 +26,67 @@ cpu0: cpu@0 {
>                         reg =3D <0>;
>                         enable-method =3D "psci";
>                         clocks =3D <&ccu CLK_CPUX>;
> +                       i-cache-size =3D <0x8000>;
> +                       i-cache-line-size =3D <64>;
> +                       i-cache-sets =3D <256>;
> +                       d-cache-size =3D <0x8000>;
> +                       d-cache-line-size =3D <64>;
> +                       d-cache-sets =3D <128>;
> +                       next-level-cache =3D <&l2_cache>;

This no longer applies due to the CPU DVFS stuff getting merged.
Can you rebase and resend?


Thanks
ChenYu

