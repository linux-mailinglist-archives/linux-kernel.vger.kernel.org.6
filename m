Return-Path: <linux-kernel+bounces-235891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F0691DADF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90EB1F23181
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23113E88C;
	Mon,  1 Jul 2024 08:59:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291913D899
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824378; cv=none; b=jjONoIc0WE6zERjmoYcv82dDT5ejSNruzvRlaky3jFr948b2+/Qekr5F3CvNhNzEPO1SDOd51qBBFX2Ry76+9tB3T711VfwQflBoo7HKeS4T/TUvkKxQWwvXb5RsFKA5fRW53nZq6SNQ4Le1c943XU7uW/vUgDcUSysJFISxDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824378; c=relaxed/simple;
	bh=azT3xfbdPATWOMN+dwJky9aP0l7x/b2aB7FXbKoBuU8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jujnJymdIJEZpv3mOoJFpNxcFyfgSQjhlmEBgwaGLXnrSqSbDmC7ipl1vsDnvLCH4cFB1UQQJpXsyS7F6oy9M2TEqURiFdegbxWS6tyTNfDSZXNx4aUFCLM7TiQSxpVVjpFpEtzvb9UKOjgbv3lbY5t0YHpBrf3eCFbyxN0jbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCKht6xwfz6J9nb;
	Mon,  1 Jul 2024 16:58:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DFEF140A30;
	Mon,  1 Jul 2024 16:59:27 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 09:59:26 +0100
Date: Mon, 1 Jul 2024 09:59:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gavin Shan <gshan@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <shan.gavin@gmail.com>,
	<linuxarm@huawei.com>
Subject: Re: [PATCH for-next/vcpu-hotplug] arm64: Kconfig: Fix dependencies
 to enable ACPI_HOTPLUG_CPU
Message-ID: <20240701095926.00003d7a@Huawei.com>
In-Reply-To: <20240701001132.1585153-1-gshan@redhat.com>
References: <20240701001132.1585153-1-gshan@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  1 Jul 2024 10:11:32 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Both ACPI_PROCESSOR and HOTPLUG_CPU are needed by ACPI_HOTPLUG_CPU.
> Otherwise, we can have compiling error with the following configurations.
>=20
>   CONFIG_HOTPLUG_CPU=3Dn
>   CONFIG_ACPI_PROCESSOR=3Dy
>   CONFIG_ACPI_HOTPLUG_CPU=3Dy
>=20
>   arch/arm64/kernel/smp.c: In function =E2=80=98arch_unregister_cpu=E2=80=
=99:
>   arch/arm64/kernel/smp.c:563:9: error: implicit declaration of  \
>   function =E2=80=98unregister_cpu=E2=80=99; did you mean =E2=80=98regist=
er_cpu=E2=80=99?        \
>   [-Werror=3Dimplicit-function-declaration]
>   563 |         unregister_cpu(c);
>       |         ^~~~~~~~~~~~~~
>       |         register_cpu
>=20
> Fix it by enabling ACPI_HOTPLUG_CPU when both ACPI_PROCESSOR and
> HOTPLUG_CPU are enabled, consistent with other architectures like
> x86 and loongarch.
>=20
> Fixes: 9d0873892f4d ("arm64: Kconfig: Enable hotplug CPU on arm64 if ACPI=
_PROCESSOR is enabled.")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406300437.XnuW0n34-lkp@i=
ntel.com/
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Thanks for the quick analysis and patch!

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e8f2ef2312db..ff17c5705324 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -5,7 +5,7 @@ config ARM64
>  	select ACPI_CCA_REQUIRED if ACPI
>  	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_GTDT if ACPI
> -	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR
> +	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
>  	select ACPI_IORT if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ACPI_MCFG if (ACPI && PCI)


