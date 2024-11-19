Return-Path: <linux-kernel+bounces-414139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545C49D239D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D033CB261E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08FF19C553;
	Tue, 19 Nov 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8bbh216"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328431BE87C;
	Tue, 19 Nov 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012198; cv=none; b=T32PgFS0uBpU6r4d/l0o5UalIIhtRG4X2GjU7CvgD73UX1gR0pIQk2eYG09gSQ5gSSeG/ThzAgfNgtnK4rIBcOldcLCirsC8xwcNR/8g9hzxogQWLpG11GkQRFy/Bk/L2uWdvfX5ZKULk5fQDXWbfI8HFHu8h/V/jti9ND7CwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012198; c=relaxed/simple;
	bh=pmJT/yWKcDPJdA1oVQGGFWFe8bYlf1ugDi6HCnRaKuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mflbWqjA5LpDdQNKgexrU38luYRa4ZHR056HjHwsYaFLaPNSO7DZTDasJk2vdiyqRJLFY+9YDbaFNOyQkO/3D1Maii5khIqmBCgNVv+/OndvTJrK8qGAsQp/gMKhrCVF0lGszOmTDr+S5xGkiuXYzIjdydfgcVxf70G5E22US4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8bbh216; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424FCC4CECF;
	Tue, 19 Nov 2024 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732012197;
	bh=pmJT/yWKcDPJdA1oVQGGFWFe8bYlf1ugDi6HCnRaKuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8bbh216ulIXikobyuCfc4gZNrjFZ1C4E8YisYrSBN7A0fd2A4T8XwFpoLol7v3YO
	 C7Kk+5JaJOIS9XScpkEkU5D7Pk+rq4zJzIXnSu49+lnQWOmZbjYPL6s/jmbWT6Wtfu
	 zaM5nGLTt5rXCsj0o51SoMqqVmKcA+Tn1Z+zzSWJEBccp3Fjgjxwv+jv8rY522WdKu
	 BTtA79PJgCMeqGaEsRcOd7FYWewaxdS8Y6819asDPDzsk91JLzUMe2jXebLU2iUosf
	 24BoDYCHyVzF2rhpQYPg0lIY9LhbTUdUXBiRNcrE/QZr/+KTWSY7Ts32i2WjA2x/kG
	 Obt/t5P4Un1DA==
Date: Tue, 19 Nov 2024 11:29:52 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Joel Granados <j.granados@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Subject: Re: drivers/parport/procfs.c:267:18-28: WARNING use flexible-array
 member instead
 (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
 (fwd)
Message-ID: <7776uzbrykjhbouthwpqakytvbxgcjbleinf7t4isaglxdizs2@lxfhkj6ec24b>
References: <alpine.DEB.2.22.394.2411022204280.15958@hadrien>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2411022204280.15958@hadrien>

On Sat, Nov 02, 2024 at 10:05:24PM +0100, Julia Lawall wrote:
> If device_dir is meant to be a flexible array, use [] instead or [1].
I don't think it is meant as a flexible array. I'll try to contextualize what is
happening and suggest a way forward.

> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Sun, 3 Nov 2024 04:56:55 +0800
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>

...

> vim +267 drivers/parport/procfs.c
> 
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  257
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  258
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  259  struct parport_sysctl_table {
> 37e9981e33e4d3 Joel Granados  2023-06-16  260  	struct ctl_table_header *port_header;
> 37e9981e33e4d3 Joel Granados  2023-06-16  261  	struct ctl_table_header *devices_header;
> 0829381e481ab2 Joel Granados  2023-10-02  262  #ifdef CONFIG_PARPORT_1284
> 0829381e481ab2 Joel Granados  2023-10-02  263  	struct ctl_table vars[10];
> 0829381e481ab2 Joel Granados  2023-10-02  264  #else
> 0829381e481ab2 Joel Granados  2023-10-02  265  	struct ctl_table vars[5];
> 0829381e481ab2 Joel Granados  2023-10-02  266  #endif /* IEEE 1284 support */
> 0829381e481ab2 Joel Granados  2023-10-02 @267  	struct ctl_table device_dir[1];
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  268  };
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  269

What we were doing was just to remove the sentinel from that device_dir array.
As you can it was originally sized at 2 (with the second element left empty to
signify a sentinel). This is the diff:
``` diff
  diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
   index 4e5b972c3e26..532d5cbbd344 100644
   --- a/drivers/parport/procfs.c
   +++ b/drivers/parport/procfs.c
   @@ -259,8 +259,12 @@ PARPORT_MAX_SPINTIME_VALUE;
    struct parport_sysctl_table {
          struct ctl_table_header *port_header;
          struct ctl_table_header *devices_header;
   -      struct ctl_table vars[12];
   -      struct ctl_table device_dir[2];
   +#ifdef CONFIG_PARPORT_1284
   +      struct ctl_table vars[10];
   +#else
   +      struct ctl_table vars[5];
   +#endif /* IEEE 1284 support */
   +      struct ctl_table device_dir[1];
    };
```

So the array was at the end with a size to begin with. But I don't think that
its original intention was to be a flexible array. I'm not sure though, I'm
ccing the parport maintainers in hope that they can shed more light on this.

Notice that I prefer device_dir to be an array, so it can be passed to the
sysctl register call as is

Best

> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 

Joel Granados

