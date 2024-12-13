Return-Path: <linux-kernel+bounces-444279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA809F03F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB28169B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55F917B421;
	Fri, 13 Dec 2024 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VfHMTejS"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3B291E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734066232; cv=none; b=Lm7E+khi8XgiXAovNE+Z0HBuzc54bAEX32uRqsetnFxtx8+ajoL7VjXI3fD/sI/ClRMDzhH2qPgCnD260PZXib3eUXI8nSAvZl7/k7/aZckkW1e6U/xS1HGQMFwf+mUXIKb7dEhKrImpjcdZBiS4GkNYa6b2hiovo68Tg0QmqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734066232; c=relaxed/simple;
	bh=uQU3tHoiktQ/YLtkYKDMPNK3vCkIrwr/k6Pf7xwpMbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/ZMS05bQXP5YAU1hUHxFQTK8bK+9xaB1cT+vWxoU7aMlSSnqAg2GMIYY2Ap8xw6gI78B0LrUwpYrxpjmdjaKLgbq82vrw4v0amzKebnWNAIUqzt7+YSXopqhAUaP9L9+B9B2nnaZ+GyWRCLPEmmT+bkn1QnIagRgaLh8XubjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VfHMTejS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728e3826211so1152519b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734066229; x=1734671029; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NXNevEN0n9qVncZh5Qf4Le7HtbaM6bdBPRxi3/t0UF4=;
        b=VfHMTejSaslkKodPyTjvomYF5fPGlmkYFQZNQNLFRgXHmbTkVcN9fPEfKwvXaYGcQI
         qKOqRyWy0PxHXaiwbjuSoqqvHUjCz/OUIZKTqistvzpuZ7R+2H6VNzDDfKkD1L9ib7ZZ
         DDM8mXuR1EsYd3FQefzilcxkGQZVVZ3V2VUU3BWgYidf9z8DxfpPGcFScVdmQZXSkSkd
         xa8KOCT3A2cbfB+srW9ecfvr+v2rYI1zG8I7FHupW6CT+26el91Ua4WqufpOWPgSQHU9
         cauqtmYmQsPipJ3QE0es1Q32MUVlNNfE8XXKEJyW/UhKFmPOqbTod+HMyG9cGgWkmKfk
         uekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734066229; x=1734671029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXNevEN0n9qVncZh5Qf4Le7HtbaM6bdBPRxi3/t0UF4=;
        b=AQqHmb0fq4HPgjJaKzxlCno4NBIkdqs2eoh+MOJ/6PGxJek2giP6n2WgpX2F/PZUIu
         1FZkV7uU+DdfAecBsjmhyr4FHm7osDSqKJAj7dHI9NFHiq5dfh4Adnk579VcXUbDrqpB
         4zT4KCkgPZszIIjgPnU1i66m2CvuPvwp3/H5jQCOtwMFmtHclJSk7Yyj5LBsQlDm2xBm
         UhVFsgAcU+6Lro5jJQIIsQS9z8HkGpTyGnXhCLmnwSZkqIFtyS7Ql7eQwLzwxqFVxEJc
         Yswmv5XUKCx8+isCMt6PupW8b84wSRfhLBHUjHpI1slO1ZbG05IIMa+bt6AjJ5REChdG
         VUNA==
X-Forwarded-Encrypted: i=1; AJvYcCV/8D9rylNtp6k/85H3bIYFABqpVKhMdEoqHmzYvKjeZZgJL8LySg+1oSUhtx6Xlari8OJxFdREL0fH5dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZuYOvlBP+LF2wNAlNDb0YC6Gr5xfLLexFebddPeg8sontTxn
	eEcotjLqhHvFv32IqQGIH1Q42xnuqoQIWY9Ztu5za9qqoj1wWjGm1jzZvegUnkQ=
X-Gm-Gg: ASbGncv7PBzNYiRGya2LNfuYwOW6lV2/1KP/7TcqujUSzwvztzsvDYwRwzWFrgwaI40
	rXIT1SmzVoOIyYbdCw99hEBXHjSUEL8VWors+uGZPTszOrIlYn09Xcl9PSRlGiyeAGWyxjVayL8
	1PuG8DpYh5pR8TR44UHNUdEHQL0X83iZv6ZoShiElwyymczwV7dp7QzV6UAKaiy1I72kQ/P2QwZ
	PJxDd8SNYqrntlkk56yFWUICLM9xcboYNqEqjs5Kgl/Ssj1dc+txnE=
X-Google-Smtp-Source: AGHT+IE2uIF/uxgtYtuLqbH276nU5dfIbzVoT0gqYVwEFkKaRaQqe1w7myZtuVqmqyjoTvwzoz9YyQ==
X-Received: by 2002:a05:6a20:6a03:b0:1e0:d867:c880 with SMTP id adf61e73a8af0-1e1dfe3eb61mr1781927637.42.1734066229289;
        Thu, 12 Dec 2024 21:03:49 -0800 (PST)
Received: from ventana ([49.37.251.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725c9ec7217sm11162179b3a.60.2024.12.12.21.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 21:03:48 -0800 (PST)
Date: Fri, 13 Dec 2024 10:33:43 +0530
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Anup Patel <apatel@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>,
	Atish Patra <atishp@atishpatra.org>
Subject: Re: [PATCH v3 3/4] drivers: firmware: add riscv SSE support
Message-ID: <Z1vALzeks+6Fkf9/@ventana>
References: <20241206163102.843505-1-cleger@rivosinc.com>
 <20241206163102.843505-4-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206163102.843505-4-cleger@rivosinc.com>

Hi Clement,

On Fri, Dec 06, 2024 at 05:30:59PM +0100, Clément Léger wrote:
> Add driver level interface to use RISC-V SSE arch support. This interface
> allows registering SSE handlers, and receive them. This will be used by
> PMU and GHES driver.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> Co-developed-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  MAINTAINERS                        |  14 +
>  drivers/firmware/Kconfig           |   1 +
>  drivers/firmware/Makefile          |   1 +
>  drivers/firmware/riscv/Kconfig     |  15 +
>  drivers/firmware/riscv/Makefile    |   3 +
>  drivers/firmware/riscv/riscv_sse.c | 691 +++++++++++++++++++++++++++++
>  include/linux/riscv_sse.h          |  56 +++
>  7 files changed, 781 insertions(+)
>  create mode 100644 drivers/firmware/riscv/Kconfig
>  create mode 100644 drivers/firmware/riscv/Makefile
>  create mode 100644 drivers/firmware/riscv/riscv_sse.c
>  create mode 100644 include/linux/riscv_sse.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 686109008d8e..a3ddde7fe9fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20125,6 +20125,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>  F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>  F:	drivers/iommu/riscv/
>  
> +RISC-V FIRMWARE DRIVERS
> +M:	Conor Dooley <conor@kernel.org>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git
> +F:	drivers/firmware/riscv/*
> +
>  RISC-V MICROCHIP FPGA SUPPORT
>  M:	Conor Dooley <conor.dooley@microchip.com>
>  M:	Daire McNamara <daire.mcnamara@microchip.com>
> @@ -20177,6 +20184,13 @@ F:	drivers/perf/riscv_pmu.c
>  F:	drivers/perf/riscv_pmu_legacy.c
>  F:	drivers/perf/riscv_pmu_sbi.c
>  
> +RISC-V SSE DRIVER
> +M:	Clément Léger <cleger@rivosinc.com>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	drivers/firmware/riscv/riscv_sse.c
> +F:	include/linux/riscv_sse.h
> +

I request you to add me as a reviewer to these SSE files.
Himanshu Chauhan <himanshu@thechauhan.dev>

Thanks
Regards
Himanshu

>  RISC-V THEAD SoC SUPPORT
>  M:	Drew Fustini <drew@pdp7.com>
>  M:	Guo Ren <guoren@kernel.org>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 71d8b26c4103..9e996a1fd511 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -267,6 +267,7 @@ source "drivers/firmware/meson/Kconfig"
>  source "drivers/firmware/microchip/Kconfig"
>  source "drivers/firmware/psci/Kconfig"
>  source "drivers/firmware/qcom/Kconfig"
> +source "drivers/firmware/riscv/Kconfig"
>  source "drivers/firmware/smccc/Kconfig"
>  source "drivers/firmware/tegra/Kconfig"
>  source "drivers/firmware/xilinx/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 7a8d486e718f..c0f5009949a8 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -33,6 +33,7 @@ obj-y				+= efi/
>  obj-y				+= imx/
>  obj-y				+= psci/
>  obj-y				+= qcom/
> +obj-y				+= riscv/
>  obj-y				+= smccc/
>  obj-y				+= tegra/
>  obj-y				+= xilinx/
> diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kconfig
> new file mode 100644
> index 000000000000..8056ed3262d9
> --- /dev/null
> +++ b/drivers/firmware/riscv/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "Risc-V Specific firmware drivers"
> +depends on RISCV
> +
> +config RISCV_SSE
> +	bool "Enable SBI Supervisor Software Events support"
> +	depends on RISCV_SBI
> +	default y
> +	help
> +	  The Supervisor Software Events support allow the SBI to deliver
> +	  NMI-like notifications to the supervisor mode software. When enable,
> +	  this option provides support to register callbacks on specific SSE
> +	  events.
> +
> +endmenu
> diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Makefile
> new file mode 100644
> index 000000000000..4ccfcbbc28ea
> --- /dev/null
> +++ b/drivers/firmware/riscv/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_RISCV_SSE)		+= riscv_sse.o
> diff --git a/drivers/firmware/riscv/riscv_sse.c b/drivers/firmware/riscv/riscv_sse.c
> new file mode 100644
> index 000000000000..c165e32cc9a5
> --- /dev/null
> +++ b/drivers/firmware/riscv/riscv_sse.c
> @@ -0,0 +1,691 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#define pr_fmt(fmt) "sse: " fmt
> +
> +#include <linux/cpu.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/hardirq.h>
> +#include <linux/list.h>
> +#include <linux/percpu-defs.h>
> +#include <linux/reboot.h>
> +#include <linux/riscv_sse.h>
> +#include <linux/slab.h>
> +
> +#include <asm/sbi.h>
> +#include <asm/sse.h>
> +
> +struct sse_event {
> +	struct list_head list;
> +	u32 evt;
> +	u32 priority;
> +	sse_event_handler *handler;
> +	void *handler_arg;
> +	bool is_enabled;
> +	/* Only valid for global events */
> +	unsigned int cpu;
> +
> +	union {
> +		struct sse_registered_event *global;
> +		struct sse_registered_event __percpu *local;
> +	};
> +};
> +
> +static int sse_hp_state;
> +static bool sse_available;
> +static DEFINE_SPINLOCK(events_list_lock);
> +static LIST_HEAD(events);
> +static DEFINE_MUTEX(sse_mutex);
> +
> +struct sse_registered_event {
> +	struct sse_event_arch_data arch;
> +	struct sse_event *evt;
> +	unsigned long attr_buf;
> +};
> +
> +void sse_handle_event(struct sse_event_arch_data *arch_event,
> +		      struct pt_regs *regs)
> +{
> +	int ret;
> +	struct sse_registered_event *reg_evt =
> +		container_of(arch_event, struct sse_registered_event, arch);
> +	struct sse_event *evt = reg_evt->evt;
> +
> +	ret = evt->handler(evt->evt, evt->handler_arg, regs);
> +	if (ret)
> +		pr_warn("event %x handler failed with error %d\n", evt->evt,
> +			ret);
> +}
> +
> +static bool sse_event_is_global(u32 evt)
> +{
> +	return !!(evt & SBI_SSE_EVENT_GLOBAL);
> +}
> +
> +static
> +struct sse_event *sse_event_get(u32 evt)
> +{
> +	struct sse_event *sse_evt = NULL, *tmp;
> +
> +	scoped_guard(spinlock, &events_list_lock) {
> +		list_for_each_entry(tmp, &events, list) {
> +			if (tmp->evt == evt) {
> +				return sse_evt;
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static phys_addr_t sse_event_get_phys(struct sse_registered_event *reg_evt,
> +				      void *addr)
> +{
> +	phys_addr_t phys;
> +
> +	if (sse_event_is_global(reg_evt->evt->evt))
> +		phys = virt_to_phys(addr);
> +	else
> +		phys = per_cpu_ptr_to_phys(addr);
> +
> +	return phys;
> +}
> +
> +static int sse_sbi_event_func(struct sse_event *event, unsigned long func)
> +{
> +	struct sbiret ret;
> +	u32 evt = event->evt;
> +
> +	ret = sbi_ecall(SBI_EXT_SSE, func, evt, 0, 0, 0, 0, 0);
> +	if (ret.error)
> +		pr_debug("Failed to execute func %lx, event %x, error %ld\n",
> +			 func, evt, ret.error);
> +
> +	return sbi_err_map_linux_errno(ret.error);
> +}
> +
> +static int sse_sbi_disable_event(struct sse_event *event)
> +{
> +	return sse_sbi_event_func(event, SBI_SSE_EVENT_DISABLE);
> +}
> +
> +static int sse_sbi_enable_event(struct sse_event *event)
> +{
> +	return sse_sbi_event_func(event, SBI_SSE_EVENT_ENABLE);
> +}
> +
> +static int sse_event_attr_get_no_lock(struct sse_registered_event *reg_evt,
> +				      unsigned long attr_id, unsigned long *val)
> +{
> +	struct sbiret sret;
> +	u32 evt = reg_evt->evt->evt;
> +	unsigned long phys;
> +
> +	phys = sse_event_get_phys(reg_evt, &reg_evt->attr_buf);
> +
> +	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt,
> +				     attr_id, 1, phys, 0, 0);
> +	if (sret.error) {
> +		pr_debug("Failed to get event %x attr %lx, error %ld\n", evt,
> +			 attr_id, sret.error);
> +		return sbi_err_map_linux_errno(sret.error);
> +	}
> +
> +	*val = reg_evt->attr_buf;
> +
> +	return 0;
> +}
> +
> +static int sse_event_attr_set_nolock(struct sse_registered_event *reg_evt,
> +				     unsigned long attr_id, unsigned long val)
> +{
> +	struct sbiret sret;
> +	u32 evt = reg_evt->evt->evt;
> +	unsigned long phys;
> +
> +	reg_evt->attr_buf = val;
> +	phys = sse_event_get_phys(reg_evt, &reg_evt->attr_buf);
> +
> +	sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE, evt,
> +				     attr_id, 1, phys, 0, 0);
> +	if (sret.error && sret.error != SBI_ERR_INVALID_STATE) {
> +		pr_debug("Failed to set event %x attr %lx, error %ld\n", evt,
> +			 attr_id, sret.error);
> +		return sbi_err_map_linux_errno(sret.error);
> +	}
> +
> +	return 0;
> +}
> +
> +static int sse_event_set_target_cpu_nolock(struct sse_event *event,
> +					   unsigned int cpu)
> +{
> +	unsigned int hart_id = cpuid_to_hartid_map(cpu);
> +	struct sse_registered_event *reg_evt = event->global;
> +	u32 evt = event->evt;
> +	bool was_enabled;
> +	int ret;
> +
> +	if (!sse_event_is_global(evt))
> +		return -EINVAL;
> +
> +	was_enabled = event->is_enabled;
> +	if (was_enabled)
> +		sse_sbi_disable_event(event);
> +	do {
> +		ret = sse_event_attr_set_nolock(reg_evt,
> +						SBI_SSE_ATTR_PREFERRED_HART,
> +						hart_id);
> +	} while (ret == -EINVAL);
> +
> +	if (ret == 0)
> +		event->cpu = cpu;
> +
> +	if (was_enabled)
> +		sse_sbi_enable_event(event);
> +
> +	return 0;
> +}
> +
> +int sse_event_set_target_cpu(struct sse_event *event, unsigned int cpu)
> +{
> +	int ret;
> +
> +	scoped_guard(mutex, &sse_mutex) {
> +		cpus_read_lock();
> +
> +		if (!cpu_online(cpu))
> +			return -EINVAL;
> +
> +		ret = sse_event_set_target_cpu_nolock(event, cpu);
> +
> +		cpus_read_unlock();
> +	}
> +
> +	return ret;
> +}
> +
> +static int sse_event_init_registered(unsigned int cpu,
> +				     struct sse_registered_event *reg_evt,
> +				     struct sse_event *event)
> +{
> +	reg_evt->evt = event;
> +	arch_sse_init_event(&reg_evt->arch, event->evt, cpu);
> +
> +	return 0;
> +}
> +
> +static void sse_event_free_registered(struct sse_registered_event *reg_evt)
> +{
> +	arch_sse_free_event(&reg_evt->arch);
> +}
> +
> +static int sse_event_alloc_global(struct sse_event *event)
> +{
> +	int err;
> +	struct sse_registered_event *reg_evt;
> +
> +	reg_evt = kzalloc(sizeof(*reg_evt), GFP_KERNEL);
> +	if (!reg_evt)
> +		return -ENOMEM;
> +
> +	event->global = reg_evt;
> +	err = sse_event_init_registered(smp_processor_id(), reg_evt,
> +					event);
> +	if (err)
> +		kfree(reg_evt);
> +
> +	return err;
> +}
> +
> +static int sse_event_alloc_local(struct sse_event *event)
> +{
> +	int err;
> +	unsigned int cpu, err_cpu;
> +	struct sse_registered_event *reg_evt;
> +	struct sse_registered_event __percpu *reg_evts;
> +
> +	reg_evts = alloc_percpu(struct sse_registered_event);
> +	if (!reg_evts)
> +		return -ENOMEM;
> +
> +	event->local = reg_evts;
> +
> +	for_each_possible_cpu(cpu) {
> +		reg_evt = per_cpu_ptr(reg_evts, cpu);
> +		err = sse_event_init_registered(cpu, reg_evt, event);
> +		if (err) {
> +			err_cpu = cpu;
> +			goto err_free_per_cpu;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_free_per_cpu:
> +	for_each_possible_cpu(cpu) {
> +		if (cpu == err_cpu)
> +			break;
> +		reg_evt = per_cpu_ptr(reg_evts, cpu);
> +		sse_event_free_registered(reg_evt);
> +	}
> +
> +	free_percpu(reg_evts);
> +
> +	return err;
> +}
> +
> +static struct sse_event *sse_event_alloc(u32 evt,
> +					 u32 priority,
> +					 sse_event_handler *handler, void *arg)
> +{
> +	int err;
> +	struct sse_event *event;
> +
> +	event = kzalloc(sizeof(*event), GFP_KERNEL);
> +	if (!event)
> +		return ERR_PTR(-ENOMEM);
> +
> +	event->evt = evt;
> +	event->priority = priority;
> +	event->handler_arg = arg;
> +	event->handler = handler;
> +
> +	if (sse_event_is_global(evt)) {
> +		err = sse_event_alloc_global(event);
> +		if (err)
> +			goto err_alloc_reg_evt;
> +	} else {
> +		err = sse_event_alloc_local(event);
> +		if (err)
> +			goto err_alloc_reg_evt;
> +	}
> +
> +	return event;
> +
> +err_alloc_reg_evt:
> +	kfree(event);
> +
> +	return ERR_PTR(err);
> +}
> +
> +static int sse_sbi_register_event(struct sse_event *event,
> +				  struct sse_registered_event *reg_evt)
> +{
> +	int ret;
> +
> +	ret = sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PRIO,
> +					event->priority);
> +	if (ret)
> +		return ret;
> +
> +	return arch_sse_register_event(&reg_evt->arch);
> +}
> +
> +static int sse_event_register_local(struct sse_event *event)
> +{
> +	int ret;
> +	struct sse_registered_event *reg_evt = per_cpu_ptr(event->local,
> +							   smp_processor_id());
> +
> +	ret = sse_sbi_register_event(event, reg_evt);
> +	if (ret)
> +		pr_debug("Failed to register event %x: err %d\n", event->evt,
> +			 ret);
> +
> +	return ret;
> +}
> +
> +
> +static int sse_sbi_unregister_event(struct sse_event *event)
> +{
> +	return sse_sbi_event_func(event, SBI_SSE_EVENT_UNREGISTER);
> +}
> +
> +struct sse_per_cpu_evt {
> +	struct sse_event *event;
> +	unsigned long func;
> +	atomic_t error;
> +};
> +
> +static void sse_event_per_cpu_func(void *info)
> +{
> +	int ret;
> +	struct sse_per_cpu_evt *cpu_evt = info;
> +
> +	if (cpu_evt->func == SBI_SSE_EVENT_REGISTER)
> +		ret = sse_event_register_local(cpu_evt->event);
> +	else
> +		ret = sse_sbi_event_func(cpu_evt->event, cpu_evt->func);
> +
> +	if (ret)
> +		atomic_set(&cpu_evt->error, ret);
> +}
> +
> +static void sse_event_free(struct sse_event *event)
> +{
> +	unsigned int cpu;
> +	struct sse_registered_event *reg_evt;
> +
> +	if (sse_event_is_global(event->evt)) {
> +		sse_event_free_registered(event->global);
> +		kfree(event->global);
> +	} else {
> +		for_each_possible_cpu(cpu) {
> +			reg_evt = per_cpu_ptr(event->local, cpu);
> +			sse_event_free_registered(reg_evt);
> +		}
> +		free_percpu(event->local);
> +	}
> +
> +	kfree(event);
> +}
> +
> +int sse_event_enable(struct sse_event *event)
> +{
> +	int ret = 0;
> +	struct sse_per_cpu_evt cpu_evt;
> +
> +	scoped_guard(mutex, &sse_mutex) {
> +		cpus_read_lock();
> +		if (sse_event_is_global(event->evt)) {
> +			ret = sse_sbi_enable_event(event);
> +		} else {
> +			cpu_evt.event = event;
> +			atomic_set(&cpu_evt.error, 0);
> +			cpu_evt.func = SBI_SSE_EVENT_ENABLE;
> +			on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
> +			ret = atomic_read(&cpu_evt.error);
> +			if (ret) {
> +				cpu_evt.func = SBI_SSE_EVENT_DISABLE;
> +				on_each_cpu(sse_event_per_cpu_func, &cpu_evt,
> +					    1);
> +			}
> +		}
> +		cpus_read_unlock();
> +
> +		if (ret == 0)
> +			event->is_enabled = true;
> +	}
> +
> +	return ret;
> +}
> +
> +static void sse_events_mask(void)
> +{
> +	sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_HART_MASK, 0, 0, 0, 0, 0, 0);
> +}
> +
> +static void sse_events_unmask(void)
> +{
> +	sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_HART_UNMASK, 0, 0, 0, 0, 0, 0);
> +}
> +
> +static void sse_event_disable_nolock(struct sse_event *event)
> +{
> +	struct sse_per_cpu_evt cpu_evt;
> +
> +	if (sse_event_is_global(event->evt)) {
> +		sse_sbi_disable_event(event);
> +	} else {
> +		cpu_evt.event = event;
> +		cpu_evt.func = SBI_SSE_EVENT_DISABLE;
> +		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
> +	}
> +}
> +
> +void sse_event_disable(struct sse_event *event)
> +{
> +	scoped_guard(mutex, &sse_mutex) {
> +		cpus_read_lock();
> +		sse_event_disable_nolock(event);
> +		event->is_enabled = false;
> +		cpus_read_unlock();
> +	}
> +}
> +
> +struct sse_event *sse_event_register(u32 evt, u32 priority,
> +				     sse_event_handler *handler, void *arg)
> +{
> +	struct sse_per_cpu_evt cpu_evt;
> +	struct sse_event *event;
> +	int ret = 0;
> +
> +	if (!sse_available)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	mutex_lock(&sse_mutex);
> +	if (sse_event_get(evt)) {
> +		pr_debug("Event %x already registered\n", evt);
> +		ret = -EEXIST;
> +		goto out_unlock;
> +	}
> +
> +	event = sse_event_alloc(evt, priority, handler, arg);
> +	if (IS_ERR(event)) {
> +		ret = PTR_ERR(event);
> +		goto out_unlock;
> +	}
> +
> +	cpus_read_lock();
> +	if (sse_event_is_global(evt)) {
> +		unsigned long preferred_hart;
> +
> +		ret = sse_event_attr_get_no_lock(event->global,
> +						 SBI_SSE_ATTR_PREFERRED_HART,
> +						 &preferred_hart);
> +		if (ret)
> +			goto err_event_free;
> +		event->cpu = riscv_hartid_to_cpuid(preferred_hart);
> +
> +		ret = sse_sbi_register_event(event, event->global);
> +		if (ret)
> +			goto err_event_free;
> +
> +	} else {
> +		cpu_evt.event = event;
> +		atomic_set(&cpu_evt.error, 0);
> +		cpu_evt.func = SBI_SSE_EVENT_REGISTER;
> +		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
> +		ret = atomic_read(&cpu_evt.error);
> +		if (ret) {
> +			cpu_evt.func = SBI_SSE_EVENT_UNREGISTER;
> +			on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
> +			goto err_event_free;
> +		}
> +	}
> +	cpus_read_unlock();
> +
> +	scoped_guard(spinlock, &events_list_lock)
> +		list_add(&event->list, &events);
> +
> +	mutex_unlock(&sse_mutex);
> +
> +	return event;
> +
> +err_event_free:
> +	cpus_read_unlock();
> +	sse_event_free(event);
> +out_unlock:
> +	mutex_unlock(&sse_mutex);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +static void sse_event_unregister_nolock(struct sse_event *event)
> +{
> +	struct sse_per_cpu_evt cpu_evt;
> +
> +	if (sse_event_is_global(event->evt)) {
> +		sse_sbi_unregister_event(event);
> +	} else {
> +		cpu_evt.event = event;
> +		cpu_evt.func = SBI_SSE_EVENT_UNREGISTER;
> +		on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
> +	}
> +}
> +
> +void sse_event_unregister(struct sse_event *event)
> +{
> +	scoped_guard(mutex, &sse_mutex) {
> +		cpus_read_lock();
> +		sse_event_unregister_nolock(event);
> +		cpus_read_unlock();
> +
> +		scoped_guard(spinlock, &events_list_lock)
> +			list_del(&event->list);
> +
> +		sse_event_free(event);
> +	}
> +}
> +
> +static int sse_cpu_online(unsigned int cpu)
> +{
> +	struct sse_event *sse_evt;
> +
> +	scoped_guard(spinlock, &events_list_lock) {
> +		list_for_each_entry(sse_evt, &events, list) {
> +			if (sse_event_is_global(sse_evt->evt))
> +				continue;
> +
> +			sse_event_register_local(sse_evt);
> +			if (sse_evt->is_enabled)
> +				sse_sbi_enable_event(sse_evt);
> +		}
> +	}
> +
> +	/* Ready to handle events. Unmask SSE. */
> +	sse_events_unmask();
> +
> +	return 0;
> +}
> +
> +static int sse_cpu_teardown(unsigned int cpu)
> +{
> +	unsigned int next_cpu;
> +	struct sse_event *sse_evt;
> +
> +	/* Mask the sse events */
> +	sse_events_mask();
> +
> +	scoped_guard(spinlock, &events_list_lock) {
> +		list_for_each_entry(sse_evt, &events, list) {
> +			if (!sse_event_is_global(sse_evt->evt)) {
> +
> +				if (sse_evt->is_enabled)
> +					sse_sbi_disable_event(sse_evt);
> +
> +				sse_sbi_unregister_event(sse_evt);
> +				continue;
> +			}
> +
> +			if (sse_evt->cpu != smp_processor_id())
> +				continue;
> +
> +			/* Update destination hart for global event */
> +			next_cpu = cpumask_any_but(cpu_online_mask, cpu);
> +			sse_event_set_target_cpu_nolock(sse_evt, next_cpu);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void sse_reset(void)
> +{
> +	struct sse_event *event = NULL;
> +
> +	list_for_each_entry(event, &events, list) {
> +		sse_event_disable_nolock(event);
> +		sse_event_unregister_nolock(event);
> +	}
> +}
> +
> +static int sse_pm_notifier(struct notifier_block *nb, unsigned long action,
> +			   void *data)
> +{
> +	WARN_ON_ONCE(preemptible());
> +
> +	switch (action) {
> +	case CPU_PM_ENTER:
> +		sse_events_mask();
> +		break;
> +	case CPU_PM_EXIT:
> +	case CPU_PM_ENTER_FAILED:
> +		sse_events_unmask();
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block sse_pm_nb = {
> +	.notifier_call = sse_pm_notifier,
> +};
> +
> +/*
> + * Mask all CPUs and unregister all events on panic, reboot or kexec.
> + */
> +static int sse_reboot_notifier(struct notifier_block *nb, unsigned long action,
> +				void *data)
> +{
> +	cpuhp_remove_state(sse_hp_state);
> +
> +	sse_reset();
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block sse_reboot_nb = {
> +	.notifier_call = sse_reboot_notifier,
> +};
> +
> +static int __init sse_init(void)
> +{
> +	int cpu, ret;
> +
> +	if (sbi_probe_extension(SBI_EXT_SSE) <= 0) {
> +		pr_err("Missing SBI SSE extension\n");
> +		return -EOPNOTSUPP;
> +	}
> +	pr_info("SBI SSE extension detected\n");
> +
> +	for_each_possible_cpu(cpu)
> +		INIT_LIST_HEAD(&events);
> +
> +	ret = cpu_pm_register_notifier(&sse_pm_nb);
> +	if (ret) {
> +		pr_warn("Failed to register CPU PM notifier...\n");
> +		return ret;
> +	}
> +
> +	ret = register_reboot_notifier(&sse_reboot_nb);
> +	if (ret) {
> +		pr_warn("Failed to register reboot notifier...\n");
> +		goto remove_cpupm;
> +	}
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/sse:online",
> +				sse_cpu_online, sse_cpu_teardown);
> +	if (ret < 0)
> +		goto remove_reboot;
> +
> +	sse_hp_state = ret;
> +	sse_available = true;
> +
> +	return 0;
> +
> +remove_reboot:
> +	unregister_reboot_notifier(&sse_reboot_nb);
> +
> +remove_cpupm:
> +	cpu_pm_unregister_notifier(&sse_pm_nb);
> +
> +	return ret;
> +}
> +arch_initcall(sse_init);
> diff --git a/include/linux/riscv_sse.h b/include/linux/riscv_sse.h
> new file mode 100644
> index 000000000000..c73184074b8c
> --- /dev/null
> +++ b/include/linux/riscv_sse.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#ifndef __LINUX_RISCV_SSE_H
> +#define __LINUX_RISCV_SSE_H
> +
> +#include <linux/types.h>
> +#include <linux/linkage.h>
> +
> +struct sse_event;
> +struct pt_regs;
> +
> +typedef int (sse_event_handler)(u32 event_num, void *arg, struct pt_regs *regs);
> +
> +#ifdef CONFIG_RISCV_SSE
> +
> +struct sse_event *sse_event_register(u32 event_num, u32 priority,
> +				     sse_event_handler *handler, void *arg);
> +
> +void sse_event_unregister(struct sse_event *evt);
> +
> +int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
> +
> +int sse_event_enable(struct sse_event *sse_evt);
> +
> +void sse_event_disable(struct sse_event *sse_evt);
> +
> +#else
> +static inline struct sse_event *sse_event_register(u32 event_num, u32 priority,
> +						   sse_event_handler *handler,
> +						   void *arg)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline void sse_event_unregister(struct sse_event *evt) {}
> +
> +static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
> +					   unsigned int cpu)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int sse_event_enable(struct sse_event *sse_evt)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void sse_event_disable(struct sse_event *sse_evt) {}
> +
> +
> +#endif
> +
> +#endif /* __LINUX_RISCV_SSE_H */
> -- 
> 2.45.2
> 

