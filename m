Return-Path: <linux-kernel+bounces-415888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 174EC9D3D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF03A281785
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DCF1AA7A6;
	Wed, 20 Nov 2024 14:32:22 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67FDA939
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113142; cv=none; b=QaKqd2mdNNwKnohl//hzzFf7/GpGPCwnZaSFmfAt/uWEuEUnIFkrcarr6tr7Y7b8EHlb+/sreGWU3W4B8hfN/KiMgOd4U/LnnWcn1iz3xB5DrUJsRrddXCKyy1UFFoLrI3KTJqq1cRowuzqdQkrslEzeKkGVj4xj1L46Kz3nh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113142; c=relaxed/simple;
	bh=eSxwL8laVUF4/gDB/ch1Kqz1hREnEubfNc2rr0+nvYU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3KznfCMty1TbcsC42fRNciupiLrLt+tbC/92tff691R2JMaMWFfJcPCN3/qjbiq+rYPIIJyzv4zb1QMz59CMaP61raDStj+SihjN0iZcPaLNgEoeiLVT1+L9rjaC1g3G0t7k/+dEd/dZmMBkQUK/6oWDOjLtg+PL7MI/7gqnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtkHx0VJfz6J6tf;
	Wed, 20 Nov 2024 22:28:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9495B140119;
	Wed, 20 Nov 2024 22:32:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 20 Nov
 2024 15:32:16 +0100
Date: Wed, 20 Nov 2024 14:32:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/6] acpi/ghes: add a firmware file with HEST address
Message-ID: <20241120143214.00003570@huawei.com>
In-Reply-To: <70ed97b5b335a3e399121be988bf37136aaaa7fd.1731486604.git.mchehab+huawei@kernel.org>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
	<70ed97b5b335a3e399121be988bf37136aaaa7fd.1731486604.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 13 Nov 2024 09:36:59 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its content at
> hest_addr_le variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> ---
> 
> Change from v8:
> - hest_addr_lr is now pointing to the error source size and data.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Drop the extra SoB. Doesn't matter really but looks strange in the
patch.

One trivial inline.

This stuff always gives me a headache, so with that in mind, looks
fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  hw/acpi/ghes.c         | 15 +++++++++++++++
>  include/hw/acpi/ghes.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index a590b0f6f85f..4cd79d42cd04 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -30,6 +30,7 @@
>  
>  #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
>  #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> @@ -361,6 +362,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>  
>      acpi_table_begin(&table, table_data);
>  
> +    int hest_offset = table_data->len;
> +
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, num_sources, 4);
>      for (i = 0; i < num_sources; i++) {
> @@ -368,6 +371,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>      }
>  
>      acpi_table_end(linker, &table);
> +
> +    /*
> +     * tell firmware to write into GPA the address of HEST via fw_cfg,
Tell

File is inconsistent but mostly uses a capital to start.
> +     * once initialized.
> +     */
> +    bios_linker_loader_write_pointer(linker,
> +                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                     sizeof(uint64_t),
> +                                     ACPI_BUILD_TABLE_FILE, hest_offset);
>  }
esState;


