Return-Path: <linux-kernel+bounces-390995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822419B80F1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E781F22319
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4841BDA8D;
	Thu, 31 Oct 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mLfJIACh"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249513AA5F;
	Thu, 31 Oct 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394853; cv=none; b=R6qY30zQsoEf21Ksf7dL19WOs5B5t344TpZTv76dCuTg7LWnkYCMIkXKSq3SKgQmWj1cNRt4ph0PP1n0d3MpyVp5o2RmYjy0QLaPzJBe5T3HcJrDrrEjY221Jl8t0GO10f8itOdZHfJBzKHgZ3/PionGOemgW919Gy5C/s3N69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394853; c=relaxed/simple;
	bh=mSzN6YpXlT2GzYEgoQL3jtlhmNugZ15r4Hvr/ti307k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yd+lL+OGe8K5nUo1Q1MUxaXwvaL1/Z2Ed0BWUEA/E0FUp3O9jWQcrC7kEf3dYSp4zinHQz5SJAXEm09XYFTh9HLMgqy3L/9LkxRh0lK74kKLrskm29ny5dPlof3fyELdr9A8j283OuFdWjSA1SITbdR5aamkw1CQ66nZ9qWmfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mLfJIACh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vGJ47LHXuM5gzL0ZKbBs9aIHU/WzZZSYIs59zdk6VbQ=; b=mLfJIACh/yCI7flYsVrDVtOGCz
	GddrhMrGvlIQU7ELUMg8S0GIB12y/mv65gJKhcpH0jtALmYcMDHykmA0Pu79TdoIzeVIj7gXgu1em
	Xp9++UhzJ7DlvHIARYlrGPaj3auHDJrundmXfwO334rrJ8fHuFlBsHQ1rM4uSvjGzrHZl6uWE2rwx
	umncXZMIe+XBZuIZjIdiXnbOEcxVHT6N6DEn0To4TcG+sOutakVoebYPh98ZL87AAK5htn6meoLv1
	YHGlq/rgOlOOiNHYtXdA6je9VgjUVBogIAMzkCYlUSclhSArL4hDqcNPU6OBjdvWt5oGZjyfPL42L
	d1WHnrbA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6YkJ-0000000AVur-456O;
	Thu, 31 Oct 2024 17:14:08 +0000
Message-ID: <07528a82-13ee-421f-8ad9-e99689d4f03a@infradead.org>
Date: Thu, 31 Oct 2024 10:14:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2 3/4] Documentation pps.rst: add PPS generators documentation
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
 <20241031163508.259522-4-giometti@enneenne.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241031163508.259522-4-giometti@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/24 9:35 AM, Rodolfo Giometti wrote:
> This patch adds some examples about how to register a new PPS
> generator in the system, and how to manage it.
> 
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  Documentation/driver-api/pps.rst | 40 ++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
> index 78dded03e5d8..dffa06ed919f 100644
> --- a/Documentation/driver-api/pps.rst
> +++ b/Documentation/driver-api/pps.rst
> @@ -202,6 +202,46 @@ Sometimes one needs to be able not only to catch PPS signals but to produce
>  them also. For example, running a distributed simulation, which requires
>  computers' clock to be synchronized very tightly.
>  
> +To do so the class pps-gen has been added. PPS generators can be
> +registered in the kernel by defining a struct pps_gen_source_info as
> +follows::
> +
> +    static struct pps_gen_source_info pps_gen_dummy_info = {
> +            .name                   = "dummy",
> +            .use_system_clock       = true,
> +            .get_time               = pps_gen_dummy_get_time,
> +            .enable                 = pps_gen_dummy_enable,
> +    };
> +
> +Where the use_system_clock states if the generator uses the system
> +clock to generate its pulses, or from a peripheral device

                                 or they are from a peripheral device

> +clock. Method get_time() is used to query the time stored into the
> +generator clock, while the method enable() is used to enable or
> +disable the PPS pulse generation.
> +
> +Then calling the function pps_gen_register_source() in your
> +initialization routine as follows creates a new generator in the
> +system::
> +
> +    pps_gen = pps_gen_register_source(&pps_gen_dummy_info);
> +
> +Generators SYSFS support
> +------------------------
> +
> +If the SYSFS filesystem is enabled in the kernel it provides a new class::
> +
> +    $ ls /sys/class/pps-gen/
> +    pps-gen0/  pps-gen1/  pps-gen2/
> +
> +Every directory is the ID of a PPS generator defined in the system and
> +inside you find several files::
> +
> +    $ ls -F /sys/class/pps-gen/pps-gen0/
> +    dev  enable  name  power/  subsystem@  system  time  uevent
> +
> +To enable the PPS signal generation you can use the command below::
> +
> +    $ echo 1 > /sys/class/pps-gen/pps-gen0/enable
>  
>  Parallel port generator
>  ------------------------

-- 
~Randy


