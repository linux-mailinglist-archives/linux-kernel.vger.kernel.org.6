Return-Path: <linux-kernel+bounces-335186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AED4297E25C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369B5B20DA3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417D1426C;
	Sun, 22 Sep 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="0jZovbWR"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835AE56C;
	Sun, 22 Sep 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727020909; cv=none; b=ZZmpb3cDW3mRAmbwdlSfKNueUGCT2xrX2YF4Mf+j9B1UUTqSDx7tuNZauEgjNFrBqKfU3+m0O/txK8CAcRxbZFL72rbWBg0KuVwvMfHaAndrnbdZlgo024cILdoQWqei2sxgYWH+k32CgcvfU7uL5TZbZCU6noyQzMAjcbjJ2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727020909; c=relaxed/simple;
	bh=+G4l5pI49KQF0rw4G2AySq/nAwCn3T80unuyujusP4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0TlE0fZkqRtPSfUGNjgzunzpXlXJ3pv5+bfK3EvAAPIfAMQ4rV1+CMVq4DgkmZPMrhXzKeeUmUWgOD/s4za6A9GbR1mBStIBcTOxEeNbbDJFTmGXgPaujoXF22fU1etRm2DpPlKDnLZ7fHDykJqLph0gKcPiHSBxSx+3fS5Y5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=0jZovbWR; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=2CO9ZxHeft+k4AuGToVXQRkA7JnlRj6/9HkeBeVpYgU=;
	t=1727020907; x=1727452907; b=0jZovbWRixMakIJYgQt/CimGSJd1M1tAtjz2JTH+43yiTow
	nIYmrN7o7J9gcP3eJMya42ZozH5JKb/UAxeN3FziXW0jHwHhJiWGP5rKZ3jTZaBPDDV/IL94V5hmc
	AWa6VVJtX9PETh5OHNHjjFp+2/CEvBkNBhXyt8sqLVp+hjmqhe0V+xN+idwR5FnicMO4zCZnlcgMZ
	pTCan7DIBIomEuQ+RrJN9Tw7XMFmFgt3nKE5OJ9rbp97Yjuesm+gNTZZp54dBpmeUiqHR3f/HhcKo
	ZXue/xpKoHnt/gOElK/GER2LyXRX/dT0yIA8Ws6VWPEuhCrqpsxiW7iRBmidu/lw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ssP1e-00044v-Ue; Sun, 22 Sep 2024 18:01:31 +0200
Message-ID: <9adb9245-612e-4bd9-b4bc-7eb3ec42624c@leemhuis.info>
Date: Sun, 22 Sep 2024 18:01:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH 17/24] sched/fair: Implement delayed
 dequeue
To: Chris Bainbridge <chris.bainbridge@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, bsegall@google.com,
 dietmar.eggemann@arm.com, efault@gmx.de, juri.lelli@redhat.com,
 kprateek.nayak@amd.com, mgorman@suse.de, mingo@redhat.com,
 rostedt@goodmis.org, tglx@linutronix.de, vincent.guittot@linaro.org,
 vschneid@redhat.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org,
 spasswolf@web.de, regressions@lists.linux.dev,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20240830123458.3557-1-spasswolf@web.de>
 <ZvA7n9GNoD-ipjkj@debian.local>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZvA7n9GNoD-ipjkj@debian.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727020907;87b48cda;
X-HE-SMSGID: 1ssP1e-00044v-Ue

On 22.09.24 17:45, Chris Bainbridge wrote:
> On Fri, Aug 30, 2024 at 02:34:56PM +0200, Bert Karwatzki wrote:
>> Since linux next-20240820 the following messages appears when booting:
>>
>> [    T1] smp: Bringing up secondary CPUs ...
>> [    T1] smpboot: x86: Booting SMP configuration:
>> [    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1
>> This is the line I'm concerend about:
>> [    T1] psi: inconsistent task state! task=61:cpuhp/3 cpu=0 psi_flags=4 clear=0 set=4
>> [    T1]   #3  #5  #7  #9 #11 #13 #15
>> [    T1] Spectre V2 : Update user space SMT mitigation: STIBP always-on
>> [    T1] smp: Brought up 1 node, 16 CPUs
>> [    T1] smpboot: Total of 16 processors activated (102216.16 BogoMIPS)
>>
>> I bisected this to commit 152e11f6df29 ("sched/fair: Implement delayed dequeue").
>> Is this normal or is this something I should worry about?
>>
> I am also getting a similar error on boot, and bisected it to the same commit:
> 
> [    0.342931] psi: inconsistent task state! task=15:rcu_tasks_trace cpu=0 psi_flags=4 clear=0 set=4
> 
> #regzbot introduced: 152e11f6df293e816a6a37c69757033cdc72667d

thx for CCing the regressions list.

Paul also reported this earlier today:

https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/

Hannes [CCed] replied there and has some idea what might be wrong:

https://lore.kernel.org/all/20240922102047.GA437832@cmpxchg.org/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.:

#regzbot dup:
https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/

#regzbot report:
https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/
#regzbot introduced: 152e11f6df293e816a6a37c69757033cdc72667d

