Return-Path: <linux-kernel+bounces-431118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3999E3925
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB93168ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA3F1AF0C1;
	Wed,  4 Dec 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1B27By4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D481B392F;
	Wed,  4 Dec 2024 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312692; cv=none; b=aG9mSoZeCbrV8srCjTyU98hIGXFTQ8O9oXurQNnM7of6BpNt32GOUsIj7BPX7pH+rxpOunWcYmeMke8K3Syu+Bnoc0bnYmdTjF6VC3t4qgAZkjSoR8NEZGEYjFT14Cjg+4UIgzOmkaG9Y8gkzSDn7EG1+SrTouYrTN+1fBR5+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312692; c=relaxed/simple;
	bh=fxbdvqMYfwSBWcfcSetPXC8gA/4i+2W1r+6OqxxH+0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGcBlV1cxYZ8woLVO1DDsO7wCHPn9U+/7fmswUSFbK9l7qXMewP8CsSogl3VGOlCzkUvdmgdBSteA1KrUvKzieK0Lq429lSfXwnm75g++WU4ZOm/Ne1vcVPgomLJO1B02ghu4j0R/ej8DC6vTGy028OtfJPwGKb/w6c7kqTVUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1B27By4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733312691; x=1764848691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fxbdvqMYfwSBWcfcSetPXC8gA/4i+2W1r+6OqxxH+0w=;
  b=I1B27By4a8JWvogh6KGoa1fqR95m+GjVCNfgT4GSUGtROSsHUENtR1FN
   6TacZJihXhmTkoqigKk4rjQ19eQIjBh/Xg2FUiNKJrKMOcNA6CM7u7Wbc
   6mCSOb7TYze86gHbgpFHzpCcm/bmrf2yMvwbju+t6lomjD/hx9iVDLTOb
   SOSBsPpdkjj4Pjv7BJPuCUdm6DZP402ug4bgE1uCByCuVCCrRnRCqKpI7
   K32s4WDXd3mbad9FvTt/7JPebnGL+VBD/kNO3jQGi8ghQKgvPfL3j5Lgb
   INZk9HDq9p7FS92hCsFghirLbOAkKRZKTBZYs5DGID+0YKu9t4FX5Z3vC
   w==;
X-CSE-ConnectionGUID: zNnLKMs/QbiJsROLJ0V3Ig==
X-CSE-MsgGUID: y2bYg6MxT2Ghppfmm7xyPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44966367"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44966367"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:44:50 -0800
X-CSE-ConnectionGUID: YK36riJKRhK3tYgnZYa1UA==
X-CSE-MsgGUID: fAo7aOSxRZefVU+SiESCDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="124670340"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 04 Dec 2024 03:44:48 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tInoE-0002yT-0M;
	Wed, 04 Dec 2024 11:44:46 +0000
Date: Wed, 4 Dec 2024 19:43:58 +0800
From: kernel test robot <lkp@intel.com>
To: liujing <liujing@cmss.chinamobile.com>, perex@perex.cz, tiwai@suse.com
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: Re: [PATCH] ALSA: asihpi: Delete redundant judgments
Message-ID: <202412041936.OygWNCmW-lkp@intel.com>
References: <20241203154635.2512-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203154635.2512-1-liujing@cmss.chinamobile.com>

Hi liujing,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.13-rc1 next-20241203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/liujing/ALSA-asihpi-Delete-redundant-judgments/20241204-113552
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20241203154635.2512-1-liujing%40cmss.chinamobile.com
patch subject: [PATCH] ALSA: asihpi: Delete redundant judgments
config: x86_64-randconfig-161 (https://download.01.org/0day-ci/archive/20241204/202412041936.OygWNCmW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041936.OygWNCmW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041936.OygWNCmW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/pci/mixart/mixart.c: In function 'snd_mixart_probe':
>> sound/pci/mixart/mixart.c:1323:52: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size between 9 and 15 [-Wformat-truncation=]
    1323 |                 snprintf(tmpid, sizeof(tmpid), "%s-%u", id[dev] ? id[dev] : "MIXART", i);
         |                                                    ^~
   sound/pci/mixart/mixart.c:1323:48: note: directive argument in the range [0, 4294967294]
    1323 |                 snprintf(tmpid, sizeof(tmpid), "%s-%u", id[dev] ? id[dev] : "MIXART", i);
         |                                                ^~~~~~~
   sound/pci/mixart/mixart.c:1323:17: note: 'snprintf' output 3 or more bytes (assuming 18) into a destination of size 16
    1323 |                 snprintf(tmpid, sizeof(tmpid), "%s-%u", id[dev] ? id[dev] : "MIXART", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1323 sound/pci/mixart/mixart.c

  1225	
  1226	
  1227	/*
  1228	 *    probe function - creates the card manager
  1229	 */
  1230	static int snd_mixart_probe(struct pci_dev *pci,
  1231				    const struct pci_device_id *pci_id)
  1232	{
  1233		static int dev;
  1234		struct mixart_mgr *mgr;
  1235		unsigned int i;
  1236		int err;
  1237		size_t size;
  1238	
  1239		/*
  1240		 */
  1241		if (dev >= SNDRV_CARDS)
  1242			return -ENODEV;
  1243		if (! enable[dev]) {
  1244			dev++;
  1245			return -ENOENT;
  1246		}
  1247	
  1248		/* enable PCI device */
  1249		err = pci_enable_device(pci);
  1250		if (err < 0)
  1251			return err;
  1252		pci_set_master(pci);
  1253	
  1254		/* check if we can restrict PCI DMA transfers to 32 bits */
  1255		if (dma_set_mask(&pci->dev, DMA_BIT_MASK(32)) < 0) {
  1256			dev_err(&pci->dev,
  1257				"architecture does not support 32bit PCI busmaster DMA\n");
  1258			pci_disable_device(pci);
  1259			return -ENXIO;
  1260		}
  1261	
  1262		/*
  1263		 */
  1264		mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
  1265		if (! mgr) {
  1266			pci_disable_device(pci);
  1267			return -ENOMEM;
  1268		}
  1269	
  1270		mgr->pci = pci;
  1271		mgr->irq = -1;
  1272	
  1273		/* resource assignment */
  1274		err = pci_request_regions(pci, CARD_NAME);
  1275		if (err < 0) {
  1276			kfree(mgr);
  1277			pci_disable_device(pci);
  1278			return err;
  1279		}
  1280		for (i = 0; i < 2; i++) {
  1281			mgr->mem[i].phys = pci_resource_start(pci, i);
  1282			mgr->mem[i].virt = pci_ioremap_bar(pci, i);
  1283			if (!mgr->mem[i].virt) {
  1284				dev_err(&pci->dev, "unable to remap resource 0x%lx\n",
  1285				       mgr->mem[i].phys);
  1286				snd_mixart_free(mgr);
  1287				return -EBUSY;
  1288			}
  1289		}
  1290	
  1291		if (request_threaded_irq(pci->irq, snd_mixart_interrupt,
  1292					 snd_mixart_threaded_irq, IRQF_SHARED,
  1293					 KBUILD_MODNAME, mgr)) {
  1294			dev_err(&pci->dev, "unable to grab IRQ %d\n", pci->irq);
  1295			snd_mixart_free(mgr);
  1296			return -EBUSY;
  1297		}
  1298		mgr->irq = pci->irq;
  1299	
  1300		/* init mailbox  */
  1301		mgr->msg_fifo_readptr = 0;
  1302		mgr->msg_fifo_writeptr = 0;
  1303	
  1304		mutex_init(&mgr->lock);
  1305		mutex_init(&mgr->msg_lock);
  1306		init_waitqueue_head(&mgr->msg_sleep);
  1307		atomic_set(&mgr->msg_processed, 0);
  1308	
  1309		/* init setup mutex*/
  1310		mutex_init(&mgr->setup_mutex);
  1311	
  1312		/* card assignment */
  1313		mgr->num_cards = MIXART_MAX_CARDS; /* 4  FIXME: configurable? */
  1314		for (i = 0; i < mgr->num_cards; i++) {
  1315			struct snd_card *card;
  1316			char tmpid[16];
  1317			int idx;
  1318	
  1319			if (index[dev] < 0)
  1320				idx = index[dev];
  1321			else
  1322				idx = index[dev] + i;
> 1323			snprintf(tmpid, sizeof(tmpid), "%s-%u", id[dev] ? id[dev] : "MIXART", i);
  1324			err = snd_card_new(&pci->dev, idx, tmpid, THIS_MODULE,
  1325					   0, &card);
  1326	
  1327			if (err < 0) {
  1328				dev_err(&pci->dev, "cannot allocate the card %u\n", i);
  1329				snd_mixart_free(mgr);
  1330				return err;
  1331			}
  1332	
  1333			strcpy(card->driver, CARD_NAME);
  1334			snprintf(card->shortname, sizeof(card->shortname),
  1335				 "Digigram miXart [PCM #%d]", i);
  1336			snprintf(card->longname, sizeof(card->longname),
  1337				"Digigram miXart at 0x%lx & 0x%lx, irq %i [PCM #%u]",
  1338				mgr->mem[0].phys, mgr->mem[1].phys, mgr->irq, i);
  1339	
  1340			err = snd_mixart_create(mgr, card, i);
  1341			if (err < 0) {
  1342				snd_card_free(card);
  1343				snd_mixart_free(mgr);
  1344				return err;
  1345			}
  1346	
  1347			if(i==0) {
  1348				/* init proc interface only for chip0 */
  1349				snd_mixart_proc_init(mgr->chip[i]);
  1350			}
  1351	
  1352			err = snd_card_register(card);
  1353			if (err < 0) {
  1354				snd_mixart_free(mgr);
  1355				return err;
  1356			}
  1357		}
  1358	
  1359		/* init firmware status (mgr->dsp_loaded reset in hwdep_new) */
  1360		mgr->board_type = MIXART_DAUGHTER_TYPE_NONE;
  1361	
  1362		/* create array of streaminfo */
  1363		size = PAGE_ALIGN( (MIXART_MAX_STREAM_PER_CARD * MIXART_MAX_CARDS *
  1364				    sizeof(struct mixart_flowinfo)) );
  1365		if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, &pci->dev,
  1366					size, &mgr->flowinfo) < 0) {
  1367			snd_mixart_free(mgr);
  1368			return -ENOMEM;
  1369		}
  1370		/* init streaminfo_array */
  1371		memset(mgr->flowinfo.area, 0, size);
  1372	
  1373		/* create array of bufferinfo */
  1374		size = PAGE_ALIGN( (MIXART_MAX_STREAM_PER_CARD * MIXART_MAX_CARDS *
  1375				    sizeof(struct mixart_bufferinfo)) );
  1376		if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, &pci->dev,
  1377					size, &mgr->bufferinfo) < 0) {
  1378			snd_mixart_free(mgr);
  1379			return -ENOMEM;
  1380		}
  1381		/* init bufferinfo_array */
  1382		memset(mgr->bufferinfo.area, 0, size);
  1383	
  1384		/* set up firmware */
  1385		err = snd_mixart_setup_firmware(mgr);
  1386		if (err < 0) {
  1387			snd_mixart_free(mgr);
  1388			return err;
  1389		}
  1390	
  1391		pci_set_drvdata(pci, mgr);
  1392		dev++;
  1393		return 0;
  1394	}
  1395	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

