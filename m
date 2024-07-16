Return-Path: <linux-kernel+bounces-253757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F356B93266C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D31F22E50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43719923D;
	Tue, 16 Jul 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rBDKFr9f"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806417CA0E;
	Tue, 16 Jul 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132450; cv=none; b=STUrH2eyKPSauiLkga2nhMbJCA8lFZ5iSTdsPmCD9fS/5C8+b0AACI4V4BsnzAIB8dLZldrqkzpwPNhYfrxYhj/m9uJfka/9QL1GCT9SbXpHpn3lf7eoFTsaFJ3Q/GexQXL81IVEppnNOSuOTGygtqjedazkltdvqqQd6AHp37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132450; c=relaxed/simple;
	bh=y8HI8xRdksJwPRHN3YDGk5+wY/3kT/9sHJmSGStf0Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr/N2vLX838vK0wHdKHHiq/P2mHp39aWpnKHtcQ0Rra2Werzij1hJYKuv16q99iOvvhkl4R97xBVLo6IgLiT/Bvhzds4SeM49Dh+VZkOphfWWzVTfBge+eUMzP0Hxvw7OAtfqhg0C9KIbQGpXbTcXzlhtce0AdePTOJ4ojCCbz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rBDKFr9f; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721132447;
	bh=y8HI8xRdksJwPRHN3YDGk5+wY/3kT/9sHJmSGStf0Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBDKFr9f8mL6ZNX6Eq3DNkWMBRe5ZT3AI/4+iN6TRRLDtF78IqvSUKuKxoz+j00RV
	 y7Scp/toztjyqfH6qk89pU5uZC4rS/qdnTAqtUhN/ylpCAwIN6MLY3QVMQ+0jk4joh
	 DrT9wAouq8ce/n2bbUuSEl2C+zQXWdR+nDDyxnwiyJojwi2Kd0waOCPBQqANqhrU5Y
	 8TltoV4caZfnLLVbH5UqOJ6tH3FhPZJyrhHzu4qahuNibdPlgWSc2obOuFeiwjRc9S
	 +ytdSMi+E3/VWOERTZx5iGFQuTCRL/XmVDgsu8mtw9iHt+lBWMXC9oLq5pd4/lOdrz
	 lbX3DRaYtCGSg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1ED443780EC6;
	Tue, 16 Jul 2024 12:20:43 +0000 (UTC)
Date: Tue, 16 Jul 2024 08:20:41 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chris Lu =?utf-8?B?KOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	Steve Lee =?utf-8?B?KOadjuimluiqoCk=?= <steve.lee@mediatek.com>,
	"kernel@collabora.com" <kernel@collabora.com>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Aaron Hou =?utf-8?B?KOS+r+S/iuS7sCk=?= <Aaron.Hou@mediatek.com>
Subject: Re: [PATCH v7 8/8] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
Message-ID: <e9bdcf44-e20a-4824-a0d4-8c6c52ed1e9b@notapiano>
References: <20240704060116.16600-1-chris.lu@mediatek.com>
 <20240704060116.16600-9-chris.lu@mediatek.com>
 <7851401b-e884-4ed4-998d-7651f427ad37@notapiano>
 <6a6dc0b081e8caa99172666c71b0826c1cb17a1c.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a6dc0b081e8caa99172666c71b0826c1cb17a1c.camel@mediatek.com>

On Tue, Jul 16, 2024 at 07:59:53AM +0000, Chris Lu (陸稚泓) wrote:
> Hi Nicolas,
> 
> Thanks for reporting the crash issue, I've sent another patc to avoid
> this crash issue happened. kill anchor function wasn't protect well if
> MediaTek Bluetooth failed to setup. Add a flag check when running into
> btmtk_usb_suspend function.

Hi Chris,

thanks for the quick follow up! I see the patch at
https://lore.kernel.org/all/20240716074947.23073-1-chris.lu@mediatek.com/

I'll try it and reply there with my results.

Thanks,
Nícolas

> 
> Thanks a lot,
> Chris
> 
> On Mon, 2024-07-15 at 18:36 -0400, Nícolas F. R. A. Prado wrote:
> > On Thu, Jul 04, 2024 at 02:01:16PM +0800, Chris Lu wrote:
> > > This patch implements functions for ISO data send and receive in
> > > btusb
> > > driver for MediaTek's controller.
> > > 
> > > MediaTek defines a specific interrupt endpoint for ISO data
> > > transmissin
> > > because the characteristics of interrupt endpoint are similar to
> > > the
> > > application of ISO data which can support guaranteed transmissin
> > > bandwidth, enough maximum data length and error checking mechanism.
> > > 
> > > Driver sets up ISO interface and endpoints in btusb_mtk_setup and
> > > clears
> > > the setup in btusb_mtk_shutdown. These flow can't move to btmtk.c
> > > due to
> > > btusb_driver is only defined in btusb.c when claiming/relaesing
> > > interface.
> > > ISO packet anchor stops when driver suspending and resubmit
> > > interrupt urb
> > > for ISO data when driver resuming.
> > > 
> > > Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> > > ---
> > 
> > Hi,
> > 
> > KernelCI has identified a boot regression originating from this
> > patch. It
> > affects the mt8195-cherry-tomato-r2 platform.
> > 
> > Through additional runs I've determined that it only happens when the
> > bluetooth
> > firmware (BT_RAM_CODE_MT7961_1_2_hdr.bin) isn't present. I realize
> > the firmware
> > should be present to make proper use of the bluetooth driver, and
> > I'll add it to
> > our testing images. Still, a panic shouldn't happen when it's
> > missing, hence
> > this report.
> > 
> > Reverting this patch fixes the issue.
> > 
> > This is the traceback:
> > 
> > [    6.734214] BUG: spinlock bad magic on CPU#3, kworker/3:1/104
> > [    6.740002]  lock: 0xffff2c7b8655f660, .magic: 00000000, .owner:
> > <none>/-1, .owner_cpu: 0
> > [    6.748207] CPU: 3 UID: 0 PID: 104 Comm: kworker/3:1 Not tainted
> > 6.10.0-next-20240715 #1 35893202ca8f99b37129997821441a29d2b23f0a
> > [    6.759874] Hardware name: Acer Tomato (rev2) board (DT)
> > [    6.765195] Workqueue: pm pm_runtime_work
> > [    6.769235] Call trace:
> > [    6.771689]  dump_backtrace+0x9c/0x100
> > [    6.775456]  show_stack+0x20/0x38
> > [    6.778786]  dump_stack_lvl+0x80/0xf8
> > [    6.782463]  dump_stack+0x18/0x28
> > [    6.785791]  spin_bug+0x90/0xd8
> > [    6.788950]  do_raw_spin_lock+0xf4/0x128
> > [    6.792890]  _raw_spin_lock_irq+0x30/0x70
> > [    6.796915]  usb_kill_anchored_urbs+0x48/0x1e0
> > [    6.801378]  btmtk_usb_suspend+0x20/0x38 [btmtk
> > 5f200a97badbdfda4266773fee49acfc8e0224d5]
> > [    6.809578]  btusb_suspend+0xd0/0x210 [btusb
> > 0bfbf19a87ff406c83b87268b87ce1e80e9a829b]
> > [    6.817527]  usb_suspend_both+0x90/0x288
> > [    6.821469]  usb_runtime_suspend+0x3c/0xa8
> > [    6.825585]  __rpm_callback+0x50/0x1f0
> > [    6.829351]  rpm_callback+0x70/0x88
> > [    6.832856]  rpm_suspend+0xe4/0x5a0
> > [    6.836361]  pm_runtime_work+0xd4/0xe0
> > [    6.840126]  process_one_work+0x18c/0x440
> > [    6.844156]  worker_thread+0x314/0x428
> > [    6.847923]  kthread+0x128/0x138
> > [    6.851167]  ret_from_fork+0x10/0x20
> > [    6.854769] Unable to handle kernel paging request at virtual
> > address ffffffffffffffd8
> > [    6.862694] Mem abort info:
> > [    6.865494]   ESR = 0x0000000096000006
> > [    6.869249]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    6.874571]   SET = 0, FnV = 0
> > [    6.877632]   EA = 0, S1PTW = 0
> > [    6.880780]   FSC = 0x06: level 2 translation fault
> > [    6.885665] Data abort info:
> > [    6.888553]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
> > [    6.894044]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [    6.899103]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [    6.904423] swapper pgtable: 4k pages, 48-bit VAs,
> > pgdp=0000000042533000
> > [    6.911134] [ffffffffffffffd8] pgd=0000000000000000,
> > p4d=0000000042e94003, pud=0000000042e95003, pmd=0000000000000000
> > lav[    6.921781] Internal error: Oops: 0000000096000006 [#1] PREEMPT
> > SMP
> > [    6.921794] Modules linked in: mt7921e mt7921_common mt792x_lib
> > mt76_connac_lib mt76 mtk_vcodec_dec_hw mac80211 cros_ec_lid_angle
> > cros_ec_sensors cros_ec_sensors_core industrialio_triggered_buffer
> > cfg80211 kfifo_buf mtk_vcodec_dec mtk_jpeg v4l2_vp9 cros_ec_rpmsg
> > mtk_vcodec_enc v4l2_h264 mtk_jpeg_enc_hw btusb mtk_vcodec_dbgfs
> > mtk_jpeg_dec_hw mtk_dp mtk_vcodec_common btintel btbcm uvcvideo btmtk
> > mtk_mdp3 videobuf2_vmalloc v4l2_mem2mem btrtl uvc joydev
> > videobuf2_v4l2 videobuf2_dma_contig bluetooth elan_i2c
> > videobuf2_memops ecdh_generic ecc videobuf2_common cros_ec_sensorhub
> > cros_kbd_led_backlight mtk_scp snd_sof_mt8195 pcie_mediatek_gen3
> > mtk_rpmsg mtk_svs mtk_adsp_common snd_sof_xtensa_dsp rpmsg_core
> > lvts_thermal snd_sof_of mtk_scp_ipi snd_soc_mt8195_afe snd_sof
> > snd_sof_utils mtk_wdt mt6577_auxadc mt8195_mt6359
> > [    6.922087] CPU: 3 UID: 0 PID: 104 Comm: kworker/3:1 Not tainted
> > 6.10.0-next-20240715 #1 35893202ca8f99b37129997821441a29d2b23f0a
> > [    6.922106] Hardware name: Acer Tomato (rev2) board (DT)
> > [    6.922114] Workqueue: pm pm_runtime_work
> > [    6.922132] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=--)
> > [    6.922147] pc : usb_kill_anchored_urbs+0x6c/0x1e0
> > [    6.922164] lr : usb_kill_anchored_urbs+0x48/0x1e0
> > [    6.922181] sp : ffff800080903b60
> > [    6.922187] x29: ffff800080903b60 x28: ffff2c7b85c32b80 x27:
> > ffff2c7bbb370930
> > [    6.922211] x26: 00000000000f4240 x25: 00000000ffffffff x24:
> > ffffd49ece2dcb48
> > [    6.922233] x23: 0000000000000001 x22: ffff2c7b8655f660 x21:
> > ffff2c7b8655f628
> > [    6.922255] x20: ffffffffffffffd8 x19: 0000000000000000 x18:
> > 0000000000000006
> > [    6.922276] x17: 6531656337386238 x16: 3632373862333863 x15:
> > ffff800080903480
> > [    6.922297] x14: 0000000000000000 x13: 303278302f303178 x12:
> > ffffd49ecf090e30
> > [    6.922318] x11: 0000000000000001 x10: 0000000000000001 x9 :
> > ffffd49ecd2c5bb4
> > [    6.922339] x8 : c0000000ffffdfff x7 : ffffd49ecefe0db8 x6 :
> > 00000000000affa8
> > [    6.922360] x5 : ffff2c7bbb35dd48 x4 : 0000000000000000 x3 :
> > 0000000000000000
> > [    6.922379] x2 : 0000000000000000 x1 : 0000000000000003 x0 :
> > ffffffffffffffd8
> > [    6.922400] Call trace:
> > [    6.922405]  usb_kill_anchored_urbs+0x6c/0x1e0
> > [    6.922422]  btmtk_usb_suspend+0x20/0x38 [btmtk
> > 5f200a97badbdfda4266773fee49acfc8e0224d5]
> > [    6.922444]  btusb_suspend+0xd0/0x210 [btusb
> > 0bfbf19a87ff406c83b87268b87ce1e80e9a829b]
> > [    6.922469]  usb_suspend_both+0x90/0x288
> > [    6.922487]  usb_runtime_suspend+0x3c/0xa8
> > [    6.922507]  __rpm_callback+0x50/0x1f0
> > [    6.922523]  rpm_callback+0x70/0x88
> > [    6.922538]  rpm_suspend+0xe4/0x5a0
> > [    6.922553]  pm_runtime_work+0xd4/0xe0
> > [    6.922569]  process_one_work+0x18c/0x440
> > [    6.922588]  worker_thread+0x314/0x428
> > [    6.922606]  kthread+0x128/0x138
> > [    6.922621]  ret_from_fork+0x10/0x20
> > [    6.922644] Code: f100a274 54000520 d503201f d100a260 (b8370000)
> > [    6.922654] ---[ end trace 0000000000000000 ]---
> > a-148[    7.203910] Kernel panic - not syncing: Oops: Fatal exception
> > [    7.209649] SMP: stopping secondary CPUs
> > [    7.213713] Kernel Offset: 0x549e4c400000 from 0xffff800080000000
> > [    7.219796] PHYS_OFFSET: 0xfff0d38580000000
> > [    7.223969] CPU features: 0x04,0000000b,80140528,4200720b
> > [    7.229360] Memory Limit: none
> > 
> > Full kernel log: 
> > https://urldefense.com/v3/__http://0x0.st/X9rx.txt__;!!CTRNKA9wMg0ARbw!g_UleOH6C5AdZoKEVoko3ewb6zKCcWfDGfw3u6LV_x3JCST7WnvMrAzM7wP0A4WkiW4v0EM53wjf8el1gXWfqA$
> >  
> > Config: 
> > https://urldefense.com/v3/__http://0x0.st/X9r2.txt__;!!CTRNKA9wMg0ARbw!g_UleOH6C5AdZoKEVoko3ewb6zKCcWfDGfw3u6LV_x3JCST7WnvMrAzM7wP0A4WkiW4v0EM53wjf8enPGJN1sg$
> >  
> > 
> > #regzbot introduced: ee6bd4b95c66
> > #regzbot title: usb_kill_anchored_urbs panic during boot on mt8195-
> > cherry-tomato-r2
> > 
> > Thanks,
> > Nícolas

