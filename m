Return-Path: <linux-kernel+bounces-576769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4393A7143D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450D0176C54
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5FC2A1B2;
	Wed, 26 Mar 2025 09:56:03 +0000 (UTC)
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8B1A5B9E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982962; cv=none; b=n7oLAoA/C4utEWZ7CmpoOabSAdXCumED70cqkuWNEsyO2dzGPGywHvmAxx55IiSvvLV2vTw6y9Z1CWhHQRrXBscuNbpGPi1RJnrwbkDG7bArKKyJxtkFItvCJS0Ai3w/I70+p+DlFE+/LhDs4Bm0l2hXeDa0GvHS5p4npIwjhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982962; c=relaxed/simple;
	bh=er2HelVBoveQdXB4Nb5dCWiFbOMaE9jAfWDMC7GExGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ad+Zk2M4TfTE4+hPOCtOS5eLcAphlxR0gIdU56rEKlk8bh4/id6mmgQtv0l0RbA7JecgMIhFChiFsJLO6Dem9BoNlTlzgWXKVX4gJSZL4LaHkRBDiRsauGJwKLGyvsodqQIEu7zij1zbt8nTZGnmA13ZsUCFuHalwsVAxf3FOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 7748 invoked from network); 26 Mar 2025 09:49:15 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@62.158.99.252)
  by mailout.selfhost.de with ESMTPA; 26 Mar 2025 09:49:15 -0000
X-Spam-Level: 
X-Spam-Report: 
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	*  0.0 DMARC_MISSING Missing DMARC policy
	*  0.4 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
Received: from afaics.de (p200300e31f37680288658ffffeb7694d.dip0.t-ipconnect.de [2003:e3:1f37:6802:8865:8fff:feb7:694d])
	by marvin.afaics.de (OpenSMTPD) with ESMTPS id 4cd3143b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Mar 2025 10:49:14 +0100 (CET)
Received: from localhost (afaics.de [local])
	by afaics.de (OpenSMTPD) with ESMTPA id 50e07105;
	Wed, 26 Mar 2025 09:49:13 +0000 (UTC)
From: Harald Dunkel <harri@afaics.de>
To: linux-kernel@vger.kernel.org
Cc: 
Subject: 6.12.12 Debian backports kernel: RIP
Date: Wed, 26 Mar 2025 10:49:13 +0100
Message-ID: <87zfh8m89y.fsf@tweety.afaics.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi folks,

I got this on a pretty new Tuxedo notebook:

[   64.286892] ------------[ cut here ]------------
[   64.286939] WARNING: CPU: 11 PID: 0 at kernel/workqueue.c:2257 delayed_w=
ork_timer_fn+0x55/0x80
[   64.286983] Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq =
snd_seq_device nvme_fabrics nvme_keyring xe drm_gpuvm drm_exec gpu_sched dr=
m_suballoc_helper drm_ttm_helper snd_hda_codec_hdmi snd_hda_codec_conexant =
snd_hda_codec_generic ip6t_REJECT nf_reject_ipv6 xt_hl ip6t_rt ipt_REJECT n=
f_reject_ipv4 nft_limit xt_limit xt_addrtype snd_sof_pci_intel_mtl snd_sof_=
intel_hda_generic soundwire_intel soundwire_generic_allocation soundwire_ca=
dence xt_tcpudp cmac snd_sof_intel_hda_common xt_conntrack algif_hash nf_co=
nntrack snd_soc_hdac_hda algif_skcipher snd_sof_intel_hda_mlink af_alg snd_=
sof_intel_hda snd_sof_pci qrtr nf_defrag_ipv6 bnep snd_sof_xtensa_dsp uinpu=
t nf_defrag_ipv4 iwlmvm nft_compat snd_sof nf_tables i915 snd_sof_utils snd=
_hda_ext_core snd_soc_acpi_intel_match binfmt_misc nfnetlink intel_rapl_msr=
 snd_soc_acpi intel_rapl_common mac80211 snd_soc_core intel_uncore_frequenc=
y intel_uncore_frequency_common x86_pkg_temp_thermal intel_powerclamp coret=
emp nls_ascii nls_cp437 snd_compress vfat snd_pcm_dmaengine
[   64.287050]  soundwire_bus fat uvcvideo snd_hda_intel kvm_intel btusb vi=
deobuf2_vmalloc uvc videobuf2_memops snd_intel_dspcfg libarc4 videobuf2_v4l=
2 btrtl snd_intel_sdw_acpi iwlwifi videodev btintel snd_hda_codec kvm btbcm=
 videobuf2_common btmtk drm_buddy drm_display_helper mc snd_hda_core cpufre=
q_powersave cec bluetooth uniwill_wmi(OE) rapl snd_hwdep rc_core clevo_wmi(=
OE) cfg80211 tuxedo_io(OE) intel_cstate intel_vpu iTCO_wdt snd_pcm intel_pm=
c_bxt ucsi_acpi tuxedo_keyboard(OE) asus_wmi ttm tuxedo_compatibility_check=
(OE) drm_shmem_helper intel_uncore snd_timer typec_ucsi iTCO_vendor_support=
 platform_profile led_class_multicolor pcspkr mei_me snd spd5118 wmi_bmof y=
t6801(OE) watchdog drm_kms_helper intel_pmc_core typec mei soundcore i2c_al=
go_bit rfkill roles igen6_edac button intel_vsec int3403_thermal acpi_tad i=
nt340x_thermal_zone intel_hid pmt_telemetry sparse_keymap pmt_class acpi_pa=
d ac evdev joydev serio_raw msr parport_pc ppdev lp parport loop efi_pstore=
 configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
[   64.287462]  btrfs blake2b_generic dm_crypt dm_mod efivarfs raid10 raid4=
56 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
libcrc32c crc32c_generic raid1 raid0 md_mod hid_multitouch hid_generic xhci=
_pci i2c_hid_acpi crct10dif_pclmul sdhci_pci i2c_hid xhci_hcd crc32_pclmul =
cqhci crc32c_intel drm nvme sdhci ghash_clmulni_intel intel_lpss_pci sha512=
_ssse3 thunderbolt usbcore nvme_core mmc_core intel_lpss sha256_ssse3 i2c_i=
801 hid sha1_ssse3 video nvme_auth idma64 usb_common i2c_smbus battery fan =
wmi pinctrl_meteorlake aesni_intel gf128mul crypto_simd cryptd
[   64.288034] CPU: 11 UID: 0 PID: 0 Comm: swapper/11 Tainted: G           =
OE      6.12.12+bpo-amd64 #1  Debian 6.12.12-1~bpo12+1
[   64.288083] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[   64.288105] Hardware name: TUXEDO TUXEDO InfinityBook Pro Intel Gen9/GXx=
MRXx, BIOS N.1.10A12 11/18/2024
[   64.288144] RIP: 0010:delayed_work_timer_fn+0x55/0x80
[   64.288169] Code: e2 48 89 de 89 ef 5b 5d 41 5c e9 66 f3 ff ff 65 f7 05 =
b3 31 b4 74 00 01 ff 00 75 0e 65 48 8b 3d a1 31 b4 74 f6 47 2c 20 75 0b <0f=
> 0b 5b 5d 41 5c c3 cc cc cc cc e8 8b 6e 00 00 48 85 c0 74 eb 48
[   64.288247] RSP: 0018:ffffa04ec06acdb0 EFLAGS: 00010006
[   64.288271] RAX: 0000000000000000 RBX: ffff8d59c0057600 RCX: ffff8d687fa=
a3940
[   64.288300] RDX: 00000000ffff19c0 RSI: ffffffff8b4f1fd0 RDI: ffff8d59429=
cf220
[   64.288329] RBP: 0000000000002000 R08: 0000000000000009 R09: ffffa04ec06=
ace18
[   64.288358] R10: 0000000000000200 R11: 0000000000000000 R12: ffff8d59429=
cf200
[   64.288387] R13: ffffffff8b4f1fd0 R14: ffff8d59429cf220 R15: ffffa04ec06=
ace10
[   64.288416] FS:  0000000000000000(0000) GS:ffff8d687fb80000(0000) knlGS:=
0000000000000000
[   64.288449] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   64.288473] CR2: 000055b658914440 CR3: 0000000f9ba22002 CR4: 0000000000f=
72ef0
[   64.288503] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   64.288532] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 00000000000=
00400
[   64.288561] PKRU: 55555554
[   64.288573] Call Trace:
[   64.288587]  <IRQ>
[   64.288601]  ? __warn+0x89/0x130
[   64.288620]  ? delayed_work_timer_fn+0x55/0x80
[   64.288641]  ? report_bug+0x164/0x190
[   64.288662]  ? handle_bug+0x58/0x90
[   64.288680]  ? exc_invalid_op+0x17/0x70
[   64.288698]  ? asm_exc_invalid_op+0x1a/0x20
[   64.288720]  ? __pfx_delayed_work_timer_fn+0x10/0x10
[   64.288744]  ? __pfx_delayed_work_timer_fn+0x10/0x10
[   64.288769]  ? delayed_work_timer_fn+0x55/0x80
[   64.288791]  ? __pfx_delayed_work_timer_fn+0x10/0x10
[   64.288814]  call_timer_fn+0x27/0x120
[   64.288834]  __run_timers+0x18b/0x280
[   64.288853]  timer_expire_remote+0x4a/0x70
[   64.288875]  tmigr_handle_remote+0x3d6/0x480
[   64.288899]  handle_softirqs+0xcd/0x2c0
[   64.288918]  __irq_exit_rcu+0x91/0xb0
[   64.288935]  sysvec_apic_timer_interrupt+0x71/0x90
[   64.288959]  </IRQ>
[   64.288970]  <TASK>
[   64.288980]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   64.289003] RIP: 0010:cpuidle_enter_state+0xcc/0x420
[   64.289026] Code: 3a 5e 48 ff e8 75 f1 ff ff 8b 53 04 49 89 c5 0f 1f 44 =
00 00 31 ff e8 b3 3c 47 ff 45 84 ff 0f 85 aa 01 00 00 fb 0f 1f 44 00 00 <45=
> 85 f6 0f 88 81 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[   64.289098] RSP: 0018:ffffa04ec0207e90 EFLAGS: 00000246
[   64.289121] RAX: ffff8d687fb80000 RBX: ffff8d687fbc05b0 RCX: 00000000000=
0001f
[   64.289150] RDX: 000000000000000b RSI: 000000002abc2bc2 RDI: 00000000000=
00000
[   64.289179] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000000=
02db2
[   64.289208] R10: 0000000000000018 R11: ffff8d687fbb4764 R12: ffffffff8d1=
b6d00
[   64.289237] R13: 0000000ef7cb93da R14: 0000000000000003 R15: 00000000000=
00000
[   64.290975]  cpuidle_enter+0x2d/0x40
[   64.292117]  do_idle+0x1e7/0x240
[   64.293255]  cpu_startup_entry+0x29/0x30
[   64.294398]  start_secondary+0x11e/0x140
[   64.295548]  common_startup_64+0x13e/0x141
[   64.296710]  </TASK>
[   64.297889] ---[ end trace 0000000000000000 ]---


Regards

Harri

