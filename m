Return-Path: <linux-kernel+bounces-339222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C5986172
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC48288DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B8A18953E;
	Wed, 25 Sep 2024 14:17:03 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF6E172798
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273822; cv=none; b=lNib1ZYTANad2TRCM8RFYwmFfYzxFqY2cqTmViVDNeNI4skUKuguJxC1dhP744mNqaUwzULRc73hnyAJj2B0bDRW8FSRdPHzi0O8lc4sQcbK1eckNIhem+JGSwhkmR/U8fTjpAXWGPKXBEADsO4dQEPTBYuYkvhU3a5QRYoShd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273822; c=relaxed/simple;
	bh=YygqN7vyON+a0MAZVuRSqYN+KrnppzXUS+nQbCOt8go=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2fXhmpy4RmJigWO/Lp6Fl5lpj3yEWW0kAQSYqN6bGyKZFDBHIfWQLbv2LZ/6VCmMy/oOjQKIcsy7Xkes5kFbG9p7BScsaOL/C0Zoml7LQyw7eWGIFrbKCPy4Z+cBEexjWHaOAKXQDsbJY/cMg09Iwfz9IbrP3FxvLcCMTkAQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDJgZ60l9z6G9MC;
	Wed, 25 Sep 2024 22:16:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D67EC140498;
	Wed, 25 Sep 2024 22:16:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 16:16:58 +0200
Date: Wed, 25 Sep 2024 15:16:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 07/15] acpi/ghes: Change the type for source_id
Message-ID: <20240925151657.00002163@Huawei.com>
In-Reply-To: <427117fa409217094f5e98694913a371fb5bcda5.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<427117fa409217094f5e98694913a371fb5bcda5.1727236561.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 25 Sep 2024 06:04:12 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> HEST source ID is actually a 16-bit value
Indeed.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes-stub.c    | 2 +-
>  hw/acpi/ghes.c         | 2 +-
>  include/hw/acpi/ghes.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index c315de1802d6..2b64cbd2819a 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index b932b6fe2c2e..29240aa139d5 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -383,7 +383,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  {
>      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
>      uint64_t start_addr;
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 50e3a25ea384..9295e46be25e 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present


