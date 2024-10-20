Return-Path: <linux-kernel+bounces-373341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64999A557E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB6D282A1A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA2C194A74;
	Sun, 20 Oct 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CBzwOBXw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA1320E;
	Sun, 20 Oct 2024 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729446529; cv=none; b=OvvtTYVBCe3WLVIemcl+01XOfXqCbZW6VqygMCtaDxR5U33OXdwA05/OaE9Cf58TEGep3p5Hv81I5dV0FNG8kxFLgP8SDIDdOcgXdEatYcsIxNd0oJ4aABDb6/Tydrn34Xh3nnRqVqpEgLddKxMqiiwG1hipUXnUDbr8M2UkarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729446529; c=relaxed/simple;
	bh=AjQozGx31sxwwqGA5LIzBMYos2hQ+1DhvQ5wyAKgCdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZUgiIZBBZWgNksU1NUuaLvvvqxuh8XnqKLWSX+X5LI7foER9Rg695rqHKu4QDYNd7iDzo6wUkbNRcxuf67gea26UQXu089EJDrwtJtKUGhax5CE8cJpsT2Ttg9Jm1APe2knkbblt0nnoUgds8MW41ffKazz29qJdKNyItcsmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CBzwOBXw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=l+z7tTLWImkAfS9LQV4C4VJSmWWObYj4AWtxGh4jsRY=; b=CBzwOBXwLE2PXqd6P0Qfs1wr5k
	sxCB0ORAeH8USPq1gstAF6l2X1WzBvvDvaXPel9yMgFV2jjr+sq48KvE2rV+2jZ02ojG/YFv3C40K
	EmGoQci/n5hn0WgmjYTVB9crdDsA+g1FNFZTebqn3jF7UfX+EWbJJ8TDjcwk0Dwmlcg729O/JA0iU
	idRNfEZURTnv+oo4GC4ogX8/Rkrqb1yXUGOC4pXb+PAqcTcoUzTAwDCFlt/1nt1TVt8A8uOOeKs/X
	K9sBk1SrfPBRr9b87/K+IstNEABoLxsF4OOD2yigx0ETIxqoMBdv6+LH3l5PwhE4JDhbqu4G3S85M
	CwjfEL+g==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2a2l-0000000FSYu-11P5;
	Sun, 20 Oct 2024 17:48:44 +0000
Message-ID: <2117cd9d-fcfd-4d5d-b798-331068b1d16a@infradead.org>
Date: Sun, 20 Oct 2024 10:48:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V1 3/4] Documentation pps.rst: add PPS generators documentation
To: Rodolfo Giometti <giometti@enneenne.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
 corbet@lwn.net, Hall Christopher S <christopher.s.hall@intel.com>,
 Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
 andriy.shevchenko@linux.intel.com, Dong Eddie <eddie.dong@intel.com>,
 N Pandith <pandith.n@intel.com>,
 T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
 Zage David <david.zage@intel.com>,
 Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>
References: <20241018143915.3877425-1-giometti@enneenne.com>
 <20241018143915.3877425-4-giometti@enneenne.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241018143915.3877425-4-giometti@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/18/24 7:39 AM, Rodolfo Giometti wrote:
> This patch adds some examples about how to register a new PPS
> generator in the system, and how to manage it.
> 
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  Documentation/driver-api/pps.rst | 40 ++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
> index 78dded03e5d8..c71b3b878e41 100644
> --- a/Documentation/driver-api/pps.rst
> +++ b/Documentation/driver-api/pps.rst
> @@ -202,6 +202,46 @@ Sometimes one needs to be able not only to catch PPS signals but to produce
>  them also. For example, running a distributed simulation, which requires
>  computers' clock to be synchronized very tightly.
>  
> +To do so the class pps-gen has been added. PPS generators can be
> +registered int the kernel by defining a struct pps_gen_source_info as

             in the kernel

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
> +clock. Method get_time() is used to query the time stored into the
> +generator clock, while the method enable() is used to enable or
> +disable the PPS pulse generation.
> +

Alternate fixes below:

> +Then calling the function pps_gen_register_source() in your

   By

> +initialization routine as follows a new generator is created into the

or (exclusive or):

                                     creates a new generator in the

back to option 1:                                       created in the

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


