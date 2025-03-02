Return-Path: <linux-kernel+bounces-540461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66325A4B0E1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D4916AD30
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC991D54D1;
	Sun,  2 Mar 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceyK0VAL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68BF17991
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740909802; cv=none; b=pKdS2XbFKF4bTXTrePM52A45P2JXtFvKp5/hnkLV87iBPL5GiNj3oEqGK70lHi1IOqX7k0oHR/QSg4gv3TSvLwcaIT+NRRv0u8F2798+/aNXLw/lvsqWDVhcd03v5poiU38/6BmePoWDG9dnSfVXAgDPgPW+afgsK5szRKBziHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740909802; c=relaxed/simple;
	bh=qkiG6gq/gUK5HOJ1OiRbl8+BqMrnUIlRfC4kO/jChpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AjJAtL1CUGu2PBWmZUTSNJhLwhflg0DQNj6xjszIlBJvwT2uDlCt95tEw+Uo62Wlr1R1gWtqYic7ouEoHQcAWml7kiQZsI5eaUN8PSheefJaZEK2xgTj8mRFCd2mSlAfDSqL64W66bprgZtWc+b+JJngv8mCHW/EO7ZZqoBmc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceyK0VAL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740909801; x=1772445801;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qkiG6gq/gUK5HOJ1OiRbl8+BqMrnUIlRfC4kO/jChpQ=;
  b=ceyK0VALY+0cRSl00K/0UQwuWVA4pWIpd56QzcD2B+F0BIqxueVyrLT6
   GXKYiXdqX+n2at8MZZtsZxg48uS6/DbJbMtYXgPkVFJBMhmcXC3XTAAs3
   0wQ5C3tC3C8pPBd9OApzDCxZimGgUgUEsbuEuUexcaV3eVNNyBlVm2Zbv
   tJNPwSzqzPGKXLaS6Tq/WJAJWxSV4cXKRFmTaxTjGORZnmcZe5CtnkE2u
   fhoBw/70jS6i9P6WJaA5hxOzYyfSH54CG9+i2s3ka6G5hAvtP7iOSujUB
   JLlCUi7xm0QkwS0aexQdvhE09qu/niFezkgAmGn1RApAj0MxIhPPCM5kC
   Q==;
X-CSE-ConnectionGUID: hsS4N8GtRPW6ZygjLSphTA==
X-CSE-MsgGUID: rHLY3SnsQH+xGKTDhVuhug==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41036293"
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="41036293"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 02:03:20 -0800
X-CSE-ConnectionGUID: dNJr6+OQRa2i9eJkg2dtZw==
X-CSE-MsgGUID: I5mepTOASsCIBNiMk4MhQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118642152"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 02 Mar 2025 02:03:18 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1togAG-000HEY-1O;
	Sun, 02 Mar 2025 10:03:16 +0000
Date: Sun, 2 Mar 2025 18:03:03 +0800
From: kernel test robot <lkp@intel.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrzej Hajda <a.hajda@samsung.com>
Subject: drivers/video/fbdev/mmp/hw/mmp_spi.c:31: warning: expecting
 prototype for spi_write(). Prototype was for lcd_spi_write() instead
Message-ID: <202503021738.nUmNW1Ny-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bartlomiej,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ece144f151ac7bf8bb5b98f7d4aeeda7a2eed02a
commit: dd90e9ae55a1e7efd3ac036afe9f7ae7bb64d39d video: fbdev: mmp: add COMPILE_TEST support
date:   5 years ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250302/202503021738.nUmNW1Ny-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503021738.nUmNW1Ny-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503021738.nUmNW1Ny-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/video/fbdev/mmp/hw/mmp_spi.c:31: warning: Function parameter or struct member 'spi' not described in 'lcd_spi_write'
>> drivers/video/fbdev/mmp/hw/mmp_spi.c:31: warning: expecting prototype for spi_write(). Prototype was for lcd_spi_write() instead


vim +31 drivers/video/fbdev/mmp/hw/mmp_spi.c

641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  17  
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  18  /**
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  19   * spi_write - write command to the SPI port
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  20   * @data: can be 8/16/32-bit, MSB justified data to write.
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  21   * @len:  data length.
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  22   *
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  23   * Wait bus transfer complete IRQ.
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  24   * The caller is expected to perform the necessary locking.
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  25   *
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  26   * Returns:
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  27   *   %-ETIMEDOUT	timeout occurred
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  28   *   0			success
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  29   */
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  30  static inline int lcd_spi_write(struct spi_device *spi, u32 data)
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21 @31  {
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  32  	int timeout = 100000, isr, ret = 0;
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  33  	u32 tmp;
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  34  	void *reg_base =
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  35  		*(void **)spi_master_get_devdata(spi->master);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  36  
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  37  	/* clear ISR */
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  38  	writel_relaxed(~SPI_IRQ_MASK, reg_base + SPU_IRQ_ISR);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  39  
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  40  	switch (spi->bits_per_word) {
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  41  	case 8:
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  42  		writel_relaxed((u8)data, reg_base + LCD_SPU_SPI_TXDATA);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  43  		break;
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  44  	case 16:
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  45  		writel_relaxed((u16)data, reg_base + LCD_SPU_SPI_TXDATA);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  46  		break;
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  47  	case 32:
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  48  		writel_relaxed((u32)data, reg_base + LCD_SPU_SPI_TXDATA);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  49  		break;
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  50  	default:
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  51  		dev_err(&spi->dev, "Wrong spi bit length\n");
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  52  	}
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  53  
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  54  	/* SPI start to send command */
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  55  	tmp = readl_relaxed(reg_base + LCD_SPU_SPI_CTRL);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  56  	tmp &= ~CFG_SPI_START_MASK;
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  57  	tmp |= CFG_SPI_START(1);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  58  	writel(tmp, reg_base + LCD_SPU_SPI_CTRL);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  59  
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  60  	isr = readl_relaxed(reg_base + SPU_IRQ_ISR);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  61  	while (!(isr & SPI_IRQ_ENA_MASK)) {
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  62  		udelay(100);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  63  		isr = readl_relaxed(reg_base + SPU_IRQ_ISR);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  64  		if (!--timeout) {
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  65  			ret = -ETIMEDOUT;
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  66  			dev_err(&spi->dev, "spi cmd send time out\n");
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  67  			break;
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  68  		}
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  69  	}
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  70  
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  71  	tmp = readl_relaxed(reg_base + LCD_SPU_SPI_CTRL);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  72  	tmp &= ~CFG_SPI_START_MASK;
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  73  	tmp |= CFG_SPI_START(0);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  74  	writel_relaxed(tmp, reg_base + LCD_SPU_SPI_CTRL);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  75  
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  76  	writel_relaxed(~SPI_IRQ_MASK, reg_base + SPU_IRQ_ISR);
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  77  
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  78  	return ret;
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  79  }
641b4b1b6a7cb4 drivers/video/mmp/hw/mmp_spi.c Zhou Zhu 2013-02-21  80  

:::::: The code at line 31 was first introduced by commit
:::::: 641b4b1b6a7cb4ab21cfd9dd7b93a1162eae4501 video: mmpdisp: add spi port in display controller

:::::: TO: Zhou Zhu <zzhu3@marvell.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

