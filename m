Return-Path: <linux-kernel+bounces-390989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC549B80E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3FFB223E2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A29B1BD020;
	Thu, 31 Oct 2024 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MewKg2wu"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACB1BD027;
	Thu, 31 Oct 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394541; cv=none; b=FCUHLBVMdrvvUiqcpSi4lPIKzknT04AzaYwGqNcSN9XsgcZtfqqwq1Sex2qPqeWeWOdcBKUsyyflPnR5aTalFDx1w4iAqhK7wm1cGLQ66P4JnEJk7stl/NI/H98/BKecOOLCAEbfCE24IBzMBdG68/u68tj4fwNlkDihjw6LaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394541; c=relaxed/simple;
	bh=KEfJVaU2vKKs59rSj84s5z2k64209Avi9d7VZOcfglY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A34wdJc3DjWjiGk1hiU7Fvwbzfq/ISTpp7EbCB65OhKW8aCUHhw9pMUOiu7p113WmfrWuAYf5VWiV96B1/jMo2B1FGO/PKWkLcrGYy8tjsQZvFjgSLFuwlWGkz7WXpJkgyq1avEK0XkE+Wb0idymPzDsJWxaN0vtqs8CKm/WsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MewKg2wu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=W5h6trhGhExF9MOboKem+7LHZquHhoyqfmnTScAyrLI=; b=MewKg2wulCfzTIKrRFCIVr5gCL
	e/egJE8/Dc8+nGTXY2SvFMb2cbFmxrMODa6k2Ie9i8m1aZKby6ty6thYVNV13GqXkcsvHDErjYQsE
	eBMDxfUq5gfzrfDNgb/Axb3BzCIaKe2qicHvMDcZorBvCmDPxympe1XgW0LUsJFmUTiwPlLxQpEg7
	c8cC/0hcJumyFcntPigjvxIh8XHuFREuwS662SmSmSgV56l4Xxojtm7zmyPmAOsoDVBFs2tHLhA09
	svYuv+yZ8JgaG0JF+3gAdoNWcX+QLGy/QzgC3rCfJBShMaiDgysv8IbQKwkojqOBSea1iAl2eysbA
	XqoxlXqg==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6YfA-0000000AVse-3jn4;
	Thu, 31 Oct 2024 17:08:50 +0000
Message-ID: <b4854dab-b5e5-4e72-97ff-4d7cdb5723c1@infradead.org>
Date: Thu, 31 Oct 2024 10:08:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2 1/4] drivers pps: add PPS generators support
To: Rodolfo Giometti <giometti@enneenne.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
 corbet@lwn.net, Hall Christopher S <christopher.s.hall@intel.com>,
 Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dong Eddie <eddie.dong@intel.com>, N Pandith <pandith.n@intel.com>,
 T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
 Zage David <david.zage@intel.com>,
 Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>
References: <20241031163508.259522-1-giometti@enneenne.com>
 <20241031163508.259522-2-giometti@enneenne.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241031163508.259522-2-giometti@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/24 9:35 AM, Rodolfo Giometti wrote:
> Sometimes one needs to be able not only to catch PPS signals but to
> produce them also. For example, running a distributed simulation,
> which requires computers' clock to be synchronized very tightly.
> 
> This patch adds PPS generators class in order to have a well-defined
> interface for these devices.
> 
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |   1 +
>  drivers/pps/Makefile                          |   3 +-
>  drivers/pps/generators/Kconfig                |  13 +-
>  drivers/pps/generators/Makefile               |   3 +
>  drivers/pps/generators/pps_gen.c              | 344 ++++++++++++++++++
>  drivers/pps/generators/sysfs.c                |  75 ++++
>  include/linux/pps_gen_kernel.h                |  78 ++++
>  include/uapi/linux/pps_gen.h                  |  37 ++
>  9 files changed, 553 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pps/generators/pps_gen.c
>  create mode 100644 drivers/pps/generators/sysfs.c
>  create mode 100644 include/linux/pps_gen_kernel.h
>  create mode 100644 include/uapi/linux/pps_gen.h
> 

> diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
> index d615e640fcad..5edbfdb8bd92 100644
> --- a/drivers/pps/generators/Kconfig
> +++ b/drivers/pps/generators/Kconfig
> @@ -3,7 +3,16 @@
>  # PPS generators configuration
>  #
>  
> -comment "PPS generators support"
> +menuconfig PPS_GENERATOR
> +	tristate "PPS generators support"
> +	help
> +	  PPS generators are special hardware which are able to produce PPS
> +	  (Pulse Per Second) signals.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pps_gen_core.ko.

Drop the ".ko" suffix as you did for the dummy module and most of the kernel does.

> +
> +if PPS_GENERATOR
>  
>  config PPS_GENERATOR_PARPORT
>  	tristate "Parallel port PPS signal generator"
> @@ -12,3 +21,5 @@ config PPS_GENERATOR_PARPORT
>  	  If you say yes here you get support for a PPS signal generator which
>  	  utilizes STROBE pin of a parallel port to send PPS signals. It uses
>  	  parport abstraction layer and hrtimers to precisely control the signal.
> +
> +endif # PPS_GENERATOR


-- 
~Randy


