Return-Path: <linux-kernel+bounces-538105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84304A4949F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4861894E86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1056824C67B;
	Fri, 28 Feb 2025 09:18:23 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94511276D3B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734302; cv=none; b=lttU08gJa/XaEsOqLOe81EUK3et9qJscahmRMzNZwbytK2wHQPVSdKiFaTyBiDb00E79p/3dCbbWcgA22A/SNHLwEEeBsZeT4qpZolNRHvte6/KaN4HKeodwjs+h5Qpkddx+iLgT9o/rSJqLZTprjjP9G8yz3Ujso6PZdGMII08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734302; c=relaxed/simple;
	bh=hO+eh0t2F7LyPMEjfa1FCx2sOdvZPD16ZPi2EVsUb0g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNjBHnWVZQo/GMfWPoymwAqXnrJGxEg3so5zv8sdy89f5psHUFIRFRgX9EOAAJjxO34MBnqfYcF0xnO75kN8osGYVbj+BLJ0PF1VjbvKjYO6AnEs+T7ZJYhqByTUlJrC/FBMfhEyqSLp/VIeiSpn11BgYgU6AOmrF91hko4sdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z42b81klbz6L597;
	Fri, 28 Feb 2025 17:14:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B3A0E140E01;
	Fri, 28 Feb 2025 17:18:18 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 28 Feb
 2025 10:18:16 +0100
Date: Fri, 28 Feb 2025 17:18:11 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>, Ani Sinha <anisinha@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 03/19] tests/acpi: virt: update HEST file with its
 current data
Message-ID: <20250228171811.000017d4@huawei.com>
In-Reply-To: <342f2cbf20eee9cafbee834adc66ae81aa4df37b.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
	<342f2cbf20eee9cafbee834adc66ae81aa4df37b.1740671863.git.mchehab+huawei@kernel.org>
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

On Thu, 27 Feb 2025 17:00:41 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that HEST table is checked for aarch64, add the current
> firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Igor Mammedov <imammedo@redhat.com>

Mostly for completeness rather than because there is any actual
review we can do on 'this is what the file is'.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  tests/data/acpi/aarch64/virt/HEST           | Bin 0 -> 132 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4c5d8c5b5da5b3241f93cd0839e94272bf6b1486 100644
> GIT binary patch
> literal 132
> zcmeZp4Gw8xU|?W;<mB({5v<@85#X$#prF9Wz`y`vgJ=-uVqjqS|DS;o#%Ew*U|?_n
> dk++-~7#J8hWI!Yi09DHYRr~Kh1c1x}0RY>66afGL
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 39901c58d647..dfb8523c8bf4 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/HEST",


