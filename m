Return-Path: <linux-kernel+bounces-275024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940FF947FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C701C20F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5E15C15D;
	Mon,  5 Aug 2024 16:56:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22552C684
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876983; cv=none; b=AksNcU8fJNizKvFf/c8axzM2q8GWtLgKYWuE16wk6IXUKPUw4Cga8sMJBXk3CVM0kYjFQIdAjP8jxPRwnFHC4TuCuPHD5yGNU4DEg1d7YRcVlLNWNfBhO6Fsy87YSf6ZLGGVOsKY270xL/SvC5YRsS4Fpw+NDaPwpfbQmefBNCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876983; c=relaxed/simple;
	bh=QlQ43cztZZoXQl9umIBhJNhLEu87pSmicGcAv1TCkdk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBjgbYqauHhQ5GBpdnoFU7oR4x3JKtQZH1lrZIMLwigpKaLdbEEzvIsaxKOZkXLbw2xDMWfe+X2jHsSwI6BU4z6zQCpqqvMOdWwQ6Wi8tFI7Xo3UMyGPN5A6fWvdYqc24hVGDL3uGzlYBkPbKvV+ESwmYiZJFrUH1w75aJP4EvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wd2ZT09H4z6K9j5;
	Tue,  6 Aug 2024 00:53:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 174F31400F4;
	Tue,  6 Aug 2024 00:56:19 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 5 Aug
 2024 17:56:18 +0100
Date: Mon, 5 Aug 2024 17:56:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Igor
 Mammedov <imammedo@redhat.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Message-ID: <20240805175617.000036ce@Huawei.com>
In-Reply-To: <5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri,  2 Aug 2024 23:43:59 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add error notification to GHES v2 using the GPIO source.

The gpio / external interrupt follows through.

> 
> [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks]
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 16 ++++++++++------
>  include/hw/acpi/ghes.h |  3 ++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 8d0262e6c1aa..a745dcc7be5e 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -34,8 +34,8 @@
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
>  
> -/* Now only support ARMv8 SEA notification type error source */
> -#define ACPI_GHES_ERROR_SOURCE_COUNT        1
> +/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
> +#define ACPI_GHES_ERROR_SOURCE_COUNT        2
>  
>  /* Generic Hardware Error Source version 2 */
>  #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
> @@ -290,6 +290,9 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>  {
>      uint64_t address_offset;
> +
> +    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> +
>      /*
>       * Type:
>       * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> @@ -327,6 +330,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>           */
>          build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
>          break;
> +    case ACPI_HEST_SRC_ID_GPIO:
> +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);
> +        break;
>      default:
>          error_report("Not support this error source");
>          abort();
> @@ -370,6 +376,7 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_GPIO, linker);
>  
>      acpi_table_end(linker, &table);
>  }
> @@ -406,10 +413,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
>      if (physical_address) {
> -
> -        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
> -            start_addr += source_id * sizeof(uint64_t);
> -        }
> +        start_addr += source_id * sizeof(uint64_t);
>  
>          cpu_physical_memory_read(start_addr, &error_block_addr,
>                                   sizeof(error_block_addr));
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 6891eafff5ab..33be1eb5acf4 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -59,9 +59,10 @@ enum AcpiGhesNotifyType {
>      ACPI_GHES_NOTIFY_RESERVED = 12
>  };
>  
> +/* Those are used as table indexes when building GHES tables */
>  enum {
>      ACPI_HEST_SRC_ID_SEA = 0,
> -    /* future ids go here */
> +    ACPI_HEST_SRC_ID_GPIO,
>      ACPI_HEST_SRC_ID_RESERVED,
>  };
>  


