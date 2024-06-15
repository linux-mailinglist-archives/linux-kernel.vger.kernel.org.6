Return-Path: <linux-kernel+bounces-215928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D192C9098F6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DC2825DB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 15:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E70E481B3;
	Sat, 15 Jun 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="zuP65fFi"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28B1094E;
	Sat, 15 Jun 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718466641; cv=none; b=kyI+UHHArvW6Q75ZKlLdfIpYht0faGLLazKCzBpg1uDvIhNV7eVvLdLpphkJ7yFlTS3dj9PEvOmWfYhOJMUqUgzmA4o760/+EjW9vcnFmiOmyRfiEq3+ggsIyb7hvZiOYfggV6HBVSLWWbuLNlOwswSA0/ttMBpStp8VlYGUuaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718466641; c=relaxed/simple;
	bh=aoAO9UhYONQUDviQ6cTyVbPwEodgKqFXxl1LCHxeVYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYZXBskpq/m9hfpO7QPfErUrq3uBtQfFLXwORqnnz6CASUurHepVgtMTmBpeZpE4EFNbsWA19uHE0MbCEnwlNE3fuSDJ1jNYu15mgyTpELJPEII/m3TApZnD5yFhhpFysPRE2DBjW04rMQZyqHslpSoW1tGWLwN9/aEqAit7ceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=zuP65fFi; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3d+lfut9NAtCyW4mQC+EOiamx8mOvvqnk1IgsFfj4qw=; t=1718466638;
	x=1718898638; b=zuP65fFil5x9hdGPRiLtmuGu86LrWotSQUUCIae2KMbeZdtK+x1nTw46qQAGf
	jdp5Ejt/yAggeDveiFJ34zz5hXoqELRdoWScpgPUyhF/Pqe9QabNNo4yLe4EcKG/vLhYJZB9CcHEt
	jt93/rXYDZ/YiohDy2R0c+ApFO/5KXqpX2wLnVY2om7s1R8bNpxuMCRumtqmaFy57vWL/y+dqes4K
	KfVRsNGSduw/CoA3PCBFyn8i8/YauPcdLTltzmi/oEKaEE8eyrThLLAa8yR5bZcNAhKzUsd/WvCVx
	FanzfjcJ3CBFqt4/25oWtrGLkZWPoBgyCJTCsxtx6ezQMs3lbQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sIVfb-0005gl-ER; Sat, 15 Jun 2024 17:50:23 +0200
Message-ID: <06cbfba8-13a3-42a3-9262-98310b8ed0ad@leemhuis.info>
Date: Sat, 15 Jun 2024 17:50:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] drm/amdgpu: amdgpu crash on playing videos, linux
 6.10-rc
To: Wang Yunchen <mac-wang@sjtu.edu.cn>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Winston Ma <winstonhyypia@gmail.com>
Cc: Felix.Kuehling@amd.com, Xinhui.Pan@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 LKML <linux-kernel@vger.kernel.org>
References: <CAMOvFfkQscju1spNKHmEC_Rut+2=qfhKGZSvGhCk_nd5VhuDkg@mail.gmail.com>
 <4ce90767-7d85-47b0-9187-4eb8d257e7e0@leemhuis.info>
 <44dc1df5f5a1b740b76d1efbf607c49f9d50dda0.camel@sjtu.edu.cn>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <44dc1df5f5a1b740b76d1efbf607c49f9d50dda0.camel@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718466638;21994e7c;
X-HE-SMSGID: 1sIVfb-0005gl-ER

[reply made easier by moving something in the quote]

On 12.06.24 18:55, Wang Yunchen wrote:
> On Wed, 2024-06-12 at 15:14 +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 06.06.24 05:06, Winston Ma wrote:
>>> Hi I got the same problem on Linux Kernel 6.10-rc2. I got the problem by
>>> following the procedure below:
>>>
>>>  1. Boot Linux Kernel 6.10-rc2
>>>  2. Open Firefox (Any browser should work)
>>>  3. Open a Youtube Video
>>>  4. On the playing video, toggle fullscreen quickly Then after 10-20
>>>     times of fullscreen toggling, the screen would enter freeze mode.
>>>     This is the log that I captured using the above method.
>>
>> Hmm, seems nothing happened here for a while. Could you maybe try to
>> bisect this
>> (https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
>> )?
>
> It seems that the issue persists on 6.10 rc3.

That's good to know, but...

>> @amd-gfx devs: Or is this unneeded, as the cause found or maybe even
>> fixed meanwhile?

...as there was no reply to that inquiry it seems we really need either
you or Winston Ma (or somebody else that is affected we don't yet know
about) to perform a git bisection (see the link quoted above) to find
the exact change that broke things. Without this it might not be getting
fixed.

Ciao, Thorsten

>>> This is the kernel log
>>>
>>> 2024-06-06T10:26:40.747576+08:00 kernel: gmc_v10_0_process_interrupt: 6 callbacks suppressed
>>> 2024-06-06T10:26:40.747618+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:2
>>> pasid:32789)
>>> 2024-06-06T10:26:40.747623+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 39524 thread
>>> firefox-bi:cs0 pid 40342
>>> 2024-06-06T10:26:40.747625+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address
>>> 0x0000800106ffe000 from client 0x12 (VMC)
>>> 2024-06-06T10:26:40.747628+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00203811
>>> 2024-06-06T10:26:40.747629+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: VCN (0x1c)
>>> 2024-06-06T10:26:40.747631+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x1
>>> 2024-06-06T10:26:40.747651+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x0
>>> 2024-06-06T10:26:40.747653+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x1
>>> 2024-06-06T10:26:40.747655+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x0
>>> 2024-06-06T10:26:40.747656+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x0
>>> 2024-06-06T10:26:40.747658+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:2
>>> pasid:32789)
>>> 2024-06-06T10:26:40.747660+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 39524 thread
>>> firefox-bi:cs0 pid 40342
>>> 2024-06-06T10:26:40.747662+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address
>>> 0x0000800106e00000 from client 0x12 (VMC)
>>> 2024-06-06T10:26:40.747663+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
>>> 2024-06-06T10:26:40.747664+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: MP0 (0x0)
>>> 2024-06-06T10:26:40.747666+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
>>> 2024-06-06T10:26:40.747667+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x0
>>> 2024-06-06T10:26:40.747668+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x0
>>> 2024-06-06T10:26:40.747670+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x0
>>> 2024-06-06T10:26:40.747671+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x0
>>> 2024-06-06T10:26:40.747674+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:2
>>> pasid:32789)
>>> 2024-06-06T10:26:40.747677+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 39524 thread
>>> firefox-bi:cs0 pid 40342
>>> 2024-06-06T10:26:40.747680+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address
>>> 0x0000800106e07000 from client 0x12 (VMC)
>>> 2024-06-06T10:26:40.747683+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
>>> 2024-06-06T10:26:40.747686+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: MP0 (0x0)
>>> 2024-06-06T10:26:40.747688+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
>>> 2024-06-06T10:26:40.747691+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x0
>>> 2024-06-06T10:26:40.747693+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x0
>>> 2024-06-06T10:26:40.747696+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x0
>>> 2024-06-06T10:26:40.747698+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x0
>>> 2024-06-06T10:26:40.747700+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:8 vmid:2
>>> pasid:32789)
>>> 2024-06-06T10:26:40.747703+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 39524 thread
>>> firefox-bi:cs0 pid 40342
>>> 2024-06-06T10:26:40.747705+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address
>>> 0x0000800107001000 from client 0x12 (VMC)
>>> 2024-06-06T10:26:40.747707+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
>>> 2024-06-06T10:26:40.747710+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: MP0 (0x0)
>>> 2024-06-06T10:26:40.747713+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
>>> 2024-06-06T10:26:40.747716+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x0
>>> 2024-06-06T10:26:40.747718+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x0
>>> 2024-06-06T10:26:40.747721+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x0
>>> 2024-06-06T10:26:40.747723+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x0
>>> 2024-06-06T10:26:51.094991+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring vcn_dec_0 timeout,
>>> signaled seq=24897, emitted seq=24898
>>> 2024-06-06T10:26:51.095023+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process
>>> RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
>>> 2024-06-06T10:26:51.095025+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
>>> 2024-06-06T10:26:52.305509+08:00 kernel: [drm] Register(0) [mmUVD_POWER_STATUS] failed to reach value 0x00000001
>>> != 0x00000002n
>>> 2024-06-06T10:26:52.586019+08:00 kernel: [drm] Register(0) [mmUVD_RBC_RB_RPTR] failed to reach value 0x000003c0 !=
>>> 0x00000360n
>>> 2024-06-06T10:26:52.639506+08:00 kernel: [drm] Register(0) [mmUVD_POWER_STATUS] failed to reach value 0x00000001
>>> != 0x00000002n
>>> 2024-06-06T10:26:52.639521+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MODE2 reset
>>> 2024-06-06T10:26:52.650614+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded, trying to resume
>>> 2024-06-06T10:26:52.650633+08:00 kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC00000).
>>> 2024-06-06T10:26:52.650637+08:00 kernel: [drm] VRAM is lost due to GPU reset!
>>> 2024-06-06T10:26:52.650641+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
>>> 2024-06-06T10:26:52.673474+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0xf41e000000 for PSP
>>> TMR
>>> 2024-06-06T10:26:53.001513+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
>>> 2024-06-06T10:26:53.013802+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
>>> 2024-06-06T10:26:53.013816+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not
>>> available
>>> 2024-06-06T10:26:53.013819+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
>>> 2024-06-06T10:26:53.016519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
>>> 2024-06-06T10:26:53.017502+08:00 kernel: [drm] DMUB hardware initialized: version=0x04000044
>>> 2024-06-06T10:26:53.677511+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q 0
>>> 2024-06-06T10:26:53.958512+08:00 kernel: amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
>>> vcn_dec_0 test failed (-110)
>>> 2024-06-06T10:26:53.958536+08:00 kernel: [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block
>>> <vcn_v3_0> failed -110
>>> 2024-06-06T10:26:53.958539+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset(1) failed
>>> 2024-06-06T10:26:53.958541+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset end with ret = -110
>>> 2024-06-06T10:26:53.959180+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* GPU Recovery Failed: -110
>>> 2024-06-06T10:26:55.261509+08:00 kernel: [drm] Register(0) [mmUVD_POWER_STATUS] failed to reach value 0x00000001
>>> != 0x00000002n
>>> 2024-06-06T10:26:55.540507+08:00 kernel: [drm] Register(0) [mmUVD_RBC_RB_RPTR] failed to reach value 0x00000010 !=
>>> 0x00000000n
>>> 2024-06-06T10:27:04.407149+08:00 kernel: [drm] Register(0) [mmUVD_POWER_STATUS] failed to reach value 0x00000001
>>> != 0x00000002n
>>> 2024-06-06T10:27:04.407252+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring vcn_dec_0 timeout,
>>> signaled seq=24898, emitted seq=24898
>>> 2024-06-06T10:27:04.407257+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process
>>> RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
>>> 2024-06-06T10:27:04.407259+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
>>> 2024-06-06T10:27:05.033745+08:00 kernel: ------------[ cut here ]------------
>>> 2024-06-06T10:27:05.033773+08:00 kernel: WARNING: CPU: 8 PID: 47039 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630
>>> amdgpu_irq_put+0x9c/0xb0 [amdgpu]
>>> 2024-06-06T10:27:05.033777+08:00 kernel: Modules linked in: nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
>>> nft_reject xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6
>>> nf_defrag_ipv4 xt_addrtype nft_compat nf_tables libcrc32c br_netfilter bridge stp llc hid_logitech_hidpp usbhid
>>> xfrm_interface xfrm6_tunnel tunnel4 tunnel6 xfrm_user xfrm_algo uhid rfcomm snd_seq_dummy snd_hrtimer cmac
>>> algif_hash algif_skcipher af_alg overlay qrtr bnep binfmt_misc uvcvideo videobuf2_vmalloc uvc videobuf2_memops
>>> videobuf2_v4l2 btusb btrtl videodev btintel btbcm snd_acp6x_pdm_dma snd_soc_dmic snd_soc_acp6x_mach amd_atl
>>> intel_rapl_msr btmtk videobuf2_common bluetooth mc intel_rapl_common snd_sof_amd_acp63 snd_sof_amd_vangogh
>>> snd_sof_amd_rembrandt iwlmvm snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_dsp amdgpu snd_sof
>>> edac_mce_amd mac80211 snd_sof_utils snd_pci_ps snd_hda_codec_realtek snd_amd_sdw_acpi kvm_amd soundwire_amd
>>> snd_hda_codec_generic soundwire_generic_allocation soundwire_bus
>>> 2024-06-06T10:27:05.033782+08:00 kernel:  snd_hda_scodec_cs35l41_spi nls_iso8859_1 snd_hda_codec_hdmi
>>> snd_hda_scodec_component libarc4 kvm snd_soc_core snd_hda_intel snd_ctl_led snd_intel_dspcfg snd_compress
>>> snd_intel_sdw_acpi amdxcp snd_seq_midi ac97_bus crct10dif_pclmul drm_exec snd_hda_codec polyval_clmulni
>>> snd_pcm_dmaengine snd_seq_midi_event gpu_sched polyval_generic iwlwifi ghash_clmulni_intel snd_rpl_pci_acp6x
>>> drm_buddy sha256_ssse3 snd_hda_core snd_rawmidi snd_acp_pci drm_suballoc_helper snd_hda_scodec_cs35l41_i2c
>>> sha1_ssse3 drm_ttm_helper snd_acp_legacy_common snd_hwdep snd_hda_scodec_cs35l41 aesni_intel snd_pci_acp6x amd_pmf
>>> snd_hda_cs_dsp_ctls ttm crypto_simd snd_pci_acp5x snd_soc_cs_amp_lib asus_nb_wmi cs_dsp cryptd amdtee snd_seq
>>> snd_rn_pci_acp3x drm_display_helper snd_pcm asus_wmi snd_acp_config rapl wmi_bmof sparse_keymap snd_seq_device
>>> cfg80211 snd_soc_cs35l41_lib cec snd_soc_acpi ccp rc_core snd_timer i2c_algo_bit i2c_piix4 snd_pci_acp3x k10temp
>>> amd_sfh tee snd platform_profile soundcore serial_multi_instantiate amd_pmc acpi_tad
>>> 2024-06-06T10:27:05.033784+08:00 kernel:  joydev input_leds mac_hid serio_raw parport_pc ppdev lp parport
>>> efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_multitouch nvme video ucsi_acpi hid_generic
>>> crc32_pclmul nvme_core typec_ucsi xhci_pci i2c_hid_acpi xhci_pci_renesas nvme_auth typec i2c_hid wmi hid 8250_dw
>>> 2024-06-06T10:27:05.033785+08:00 kernel: CPU: 8 PID: 47039 Comm: kworker/u64:0 Tainted: G        W         
>>> 6.10.0-061000rc2-generic #202406022333
>>> 2024-06-06T10:27:05.033787+08:00 kernel: Hardware name: ASUSTeK COMPUTER INC. Zenbook UM5302TA_UM5302TA/UM5302TA,
>>> BIOS UM5302TA.311 01/17/2023
>>> 2024-06-06T10:27:05.033788+08:00 kernel: Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>>> 2024-06-06T10:27:05.033789+08:00 kernel: RIP: 0010:amdgpu_irq_put+0x9c/0xb0 [amdgpu]
>>> 2024-06-06T10:27:05.033790+08:00 kernel: Code: 31 f6 31 ff e9 c0 05 2f e6 44 89 e2 48 89 de 4c 89 f7 e8 97 fc ff
>>> ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 9f 05 2f e6 <0f> 0b b8 ea ff ff ff eb c3 b8 fe ff ff ff eb bc 0f
>>> 1f 40 00 90 90
>>> 2024-06-06T10:27:05.033791+08:00 kernel: RSP: 0018:ffffb65847227c18 EFLAGS: 00010246
>>> 2024-06-06T10:27:05.033793+08:00 kernel: RAX: 0000000000000000 RBX: ffff9ac0a0280c60 RCX: 0000000000000000
>>> 2024-06-06T10:27:05.033794+08:00 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>>> 2024-06-06T10:27:05.033796+08:00 kernel: RBP: ffffb65847227c38 R08: 0000000000000000 R09: 0000000000000000
>>> 2024-06-06T10:27:05.033797+08:00 kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>> 2024-06-06T10:27:05.033798+08:00 kernel: R13: 0000000000000001 R14: ffff9ac0a0280000 R15: ffff9ac0a0280000
>>> 2024-06-06T10:27:05.033799+08:00 kernel: FS:  0000000000000000(0000) GS:ffff9ac38e600000(0000)
>>> knlGS:0000000000000000
>>> 2024-06-06T10:27:05.033800+08:00 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> 2024-06-06T10:27:05.033802+08:00 kernel: CR2: 00007d1a5edfe000 CR3: 000000001863c000 CR4: 0000000000f50ef0
>>> 2024-06-06T10:27:05.033803+08:00 kernel: PKRU: 55555554
>>> 2024-06-06T10:27:05.033805+08:00 kernel: Call Trace:
>>> 2024-06-06T10:27:05.033806+08:00 kernel:  <TASK>
>>> 2024-06-06T10:27:05.033807+08:00 kernel:  ? show_regs+0x6c/0x80
>>> 2024-06-06T10:27:05.033845+08:00 kernel:  ? __warn+0x88/0x140
>>> 2024-06-06T10:27:05.034598+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0 [amdgpu]
>>> 2024-06-06T10:27:05.034615+08:00 kernel:  ? report_bug+0x182/0x1b0
>>> 2024-06-06T10:27:05.034618+08:00 kernel:  ? handle_bug+0x51/0xa0
>>> 2024-06-06T10:27:05.034619+08:00 kernel:  ? exc_invalid_op+0x18/0x80
>>> 2024-06-06T10:27:05.034620+08:00 kernel:  ? asm_exc_invalid_op+0x1b/0x20
>>> 2024-06-06T10:27:05.034621+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0 [amdgpu]
>>> 2024-06-06T10:27:05.034623+08:00 kernel:  ? amdgpu_irq_put+0x55/0xb0 [amdgpu]
>>> 2024-06-06T10:27:05.035573+08:00 kernel:  gmc_v10_0_hw_fini+0x67/0xe0 [amdgpu]
>>> 2024-06-06T10:27:05.035580+08:00 kernel:  gmc_v10_0_suspend+0xe/0x20 [amdgpu]
>>> 2024-06-06T10:27:05.035581+08:00 kernel:  amdgpu_device_ip_suspend_phase2+0x251/0x480 [amdgpu]
>>> 2024-06-06T10:27:05.035582+08:00 kernel:  amdgpu_device_ip_suspend+0x49/0x80 [amdgpu]
>>> 2024-06-06T10:27:05.036529+08:00 kernel:  amdgpu_device_pre_asic_reset+0xd1/0x490 [amdgpu]
>>> 2024-06-06T10:27:05.036546+08:00 kernel:  amdgpu_device_gpu_recover+0x406/0xa30 [amdgpu]
>>> 2024-06-06T10:27:05.036548+08:00 kernel:  amdgpu_job_timedout+0x141/0x200 [amdgpu]
>>> 2024-06-06T10:27:05.036550+08:00 kernel:  drm_sched_job_timedout+0x70/0x110 [gpu_sched]
>>> 2024-06-06T10:27:05.036551+08:00 kernel:  process_one_work+0x186/0x3e0
>>> 2024-06-06T10:27:05.036552+08:00 kernel:  worker_thread+0x304/0x440
>>> 2024-06-06T10:27:05.036554+08:00 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
>>> 2024-06-06T10:27:05.036555+08:00 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
>>> 2024-06-06T10:27:05.036556+08:00 kernel:  ? __pfx_worker_thread+0x10/0x10
>>> 2024-06-06T10:27:05.036557+08:00 kernel:  kthread+0xe4/0x110
>>> 2024-06-06T10:27:05.036558+08:00 kernel:  ? __pfx_kthread+0x10/0x10
>>> 2024-06-06T10:27:05.036559+08:00 kernel:  ret_from_fork+0x47/0x70
>>> 2024-06-06T10:27:05.036561+08:00 kernel:  ? __pfx_kthread+0x10/0x10
>>> 2024-06-06T10:27:05.036562+08:00 kernel:  ret_from_fork_asm+0x1a/0x30
>>> 2024-06-06T10:27:05.036563+08:00 kernel:  </TASK>
>>> 2024-06-06T10:27:05.036564+08:00 kernel: ---[ end trace 0000000000000000 ]---
>>> 2024-06-06T10:27:05.036565+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MODE2 reset
>>> 2024-06-06T10:27:05.046502+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded, trying to resume
>>> 2024-06-06T10:27:05.047516+08:00 kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC00000).
>>> 2024-06-06T10:27:05.047533+08:00 kernel: [drm] VRAM is lost due to GPU reset!
>>> 2024-06-06T10:27:05.047538+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
>>> 2024-06-06T10:27:05.070481+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0xf41e000000 for PSP
>>> TMR
>>> 2024-06-06T10:27:05.397519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
>>> 2024-06-06T10:27:05.409509+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
>>> 2024-06-06T10:27:05.409517+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not
>>> available
>>> 2024-06-06T10:27:05.409518+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
>>> 2024-06-06T10:27:05.411482+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
>>> 2024-06-06T10:27:05.413504+08:00 kernel: [drm] DMUB hardware initialized: version=0x04000044
>>> 2024-06-06T10:27:06.055474+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q 0
>>> 2024-06-06T10:27:06.335476+08:00 kernel: amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
>>> vcn_dec_0 test failed (-110)
>>> 2024-06-06T10:27:06.335495+08:00 kernel: [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block
>>> <vcn_v3_0> failed -110
>>> 2024-06-06T10:27:06.335498+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset(2) failed
>>> 2024-06-06T10:27:06.335499+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset end with ret = -110
>>> 2024-06-06T10:27:06.335631+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* GPU Recovery Failed: -110

