Return-Path: <linux-kernel+bounces-393573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23809BA278
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71610282C13
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2721AB6CD;
	Sat,  2 Nov 2024 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="VnfDWs3S"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985F15539A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730581536; cv=none; b=dosgGSN2//UJYnZy06Xk72fWCPlw/bNAMsz2Vfie0jd+gqmIPpbO+xxHxfN87W/RsysB3Zu9uYanNs5L96KuMmTgoFqjnGdA8lPB6c84nAbay7fcb1Mbo0OhTEB2XpUOpQI7H7cTXuVGXqX+AwVqBcIqSAGNpqLWKKrv473YTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730581536; c=relaxed/simple;
	bh=23YfwIYN1koxCgtfe4KD5N+ORe0ESaE/bMPjDiBXZIk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=EnaM9WOMMKAzQ0wFYV9z/o/0C3SkNThA8ZG2/pLGv57aIp6Le3rN0VlWo/7neUIbOE07My3ZXLt81BoEnc4dp+O3rBS3fMppbCFz04bRYP5CtSxElcW1noHvDWxhLA1wOHoiYrC6f18ueGHptknVIogDniT1PNwPSBR5Pu9ZpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=VnfDWs3S; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SWYIFYb+Zx7puvJ4vcP4AeCNUeAXlDc0PqpgIrPzFbs=;
  b=VnfDWs3S8SrNyO0bVCC6H6zP6ymwI1TUcbPJ9eTlmKoVnM0nfEa0FjSt
   6h2OIoAm8ck+TfZonAF9K0aq3/YeBoCCSkD6903j6HPnGi0VMKqoSQyKj
   M756Ida1SSYRHzcj2c86fGMtGebXm2cc2/sE0woqggGXlrrXLKy8uqgWg
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,253,1725314400"; 
   d="scan'208";a="100585925"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 22:05:25 +0100
Date: Sat, 2 Nov 2024 22:05:24 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joel Granados <j.granados@samsung.com>
cc: Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org, 
    oe-kbuild-all@lists.linux.dev
Subject: drivers/parport/procfs.c:267:18-28: WARNING use flexible-array member
 instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
 (fwd)
Message-ID: <alpine.DEB.2.22.394.2411022204280.15958@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

If device_dir is meant to be a flexible array, use [] instead or [1].

julia

---------- Forwarded message ----------
Date: Sun, 3 Nov 2024 04:56:55 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/parport/procfs.c:267:18-28: WARNING use flexible-array member
    instead
    (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-
    and-one-element-arrays)

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Joel Granados <j.granados@samsung.com>
CC: Luis Chamberlain <mcgrof@kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   11066801dd4b7c4d75fce65c812723a80c1481ae
commit: 0829381e481ab2760086cc88090f70e761e4fcc2 parport: Remove the now superfluous sentinel element from ctl_table array
date:   1 year, 1 month ago
:::::: branch date: 19 hours ago
:::::: commit date: 1 year, 1 month ago
config: x86_64-randconfig-102-20241102 (https://download.01.org/0day-ci/archive/20241103/202411030437.OYnKHsPA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202411030437.OYnKHsPA-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/parport/procfs.c:267:18-28: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
   drivers/parport/procfs.c:364:18-28: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

vim +267 drivers/parport/procfs.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  257
^1da177e4c3f41 Linus Torvalds 2005-04-16  258
^1da177e4c3f41 Linus Torvalds 2005-04-16  259  struct parport_sysctl_table {
37e9981e33e4d3 Joel Granados  2023-06-16  260  	struct ctl_table_header *port_header;
37e9981e33e4d3 Joel Granados  2023-06-16  261  	struct ctl_table_header *devices_header;
0829381e481ab2 Joel Granados  2023-10-02  262  #ifdef CONFIG_PARPORT_1284
0829381e481ab2 Joel Granados  2023-10-02  263  	struct ctl_table vars[10];
0829381e481ab2 Joel Granados  2023-10-02  264  #else
0829381e481ab2 Joel Granados  2023-10-02  265  	struct ctl_table vars[5];
0829381e481ab2 Joel Granados  2023-10-02  266  #endif /* IEEE 1284 support */
0829381e481ab2 Joel Granados  2023-10-02 @267  	struct ctl_table device_dir[1];
^1da177e4c3f41 Linus Torvalds 2005-04-16  268  };
^1da177e4c3f41 Linus Torvalds 2005-04-16  269

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

