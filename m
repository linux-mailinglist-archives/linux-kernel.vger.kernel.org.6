Return-Path: <linux-kernel+bounces-219050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C455990C941
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1DD1F2120B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3FC15E5DD;
	Tue, 18 Jun 2024 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VKk2LFjR"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322613C913;
	Tue, 18 Jun 2024 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706172; cv=none; b=XKjtYWUhzASdzDZUIcl38+cOg+1rmMG1ho74vANp8I20J78Pz/SGySO0KlRIyRaGHdbpCkG/0EVnwWJHafTBI/1MYPwavNtC5kGmCFDriCK03m4pZmC0ZysWWG3Xm5ZgElhDT+AFZBPvHok0gQbwPEexc6WyZF3nq0PFWO4Z/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706172; c=relaxed/simple;
	bh=r6pJTIEmvLC1nd8y75hngavgg8Hy2QqhAckp8Oh9DaE=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=fzE+4I48gOStlZmM1jMDWAAcw2pockEhFKGHEi1kOoaz1refB+qXyyiQ/xd+kwYAVohgiehDIvh9iIseVIB0Zd6pwqaJbdJd0W+84cjchFR50/VhUnKQlPWIse5Skn6SsrpspbcJGL4x5oED92tKyfSU5a5szybOnOBe5o7Wz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VKk2LFjR; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gedkI59GOhsqqQN0ahgyfWFQH2lfghvEsw3T4E/Gb0E=; t=1718706170; x=1719138170;
	 b=VKk2LFjRpyIy9V9Z8K++Kwo+Y8MTSAPppK0nIuA941ize+9V+cTYT1+p0XJ4tLLlfSRDeU/0LM
	r6YG7A5KMq+lKsgtLXCQWM4nN8i7n41wUpsT+NjyjNMNpb99cU0V/frqXrtXvvb86QLJeHSNfcx+W
	Jhg2+NfZPjXQF66bKuU2gjvK0MGTuDx3t/B5babESVZtZjJnFyS5M5A6Q8aituU+C4bTMnDb4vMqo
	T+0S/AU58KSpXIfMpoNOKYlo7dJBZB1RidTHSPRjQFzW3DrXm7RKb1wgYW+E/Vr+gQHm2/HONGXN3
	6z3rUwBY9rfWuPjv4EcDDV2Cj4eVVTgLbC2tg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJVzB-0006jm-SG; Tue, 18 Jun 2024 12:22:46 +0200
Message-ID: <ca2d3d47-0ac0-48a5-910b-e481f2a9870a@leemhuis.info>
Date: Tue, 18 Jun 2024 12:22:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Todd Brandt <todd.e.brandt@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux Sound System <linux-sound@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, sound-open-firmware@alsa-project.org
Subject: [Regression] Lenovo Thinkpad X1 Carbon Gen 10 first S2idle fails,
 S0ix fails in all further suspends
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718706170;f81fa682;
X-HE-SMSGID: 1sJVzB-0006jm-SG

Hi, Thorsten here, the Linux kernel's regression tracker.

Pierre-Louis Bossart, I noticed a report about a regression in
bugzilla.kernel.org that appears to be caused by the following change of
yours: d5263dbbd8af02 ("ASoC: SOF: Intel: don't ignore IOC interrupts
for non-audio transfers") [v6.10-rc1]

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to write this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=218961 :

> We have a Lenovo Thinkpad X1 Carbon Gen 10 in our lab and ever since
> 6.10.0-rc1 it has failed its first S2idle suspend, and has stopped
> getting S0iX on subsequent successful S2idle suspends. The issue in the
> first suspend fail is here in the audio driver (dmesg section shown):
> 
> sof-audio-pci-intel-tgl 0000:00:1f.3: Code loader DMA did not complete
> sof-audio-pci-intel-tgl 0000:00:1f.3: ------------[ DSP dump start ]------------
> sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware download failed
> sof-audio-pci-intel-tgl 0000:00:1f.3: fw_state: SOF_FW_BOOT_READY_OK (6)
> sof-audio-pci-intel-tgl 0000:00:1f.3: 0x00000005: module: ROM, state: FW_ENTERED, running
> sof-audio-pci-intel-tgl 0000:00:1f.3: extended rom status:  0x5 0x0 0x4000 0x0 0x0 0x0 0x2560521 0x0
> sof-audio-pci-intel-tgl 0000:00:1f.3: ------------[ DSP dump end ]------------
> sof-audio-pci-intel-tgl 0000:00:1f.3: Failed to start DSP
> sof-audio-pci-intel-tgl 0000:00:1f.3: error: failed to boot DSP firmware after resume -110
> sof-audio-pci-intel-tgl 0000:00:1f.3: error: hda_dsp_core_reset_enter: timeout on HDA_DSP_REG_ADSPCS read
> sof-audio-pci-intel-tgl 0000:00:1f.3: error: dsp core reset failed: core_mask 1
> sof-audio-pci-intel-tgl 0000:00:1f.3: failed to power down DSP during suspend
> sof-audio-pci-intel-tgl 0000:00:1f.3: error: suspending dsp
> sof-audio-pci-intel-tgl 0000:00:1f.3: error: failed to power down DSP during suspend -110
> sof-audio-pci-intel-tgl 0000:00:1f.3: PM: pci_pm_suspend(): snd_sof_suspend [snd_sof] returns -110
> sof-audio-pci-intel-tgl 0000:00:1f.3: PM: dpm_run_callback(): pci_pm_suspend returns -110
> sof-audio-pci-intel-tgl 0000:00:1f.3: PM: failed to suspend async: error -110
> 
> This is the commit:
> 
> commit d5263dbbd8af026159b16a08a94bedfe51b5f67b
> Author: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Date:   Thu Apr 4 13:54:47 2024 -0500
> 
>     ASoC: SOF: Intel: don't ignore IOC interrupts for non-audio transfers
> 
> Reverting the commit thusly fixes things in everything up to 6.10.0-rc3.
> 
> %> git diff 6cbf086143cf9674c7f029e1cf435c65a537066a d5263dbbd8af026159b16a08a94bedfe51b5f67b > ../revert.patch
> %> cat ../revert.patch | patch -1 -R
> 
> I've attached the sleepgraph timeline of the fail. The dmesg log is
> accesible by clicking the "dmesg" button in the upper right hand corner.
> They "log" button shows all the system details.

See the ticket for more details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: d5263dbbd8af02
#regzbot title: ASoC: SOF: Intel:
#regzbot from: Todd Brandt
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218961
#regzbot ignore-activity

