Return-Path: <linux-kernel+bounces-539909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D10A4AAB2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E92172810
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DDD1DE885;
	Sat,  1 Mar 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyXAoBQI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7D1D9320
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829368; cv=none; b=TFry9kkJcAoXVJ1A8+5JXzB/oCys7ZuzSBa2QSsaeYw/QmflQclV6rTHwndPnD0e1BFOX5yy7cXAOMfrQkDt+UyPHU6630BFkklLjQnc9ugrjw+qrGthzQvkO4kFxq039zn6cemsvCjnL7ghNELkDZKnYJJuAM0dgIffGC+GDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829368; c=relaxed/simple;
	bh=loQERbRAMWJK568EC+WB31N7hA3/Rm4J+/jYQDqGYLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jX2rh2CnkCUk/ifmLoki3cE0/tdzwsyCXbavztNS7w/Z4wIia2HqALAJ7/WAJdJ4ZKZhwWReUWSXXRJnkrtXmEf6yhKmsncckLZ+cVCdg/Z1s8lbEo1Z6mnyWoFds40C2hFEG0S03VT5zBaBISW3ZZNoeMOoJ66D9SocsXiuzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyXAoBQI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740829367; x=1772365367;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=loQERbRAMWJK568EC+WB31N7hA3/Rm4J+/jYQDqGYLM=;
  b=NyXAoBQI46NJW0u0ZppXrmS6k/lN5REGaFD5yb3KcOrXX/xZLT7T+3ra
   ApfVqgv1dQN+7M2GrFn+rqkFmrpBMS73RhT5P7ccj9cC4+4yGGFmHEAy/
   +vNtFUP8K9sWSXh5l4maGvsgPCTtjMU9wLsUawpmSfuDIcxmomQEPsNea
   a+TWiTyrJbFOTuO75Ziebpnvk/0l9wrfz7OylQnVkiVrLAspuoo9rQpmy
   TX8haIikWhylqWNCIUvbPLZlGaC6M04vRLl4jVG2425SVruqwkUVHCNe+
   c2lrvF4ermavLTrHe1HTrL+GVkBnZtnpB9wkOfNYN03UCxhQmAHS5h8rn
   Q==;
X-CSE-ConnectionGUID: motia6L4SFGyp9TAnNjHxw==
X-CSE-MsgGUID: taRVuzayQ1GOL908RlXxUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41673266"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="41673266"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 03:42:46 -0800
X-CSE-ConnectionGUID: LIFpm2bnT6OP6puLLehvnA==
X-CSE-MsgGUID: MPA9m5RXRGi2uuacjz6cSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="122710913"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 01 Mar 2025 03:42:45 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toLEw-000GCa-2O;
	Sat, 01 Mar 2025 11:42:42 +0000
Date: Sat, 1 Mar 2025 19:42:32 +0800
From: kernel test robot <lkp@intel.com>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1355:47: warning:
 '%d' directive output may be truncated writing between 1 and 5 bytes into a
 region of size between 1 and 16
Message-ID: <202503011947.TPDmWEeE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rahul,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   03d38806a902b36bf364cae8de6f1183c0a35a67
commit: 2b465ed00f7db9c5b2aca95a91671f86282b1822 cxgb4: add support for mirror Rxqs
date:   4 years, 8 months ago
config: x86_64-randconfig-a013-20230508 (https://download.01.org/0day-ci/archive/20250301/202503011947.TPDmWEeE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503011947.TPDmWEeE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503011947.TPDmWEeE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c: In function 'cxgb4_port_mirror_alloc_queues':
>> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1355:47: warning: '%d' directive output may be truncated writing between 1 and 5 bytes into a region of size between 1 and 16 [-Wformat-truncation=]
    1355 |                                  "%s-mirrorrxq%d", dev->name, i);
         |                                               ^~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1355:34: note: directive argument in the range [0, 65534]
    1355 |                                  "%s-mirrorrxq%d", dev->name, i);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1353:25: note: 'snprintf' output between 12 and 31 bytes into a destination of size 26
    1353 |                         snprintf(mirror_rxq->msix->desc,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1354 |                                  sizeof(mirror_rxq->msix->desc),
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1355 |                                  "%s-mirrorrxq%d", dev->name, i);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1355 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c

  1315	
  1316	static int cxgb4_port_mirror_alloc_queues(struct net_device *dev)
  1317	{
  1318		struct port_info *pi = netdev2pinfo(dev);
  1319		struct adapter *adap = netdev2adap(dev);
  1320		struct sge_eth_rxq *mirror_rxq;
  1321		struct sge *s = &adap->sge;
  1322		int ret = 0, msix = 0;
  1323		u16 i, rxqid;
  1324		u16 *rss;
  1325	
  1326		if (!pi->vi_mirror_count)
  1327			return 0;
  1328	
  1329		if (s->mirror_rxq[pi->port_id])
  1330			return 0;
  1331	
  1332		mirror_rxq = kcalloc(pi->nmirrorqsets, sizeof(*mirror_rxq), GFP_KERNEL);
  1333		if (!mirror_rxq)
  1334			return -ENOMEM;
  1335	
  1336		s->mirror_rxq[pi->port_id] = mirror_rxq;
  1337	
  1338		if (!(adap->flags & CXGB4_USING_MSIX))
  1339			msix = -((int)adap->sge.intrq.abs_id + 1);
  1340	
  1341		for (i = 0, rxqid = 0; i < pi->nmirrorqsets; i++, rxqid++) {
  1342			mirror_rxq = &s->mirror_rxq[pi->port_id][i];
  1343	
  1344			/* Allocate Mirror Rxqs */
  1345			if (msix >= 0) {
  1346				msix = cxgb4_get_msix_idx_from_bmap(adap);
  1347				if (msix < 0) {
  1348					ret = msix;
  1349					goto out_free_queues;
  1350				}
  1351	
  1352				mirror_rxq->msix = &adap->msix_info[msix];
  1353				snprintf(mirror_rxq->msix->desc,
  1354					 sizeof(mirror_rxq->msix->desc),
> 1355					 "%s-mirrorrxq%d", dev->name, i);
  1356			}
  1357	
  1358			init_rspq(adap, &mirror_rxq->rspq,
  1359				  CXGB4_MIRROR_RXQ_DEFAULT_INTR_USEC,
  1360				  CXGB4_MIRROR_RXQ_DEFAULT_PKT_CNT,
  1361				  CXGB4_MIRROR_RXQ_DEFAULT_DESC_NUM,
  1362				  CXGB4_MIRROR_RXQ_DEFAULT_DESC_SIZE);
  1363	
  1364			mirror_rxq->fl.size = CXGB4_MIRROR_FLQ_DEFAULT_DESC_NUM;
  1365	
  1366			ret = t4_sge_alloc_rxq(adap, &mirror_rxq->rspq, false,
  1367					       dev, msix, &mirror_rxq->fl,
  1368					       t4_ethrx_handler, NULL, 0);
  1369			if (ret)
  1370				goto out_free_msix_idx;
  1371	
  1372			/* Setup MSI-X vectors for Mirror Rxqs */
  1373			if (adap->flags & CXGB4_USING_MSIX) {
  1374				ret = request_irq(mirror_rxq->msix->vec,
  1375						  t4_sge_intr_msix, 0,
  1376						  mirror_rxq->msix->desc,
  1377						  &mirror_rxq->rspq);
  1378				if (ret)
  1379					goto out_free_rxq;
  1380	
  1381				cxgb4_set_msix_aff(adap, mirror_rxq->msix->vec,
  1382						   &mirror_rxq->msix->aff_mask, i);
  1383			}
  1384	
  1385			/* Start NAPI for Mirror Rxqs */
  1386			cxgb4_enable_rx(adap, &mirror_rxq->rspq);
  1387		}
  1388	
  1389		/* Setup RSS for Mirror Rxqs */
  1390		rss = kcalloc(pi->rss_size, sizeof(u16), GFP_KERNEL);
  1391		if (!rss) {
  1392			ret = -ENOMEM;
  1393			goto out_free_queues;
  1394		}
  1395	
  1396		mirror_rxq = &s->mirror_rxq[pi->port_id][0];
  1397		for (i = 0; i < pi->rss_size; i++)
  1398			rss[i] = mirror_rxq[i % pi->nmirrorqsets].rspq.abs_id;
  1399	
  1400		ret = cxgb4_config_rss(pi, rss, pi->rss_size, pi->viid_mirror);
  1401		kfree(rss);
  1402		if (ret)
  1403			goto out_free_queues;
  1404	
  1405		return 0;
  1406	
  1407	out_free_rxq:
  1408		free_rspq_fl(adap, &mirror_rxq->rspq, &mirror_rxq->fl);
  1409	
  1410	out_free_msix_idx:
  1411		cxgb4_free_msix_idx_in_bmap(adap, mirror_rxq->msix->idx);
  1412	
  1413	out_free_queues:
  1414		while (rxqid-- > 0)
  1415			cxgb4_port_mirror_free_rxq(adap,
  1416						   &s->mirror_rxq[pi->port_id][rxqid]);
  1417	
  1418		kfree(s->mirror_rxq[pi->port_id]);
  1419		s->mirror_rxq[pi->port_id] = NULL;
  1420		return ret;
  1421	}
  1422	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

