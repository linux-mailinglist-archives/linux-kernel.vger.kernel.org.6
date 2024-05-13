Return-Path: <linux-kernel+bounces-177673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8CE8C42DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C541C20D38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004DE153817;
	Mon, 13 May 2024 14:10:12 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00A1E497
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609411; cv=none; b=pLUPspOknSHMJ/LbYKibcNkvUJHCTgB74KRtMKel3NNEWZstFIx3Xu3XJGhco/AxI133ApW6V8dPXY/0DQ+h/tBoBBO2jLYk+zrscJxPyLpXrnek72+gLimaMyWQD95+uZ/2eDT8CiP1p+ouSYTDrGHM4FGRcJiZH8GiLSPxrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609411; c=relaxed/simple;
	bh=qOjzP0kyb4Onm7nt74kqRgFE7k/1ilB1V5UByHfoeHo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BgWJT1HrLolkxUE4GEQfQbtfEckwkZ33N/dg3uRMpOsTjaY6bKrDqUZqPIym3WoV0aCWEwprVzoO2IYlvD3Wm1kQmRpNRU1yk08C3/PXc3n+BKSuODWxCbvFESpnCpjJl6cQDppQ4g045Q6wc+mBkarN06S+BpAV1gaR4xwNc+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VdLtt43G7z1HBj4;
	Mon, 13 May 2024 22:08:38 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (unknown [7.185.36.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E34961A016C;
	Mon, 13 May 2024 22:10:00 +0800 (CST)
Received: from [10.67.110.25] (10.67.110.25) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 13 May
 2024 22:10:00 +0800
Message-ID: <1314703e-4251-f31f-3d43-ece5c1b68344@huawei.com>
Date: Mon, 13 May 2024 22:10:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [bug report] WARNING: CPU: 0 PID: 49573 at kernel/sched/rt.c:802
 rq_offline_rt+0x24d/0x260
From: "zhaowenhui (A)" <zhaowenhui8@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, "open list:SCHEDULER"
	<linux-kernel@vger.kernel.org>
References: <47b4a790-9a27-2fc5-f2aa-f9981c6da015@huawei.com>
In-Reply-To: <47b4a790-9a27-2fc5-f2aa-f9981c6da015@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500022.china.huawei.com (7.185.36.162)



在 2024/4/7 22:06, zhaowenhui (A) 写道:

> More information:
> 1. RT_RUNTIME_SHARE is enabled.
> 2. We continuously create and remove cpu cgroups. We use cgexec to do 
> some tasks like "tree" or "ps" in these cgroups and the rt_runtime_us in 
> these cgroups are set to 2000~6000.
> 3. There are frequent cpu offline/online operations, so it will trigger 
> __disable_runtime.
> 
> Every time we run these operations after reboot, this warning will 
> happen easily.
> 

--------reproduce shell scripts----------
[1] on_off.sh
#!/bin/bash

let cpu_end=8

while true
do
         for i in `seq 0 $cpu_end`
         do
                 echo $i
                 let j=i+1
                 echo 0 > /sys/devices/system/cpu/cpu${i}/online
                 echo 0 > /sys/devices/system/cpu/cpu${j}/online
                 sleep 0.5
                 echo 1 > /sys/devices/system/cpu/cpu${i}/online
                 echo 1 > /sys/devices/system/cpu/cpu${j}/online
         done
done

[2] rt_test.sh
#!/bin/bsh
# set -x

name=test$$
cpu_dir=/sys/fs/cgroup/cpu/$name
mkdir $cpu_dir
echo $rt_runtime_us > $cpu_dir/cpu.rt_runtime_us  &>/dev/null

function cg_change_rt_runtime_us()
{
         while true
         do
                 let tmp=2+RANDOM%4
                 let quota=tmp*1000
                 echo $quota > $cpu_dir/cpu.rt_runtime_us
         done
}

function rt_test1()
{
         while true
         do
                 cgexec -g cpu:/${name} chrt 20 tree /sys/fs/cgroup/cpu 
&>/dev/null
         done
}

function rt_test2()
{
         while true
         do
                 cgexec -g cpu:/${name} chrt 30 ps aux  &>/dev/null
         done
}

rt_test1 &
rt_test2 &
cg_change_rt_runtime_us &> /dev/null &

[3] start_repro.sh
function set_env(){
     echo RT_RUNTIME_SHARE > /sys/kernel/debug/sched/features
     echo RT_RUNTIME_SHARE > /sys/kernel/debug/sched_features
}

function run_test(){
     for i in 0 1
     do
         nohup sh rt_test.sh &
         nohup sh rt_test.sh &
         nohup sh rt_test.sh &
         nohup sh rt_test.sh &
     done

     nohup sh on_off.sh &>/dev/null &

}
set_env
run_test

--------reproduce shell scripts----------

Running the start_repro.sh can easily reproduce this issue.
And when I debug in __disable_runtime, I found that the rtrq have
borrow some runtime, because rtrq->runtime is greater than 
rtb->rt_runtime, but its span has only one cpu which is itself.
[   43.686441] [__disable_runtime] begin, rq: ff3113087e5b4ec0 , cpu: 159
[   43.686449] [__disable_runtime] rtrq: ff3112c9e9259800 , 
rtrq->runtime :3037500
[   43.686450] [__disable_runtime] rtb->period: 1000000000 , 
rtb->rt_runtime: 3000000
[   43.686451] [__disable_runtime] want original : -37500
[   43.686451] [__disable_runtime] after get want, rtrq: 
ff3112c9e9259800 , rtrq->runtime :3037500
[   43.686453] [ERROR!] span have cpu: 159

Do you have any idea about this? 😄

---
Regards
Zhao Wenhui

