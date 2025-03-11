Return-Path: <linux-kernel+bounces-557049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9B9A5D2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5174B18990D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26BA22257B;
	Tue, 11 Mar 2025 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="njAOEc0U"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D2E2206BD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734569; cv=none; b=ZE0ax9iMKl0kOzF7nYw0L76XD32EzTCgeU2zLabahYb3Pjvl5hp4Hy1rGNxRgmBXRIR/uBwFvdvA4JjWxzHRTQze0cQoEWeZ3F4HH54uiDkxdeVSppaAmlntYOG+Y8/u2tNqdH22WcFFM/ubI9Mui26IaMd0U3uXx7lYbmU+pcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734569; c=relaxed/simple;
	bh=WTJfqfHG3CJVV07K4xyiuC9wLiYGD+o2GZuKaIc/qeY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5J/Q1wMMUluuDSPJl14QbebEFbcX/alF4++QxYQfqwTWljiWBZ8KZlMEja/6iF1OlSTgK/3Pfab1dglurZwwqmJd+t2xxSVSBE3blVBasnW7cjen7yt3BLroKFcuAbWcL5i/EpD1UPn0LL9PeDibOwyQBJYB+Q6JA4jY5prmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=njAOEc0U; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741734563; x=1742339363; i=spasswolf@web.de;
	bh=GrdpnDES+T9ernNQyyThlyU4rgW0XmNN8RoMtLSgl0Y=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=njAOEc0UdEY1FDh1+C8Fo+WUajX9plFNOLe9Z31agoIn/DzVu3DQtGLkvOMOt3SC
	 fMsUTdSJ7hlT7/JPRwMQ5apE4rQRGlc8xzUq8GDars5hKfZJyU/skbuWFWe5K5UX6
	 AWpkwqYPyXix1fYI/DYTTsMPdFUTZeAyvNwQrN27diRscbL18nxPpRDervFQbzqnB
	 sTF0gW/t35EAKnlW0/9NtoJVCkzYlH78qLan1A9u+h+HgBAbiLASR/yMgb+pBKcLZ
	 g1Qmfnakm12YW88sUgq4KVxZ+FAXtRqu1GaW4JUYsp4FMkQhAJed2Sg+V45+oQ0GD
	 8IZ10JBQrcpvXY9GLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1tfTHt00lG-00YqTb; Wed, 12
 Mar 2025 00:09:23 +0100
Message-ID: <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	spasswolf@web.de
Date: Wed, 12 Mar 2025 00:09:21 +0100
In-Reply-To: <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
References: <20250310112206.4168-1-spasswolf@web.de>
		 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
		 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
		 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
		 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
		 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oOeet3774qCwumugYK22VvOs42K3mWJHfkhLqrmwFhua/Xs2EPs
 AT9GgKk8DDtImYbMBvilXT6pOemR3dAUWfFwbPWRZbH+Jcx+MSwVGg0p9kOQ1NKQHPkAOT7
 J1yDgvr/Yi6yJlkHygMWEV5r4bceS7y+J5BxB1PYkB97rdeKYKWSO9YXOdO3JdSQ6y9mhEa
 U+2ayj2yq2zlvyERrhFZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m7bMuETp6VY=;WVJLYBwwW1nMdpZvc1xgV4mwLPO
 JyYduO7rU87b9+V75/XSaNuiaVSRel5UI+3BkoFoLwYQvVRaeG5djjdoZXBH4GMteZshHM7ci
 NTC/C/PchuJq6JMTqC7l48nxQB2o32ITDJbyDaRcJ0c3RAJenxS1fhsD60We+Gohc+mCDYsfK
 g4xCCNvvHfyEl9ONeEArsvGP2flLJycvRoo8FTMwpyalTs5mFHpYMRTDyUlh7xonPMXfmCFWT
 PvmzTRbtgvfsZlmQHBmFmYrw7WWtwqqoHME2oDbpKUEhyAXITtYKd+1R3U/fYx+rnCSgtg/Vf
 Vkrfvr03O5qT1O8QowAlqIcbSUl9lnne2/TWEfOzkgyyCsB3zT6sVOAFvXtVrB8rluGpk5pZ1
 +BhOER6JdjuWxL4ryfbvgu08N1bc0yMV2o/obWtCn48RjygwQnteCg7lmVqeoNGXb4UdiA4fW
 peBO+n9d8yJY63+FVsCnuiLvfKxgbLwqmhqw+w5I2D99Xg9OvZHgIjpnF6S+zzq7mKZ1dBmGW
 NAHP6D3J+ZhaSavcb3iReTnWGK9pfOo9a1rMNzVDGUC8HTlVsjr8UvFPvOrIv8qvqwQcvHMNo
 AqYNpKIiB5G9L2CYzNI7mQLmjwW4tDrnWbM5Rg1f6cFjfwFDY6QEa2sotu1MMr47ReEXcP2b5
 p/+S9Z5259uktHsfCj1QxUNNMJxu55OzEsymMixgF5FfpQvxjgcaieNbN4QEevMetTBcG12W6
 iVKG9FuBKya3I0DS90NvI+sPf15dcVgZDZUq2imGse1L4FbG7jR1nSEz1M+uXOkwFv6aZKWh5
 AVVecjdjVmIm9Do0IKnVuvPmBo6sXGGjv1b28tmiQ054Jcc2tHOmgYzFz+tXaiJesu+443HrO
 FCW7a6wH6O6kZTS6hk9nkcquBn4p65Jzesq78I9LxcfUYQbLbzLhz+Yw/xH4QKEWLbj3468vZ
 sDQiNRBzaeeUKPtIQGr3LvewDI/BVD/sGSPa+YKDR06127J2319671iTRwe/eaSLa1qro4gZT
 LZvblZFOQ2534ppKi6RSeRZPm95nYR8tk0LbmDBX0BhGrz35Na67nDCz21Noz1vxrvYNKWGQ/
 Rchpl2yDJ9m6g9WWOOozOHh2kY5G/P98fBPz+Yk8zixu/d+SicznSowT6pwMyUHm3cBNvfZYM
 5G+w5NUYRhC8CKWhzyZKFB/6qpr2hc4HGS/Dn+hLVWAxfLhiTuXPBAyM+NPvYSnNNc2ANxT3E
 aoJ9KnXvrLz0QhDzATjSVyaI93lG+/7Z1wcd4cIf+D+kEUmkWYuBIK+dOyFgd3bYNePygM2zS
 EuwGVuzDvaIR41Mo9Zr6BtSsPMC4fmHfUgEOa6aJjFbnbiCsNJgCE/4SYk08ZJ//S3BNhsyM3
 kX3gahfbMyLk8NxE0eN9BjbmarVzOhgp5rYntBhOmTKTJ9tI0TycSUQ7Y6ZYKFbQBMJ4STYWv
 FNJxAJfmbf3Jld49EizVfa5zRK5c=

Am Mittwoch, dem 12.03.2025 um 09:10 +1100 schrieb Balbir Singh:
>
>
> Thanks, so the issue is specific to the game and running it?
>
> > > 3. For some weird reason my kernel does not recongnize the nokaslr c=
mdline
> > > parameter, so I build a kernel without CONFIG_RANDOMIZE_BASE and thi=
s does NOT
> > > fix the issue.
>
> Can you clarify if you're booting with the compressed image bzImage/vmli=
nuz or
> with vmlinux?

I'm booting vmlinuz images (the kernel is compile via make -j16 bindeb-pkg=
 which
gives debian packages which I install with dpkg).

> > > 4. Most surprisingly removing CONFIG_PCI_P2PDMA also does NOT fix th=
e issue.
> > >
>
>
> >
> > I've done more experimenting regarding 4.:
> > next-20250307 with "CONFIG_RANDOMIZE_BASE=3Dy" AND "CONFIG_PCI_P2PDMA =
is not set"
> > works as expected (i.e. no input lag when stellaris is running)
> >
> > next-20250307 with "CONFIG_RANDOMIZE_BASE is not set" AND "CONFIG_PCI_=
P2PDMA is
> > not set" also shows the buggy behaviour (i.e. input lag when stellaris=
 is
> > running) (this was the configuration I tested before)
>
> This is an interesting experiment, I am beginning to wonder if the syste=
m relies
> on a reduced direct map for the game to work correctly. Can you also che=
ck in this
> scenario if CONFIG_RANDOMIZE_MEMORY is disabled?
>
I'm on it.

> Can you please share the dmesg
> 1. output before and after the changes?
> 2. Do you see any warnings/errors in journalctl or game specific log fil=
es?
> 3. lspci -vvv output before and after the changes?
>

My dmesg shows a warning, but this is seems to be unrelated (it's present =
in
both the working and non-working case and also in 6.12.17). I have not bis=
ected
this, yet. I also tried CONFIG_LOCKDEP=3Dy in next-20250307 (with and with=
out the
revert) and got a warning about a possible deadlock in Networkmanager in b=
oth
cases (also not bisected, yet)

[ 11.241282] [ T1751] WARNING: CPU: 14 PID: 1751 at mm/util.c:674
__kvmalloc_node_noprof+0xa2/0xb0
[   11.241289] [   T1751] Modules linked in: snd_seq_dummy snd_hrtimer
snd_seq_midi snd_seq_midi_event snd_seq rfcomm bnep nls_ascii nls_cp437 vf=
at fat
snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_com=
ponent
btusb snd_hda_codec_hdmi btrtl btintel btbcm btmtk snd_hda_intel snd_usb_a=
udio
snd_intel_dspcfg uvcvideo snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn
snd_usbmidi_lib snd_hda_codec videobuf2_vmalloc snd_ump videobuf2_memops u=
vc
bluetooth snd_soc_core videobuf2_v4l2 snd_hwdep snd_hda_core snd_rawmidi
videodev snd_seq_device snd_pcm_oss snd_mixer_oss snd_rn_pci_acp3x snd_pcm
snd_acp_config videobuf2_common msi_wmi snd_soc_acpi ecdh_generic ecc mc
sparse_keymap edac_mce_amd snd_timer wmi_bmof k10temp snd snd_pci_acp3x cc=
p
soundcore ac battery button joydev hid_sensor_als hid_sensor_gyro_3d
hid_sensor_prox hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_trigger
amd_pmc industrialio_triggered_buffer kfifo_buf industrialio evdev
hid_sensor_iio_common mt7921e mt7921_common mt792x_lib mt76_connac_lib mt7=
6
[   11.241354] [   T1751]  mac80211 libarc4 cfg80211 rfkill msr fuse
nvme_fabrics efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2 amdgpu
usbhid amdxcp i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_=
sched
xhci_pci drm_suballoc_helper drm_panel_backlight_quirks xhci_hcd cec
hid_sensor_hub hid_multitouch mfd_core drm_buddy hid_generic drm_display_h=
elper
usbcore i2c_hid_acpi psmouse nvme amd_sfh i2c_hid drm_kms_helper serio_raw=
 hid
nvme_core r8169 i2c_piix4 usb_common i2c_smbus crc16 i2c_designware_platfo=
rm
i2c_designware_core
[   11.241391] [   T1751] CPU: 14 UID: 1000 PID: 1751 Comm: gst-plugin-sca=
n Not
tainted 6.14.0-rc6-nop2pdma #559
[   11.241394] [   T1751] Hardware name: Micro-Star International Co., Ltd=
.
Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[   11.241396] [   T1751] RIP: 0010:__kvmalloc_node_noprof+0xa2/0xb0
[   11.241400] [   T1751] Code: 00 49 b9 63 01 00 00 00 00 00 80 68 00 04 =
00 00
4c 23 0d 79 0d ea 00 48 01 d1 e8 c9 af 03 00 48 83 c4 18 eb 9a 80 e7 20 75=
 95
<0f> 0b eb 91 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
[   11.241402] [   T1751] RSP: 0018:ffffa32dc63abcc0 EFLAGS: 00010246
[   11.241403] [   T1751] RAX: 0000000000000000 RBX: 00000000000000c0 RCX:
0000000000000000
[   11.241405] [   T1751] RDX: 0000000000000000 RSI: 0000000000000017 RDI:
0000000000052cc0
[   11.241406] [   T1751] RBP: 00000005c2980d00 R08: ffffa32dc63abe00 R09:
ffffa32dc63abe10
[   11.241407] [   T1751] R10: 0000000000000018 R11: 0000000000000000 R12:
00000000ffffffff
[   11.241408] [   T1751] R13: ffff8c7e8d480010 R14: 00000005c2980d00 R15:
ffffa32dc63abd28
[   11.241410] [   T1751] FS:  00007fc1f34ed680(0000) GS:ffff8c8d2e780000(=
0000)
knlGS:0000000000000000
[   11.241412] [   T1751] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
[   11.241413] [   T1751] CR2: 00007fc1e0e2850b CR3: 00000002a28b8000 CR4:
0000000000750ef0
[   11.241414] [   T1751] PKRU: 55555554
[   11.241415] [   T1751] Call Trace:
[   11.241417] [   T1751]  <TASK>
[   11.241419] [   T1751]  ? __warn.cold+0x90/0x9e
[   11.241423] [   T1751]  ? __kvmalloc_node_noprof+0xa2/0xb0
[   11.241426] [   T1751]  ? report_bug+0xfa/0x140
[   11.241430] [   T1751]  ? handle_bug+0x53/0x90
[   11.241432] [   T1751]  ? exc_invalid_op+0x17/0x70
[   11.241435] [   T1751]  ? asm_exc_invalid_op+0x1a/0x20
[   11.241438] [   T1751]  ? __kvmalloc_node_noprof+0xa2/0xb0
[   11.241442] [   T1751]  amdgpu_bo_create_list_entry_array+0x38/0x150 [a=
mdgpu]
[   11.241810] [   T1751]  ? rt_spin_unlock+0x12/0x40
[   11.241815] [   T1751]  ? srso_alias_return_thunk+0x5/0xfbef5
[   11.241821] [   T1751]  amdgpu_bo_list_ioctl+0x47/0x340 [amdgpu]
[   11.242282] [   T1751]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
[   11.242622] [   T1751]  drm_ioctl_kernel+0xa3/0xf0
[   11.242627] [   T1751]  drm_ioctl+0x25e/0x4e0
[   11.242630] [   T1751]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
[   11.242930] [   T1751]  ? srso_alias_return_thunk+0x5/0xfbef5
[   11.242934] [   T1751]  ? srso_alias_return_thunk+0x5/0xfbef5
[   11.242936] [   T1751]  ? srso_alias_return_thunk+0x5/0xfbef5
[   11.242938] [   T1751]  ? srso_alias_return_thunk+0x5/0xfbef5
[   11.242941] [   T1751]  amdgpu_drm_ioctl+0x46/0x80 [amdgpu]
[   11.243238] [   T1751]  __x64_sys_ioctl+0x92/0xc0
[   11.243244] [   T1751]  do_syscall_64+0x5f/0x1a0
[   11.243249] [   T1751]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   11.243253] [   T1751] RIP: 0033:0x7fc1f381c8db
[   11.243255] [   T1751] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 =
04 24
10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f=
 05
<89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[   11.243257] [   T1751] RSP: 002b:00007ffcb8530080 EFLAGS: 00000246 ORIG=
_RAX:
0000000000000010
[   11.243260] [   T1751] RAX: ffffffffffffffda RBX: 0000564fd56bc7a0 RCX:
00007fc1f381c8db
[   11.243261] [   T1751] RDX: 00007ffcb8530130 RSI: 00000000c0106443 RDI:
0000000000000006
[   11.243262] [   T1751] RBP: 00007ffcb8530130 R08: 0000000000000000 R09:
0000000000000000
[   11.243263] [   T1751] R10: 000000000000002b R11: 0000000000000246 R12:
00000000c0106443
[   11.243265] [   T1751] R13: 0000000000000006 R14: 00007ffcb85301a0 R15:
0000564fd56bc7b8
[   11.243269] [   T1751]  </TASK>
[   11.243270] [   T1751] ---[ end trace 0000000000000000 ]---


>
> >
> > As a sidenote, I've tested several kernel with nokaslr as command line=
 parameter
> > (6.1.128, 6.8.12, 6.12.17 (the debian sid distributional kernel)) and =
nokaslr is
> > not recognized as a command line parameter in any of them
> >
>
> Please see my comment above about booting. How did you check if nokaslr =
is being
> recognized, is it via looking up dmesg?
>
When I boot with nokaslr I get the following messages in dmesg
[    T0] Unknown kernel command line parameters "nokaslr
BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc5-next-20250307-master", will be passe=
d to
user space.

This also happens when I use the debian kernel with standard .config


> Thanks!
> Balbir Singh

