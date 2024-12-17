Return-Path: <linux-kernel+bounces-448846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512AF9F466A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FBE16895E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6A1DEFF3;
	Tue, 17 Dec 2024 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Ey8zGE2Y"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE7171092
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425177; cv=none; b=QJwMdwPeND3UbADZRfo3vH9knQfqDwhp3xfVWczElyhPmEhY8Pwt5k0jJkqC4nc04n9AbhCyUR3ASx3vdbNYTEil4SBZ2lwQzGkilJUdbnuWhpYokx/wWqSp75v/W4ZiNjCIZZzkDYwu6LpPMHYh7W1QeRfgO/Ajj/N/D7ScGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425177; c=relaxed/simple;
	bh=oOlSR/inyA80CTgFMIToej0wYVKqLBtuNwJvZZfAoVA=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=tC5BMFbpcTrbhPhLRsJFMRQasxRtqLWPOmhWyjI2A3TnHzglotQ+zmzC9qWYl80JD2n1dKQ3eCnuVJ8g8pbaO+maNng/gQKf+grWLBEzB4a0ChTDSgF3D1euqymsG1kWC5PJgWxHhwpFvHouGPaRkdz6BSI1dhF+FQ2Jmpb1Plc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Ey8zGE2Y; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y1JGsxqNjY8bz1ktiFgTDJJPb3UnpO7XcGc6KNyhQWU=;
  b=Ey8zGE2YJipR+kL3DBOfs+IXhr6QcoOsqF0o72rmoA8s6IsZNimFMO/o
   SwjKDOQpa51hSVD+N4kHXqe84dyNBHDw8KIZjnpELSO2yZE1vFQ64TiHf
   8oNaZ2y+oIHwWThxjBJdRsXn++WEFrt4PsCIAGiURAiXC4jF8uFdLkjIR
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,241,1728943200"; 
   d="scan'208";a="104515743"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 09:45:02 +0100
Date: Tue, 17 Dec 2024 09:45:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mika Westerberg <mika.westerberg@linux.intel.com>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/thunderbolt/debugfs.c:532:5-33: opportunity for
 str_yes_no(supports_software ( margining )) (fwd)
Message-ID: <alpine.DEB.2.22.394.2412170944390.3436@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Tue, 17 Dec 2024 16:26:31 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/thunderbolt/debugfs.c:532:5-33: opportunity for
    str_yes_no(supports_software ( margining ))

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Mika Westerberg <mika.westerberg@linux.intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f44d154d6e3d633d4c49a5d6aed8a0e4684ae25e
commit: ec6f888ed08aeceaebfdd7d344ae0cd91a1b9a1b thunderbolt: Split out margining from USB4 port
date:   6 months ago
:::::: branch date: 14 hours ago
:::::: commit date: 6 months ago
config: loongarch-randconfig-r061-20241217 (https://download.01.org/0day-ci/archive/20241217/202412171648.LGwq0U3d-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202412171648.LGwq0U3d-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
   drivers/thunderbolt/debugfs.c:544:4-25: opportunity for str_yes_no(both_lanes ( margining ))
>> drivers/thunderbolt/debugfs.c:532:5-33: opportunity for str_yes_no(supports_software ( margining ))
   drivers/thunderbolt/debugfs.c:565:6-41: opportunity for str_yes_no(cap1 & USB4_MARGIN_CAP_1_TIME_DESTR)

vim +532 drivers/thunderbolt/debugfs.c

d0f1e0c2a699092 Mika Westerberg 2022-02-22  515
d0f1e0c2a699092 Mika Westerberg 2022-02-22  516  static int margining_caps_show(struct seq_file *s, void *not_used)
d0f1e0c2a699092 Mika Westerberg 2022-02-22  517  {
ec6f888ed08aece Mika Westerberg 2023-03-14  518  	struct tb_margining *margining = s->private;
ec6f888ed08aece Mika Westerberg 2023-03-14  519  	struct tb *tb = margining->port->sw->tb;
d0f1e0c2a699092 Mika Westerberg 2022-02-22  520  	u32 cap0, cap1;
d0f1e0c2a699092 Mika Westerberg 2022-02-22  521
d0f1e0c2a699092 Mika Westerberg 2022-02-22  522  	if (mutex_lock_interruptible(&tb->lock))
d0f1e0c2a699092 Mika Westerberg 2022-02-22  523  		return -ERESTARTSYS;
d0f1e0c2a699092 Mika Westerberg 2022-02-22  524
d0f1e0c2a699092 Mika Westerberg 2022-02-22  525  	/* Dump the raw caps first */
ec6f888ed08aece Mika Westerberg 2023-03-14  526  	cap0 = margining->caps[0];
d0f1e0c2a699092 Mika Westerberg 2022-02-22  527  	seq_printf(s, "0x%08x\n", cap0);
ec6f888ed08aece Mika Westerberg 2023-03-14  528  	cap1 = margining->caps[1];
d0f1e0c2a699092 Mika Westerberg 2022-02-22  529  	seq_printf(s, "0x%08x\n", cap1);
d0f1e0c2a699092 Mika Westerberg 2022-02-22  530
d0f1e0c2a699092 Mika Westerberg 2022-02-22  531  	seq_printf(s, "# software margining: %s\n",
ec6f888ed08aece Mika Westerberg 2023-03-14 @532  		   supports_software(margining) ? "yes" : "no");
ec6f888ed08aece Mika Westerberg 2023-03-14  533  	if (supports_hardware(margining)) {
d0f1e0c2a699092 Mika Westerberg 2022-02-22  534  		seq_puts(s, "# hardware margining: yes\n");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  535  		seq_puts(s, "# minimum BER level contour: ");
ec6f888ed08aece Mika Westerberg 2023-03-14  536  		ber_level_show(s, margining->min_ber_level);
d0f1e0c2a699092 Mika Westerberg 2022-02-22  537  		seq_puts(s, "# maximum BER level contour: ");
ec6f888ed08aece Mika Westerberg 2023-03-14  538  		ber_level_show(s, margining->max_ber_level);
d0f1e0c2a699092 Mika Westerberg 2022-02-22  539  	} else {
d0f1e0c2a699092 Mika Westerberg 2022-02-22  540  		seq_puts(s, "# hardware margining: no\n");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  541  	}
d0f1e0c2a699092 Mika Westerberg 2022-02-22  542
706d73836481cce Colin Ian King  2022-09-06  543  	seq_printf(s, "# both lanes simultaneously: %s\n",
ec6f888ed08aece Mika Westerberg 2023-03-14  544  		  both_lanes(margining) ? "yes" : "no");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  545  	seq_printf(s, "# voltage margin steps: %u\n",
ec6f888ed08aece Mika Westerberg 2023-03-14  546  		   margining->voltage_steps);
d0f1e0c2a699092 Mika Westerberg 2022-02-22  547  	seq_printf(s, "# maximum voltage offset: %u mV\n",
ec6f888ed08aece Mika Westerberg 2023-03-14  548  		   margining->max_voltage_offset);
d0f1e0c2a699092 Mika Westerberg 2022-02-22  549
ec6f888ed08aece Mika Westerberg 2023-03-14  550  	switch (independent_voltage_margins(margining)) {
d0f1e0c2a699092 Mika Westerberg 2022-02-22  551  	case USB4_MARGIN_CAP_0_VOLTAGE_MIN:
d0f1e0c2a699092 Mika Westerberg 2022-02-22  552  		seq_puts(s, "# returns minimum between high and low voltage margins\n");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  553  		break;
d0f1e0c2a699092 Mika Westerberg 2022-02-22  554  	case USB4_MARGIN_CAP_0_VOLTAGE_HL:
d0f1e0c2a699092 Mika Westerberg 2022-02-22  555  		seq_puts(s, "# returns high or low voltage margin\n");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  556  		break;
d0f1e0c2a699092 Mika Westerberg 2022-02-22  557  	case USB4_MARGIN_CAP_0_VOLTAGE_BOTH:
706d73836481cce Colin Ian King  2022-09-06  558  		seq_puts(s, "# returns both high and low margins\n");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  559  		break;
d0f1e0c2a699092 Mika Westerberg 2022-02-22  560  	}
d0f1e0c2a699092 Mika Westerberg 2022-02-22  561
ec6f888ed08aece Mika Westerberg 2023-03-14  562  	if (supports_time(margining)) {
d0f1e0c2a699092 Mika Westerberg 2022-02-22  563  		seq_puts(s, "# time margining: yes\n");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  564  		seq_printf(s, "# time margining is destructive: %s\n",
d0f1e0c2a699092 Mika Westerberg 2022-02-22  565  			   cap1 & USB4_MARGIN_CAP_1_TIME_DESTR ? "yes" : "no");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  566
ec6f888ed08aece Mika Westerberg 2023-03-14  567  		switch (independent_time_margins(margining)) {
d0f1e0c2a699092 Mika Westerberg 2022-02-22  568  		case USB4_MARGIN_CAP_1_TIME_MIN:
d0f1e0c2a699092 Mika Westerberg 2022-02-22  569  			seq_puts(s, "# returns minimum between left and right time margins\n");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  570  			break;
d0f1e0c2a699092 Mika Westerberg 2022-02-22  571  		case USB4_MARGIN_CAP_1_TIME_LR:
d0f1e0c2a699092 Mika Westerberg 2022-02-22  572  			seq_puts(s, "# returns left or right margin\n");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  573  			break;
d0f1e0c2a699092 Mika Westerberg 2022-02-22  574  		case USB4_MARGIN_CAP_1_TIME_BOTH:
d0f1e0c2a699092 Mika Westerberg 2022-02-22  575  			seq_puts(s, "# returns both left and right margins\n");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  576  			break;
d0f1e0c2a699092 Mika Westerberg 2022-02-22  577  		}
d0f1e0c2a699092 Mika Westerberg 2022-02-22  578
d0f1e0c2a699092 Mika Westerberg 2022-02-22  579  		seq_printf(s, "# time margin steps: %u\n",
ec6f888ed08aece Mika Westerberg 2023-03-14  580  			   margining->time_steps);
d0f1e0c2a699092 Mika Westerberg 2022-02-22  581  		seq_printf(s, "# maximum time offset: %u mUI\n",
ec6f888ed08aece Mika Westerberg 2023-03-14  582  			   margining->max_time_offset);
d0f1e0c2a699092 Mika Westerberg 2022-02-22  583  	} else {
d0f1e0c2a699092 Mika Westerberg 2022-02-22  584  		seq_puts(s, "# time margining: no\n");
d0f1e0c2a699092 Mika Westerberg 2022-02-22  585  	}
d0f1e0c2a699092 Mika Westerberg 2022-02-22  586
d0f1e0c2a699092 Mika Westerberg 2022-02-22  587  	mutex_unlock(&tb->lock);
d0f1e0c2a699092 Mika Westerberg 2022-02-22  588  	return 0;
d0f1e0c2a699092 Mika Westerberg 2022-02-22  589  }
d0f1e0c2a699092 Mika Westerberg 2022-02-22  590  DEBUGFS_ATTR_RO(margining_caps);
d0f1e0c2a699092 Mika Westerberg 2022-02-22  591

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

