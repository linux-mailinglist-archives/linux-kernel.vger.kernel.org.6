Return-Path: <linux-kernel+bounces-575831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EDDA707B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A928C3AA578
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D2325FA1C;
	Tue, 25 Mar 2025 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YGdxRfbz"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEA2E339B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922418; cv=none; b=HK0Cg+uATz+WK2jTYltnFUZQ1zoYOq/jk5+cwXqbllYKAJYRS+Izw3RhY7JvAvUty4o6JZ8xH0Xi8UIwaZhYT4XtgpJg2c+WrGzh6XvuRbKnuhpWzxN8oPzRujuKFntOcG5Ihwu2gVSKiHSnSdrkZ+KIK1uo170oARHwc3kt/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922418; c=relaxed/simple;
	bh=p4hI6rmj/B2jQcKFonO+VLVTRv3JWXwyiknfAMihw2Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=A71pkFeJzvD8ZDde0ADOqBtL/CWPp99w9OYBoT5OMuDyPHy/tPSSkDexISgCkc2+BtQWPx6l45eb7sjEKS7cnOu19HWlhbsVHtjE8wRF+O55sP7NEWLkNpUY1OVAofIBjiNTkaslGETKZonMR+hhvYvoYTKsxKWON3UKmCrmp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YGdxRfbz; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6ab8b951-a2be-4434-8621-0b31d00608ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742922414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Nbign4VerDHGQ4baDVBf0Bsdr3S4g3WcFkWogC97fU=;
	b=YGdxRfbzDkzHKl5/qMOZrrR4LII7XP0QUt4iwMW61UJEowyRrEsbO9yZpQA0ymxy+9uyFW
	jTqenr7oGL2jmdGvM8YgwevbtNmWQ7EdCjIvoqFM/bjS9YrRYVsCdLPkYCvMnHVonpPY42
	zWBWUW+7/xFGNwbkcmzVqhqiX94q6wo=
Date: Tue, 25 Mar 2025 18:06:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
Subject: Re: [PATCH 04/10] fpga: tests: add module descriptions
To: Arnd Bergmann <arnd@kernel.org>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
 Marco Pagani <marpagan@redhat.com>, Russ Weight <russ.weight@linux.dev>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324173242.1501003-1-arnd@kernel.org>
 <20250324173242.1501003-4-arnd@kernel.org>
Content-Language: en-US
In-Reply-To: <20250324173242.1501003-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2025-03-24 18:32, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Modules without a description now cause a warning:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Marco Pagani <marco.pagani@linux.dev>

> ---
>  drivers/fpga/tests/fpga-bridge-test.c | 1 +
>  drivers/fpga/tests/fpga-mgr-test.c    | 1 +
>  drivers/fpga/tests/fpga-region-test.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
> index b9ab29809e96..124ba40e32b1 100644
> --- a/drivers/fpga/tests/fpga-bridge-test.c
> +++ b/drivers/fpga/tests/fpga-bridge-test.c
> @@ -170,4 +170,5 @@ static struct kunit_suite fpga_bridge_suite = {
>  
>  kunit_test_suite(fpga_bridge_suite);
>  
> +MODULE_DESCRIPTION("KUnit test for the FPGA Bridge");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
> index 9cb37aefbac4..8748babb0504 100644
> --- a/drivers/fpga/tests/fpga-mgr-test.c
> +++ b/drivers/fpga/tests/fpga-mgr-test.c
> @@ -330,4 +330,5 @@ static struct kunit_suite fpga_mgr_suite = {
>  
>  kunit_test_suite(fpga_mgr_suite);
>  
> +MODULE_DESCRIPTION("KUnit test for the FPGA Manager");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
> index 6a108cafded8..020ceac48509 100644
> --- a/drivers/fpga/tests/fpga-region-test.c
> +++ b/drivers/fpga/tests/fpga-region-test.c
> @@ -214,4 +214,5 @@ static struct kunit_suite fpga_region_suite = {
>  
>  kunit_test_suite(fpga_region_suite);
>  
> +MODULE_DESCRIPTION("KUnit test for the FPGA Region");
>  MODULE_LICENSE("GPL");


