Return-Path: <linux-kernel+bounces-538173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D45A4954C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DCB165709
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B3E2580DF;
	Fri, 28 Feb 2025 09:36:21 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A224A046
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735380; cv=none; b=meLryyDSgnd5Cht7l6c0ihhCdblGXydSoX9rOM+33YblW63xhtYANFryw9it3qVYHr+Z9zvpAZ7CwvhU+C4VfrtmSSDTTkHGwwqI1pRabnQbXKovULHoyFG8DZfc0/Bruzv3STY0uSiflcq4cpFARBBAuWyyAJTKahJcbv2rbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735380; c=relaxed/simple;
	bh=/yYoODwOWH/fJEqj/r2bETdb0AQnmKjf/rDkraQrGmE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3Nryi6lWcxdyb8kf6tnLaVcSlPIuk66jsyhGleEf503NPG7uPH1tDqnf6djp6nhfSJ5fFHfCtws7qf7kpNCBRsIBLirD2sikys43giIMPAN429lqaCT0DQ41A7IBw/OGwz8Uu00wyvkvhubbMDE17BFF4VLNBhKAx8U5bGluek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z43131C69z6M4fN;
	Fri, 28 Feb 2025 17:33:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 919A5140B55;
	Fri, 28 Feb 2025 17:36:16 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 28 Feb
 2025 10:36:13 +0100
Date: Fri, 28 Feb 2025 17:36:08 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>, Dongjiu Geng <gengdongjiu1@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 18/19] docs: hest: add new "etc/acpi_table_hest_addr"
 and update workflow
Message-ID: <20250228173608.0000779c@huawei.com>
In-Reply-To: <445f7d41b01ffc5bd79d6fd83bc7c4c621bcbc85.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
	<445f7d41b01ffc5bd79d6fd83bc7c4c621bcbc85.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 27 Feb 2025 17:00:56 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> While the HEST layout didn't change, there are some internal
> changes related to how offsets are calculated and how memory error
> events are triggered.
> 
> Update specs to reflect such changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
One minor editorial suggestion. With that or similar tidy up,
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  docs/specs/acpi_hest_ghes.rst | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> index c3e9f8d9a702..4311a9536b21 100644
> --- a/docs/specs/acpi_hest_ghes.rst
> +++ b/docs/specs/acpi_hest_ghes.rst
> @@ -89,12 +89,21 @@ Design Details
>      addresses in the "error_block_address" fields with a pointer to the
>      respective "Error Status Data Block" in the "etc/hardware_errors" blob.
>  
> -(8) QEMU defines a third and write-only fw_cfg blob which is called
> -    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> -    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> -    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
> -    for the firmware. The firmware will write back the start address of
> -    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
> +(8) QEMU defines a third and write-only fw_cfg blob to store the location
> +    where the error block offsets, read ack registers and CPER records are
> +    stored.
> +
> +    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
> +    contains a GPA for the beginning of "etc/hardware_errors".
> +
> +    Newer versions place the location at "etc/acpi_table_hest_addr",
> +    pointing to the GPA of the HEST table.
> +
> +    Through that such GPA values, the firmware can send back the guest-side
This confuses me.
 Via those GPA values...? (maybe?)

> +    allocation addresses to QEMU. They contain a 8-byte entry. QEMU generates
> +    a single WRITE_POINTER command for the firmware. The firmware will write
> +    back the start address of either "etc/hardware_errors" or HEST table at
> +    the corresponding fw_cfg file.
>  
>  (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
>      "Error Status Data Block", guest memory, and then injects platform specific
> @@ -105,8 +114,5 @@ Design Details
>       kernel, on receiving notification, guest APEI driver could read the CPER error
>       and take appropriate action.
>  
> -(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
> -     find out "Error Status Data Block" entry corresponding to error source. So supported
> -     source_id values should be assigned here and not be changed afterwards to make sure
> -     that guest will write error into expected "Error Status Data Block" even if guest was
> -     migrated to a newer QEMU.
> +(11) kvm_arch_on_sigbus_vcpu() report RAS errors via a SEA notifications,
> +     when a SIGBUS event is triggered.


