Return-Path: <linux-kernel+bounces-381052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEDD9AF9A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DEE2828A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6D18C92C;
	Fri, 25 Oct 2024 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="M6N3aK0D";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="CRLOqEQs"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955D18C030
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836681; cv=none; b=k9OX137a5DrdZSUueOdhIks282j9fYCMxg/K9sMzUzYKNnjoUE1dvsBAM2l5g8uI+h+qe8175zxZz1bVosCmI7/rLhXPJnI6IaTcrOdQgAO1Vov4wxgSpZH0ClRSbU8v3+vwINlyw829ypIlI4fohhLjXf8lo6eCSpSa4IuB+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836681; c=relaxed/simple;
	bh=BMDr3FIAjRDNs+rV26H8iwijAxxyrD558QpWGVEIj4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TK7+VosHlvPxQ/PUSOQWUcQ3P+7P7qPKQ1qMChhoFOZnOnyLQbFwzCFBxwpG7zPnZ0mGaeyUdlkmNK5xgiOYahHfhDzG/myIhVF+kzxwDIPskLQQzMhNueA9Bpr4WnbbkZQH7u27gmZzxM7N0Ud/P+NMjP/yPrrQfUU9hNc3vt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=M6N3aK0D; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=CRLOqEQs; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1729836675;
	bh=4Jf13xgK/BAkOiohpyeU9oNF8VJ5p3bOhnQeOMjixG0=; l=4601;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=M6N3aK0DC6F5PPpDlNcYJNbtEo9X25SkPwvO21Gr0j7/XPbH4lt+d8SqiQMoJfDXL
	 8k8wA/yKL0g3V6EijxnhFLDQaI4Oy3cRynU+ZZXr2WpSYdyc9ZMGd3TJjoAIvOnn2O
	 nwnG5zmxV/AHfeeqSIg4iLueMpYWeCk3RcBREtKtsNFp4y70xeCi7jKEFtJ7U5iR/q
	 ydg8WS0GcncWRytE64tyD3NmFFePXQE0/6X3QpeuI9048k8TTjfGxb/ZFqrUHYspmv
	 nTKkVf9RGFp9+ztkOdFgxmRdYu8hVQx2asCvLnqmDR+AtSSSSR03oQGIEeFuAeuuQO
	 MmRQtG9UwLTWg==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(3190227:0:AUTH_RELAY)
	(envelope-from <prvs=10233091D0=cy_huang@richtek.com>); Fri, 25 Oct 2024 14:11:13 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1729836673;
	bh=4Jf13xgK/BAkOiohpyeU9oNF8VJ5p3bOhnQeOMjixG0=; l=4601;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CRLOqEQsaiJ+PLNu9zc90qlKYRVYqoM41tWxT76mhZYNrwtCttvuvCJQmDVPdp1gF
	 GpVpUiEiI98vCAMpFwKEf/+zg5B/Xd6Dx1d0b5zAvGIsZ7+HBZpQvbcaPB8li3KUur
	 gxrwI33iJxb99z8PlTuQZFXaZ/nHuD6IwnKQrvC55NBfZ/wSTMsvgT+Zp6X8Unnb2o
	 PkwYxBPRqVKQbAfzYkGwe/zoKPNtQqkCN0SufVGXldTwkZQqP05QU31khiShyt7g/5
	 eNeem6V6CbUzXYyrnWBciNyga/XqoMrBwP1Bd217xDvDsqXLnkJB3QBonJ2zWa34FJ
	 6iUl+aeGoiJTg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2353160:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 25 Oct 2024 13:59:07 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 13:59:07 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Fri, 25 Oct 2024 13:59:07 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
	ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH] regulator: rtq2208: Fix uninitialized use of regulator_config
Date: Fri, 25 Oct 2024 13:59:18 +0800
Message-ID: <00d691cfcc0eae9ce80a37b62e99851e8fdcffe2.1729829243.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Fix rtq2208 driver uninitialized use to cause kernel error.

Fixes: 85a11f55621a ("regulator: rtq2208: Add Richtek RTQ2208 SubPMIC")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

  The log is attached below

| Unable to handle kernel paging request at virtual address ffffffe2625ac9b8
| Mem abort info:
|   ESR = 0x0000000096000007
|   EC = 0x25: DABT (current EL), IL = 32 bits
|   SET = 0, FnV = 0
|   EA = 0, S1PTW = 0
|   FSC = 0x07: level 3 translation fault
| Data abort info:
|   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
|   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
|   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
| swapper pgtable: 4k pages, 39-bit VAs, pgdp=000000000144c000
| [ffffffe2625ac9b8| pgd=1000000001c28003, p4d=1000000001c28003, pud=1000000001c28003, pmd=1000000001c2b003, pte=0000000000000000
| Internal error: Oops: 0000000096000007 [#1| PREEMPT SMP
| Modules linked in: rtq2208_regulator(+) regmap_i2c rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device cmac algif_hash aes_arm64 aes_generic algif_skcipher af_alg bnep brcmfmac_wcc brcmfmac vc4 brcmutil binfmt_misc cfg80211 hci_uart bcm2835_isp(C) btbcm bluetooth rpivid_hevc(C) bcm2835_v4l2(C) bcm2835_codec(C) v3d bcm2835_mmal_vchiq(C) snd_soc_hdmi_codec drm_display_helper cec drm_dma_helper vc_sm_cma(C) snd_soc_core ecdh_generic v4l2_mem2mem videobuf2_vmalloc videobuf2_dma_contig gpu_sched videobuf2_memops ecc rfkill drm_shmem_helper videobuf2_v4l2 drm_kms_helper snd_compress libaes videodev snd_bcm2835(C) raspberrypi_hwmon snd_pcm_dmaengine snd_pcm videobuf2_common i2c_bcm2835 i2c_brcmstb raspberrypi_gpiomem mc snd_timer snd nvmem_rmem uio_pdrv_genirq uio i2c_dev drm fuse drm_panel_orientation_quirks dm_mod backlight ip_tables x_tables ipv6
| CPU: 1 UID: 0 PID: 1406 Comm: modprobe Tainted: G         C         6.12.0-rc4-v8+ #2
| Tainted: [C|=CRAP
| Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
| pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : __srcu_read_lock+0x18/0xa0
| lr : gpiod_free_commit+0x40/0x308
| sp : ffffffc08331b610
| x29: ffffffc08331b610 x28: ffffff80453b4680 x27: ffffffe219d68048
| x26: ffffff80651e3b40 x25: ffffff8040001180 x24: ffffffe262abed78
| x23: 0000000000000001 x22: ffffffe2625ac9b8 x21: ffffffe2625ac5a0
| x20: ffffff804370b800 x19: ffffff8040001180 x18: ffffffffffffffff
| x17: ffffff8041041a00 x16: ffffffe261a43378 x15: 0000000000000000
| x14: 0000000000000000 x13: 4c41564e49452d20 x12: 3a656761746c6f76
| x11: 20746e6572727563 x10: ffffffe2629e5780 x9 : ffffffe26199ea80
| x8 : 00000000ffffefff x7 : ffffffe2629e5780 x6 : 0000000000000000
| x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
| x2 : ffffff80445d20c0 x1 : ffffff80445d20c0 x0 : ffffffe2625ac9b8
| Call trace:
|  __srcu_read_lock+0x18/0xa0
|  gpiod_free_commit+0x40/0x308
|  gpiod_free+0x30/0x88
|  gpiod_put+0x1c/0x38
|  regulator_ena_gpio_free+0x84/0xd0
|  regulator_register+0x2dc/0xa10
|  devm_regulator_register+0x60/0xb0
|  rtq2208_probe+0x3ec/0x5e0 [rtq2208_regulator]
|  i2c_device_probe+0x150/0x2a0
|  really_probe+0xc4/0x2a8
|  __driver_probe_device+0x80/0x140
|  driver_probe_device+0xe4/0x170
|  __driver_attach+0x9c/0x1b0
|  bus_for_each_dev+0x7c/0xe8
|  driver_attach+0x2c/0x40
|  bus_add_driver+0xec/0x218
|  driver_register+0x68/0x138
|  i2c_register_driver+0x50/0xe0
|  rtq2208_driver_init+0x28/0xff8 [rtq2208_regulator]
|  do_one_initcall+0x4c/0x280
|  do_init_module+0x68/0x220
|  load_module+0x1c70/0x1d60
|  __do_sys_init_module+0x1a8/0x1e8
|  __arm64_sys_init_module+0x24/0x38
|  invoke_syscall+0x50/0x120
|  el0_svc_common.constprop.0+0xd0/0xf8
|  do_el0_svc+0x28/0x40
|  el0_svc+0x34/0xe0
|  el0t_64_sync_handler+0x13c/0x158
|  el0t_64_sync+0x190/0x198
| Code: d503233f a9be7bfd d5384102 910003fd (b9400001)
| ---[ end trace 0000000000000000 ]---
---
 drivers/regulator/rtq2208-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index a5c126afc648..5925fa7a9a06 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -568,7 +568,7 @@ static int rtq2208_probe(struct i2c_client *i2c)
 	struct regmap *regmap;
 	struct rtq2208_regulator_desc *rdesc[RTQ2208_LDO_MAX];
 	struct regulator_dev *rdev;
-	struct regulator_config cfg;
+	struct regulator_config cfg = {};
 	struct rtq2208_rdev_map *rdev_map;
 	int i, ret = 0, idx, n_regulator = 0;
 	unsigned int regulator_idx_table[RTQ2208_LDO_MAX],
-- 
2.34.1


