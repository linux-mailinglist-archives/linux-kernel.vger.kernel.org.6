Return-Path: <linux-kernel+bounces-293167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE62957B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D95C1C23451
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135F73D3B3;
	Tue, 20 Aug 2024 02:42:16 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D29DDA6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121735; cv=none; b=O+fG2qV68RHZEJTLROHrvWTsgDyfMPudxVL8dZXfW5EdvTMi8RreFdE7uJKschNWMkcq+o/ixhy2RRiog4bV9eMAh8EDaEDaWBzPYkpr21BJUttF73LP2u7C94gDShAfvnePhutExHw7B31xP3tsEOnEcV88uhWSuGLtsEysrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121735; c=relaxed/simple;
	bh=lEG2Ze+wSXd5onXixxVibMXfauGoTixD//TQtTVyirA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Co96wUcY0ZexQQAZDGcBDdgkRmFWZasYdYkAZuwBGpASZZGbMGngacXbhog0/t0v485MhfYZDoZ38KJ76pgnN8L+780fQfvQ4gkZzmpCIUGfi2QqTRBu93BQNVhOvI5lp3vtZpneWX7IEJ0BYsVWk5td65hdmjMR+b/HZz2hxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WntyM3TpRz13cKH;
	Tue, 20 Aug 2024 10:41:31 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FF571402E0;
	Tue, 20 Aug 2024 10:42:05 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Aug 2024 10:42:04 +0800
Message-ID: <44c60279-82d8-3519-8f83-7e2c834a018d@huawei.com>
Date: Tue, 20 Aug 2024 10:42:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] RISC-V: Implement kgdb_roundup_cpus() to enable future
 NMI Roundup
Content-Language: en-US
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<samuel.holland@sifive.com>, <conor.dooley@microchip.com>,
	<takakura@valinux.co.jp>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
References: <20240727063438.886155-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240727063438.886155-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Ping.

On 2024/7/27 14:34, Jinjie Ruan wrote:
> Until now, the generic weak kgdb_roundup_cpus() has been used for kgdb on
> RISCV. A custom one allows to debug CPUs that are stuck with interrupts
> disabled with NMI support in the future. And using an IPI is better than
> the generic one since it avoids the potential situation described in the
> generic kgdb_call_nmi_hook(). As Andrew pointed out, once there is NMI
> support, we can easily extend this and the CPU backtrace support
> to use NMIs.
> 
> After this patch, the kgdb test show that:
> 	# echo g > /proc/sysrq-trigger
> 	[2]kdb> btc
> 	btc: cpu status: Currently on cpu 2
> 	Available cpus: 0-1(-), 2, 3(-)
> 	Stack traceback for pid 0
> 	0xffffffff81c13a40        0        0  1    0   -  0xffffffff81c14510  swapper/0
> 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-g3120273055b6-dirty #51
> 	Hardware name: riscv-virtio,qemu (DT)
> 	Call Trace:
> 	[<ffffffff80006c48>] dump_backtrace+0x28/0x30
> 	[<ffffffff80fceb38>] show_stack+0x38/0x44
> 	[<ffffffff80fe6a04>] dump_stack_lvl+0x58/0x7a
> 	[<ffffffff80fe6a3e>] dump_stack+0x18/0x20
> 	[<ffffffff801143fa>] kgdb_cpu_enter+0x682/0x6b2
> 	[<ffffffff801144ca>] kgdb_nmicallback+0xa0/0xac
> 	[<ffffffff8000a392>] handle_IPI+0x9c/0x120
> 	[<ffffffff800a2baa>] handle_percpu_devid_irq+0xa4/0x1e4
> 	[<ffffffff8009cca8>] generic_handle_domain_irq+0x28/0x36
> 	[<ffffffff800a9e5c>] ipi_mux_process+0xe8/0x110
> 	[<ffffffff806e1e30>] imsic_handle_irq+0xf8/0x13a
> 	[<ffffffff8009cca8>] generic_handle_domain_irq+0x28/0x36
> 	[<ffffffff806dff12>] riscv_intc_aia_irq+0x2e/0x40
> 	[<ffffffff80fe6ab0>] handle_riscv_irq+0x54/0x86
> 	[<ffffffff80ff2e4a>] call_on_irq_stack+0x32/0x40
> 
> Rebased on Ryo Takakura's "RISC-V: Enable IPI CPU Backtrace" patch.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
> v2:
> - Update the commit title and message.
> - Add Reviewed-by.
> ---
>  arch/riscv/kernel/smp.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 9b047899791c..c180a647a30e 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/kexec.h>
> +#include <linux/kgdb.h>
>  #include <linux/percpu.h>
>  #include <linux/profile.h>
>  #include <linux/smp.h>
> @@ -35,6 +36,7 @@ enum ipi_message_type {
>  	IPI_IRQ_WORK,
>  	IPI_TIMER,
>  	IPI_CPU_BACKTRACE,
> +	IPI_KGDB_ROUNDUP,
>  	IPI_MAX
>  };
>  
> @@ -115,6 +117,7 @@ void arch_irq_work_raise(void)
>  
>  static irqreturn_t handle_IPI(int irq, void *data)
>  {
> +	unsigned int cpu = smp_processor_id();
>  	int ipi = irq - ipi_virq_base;
>  
>  	switch (ipi) {
> @@ -128,7 +131,7 @@ static irqreturn_t handle_IPI(int irq, void *data)
>  		ipi_stop();
>  		break;
>  	case IPI_CPU_CRASH_STOP:
> -		ipi_cpu_crash_stop(smp_processor_id(), get_irq_regs());
> +		ipi_cpu_crash_stop(cpu, get_irq_regs());
>  		break;
>  	case IPI_IRQ_WORK:
>  		irq_work_run();
> @@ -141,8 +144,11 @@ static irqreturn_t handle_IPI(int irq, void *data)
>  	case IPI_CPU_BACKTRACE:
>  		nmi_cpu_backtrace(get_irq_regs());
>  		break;
> +	case IPI_KGDB_ROUNDUP:
> +		kgdb_nmicallback(cpu, get_irq_regs());
> +		break;
>  	default:
> -		pr_warn("CPU%d: unhandled IPI%d\n", smp_processor_id(), ipi);
> +		pr_warn("CPU%d: unhandled IPI%d\n", cpu, ipi);
>  		break;
>  	}
>  
> @@ -209,6 +215,7 @@ static const char * const ipi_names[] = {
>  	[IPI_IRQ_WORK]		= "IRQ work interrupts",
>  	[IPI_TIMER]		= "Timer broadcast interrupts",
>  	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
> +	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
>  };
>  
>  void show_ipi_stats(struct seq_file *p, int prec)
> @@ -339,3 +346,19 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
>  {
>  	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, riscv_backtrace_ipi);
>  }
> +
> +#ifdef CONFIG_KGDB
> +void kgdb_roundup_cpus(void)
> +{
> +	int this_cpu = raw_smp_processor_id();
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		/* No need to roundup ourselves */
> +		if (cpu == this_cpu)
> +			continue;
> +
> +		send_ipi_single(cpu, IPI_KGDB_ROUNDUP);
> +	}
> +}
> +#endif

