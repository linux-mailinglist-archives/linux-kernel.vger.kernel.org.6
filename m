Return-Path: <linux-kernel+bounces-333376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734597C792
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784491C275E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4519AD7D;
	Thu, 19 Sep 2024 09:50:30 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF891AAE33
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739427; cv=none; b=HQKgQ061QnZ5oOmW40RnU057izfEmWr7SFtdmAGhZWLpTCk2WYyt4+uPBdlXbOB0IBEGikGbHXpU7OfP6GSmRhjxp0oPj95P8Hiz8+0susSiDhlJwDBpqPpdn6kY3tcqP9sGgOVAeEk05OwML8VcyAH+oXq+rU7+TLEmN3ostAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739427; c=relaxed/simple;
	bh=Mg8uQq4Zcfkks1bgYD1rE0jquOyJco2dJmVtf9YhzPc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=TxcOf/gXDwxiymsornvx0sTC5gfUDfVS3Vt1fjjUCu8WIK+aNoHC/8OpE5ZpZLnNmBYCotI+ZyaZuxWyuEaEAtORtlDZtSTB6UFfXdc2i2V3+lHNn7fUJZX5QOsQaRcNNI69DPvjjeffHaseMJciP7vOuNQNJOHk4BVFcurzOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726739411-1eb14e31a81117c0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id zzp7jIoPGSNh0CNE (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 19 Sep 2024 17:50:11 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Sep
 2024 17:50:11 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Sep
 2024 17:50:10 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Thu, 19 Sep 2024 17:50:10 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from [10.29.8.43] (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Sep
 2024 17:41:16 +0800
Message-ID: <1d9b40ac-f5d8-4242-bb12-92b7a50a3d05@zhaoxin.com>
Date: Thu, 19 Sep 2024 17:41:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: yongli-os <yongli-oc@zhaoxin.com>
Subject: Re: [PATCH 4/4] locking/osq_lock: The numa-aware lock memory prepare,
 assign and cleanup.
To: Waiman Long <longman@redhat.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <will@kernel.org>, <boqun.feng@gmail.com>
X-ASG-Orig-Subj: Re: [PATCH 4/4] locking/osq_lock: The numa-aware lock memory prepare,
 assign and cleanup.
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240914085327.32912-5-yongli-oc@zhaoxin.com>
 <5045fb8b-4968-4b5a-9d9e-1def94308426@redhat.com>
Content-Language: en-US
In-Reply-To: <5045fb8b-4968-4b5a-9d9e-1def94308426@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/19/2024 5:50:09 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1726739411
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5841
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130665
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------


On 2024/9/15 01:21, Waiman Long wrote:
>
>
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>
> On 9/14/24 04:53, yongli-oc wrote:
>> The numa-aware lock kernel memory cache preparation, and a
>> workqueue to turn numa-aware lock back to osq lock.
>> The /proc interface. Enable dynamic switch by
>> echo 1 > /proc/zx_numa_lock/dynamic_enable
>>
>> Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
>> ---
>> =C2=A0 kernel/locking/zx_numa.c | 537 ++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 537 insertions(+)
>> =C2=A0 create mode 100644 kernel/locking/zx_numa.c
>>
>> diff --git a/kernel/locking/zx_numa.c b/kernel/locking/zx_numa.c
>> new file mode 100644
>> index 000000000000..89df6670a024
>> --- /dev/null
>> +++ b/kernel/locking/zx_numa.c
>> @@ -0,0 +1,537 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Dynamic numa-aware osq lock
>> + * Crossing from numa-aware lock to osq_lock
>> + * Numa lock memory initialize and /proc interface
>> + * Author: LiYong <yongli-oc@zhaoxin.com>
>> + *
>> + */
>> +#include <linux/cpumask.h>
>> +#include <asm/byteorder.h>
>> +#include <asm/kvm_para.h>
>> +#include <linux/percpu.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/osq_lock.h>
>> +#include <linux/module.h>
>> +#include <linux/proc_fs.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/reboot.h>
>> +
>> +#include "numa.h"
>> +#include "numa_osq.h"
>> +
>> +int enable_zx_numa_osq_lock;
>> +struct delayed_work zx_numa_start_work;
>> +struct delayed_work zx_numa_cleanup_work;
>> +
>> +atomic_t numa_count;
>> +struct _numa_buf *zx_numa_entry;
>> +int zx_numa_lock_total =3D 256;
>> +LIST_HEAD(_zx_numa_head);
>> +LIST_HEAD(_zx_numa_lock_head);
>> +
>> +struct kmem_cache *zx_numa_entry_cachep;
>> +struct kmem_cache *zx_numa_lock_cachep;
>> +int NUMASHIFT;
>> +int NUMACLUSTERS;
>> +static atomic_t lockindex;
>> +int dynamic_enable;
>> +
>> +static const struct numa_cpu_info numa_cpu_list[] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*feature1=3D1, a numa node includes two clust=
ers*/
>> +=C2=A0=C2=A0=C2=A0=C2=A0 //{1, 23, X86_VENDOR_AMD, 0, 1},
>> +=C2=A0=C2=A0=C2=A0=C2=A0 {0x5b, 7, X86_VENDOR_CENTAUR, 0, 1},
>> +=C2=A0=C2=A0=C2=A0=C2=A0 {0x5b, 7, X86_VENDOR_ZHAOXIN, 0, 1}
>> +};
>
> Why are this zx_*() code specifically for ZhaoXin and Centaur family of
> CPUs? Are there some special hardware features that are specific to
> these CPUs?

> Zhaoxin cpu is a x86 architecture processor. The processor has no any

special hardware features about the dynamic numa-aware lock patch.

But since different processor always has different=C2=A0 NUMA architecture

features,=C2=A0 I listed Zhaoxin CPU only.

When I tested the patch, I found the AMD EPYC 7551 is something like

 =C2=A0the Zhaoxin CPU. Both one node has=C2=A0 two clusters,=C2=A0 unlock =
processes

 =C2=A0in one cluster is much faster than unlock them in NUMA node.

I am not sure if it is fit for AMD CPU or not. so I comment the code for

the AMD CPU.

BTW, your patch series lacks performance data to justify the addition of

> quite a lot of complexity to the core locking code. We are unlikely to
> take this without sufficient justification.
>
In the cover letter,=C2=A0 these is performance test result for AMD EPYC 75=
51 and

Zhaoxin KH40000. I listed the perf epoll, locktorture mutex, unixbench=20
and fxmark.

What test do you think is important for the Lock performance?

I will do more test in next submission.


> Another question that I have is that the base osq_lock() can coexist
> with your xz_osq_lock(). A cpu can dynamically switch from using
> osq_lock() to xz_osq_lock() and vice versa. What happens if some CPUs
> use osq_lock() while others use xz_osq_lock()? Will that cause a
> problem? Have you fully test this scenario to make sure that nothing
> breaks?
> Cheers,
> Longman=20

The x_osq_lock uses a 16 bits tail,=C2=A0 the program is the nearly the sam=
e as

osq_lock before turning to numa-aware lock. By my opinion, from Intel

instruction set,=C2=A0 the atomic_xchg 32bits and cmpxchg 16 bits, both hav=
e

LOCK prefix,=C2=A0 the cacheline for tail are all accessed exclusively.


After dynamic switch enable,=C2=A0 some processes will enter the

x_osq_lock/x_osq_unlock,=C2=A0 if these processes meet queue tail, it will

atomic set the numa_enable to OSQTONUMADETECT. If some processes

are still in osq_lock, the numa_enable will be cleaned by atomic_xchg and

old &=3D 0xffff;=C2=A0 it will be set again when x_osq_unlock meets queue t=
ail

next time.

After the numa_enable is set to OSQTONUMADETECT, the x_osq_unlock

will start to record contention depth(the serial in queue tail 's

optimistic_spin_node minus it in current unlocked CPU's node). If the depth

is more than osq_lock_depth, it will start increase the locked variable

in struct optimistic_spin_node.=C2=A0 After the locked variable is more tha=
n

osq_keep_times, it starts to turn to numa-aware lock.

If some processes in osq_lock/osq_unlock, the locked variable is

always set to 1.

So when set numa_enable to OSQLOCKSTOPPING, start switching to numa-aware

lock, so many lock()/unlock() are finished, all the processes should=20
read the

enable_zx_numa_osq_lock as 2, to execute the x_osq_lock().

Consider unnecessarily to enable/disable dynamic switch frequently,

I did not add stopping protection here.


I prefer to use x_osq_lock to replace the osq_lock when

CONFIG_LOCK_SPIN_ON_OWNER_NUMA=3Dy.

As I know,=C2=A0 in x86_64,=C2=A0 with __LOCK prefix,=C2=A0=C2=A0 the perfo=
rmance of 32 bits=20
operand

is nearly the same as its of 16 bits operand.=C2=A0 From the test result in=
=20
cover letter,

one or two processes, the performance difference is very little. I do=20
not know if it

 =C2=A0is the same for other platform?

Best regards.

Li Yong


>

