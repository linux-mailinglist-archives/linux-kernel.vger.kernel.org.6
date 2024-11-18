Return-Path: <linux-kernel+bounces-412835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34B39D0FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71AB3B22E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C19D194A68;
	Mon, 18 Nov 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hyFykbrM"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE21188A0D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929801; cv=none; b=mjfzmfRg1Sik9QMtHNLDT/SNrRSJJicjtBuXjmTiGJAQS1QdL+BnVpk7fVUvooSDq/S1lFWzz9cd3bBVjs6NR6je71OmrIaAf52rto4FCBD+0Gl9tL2hGDGc/O01QIrWbBk+uzJt8nY5RgN28f+qmzwe3xghefUk1VBPRtnIdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929801; c=relaxed/simple;
	bh=6CKW1PZZXpj2YUvD7cXnvJodB4Lzp685MarqaX86D2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFnH6K/2SGfYYy8+uXp8SI0ugoR7Cj1naUhmk5dvvp8AVM2xT9ZNBCp7derLShVQWlyH94Yp/zum+tMUIdArpIjk2/7TF45rhUmhnvG1ueWUb8vApccPDBaf2qz1ahydzVwBY7IRI6Waiwhe57JsevNdvQ0yu+Sb+p1p7yPbU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hyFykbrM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731929790;
	bh=6CKW1PZZXpj2YUvD7cXnvJodB4Lzp685MarqaX86D2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyFykbrMhhu6zI5bqdP4p2IIw21E8xyGjKAMvZvWz1CXNWVPHpeJWMVAI4kz+vShH
	 j56XAsoZ05/gDW9k9BPbEwyk1XLcq5lLRfibPdz91fG6YcwxOa0W21sUAYaPgPmMER
	 zmIEc31T1nvG2HYxl/rYvZ6mRI65TZi2Y9TZrg6g=
Date: Mon, 18 Nov 2024 12:36:06 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] sysfs: attribute_group: allow registration of const
 bin_attribute
Message-ID: <71fe4030-d6a1-47da-b8a7-28b899187168@t-8ch.de>
References: <20241115-b4-sysfs-const-bin_attr-group-v1-0-2c9bb12dfc48@weissschuh.net>
 <20241115-b4-sysfs-const-bin_attr-group-v1-1-2c9bb12dfc48@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115-b4-sysfs-const-bin_attr-group-v1-1-2c9bb12dfc48@weissschuh.net>

Hi Greg,

On 2024-11-15 17:42:48+0100, Thomas Weißschuh wrote:

> [..]

> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index d713a6445a6267145a7014f308df3bb25b8c3287..0f2fcd244523f050c5286f19d4fe1846506f9214 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -106,7 +106,10 @@ struct attribute_group {
>  					    const struct bin_attribute *,
>  					    int);
>  	struct attribute	**attrs;
> -	struct bin_attribute	**bin_attrs;
> +	union {
> +		struct bin_attribute		**bin_attrs;
> +		const struct bin_attribute	*const *bin_attrs_new;
> +	};

Unfortunately this triggers warnings in two drivers.
These incorrectly have a trailing NULL literal in their struct attribute
definition (full list at the end of the mail):

>> drivers/perf/arm-ni.c:248:63: warning: missing braces around initializer [-Wmissing-braces]
     248 | static const struct attribute_group arm_ni_other_attr_group = {
         |                                                               ^


vim +248 drivers/perf/arm-ni.c

4d5a7680f2b4d0 Robin Murphy 2024-09-04  247
4d5a7680f2b4d0 Robin Murphy 2024-09-04 @248  static const struct attribute_group arm_ni_other_attr_group = {
4d5a7680f2b4d0 Robin Murphy 2024-09-04  249  	.attrs = arm_ni_other_attrs,
4d5a7680f2b4d0 Robin Murphy 2024-09-04  250  	NULL
4d5a7680f2b4d0 Robin Murphy 2024-09-04  251  };
4d5a7680f2b4d0 Robin Murphy 2024-09-04  252

These trailing NULLs should first be removed.
How do you want to proceed?

Cocci script and results, only the first two results are relevant at
this moment.

	virtual patch

	@@
	identifier ag, pattrs;
	@@

	  struct attribute_group ag = {
	    .attrs = pattrs,
	-   NULL
	  };

diff -u -p a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -803,7 +803,6 @@ static struct attribute *con3215_drv_att

 static struct attribute_group con3215_drv_attr_group = {
 	.attrs = con3215_drv_attrs,
-	NULL,
 };

 static const struct attribute_group *con3215_drv_attr_groups[] = {
diff -u -p a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -247,7 +247,6 @@ static struct attribute *arm_ni_other_at

 static const struct attribute_group arm_ni_other_attr_group = {
 	.attrs = arm_ni_other_attrs,
-	NULL
 };

 static const struct attribute_group *arm_ni_attr_groups[] = {
diff -u -p a/kernel/cpu.c b/kernel/cpu.c
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2866,7 +2866,6 @@ static struct attribute *cpuhp_cpu_attrs
 static const struct attribute_group cpuhp_cpu_attr_group = {
 	.attrs = cpuhp_cpu_attrs,
 	.name = "hotplug",
-	NULL
 };

 static ssize_t states_show(struct device *dev,
@@ -2898,7 +2897,6 @@ static struct attribute *cpuhp_cpu_root_
 static const struct attribute_group cpuhp_cpu_root_attr_group = {
 	.attrs = cpuhp_cpu_root_attrs,
 	.name = "hotplug",
-	NULL
 };

 #ifdef CONFIG_HOTPLUG_SMT
@@ -3020,7 +3018,6 @@ static struct attribute *cpuhp_smt_attrs
 static const struct attribute_group cpuhp_smt_attr_group = {
 	.attrs = cpuhp_smt_attrs,
 	.name = "smt",
-	NULL
 };

 static int __init cpu_smt_sysfs_init(void)

