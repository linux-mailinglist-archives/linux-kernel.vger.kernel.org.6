Return-Path: <linux-kernel+bounces-211541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C125A905366
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B0E1C21A41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833F217994D;
	Wed, 12 Jun 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Qj/gSAMm"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716F1D54B;
	Wed, 12 Jun 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198064; cv=none; b=mn/53STrg1041+JyQvLy9iLYahyVizuFZ0l5VXXMsrKklDAM3bGMYR4vnGHZAEMVdEqOHGQkqbRNnHlwd2bd06LGPneVV2cjpJOfOwNBb1hdCVZY+iVry+FmMUV4Ns0Kd5ERgSiseRn6FN+fs2KIf9Gk6imEXj8v5XHNoTxRWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198064; c=relaxed/simple;
	bh=R+p5W0oxMIfPMGXuJlnu6FL2+qhfvC0bZwUpn7OfhNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwhdkA1wIPMqTmpUIF2WCS2oRCDLmiGLvhBivtY8o9s1nxLwFJ7SvlAmkQYn7BIbKDss6qGJU8GMgvR5EjzFDY+rKdUUHrGMuyWvKUXY6zWk9BL7NH0ADKxa35bzYpD7fwbzoGB+AIsLT3UqIHBNMMkpLa6J1nKQxk41B+k6SBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Qj/gSAMm; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Iyw+qxE9pXBrCIVTM0xRnlY3cj/1xZrA3eao7AZmmWI=;
	t=1718198061; x=1718630061; b=Qj/gSAMmTFCLCxtU3w2QQItvjJmB47VfexdL9UfSa7j0H7b
	XMK3D44YS7bC6i8bvQO17YnvxBRG4upJFvy5HUgSMEP1A/67zs8n6QqWZFTANy2THCrqrIE+pVD6p
	NLPWPS9DA4AmpMAl44FoGEmBmVnVqx2yDp4B0BUNxtPhcV5kinpA3iUHw7posQgMcCPpjzEWP131a
	kuwL2Y6VlCroCq+RPSaRdEO0BPutR5sXt3gZ8tomddW1rV97W+YIzQmQ2h0ZFDTrXhpYi5eNLt33+
	DtIsayM9cOtS6WjhGVpGgXiSwg/5q4kvvnrBVCjZuwGnl/3MSgZ3Yxv3cgbpYB+A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sHNno-00048K-N2; Wed, 12 Jun 2024 15:14:12 +0200
Message-ID: <4ce90767-7d85-47b0-9187-4eb8d257e7e0@leemhuis.info>
Date: Wed, 12 Jun 2024 15:14:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [bug report] drm/amdgpu: amdgpu crash on playing videos, linux
 6.10-rc
To: Winston Ma <winstonhyypia@gmail.com>, mac-wang@sjtu.edu.cn
Cc: Felix.Kuehling@amd.com, Xinhui.Pan@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
References: <CAMOvFfkQscju1spNKHmEC_Rut+2=qfhKGZSvGhCk_nd5VhuDkg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <CAMOvFfkQscju1spNKHmEC_Rut+2=qfhKGZSvGhCk_nd5VhuDkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718198061;30f43847;
X-HE-SMSGID: 1sHNno-00048K-N2

On 06.06.24 05:06, Winston Ma wrote:
> Hi I got the same problem on Linux Kernel 6.10-rc2. I got the problem b=
y
> following the procedure below:
>=20
>  1. Boot Linux Kernel 6.10-rc2
>  2. Open Firefox (Any browser should work)
>  3. Open a Youtube Video
>  4. On the playing video, toggle fullscreen quickly Then after 10-20
>     times of fullscreen toggling, the screen would enter freeze mode.
>     This is the log that I captured using the above method.

Hmm, seems nothing happened here for a while. Could you maybe try to
bisect this
(https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.h=
tml
)?

@amd-gfx devs: Or is this unneeded, as the cause found or maybe even
fixed meanwhile?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> This is the kernel log
>=20
> 2024-06-06T10:26:40.747576+08:00 kernel: gmc_v10_0_process_interrupt: 6=
 callbacks suppressed
> 2024-06-06T10:26:40.747618+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [=
mmhub] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
> 2024-06-06T10:26:40.747623+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  =
in process RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
> 2024-06-06T10:26:40.747625+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  =
 in page starting at address 0x0000800106ffe000 from client 0x12 (VMC)
> 2024-06-06T10:26:40.747628+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
MVM_L2_PROTECTION_FAULT_STATUS:0x00203811
> 2024-06-06T10:26:40.747629+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 Faulty UTCL2 client ID: VCN (0x1c)
> 2024-06-06T10:26:40.747631+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 MORE_FAULTS: 0x1
> 2024-06-06T10:26:40.747651+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 WALKER_ERROR: 0x0
> 2024-06-06T10:26:40.747653+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 PERMISSION_FAULTS: 0x1
> 2024-06-06T10:26:40.747655+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 MAPPING_ERROR: 0x0
> 2024-06-06T10:26:40.747656+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 RW: 0x0
> 2024-06-06T10:26:40.747658+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [=
mmhub] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
> 2024-06-06T10:26:40.747660+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  =
in process RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
> 2024-06-06T10:26:40.747662+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  =
 in page starting at address 0x0000800106e00000 from client 0x12 (VMC)
> 2024-06-06T10:26:40.747663+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
MVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 2024-06-06T10:26:40.747664+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 Faulty UTCL2 client ID: MP0 (0x0)
> 2024-06-06T10:26:40.747666+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 MORE_FAULTS: 0x0
> 2024-06-06T10:26:40.747667+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 WALKER_ERROR: 0x0
> 2024-06-06T10:26:40.747668+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 PERMISSION_FAULTS: 0x0
> 2024-06-06T10:26:40.747670+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 MAPPING_ERROR: 0x0
> 2024-06-06T10:26:40.747671+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 RW: 0x0
> 2024-06-06T10:26:40.747674+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [=
mmhub] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
> 2024-06-06T10:26:40.747677+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  =
in process RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
> 2024-06-06T10:26:40.747680+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  =
 in page starting at address 0x0000800106e07000 from client 0x12 (VMC)
> 2024-06-06T10:26:40.747683+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
MVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 2024-06-06T10:26:40.747686+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 Faulty UTCL2 client ID: MP0 (0x0)
> 2024-06-06T10:26:40.747688+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 MORE_FAULTS: 0x0
> 2024-06-06T10:26:40.747691+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 WALKER_ERROR: 0x0
> 2024-06-06T10:26:40.747693+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 PERMISSION_FAULTS: 0x0
> 2024-06-06T10:26:40.747696+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 MAPPING_ERROR: 0x0
> 2024-06-06T10:26:40.747698+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 RW: 0x0
> 2024-06-06T10:26:40.747700+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [=
mmhub] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
> 2024-06-06T10:26:40.747703+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  =
in process RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
> 2024-06-06T10:26:40.747705+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  =
 in page starting at address 0x0000800107001000 from client 0x12 (VMC)
> 2024-06-06T10:26:40.747707+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
MVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> 2024-06-06T10:26:40.747710+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 Faulty UTCL2 client ID: MP0 (0x0)
> 2024-06-06T10:26:40.747713+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 MORE_FAULTS: 0x0
> 2024-06-06T10:26:40.747716+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 WALKER_ERROR: 0x0
> 2024-06-06T10:26:40.747718+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 PERMISSION_FAULTS: 0x0
> 2024-06-06T10:26:40.747721+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 MAPPING_ERROR: 0x0
> 2024-06-06T10:26:40.747723+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	=
 RW: 0x0
> 2024-06-06T10:26:51.094991+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* ring vcn_dec_0 timeout, signaled seq=3D24897, emitted seq=3D=
24898
> 2024-06-06T10:26:51.095023+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* Process information: process RDD Process pid 39524 thread fi=
refox-bi:cs0 pid 40342
> 2024-06-06T10:26:51.095025+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset begin!
> 2024-06-06T10:26:52.305509+08:00 kernel: [drm] Register(0) [mmUVD_POWER=
_STATUS] failed to reach value 0x00000001 !=3D 0x00000002n
> 2024-06-06T10:26:52.586019+08:00 kernel: [drm] Register(0) [mmUVD_RBC_R=
B_RPTR] failed to reach value 0x000003c0 !=3D 0x00000360n
> 2024-06-06T10:26:52.639506+08:00 kernel: [drm] Register(0) [mmUVD_POWER=
_STATUS] failed to reach value 0x00000001 !=3D 0x00000002n
> 2024-06-06T10:26:52.639521+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
ODE2 reset
> 2024-06-06T10:26:52.650614+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset succeeded, trying to resume
> 2024-06-06T10:26:52.650633+08:00 kernel: [drm] PCIE GART of 1024M enabl=
ed (table at 0x000000F41FC00000).
> 2024-06-06T10:26:52.650637+08:00 kernel: [drm] VRAM is lost due to GPU =
reset!
> 2024-06-06T10:26:52.650641+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: P=
SP is resuming...
> 2024-06-06T10:26:52.673474+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: r=
eserve 0xa00000 from 0xf41e000000 for PSP TMR
> 2024-06-06T10:26:53.001513+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: R=
AS: optional ras ta ucode is not available
> 2024-06-06T10:26:53.013802+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: R=
AP: optional rap ta ucode is not available
> 2024-06-06T10:26:53.013816+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
ECUREDISPLAY: securedisplay ta ucode is not available
> 2024-06-06T10:26:53.013819+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
MU is resuming...
> 2024-06-06T10:26:53.016519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
MU is resumed successfully!
> 2024-06-06T10:26:53.017502+08:00 kernel: [drm] DMUB hardware initialize=
d: version=3D0x04000044
> 2024-06-06T10:26:53.677511+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q =
0
> 2024-06-06T10:26:53.958512+08:00 kernel: amdgpu 0000:03:00.0: [drm:amdg=
pu_ring_test_helper [amdgpu]] *ERROR* ring vcn_dec_0 test failed (-110)
> 2024-06-06T10:26:53.958536+08:00 kernel: [drm:amdgpu_device_ip_resume_p=
hase2 [amdgpu]] *ERROR* resume of IP block <vcn_v3_0> failed -110
> 2024-06-06T10:26:53.958539+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset(1) failed
> 2024-06-06T10:26:53.958541+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset end with ret =3D -110
> 2024-06-06T10:26:53.959180+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* GPU Recovery Failed: -110
> 2024-06-06T10:26:55.261509+08:00 kernel: [drm] Register(0) [mmUVD_POWER=
_STATUS] failed to reach value 0x00000001 !=3D 0x00000002n
> 2024-06-06T10:26:55.540507+08:00 kernel: [drm] Register(0) [mmUVD_RBC_R=
B_RPTR] failed to reach value 0x00000010 !=3D 0x00000000n
> 2024-06-06T10:27:04.407149+08:00 kernel: [drm] Register(0) [mmUVD_POWER=
_STATUS] failed to reach value 0x00000001 !=3D 0x00000002n
> 2024-06-06T10:27:04.407252+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* ring vcn_dec_0 timeout, signaled seq=3D24898, emitted seq=3D=
24898
> 2024-06-06T10:27:04.407257+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* Process information: process RDD Process pid 39524 thread fi=
refox-bi:cs0 pid 40342
> 2024-06-06T10:27:04.407259+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset begin!
> 2024-06-06T10:27:05.033745+08:00 kernel: ------------[ cut here ]------=
------
> 2024-06-06T10:27:05.033773+08:00 kernel: WARNING: CPU: 8 PID: 47039 at =
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x9c/0xb0 [amd=
gpu]
> 2024-06-06T10:27:05.033777+08:00 kernel: Modules linked in: nft_reject_=
inet nf_reject_ipv4 nf_reject_ipv6 nft_reject xt_conntrack nft_chain_nat =
xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_=
defrag_ipv4 xt_addrtype nft_compat nf_tables libcrc32c br_netfilter bridg=
e stp llc hid_logitech_hidpp usbhid xfrm_interface xfrm6_tunnel tunnel4 t=
unnel6 xfrm_user xfrm_algo uhid rfcomm snd_seq_dummy snd_hrtimer cmac alg=
if_hash algif_skcipher af_alg overlay qrtr bnep binfmt_misc uvcvideo vide=
obuf2_vmalloc uvc videobuf2_memops videobuf2_v4l2 btusb btrtl videodev bt=
intel btbcm snd_acp6x_pdm_dma snd_soc_dmic snd_soc_acp6x_mach amd_atl int=
el_rapl_msr btmtk videobuf2_common bluetooth mc intel_rapl_common snd_sof=
_amd_acp63 snd_sof_amd_vangogh snd_sof_amd_rembrandt iwlmvm snd_sof_amd_r=
enoir snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_dsp amdgpu snd_sof edac_=
mce_amd mac80211 snd_sof_utils snd_pci_ps snd_hda_codec_realtek snd_amd_s=
dw_acpi kvm_amd soundwire_amd snd_hda_codec_generic soundwire_generic_all=
ocation soundwire_bus
> 2024-06-06T10:27:05.033782+08:00 kernel:  snd_hda_scodec_cs35l41_spi nl=
s_iso8859_1 snd_hda_codec_hdmi snd_hda_scodec_component libarc4 kvm snd_s=
oc_core snd_hda_intel snd_ctl_led snd_intel_dspcfg snd_compress snd_intel=
_sdw_acpi amdxcp snd_seq_midi ac97_bus crct10dif_pclmul drm_exec snd_hda_=
codec polyval_clmulni snd_pcm_dmaengine snd_seq_midi_event gpu_sched poly=
val_generic iwlwifi ghash_clmulni_intel snd_rpl_pci_acp6x drm_buddy sha25=
6_ssse3 snd_hda_core snd_rawmidi snd_acp_pci drm_suballoc_helper snd_hda_=
scodec_cs35l41_i2c sha1_ssse3 drm_ttm_helper snd_acp_legacy_common snd_hw=
dep snd_hda_scodec_cs35l41 aesni_intel snd_pci_acp6x amd_pmf snd_hda_cs_d=
sp_ctls ttm crypto_simd snd_pci_acp5x snd_soc_cs_amp_lib asus_nb_wmi cs_d=
sp cryptd amdtee snd_seq snd_rn_pci_acp3x drm_display_helper snd_pcm asus=
_wmi snd_acp_config rapl wmi_bmof sparse_keymap snd_seq_device cfg80211 s=
nd_soc_cs35l41_lib cec snd_soc_acpi ccp rc_core snd_timer i2c_algo_bit i2=
c_piix4 snd_pci_acp3x k10temp amd_sfh tee snd platform_profile soundcore =
serial_multi_instantiate amd_pmc acpi_tad
> 2024-06-06T10:27:05.033784+08:00 kernel:  joydev input_leds mac_hid ser=
io_raw parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysfs ip_tabl=
es x_tables autofs4 hid_multitouch nvme video ucsi_acpi hid_generic crc32=
_pclmul nvme_core typec_ucsi xhci_pci i2c_hid_acpi xhci_pci_renesas nvme_=
auth typec i2c_hid wmi hid 8250_dw
> 2024-06-06T10:27:05.033785+08:00 kernel: CPU: 8 PID: 47039 Comm: kworke=
r/u64:0 Tainted: G        W          6.10.0-061000rc2-generic #2024060223=
33
> 2024-06-06T10:27:05.033787+08:00 kernel: Hardware name: ASUSTeK COMPUTE=
R INC. Zenbook UM5302TA_UM5302TA/UM5302TA, BIOS UM5302TA.311 01/17/2023
> 2024-06-06T10:27:05.033788+08:00 kernel: Workqueue: amdgpu-reset-dev dr=
m_sched_job_timedout [gpu_sched]
> 2024-06-06T10:27:05.033789+08:00 kernel: RIP: 0010:amdgpu_irq_put+0x9c/=
0xb0 [amdgpu]
> 2024-06-06T10:27:05.033790+08:00 kernel: Code: 31 f6 31 ff e9 c0 05 2f =
e6 44 89 e2 48 89 de 4c 89 f7 e8 97 fc ff ff 5b 41 5c 41 5d 41 5e 5d 31 d=
2 31 f6 31 ff e9 9f 05 2f e6 <0f> 0b b8 ea ff ff ff eb c3 b8 fe ff ff ff =
eb bc 0f 1f 40 00 90 90
> 2024-06-06T10:27:05.033791+08:00 kernel: RSP: 0018:ffffb65847227c18 EFL=
AGS: 00010246
> 2024-06-06T10:27:05.033793+08:00 kernel: RAX: 0000000000000000 RBX: fff=
f9ac0a0280c60 RCX: 0000000000000000
> 2024-06-06T10:27:05.033794+08:00 kernel: RDX: 0000000000000000 RSI: 000=
0000000000000 RDI: 0000000000000000
> 2024-06-06T10:27:05.033796+08:00 kernel: RBP: ffffb65847227c38 R08: 000=
0000000000000 R09: 0000000000000000
> 2024-06-06T10:27:05.033797+08:00 kernel: R10: 0000000000000000 R11: 000=
0000000000000 R12: 0000000000000000
> 2024-06-06T10:27:05.033798+08:00 kernel: R13: 0000000000000001 R14: fff=
f9ac0a0280000 R15: ffff9ac0a0280000
> 2024-06-06T10:27:05.033799+08:00 kernel: FS:  0000000000000000(0000) GS=
:ffff9ac38e600000(0000) knlGS:0000000000000000
> 2024-06-06T10:27:05.033800+08:00 kernel: CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
> 2024-06-06T10:27:05.033802+08:00 kernel: CR2: 00007d1a5edfe000 CR3: 000=
000001863c000 CR4: 0000000000f50ef0
> 2024-06-06T10:27:05.033803+08:00 kernel: PKRU: 55555554
> 2024-06-06T10:27:05.033805+08:00 kernel: Call Trace:
> 2024-06-06T10:27:05.033806+08:00 kernel:  <TASK>
> 2024-06-06T10:27:05.033807+08:00 kernel:  ? show_regs+0x6c/0x80
> 2024-06-06T10:27:05.033845+08:00 kernel:  ? __warn+0x88/0x140
> 2024-06-06T10:27:05.034598+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0 [a=
mdgpu]
> 2024-06-06T10:27:05.034615+08:00 kernel:  ? report_bug+0x182/0x1b0
> 2024-06-06T10:27:05.034618+08:00 kernel:  ? handle_bug+0x51/0xa0
> 2024-06-06T10:27:05.034619+08:00 kernel:  ? exc_invalid_op+0x18/0x80
> 2024-06-06T10:27:05.034620+08:00 kernel:  ? asm_exc_invalid_op+0x1b/0x2=
0
> 2024-06-06T10:27:05.034621+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0 [a=
mdgpu]
> 2024-06-06T10:27:05.034623+08:00 kernel:  ? amdgpu_irq_put+0x55/0xb0 [a=
mdgpu]
> 2024-06-06T10:27:05.035573+08:00 kernel:  gmc_v10_0_hw_fini+0x67/0xe0 [=
amdgpu]
> 2024-06-06T10:27:05.035580+08:00 kernel:  gmc_v10_0_suspend+0xe/0x20 [a=
mdgpu]
> 2024-06-06T10:27:05.035581+08:00 kernel:  amdgpu_device_ip_suspend_phas=
e2+0x251/0x480 [amdgpu]
> 2024-06-06T10:27:05.035582+08:00 kernel:  amdgpu_device_ip_suspend+0x49=
/0x80 [amdgpu]
> 2024-06-06T10:27:05.036529+08:00 kernel:  amdgpu_device_pre_asic_reset+=
0xd1/0x490 [amdgpu]
> 2024-06-06T10:27:05.036546+08:00 kernel:  amdgpu_device_gpu_recover+0x4=
06/0xa30 [amdgpu]
> 2024-06-06T10:27:05.036548+08:00 kernel:  amdgpu_job_timedout+0x141/0x2=
00 [amdgpu]
> 2024-06-06T10:27:05.036550+08:00 kernel:  drm_sched_job_timedout+0x70/0=
x110 [gpu_sched]
> 2024-06-06T10:27:05.036551+08:00 kernel:  process_one_work+0x186/0x3e0
> 2024-06-06T10:27:05.036552+08:00 kernel:  worker_thread+0x304/0x440
> 2024-06-06T10:27:05.036554+08:00 kernel:  ? srso_alias_return_thunk+0x5=
/0xfbef5
> 2024-06-06T10:27:05.036555+08:00 kernel:  ? _raw_spin_lock_irqsave+0xe/=
0x20
> 2024-06-06T10:27:05.036556+08:00 kernel:  ? __pfx_worker_thread+0x10/0x=
10
> 2024-06-06T10:27:05.036557+08:00 kernel:  kthread+0xe4/0x110
> 2024-06-06T10:27:05.036558+08:00 kernel:  ? __pfx_kthread+0x10/0x10
> 2024-06-06T10:27:05.036559+08:00 kernel:  ret_from_fork+0x47/0x70
> 2024-06-06T10:27:05.036561+08:00 kernel:  ? __pfx_kthread+0x10/0x10
> 2024-06-06T10:27:05.036562+08:00 kernel:  ret_from_fork_asm+0x1a/0x30
> 2024-06-06T10:27:05.036563+08:00 kernel:  </TASK>
> 2024-06-06T10:27:05.036564+08:00 kernel: ---[ end trace 000000000000000=
0 ]---
> 2024-06-06T10:27:05.036565+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
ODE2 reset
> 2024-06-06T10:27:05.046502+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset succeeded, trying to resume
> 2024-06-06T10:27:05.047516+08:00 kernel: [drm] PCIE GART of 1024M enabl=
ed (table at 0x000000F41FC00000).
> 2024-06-06T10:27:05.047533+08:00 kernel: [drm] VRAM is lost due to GPU =
reset!
> 2024-06-06T10:27:05.047538+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: P=
SP is resuming...
> 2024-06-06T10:27:05.070481+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: r=
eserve 0xa00000 from 0xf41e000000 for PSP TMR
> 2024-06-06T10:27:05.397519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: R=
AS: optional ras ta ucode is not available
> 2024-06-06T10:27:05.409509+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: R=
AP: optional rap ta ucode is not available
> 2024-06-06T10:27:05.409517+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
ECUREDISPLAY: securedisplay ta ucode is not available
> 2024-06-06T10:27:05.409518+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
MU is resuming...
> 2024-06-06T10:27:05.411482+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
MU is resumed successfully!
> 2024-06-06T10:27:05.413504+08:00 kernel: [drm] DMUB hardware initialize=
d: version=3D0x04000044
> 2024-06-06T10:27:06.055474+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q =
0
> 2024-06-06T10:27:06.335476+08:00 kernel: amdgpu 0000:03:00.0: [drm:amdg=
pu_ring_test_helper [amdgpu]] *ERROR* ring vcn_dec_0 test failed (-110)
> 2024-06-06T10:27:06.335495+08:00 kernel: [drm:amdgpu_device_ip_resume_p=
hase2 [amdgpu]] *ERROR* resume of IP block <vcn_v3_0> failed -110
> 2024-06-06T10:27:06.335498+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset(2) failed
> 2024-06-06T10:27:06.335499+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset end with ret =3D -110
> 2024-06-06T10:27:06.335631+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* GPU Recovery Failed: -110
>=20

