Return-Path: <linux-kernel+bounces-372604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E15A9A4AE5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 03:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F59E1C21CDD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCC1BE23C;
	Sat, 19 Oct 2024 01:45:22 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A532D60C;
	Sat, 19 Oct 2024 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729302320; cv=none; b=qgSK0DRheYqT27oqDsMOAUrAeBM40JvOm9mSk7SIE0Ip25bpyOramTWBkm1Jwd/wKumbzkz55p5xeCmwNMH9LMAuI/1UD/o6HFLYMMtCgHC9rP0ycofRV5M3TdnXx3dibMKn8Dny4Zujo3uQvSZmNaFBFA+2AdFlZfR8/xNan4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729302320; c=relaxed/simple;
	bh=PciBsbY2V7xdc8vEVA/eFi1lyXEM9Ij2g3rtwSbtWiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeAWYv8pGfM31DdPwmeGnhiTDS+HmDPJT8zJ5qm/wd0XJuRYZEVOPLo8ykx4b+ly+03u3gFbQFrCjFFnw4KQOUTRdvghGP0k+6puFDyIf1seBECH/r8N8Bq2QgcGEN12QLm+rJYbWjlYElsyHJTYgkrkoQTRpm4Ki8W+ndal9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip2t1729302290trn1gr9
X-QQ-Originating-IP: N5DR9taKIn8nT/tgl7RoKrRPH4j8skCVtYOhSOqpDFo=
Received: from [IPV6:240f:10b:7440:1:cb8d:6c02 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 19 Oct 2024 09:44:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16317890409441601363
Message-ID: <82A35953D5DC5F46+9e167934-b77b-4393-a9cc-a2dd661b0d2d@radxa.com>
Date: Sat, 19 Oct 2024 10:44:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH UNTESTED 5/5] arm64: dts: rockchip: Enable HDMI0 on
 rock-5a
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241019-rk3588-hdmi0-dt-v1-0-bd8f299feacd@collabora.com>
 <20241019-rk3588-hdmi0-dt-v1-5-bd8f299feacd@collabora.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241019-rk3588-hdmi0-dt-v1-5-bd8f299feacd@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MOZa7CAAAGYAGTfkk9MqfrOAJRv1KiIAqPZ2ZfBbKEJel8CatkgyM1LR
	bc0koFMBm6foDZ6igWVg+qemrusj+YBIUloN+ZfQleFegguP4oI08I0DTZ8JzEKHcR6nsk7
	RMwjvcvpBSyjEzqI46tQyJPY44HRrXE7C2xmCtOaPFxX2JHq/+bAyEAavwCHzyLTFgnL/3s
	WuGst8foPrG5fT7pqSTPgkmdudUyAXlRXN8GA/HwDId3d7U/Nc5fOdpYwqp6GY0rmmsRh8D
	ukU+1f/o+rH9H1S5BrUIUW7LBPXNZoFOcxMwD1kQ+xlaSuNusW6hpNBCPnLM1YqIGAnXbm1
	PjS9W3ujSP/dFxb7rDpJfrckWnK0ZQkGReGsa6ec3/Wrbs69rWp3JtC9Md1iBlGeGz9H6Sm
	oPhf+EGjUVLgXaCZdf5RZ6A49Ia9EGBAA2ajLNIOKBdD3cRxOif/e289o0RVvo8M2AjDZjs
	nUVXLNKTD1AKhNG5WlzhKcC9fCP/tv+k83TqltTKH7ZNkc7B2jCG0M3iEHMMM4vXVJ0CE4b
	Sujy65biH9Ik1jxttoDyNt/1RlxyrTk4ysIWjqqL8s/UW7v1cGRjON3EVlsCAXvOm/6LQAg
	2HTzJGO9oOz9EwgsDPj7YDOXrM95gYotft8Op0YtRkQSstU3UpHRYeqfUsjKA2xdF/Ar3q6
	Cotc6qqN2pMRoxN1P0QzCXsgmJSi/lhtgNJT19IzU5GlfU/UR+yQQZ/0KVwtUy6/Zqa0YlR
	cxNp0EE7jra0FDxuKhiv6uBgUR8kUzJn+m0dmSw9wL+yo8digQ8Dd4l0B7nJGGwEelb/fwE
	0mpckgmsOcj92fMy7h8J9kv7XdBo9sWPFBdo7XDZsJh2r3YxMTEoWBDOhrm41EpKIZF+00D
	fENCIWTvYnApTD207hlLJpoH+S/uVV8wf9FHkKIAFeE=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi,

On 10/19/24 06:39, Cristian Ciocaltea wrote:
> Add the necessary DT changes to enable HDMI0 on Rock 5A.

Rock 5A -> (Radxa) ROCK 5A

> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

something wrong... dmesg is below

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x412fd050]
[    0.000000] Linux version 
6.12.0-rc3-next-20241018-05708-gfa23bedaae21 (radxa@radxa) (gcc (Ubuntu 
13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #1 SMP 
PREEMPT Sat Oct 19 00:36:14 UTC 2024
[    0.000000] KASLR enabled
[    0.000000] Machine model: Radxa ROCK 5A
[    0.000000] efi: UEFI not found.
[    0.000000] earlycon: uart0 at MMIO32 0x00000000feb50000 (options 
'1500000n8')
[    0.000000] printk: legacy bootconsole [uart0] enabled
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory 
node in the DT
[    0.000000] NUMA: Faking a node at [mem 
0x0000000000200000-0x00000002ffffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x2fef84bc0-0x2fef871ff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000200000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000002ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x00000000efffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000001ffffffff]
[    0.000000]   node   0: [mem 0x00000002f0000000-0x00000002ffffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000200000-0x00000002ffffffff]
[    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000ee000000 on node -1
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 25 pages/cpu s61720 r8192 d32488 u102400
[    0.000000] pcpu-alloc: s61720 r8192 d32488 u102400 alloc=25*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 
1530923
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: 
root=/dev/disk/by-uuid/4310f77a-a5c1-43d3-83ee-3b3d9a2821be ro earlycon 
console=tty1 console=ttyS2,1500000
[    0.000000] printk: log buffer data + meta data: 131072 + 458752 = 
589824 bytes
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 
8388608 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 
4194304 bytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 
2096640
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: mapped [mem 
0x00000000e775a000-0x00000000eb75a000] (64MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] RCU Tasks: Setting shift to 3 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.000000] RCU Tasks Trace: Setting shift to 3 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 480 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: MBI range [424:479]
[    0.000000] GICv3: Using MBI frame 0x00000000fe610000
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: GICD_CTRL.DS=0, SCR_EL3.FIQ=1
[    0.000000] GICv3: CPU0: found redistributor 0 region 
0:0x00000000fe680000
[    0.000000] ITS [mem 0xfe640000-0xfe65ffff]
[    0.000000] GIC: enabling workaround for ITS: Rockchip erratum RK3588001
[    0.000000] ITS@0x00000000fe640000: allocated 8192 Devices @100070000 
(indirect, esz 8, psz 64K, shr 0)
[    0.000000] ITS@0x00000000fe640000: allocated 32768 Interrupt 
Collections @100080000 (flat, esz 2, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] ITS [mem 0xfe660000-0xfe67ffff]
[    0.000000] GIC: enabling workaround for ITS: Rockchip erratum RK3588001
[    0.000000] ITS@0x00000000fe660000: allocated 8192 Devices @1000a0000 
(indirect, esz 8, psz 64K, shr 0)
[    0.000000] ITS@0x00000000fe660000: allocated 32768 Interrupt 
Collections @1000b0000 (flat, esz 2, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x00000001000c0000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table 
@0x00000001000d0000
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] { 
/cpus/cpu@0[0] /cpus/cpu@100[1] /cpus/cpu@200[2] /cpus/cpu@300[3] }
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] { 
/cpus/cpu@400[4] /cpus/cpu@500[5] /cpus/cpu@600[6] /cpus/cpu@700[7] }
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000001] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps 
every 4398046511097ns
[    0.004692] Console: colour dummy device 80x25
[    0.005121] printk: legacy console [tty1] enabled
[    0.006537] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.007519] pid_max: default: 32768 minimum: 301
[    0.008054] LSM: initializing lsm=capability
[    0.008651] Mount-cache hash table entries: 16384 (order: 5, 131072 
bytes, linear)
[    0.009401] Mountpoint-cache hash table entries: 16384 (order: 5, 
131072 bytes, linear)
[    0.020750] rcu: Hierarchical SRCU implementation.
[    0.021218] rcu: 	Max phase no-delay instances is 1000.
[    0.022012] Timer migration: 1 hierarchy levels; 8 children per 
group; 1 crossnode level
[    0.023069] fsl-mc MSI: msi-controller@fe640000 domain created
[    0.023650] fsl-mc MSI: msi-controller@fe660000 domain created
[    0.030498] EFI services will not be available.
[    0.031400] smp: Bringing up secondary CPUs ...
[    0.034334] Detected VIPT I-cache on CPU1
[    0.034412] GICv3: CPU1: found redistributor 100 region 
0:0x00000000fe6a0000
[    0.034429] GICv3: CPU1: using allocated LPI pending table 
@0x00000001000e0000
[    0.034476] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[    0.038215] Detected VIPT I-cache on CPU2
[    0.038289] GICv3: CPU2: found redistributor 200 region 
0:0x00000000fe6c0000
[    0.038305] GICv3: CPU2: using allocated LPI pending table 
@0x00000001000f0000
[    0.038352] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[    0.046240] Detected VIPT I-cache on CPU3
[    0.046314] GICv3: CPU3: found redistributor 300 region 
0:0x00000000fe6e0000
[    0.046329] GICv3: CPU3: using allocated LPI pending table 
@0x0000000100100000
[    0.046373] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[    0.050232] CPU features: detected: Spectre-v4
[    0.050238] CPU features: detected: Spectre-BHB
[    0.050243] CPU features: detected: SSBS not fully self-synchronizing
[    0.050246] Detected PIPT I-cache on CPU4
[    0.050288] GICv3: CPU4: found redistributor 400 region 
0:0x00000000fe700000
[    0.050297] GICv3: CPU4: using allocated LPI pending table 
@0x0000000100110000
[    0.050326] CPU4: Booted secondary processor 0x0000000400 [0x414fd0b0]
[    0.054275] Detected PIPT I-cache on CPU5
[    0.054326] GICv3: CPU5: found redistributor 500 region 
0:0x00000000fe720000
[    0.054336] GICv3: CPU5: using allocated LPI pending table 
@0x0000000100120000
[    0.054366] CPU5: Booted secondary processor 0x0000000500 [0x414fd0b0]
[    0.058282] Detected PIPT I-cache on CPU6
[    0.058332] GICv3: CPU6: found redistributor 600 region 
0:0x00000000fe740000
[    0.058342] GICv3: CPU6: using allocated LPI pending table 
@0x0000000100130000
[    0.058370] CPU6: Booted secondary processor 0x0000000600 [0x414fd0b0]
[    0.066197] Detected PIPT I-cache on CPU7
[    0.066247] GICv3: CPU7: found redistributor 700 region 
0:0x00000000fe760000
[    0.066257] GICv3: CPU7: using allocated LPI pending table 
@0x0000000100140000
[    0.066286] CPU7: Booted secondary processor 0x0000000700 [0x414fd0b0]
[    0.066395] smp: Brought up 1 node, 8 CPUs
[    0.084617] SMP: Total of 8 processors activated.
[    0.085070] CPU: All CPU(s) started at EL2
[    0.085464] CPU features: detected: 32-bit EL0 Support
[    0.085953] CPU features: detected: Data cache clean to the PoU not 
required for I/D coherence
[    0.086769] CPU features: detected: Common not Private translations
[    0.087363] CPU features: detected: CRC32 instructions
[    0.087876] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.088423] CPU features: detected: LSE atomic instructions
[    0.088954] CPU features: detected: Privileged Access Never
[    0.089484] CPU features: detected: RAS Extension Support
[    0.090000] CPU features: detected: Speculative Store Bypassing Safe 
(SSBS)
[    0.090729] alternatives: applying system-wide alternatives
[    0.094850] CPU features: detected: Hardware dirty bit management on 
CPU4-7
[    0.096002] Memory: 8051128K/8386560K available (17344K kernel code, 
4898K rwdata, 11908K rodata, 10496K init, 734K bss, 294792K reserved, 
32768K cma-reserved)
[    0.099639] devtmpfs: initialized
[    0.107249] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.108172] futex hash table entries: 2048 (order: 5, 131072 bytes, 
linear)
[    0.109116] 2G module region forced by RANDOMIZE_MODULE_REGION_FULL
[    0.109710] 0 pages in range for non-PLT usage
[    0.109713] 512880 pages in range for PLT usage
[    0.110267] pinctrl core: initialized pinctrl subsystem
[    0.112824] DMI not present or invalid.
[    0.115108] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.116237] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic 
allocations
[    0.117026] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for 
atomic allocations
[    0.117948] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for 
atomic allocations
[    0.118725] audit: initializing netlink subsys (disabled)
[    0.119361] audit: type=2000 audit(0.112:1): state=initialized 
audit_enabled=0 res=1
[    0.119949] thermal_sys: Registered thermal governor 'step_wise'
[    0.120097] thermal_sys: Registered thermal governor 'power_allocator'
[    0.120704] cpuidle: using governor menu
[    0.121782] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.122551] ASID allocator initialised with 32768 entries
[    0.124420] Serial: AMBA PL011 UART driver
[    0.136557] platform fdd90000.vop: Fixed dependency cycle(s) with 
/hdmi@fde80000
[    0.137283] platform fde80000.hdmi: Fixed dependency cycle(s) with 
/vop@fdd90000
[    0.145489] platform a41000000.pcie: Fixed dependency cycle(s) with 
/pcie@fe190000/legacy-interrupt-controller
[    0.154046] gpio gpiochip0: Static allocation of GPIO base is 
deprecated, use dynamic allocation.
[    0.155110] rockchip-gpio fd8a0000.gpio: probed /pinctrl/gpio@fd8a0000
[    0.155912] gpio gpiochip1: Static allocation of GPIO base is 
deprecated, use dynamic allocation.
[    0.156863] rockchip-gpio fec20000.gpio: probed /pinctrl/gpio@fec20000
[    0.157637] gpio gpiochip2: Static allocation of GPIO base is 
deprecated, use dynamic allocation.
[    0.158574] rockchip-gpio fec30000.gpio: probed /pinctrl/gpio@fec30000
[    0.159393] gpio gpiochip3: Static allocation of GPIO base is 
deprecated, use dynamic allocation.
[    0.160346] rockchip-gpio fec40000.gpio: probed /pinctrl/gpio@fec40000
[    0.161126] gpio gpiochip4: Static allocation of GPIO base is 
deprecated, use dynamic allocation.
[    0.162064] rockchip-gpio fec50000.gpio: probed /pinctrl/gpio@fec50000
[    0.163300] platform fde80000.hdmi: Fixed dependency cycle(s) with 
/hdmi0-con
[    0.163998] platform hdmi0-con: Fixed dependency cycle(s) with 
/hdmi@fde80000
[    0.167172] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.167813] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.168403] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.169040] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.169629] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.170265] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.170862] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.171498] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.173628] ACPI: Interpreter disabled.
[    0.176660] iommu: Default domain type: Translated
[    0.177115] iommu: DMA domain TLB invalidation policy: strict mode
[    0.178048] SCSI subsystem initialized
[    0.178515] libata version 3.00 loaded.
[    0.178606] usbcore: registered new interface driver usbfs
[    0.179144] usbcore: registered new interface driver hub
[    0.179654] usbcore: registered new device driver usb
[    0.181126] pps_core: LinuxPPS API ver. 1 registered
[    0.181594] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.182454] PTP clock support registered
[    0.182910] EDAC MC: Ver: 3.0.0
[    0.183569] scmi_core: SCMI protocol bus registered
[    0.184929] FPGA manager framework
[    0.185288] Advanced Linux Sound Architecture Driver Initialized.
[    0.186419] vgaarb: loaded
[    0.186976] clocksource: Switched to clocksource arch_sys_counter
[    0.187682] VFS: Disk quotas dquot_6.6.0
[    0.188061] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    0.188815] pnp: PnP ACPI: disabled
[    0.195172] NET: Registered PF_INET protocol family
[    0.195813] IP idents hash table entries: 131072 (order: 8, 1048576 
bytes, linear)
[    0.200704] tcp_listen_portaddr_hash hash table entries: 4096 (order: 
4, 65536 bytes, linear)
[    0.201586] Table-perturb hash table entries: 65536 (order: 6, 262144 
bytes, linear)
[    0.202320] TCP established hash table entries: 65536 (order: 7, 
524288 bytes, linear)
[    0.203569] TCP bind hash table entries: 65536 (order: 9, 2097152 
bytes, linear)
[    0.206145] TCP: Hash tables configured (established 65536 bind 65536)
[    0.206804] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.207631] UDP-Lite hash table entries: 4096 (order: 5, 131072 
bytes, linear)
[    0.208540] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.209405] RPC: Registered named UNIX socket transport module.
[    0.209963] RPC: Registered udp transport module.
[    0.210405] RPC: Registered tcp transport module.
[    0.210846] RPC: Registered tcp-with-tls transport module.
[    0.211371] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.211978] PCI: CLS 0 bytes, default 64
[    0.212525] Unpacking initramfs...
[    0.220910] kvm [1]: nv: 554 coarse grained trap handlers
[    0.221636] kvm [1]: IPA Size Limit: 40 bits
[    0.222052] kvm [1]: GICv3: no GICV resource entry
[    0.222504] kvm [1]: disabling GICv2 emulation
[    0.222953] kvm [1]: GIC system register CPU interface enabled
[    0.223511] kvm [1]: vgic interrupt IRQ18
[    0.223915] kvm [1]: VHE mode initialized successfully
[    0.225334] Initialise system trusted keyrings
[    0.225920] workingset: timestamp_bits=42 max_order=21 bucket_order=0
[    0.226674] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.227426] NFS: Registering the id_resolver key type
[    0.227912] Key type id_resolver registered
[    0.228306] Key type id_legacy registered
[    0.228691] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.229320] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver 
Registering...
[    0.230127] 9p: Installing v9fs 9p2000 file system support
[    0.269744] Key type asymmetric registered
[    0.270134] Asymmetric key parser 'x509' registered
[    0.270622] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 245)
[    0.271323] io scheduler mq-deadline registered
[    0.271750] io scheduler kyber registered
[    0.272147] io scheduler bfq registered
[    0.580049] Freeing initrd memory: 20748K
[    0.587097] ledtrig-cpu: registered to indicate activity on CPUs
[    0.607079] dma-pl330 fea10000.dma-controller: Loaded driver for 
PL330 DMAC-241330
[    0.607797] dma-pl330 fea10000.dma-controller: 	DBUFF-128x8bytes 
Num_Chans-8 Num_Peri-32 Num_Events-16
[    0.609389] dma-pl330 fea30000.dma-controller: Loaded driver for 
PL330 DMAC-241330
[    0.610103] dma-pl330 fea30000.dma-controller: 	DBUFF-128x8bytes 
Num_Chans-8 Num_Peri-32 Num_Events-16
[    0.611719] dma-pl330 fed10000.dma-controller: Loaded driver for 
PL330 DMAC-241330
[    0.612432] dma-pl330 fed10000.dma-controller: 	DBUFF-128x8bytes 
Num_Chans-8 Num_Peri-32 Num_Events-16
[    0.625037] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.627086] printk: legacy console [ttyS2] disabled
[    0.627682] feb50000.serial: ttyS2 at MMIO 0xfeb50000 (irq = 40, 
base_baud = 1500000) is a 16550A
[    0.628636] printk: legacy console [ttyS2] enabled
[    0.629506] printk: legacy bootconsole [uart0] disabled
[    0.632717] msm_serial: driver initialized
[    0.633450] SuperH (H)SCI(F) driver initialized
[    0.634105] STM32 USART driver initialized
[    0.642810] loop: module loaded
[    0.643863] megasas: 07.727.03.00-rc1
[    0.648109] rockchip-spi feb20000.spi: Runtime PM usage count underflow!
[    0.648834] spi spi2.0: Fixed dependency cycle(s) with 
/spi@feb20000/pmic@0/regulators/dcdc-reg7
[    0.649637] spi spi2.0: Fixed dependency cycle(s) with 
/spi@feb20000/pmic@0/dvs3-null-pins
[    0.650365] spi spi2.0: Fixed dependency cycle(s) with 
/spi@feb20000/pmic@0/dvs2-null-pins
[    0.651107] spi spi2.0: Fixed dependency cycle(s) with 
/spi@feb20000/pmic@0/dvs1-null-pins
[    0.654266] tun: Universal TUN/TAP device driver, 1.6
[    0.655932] thunder_xcv, ver 1.0
[    0.656238] thunder_bgx, ver 1.0
[    0.656533] nicpf, ver 1.0
[    0.657925] hns3: Hisilicon Ethernet Network Driver for Hip08 Family 
- version
[    0.658561] hns3: Copyright (c) 2017 Huawei Corporation.
[    0.659054] hclge is initializing
[    0.659364] e1000: Intel(R) PRO/1000 Network Driver
[    0.659793] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.660308] e1000e: Intel(R) PRO/1000 Network Driver
[    0.660744] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.661272] igb: Intel(R) Gigabit Ethernet Network Driver
[    0.661746] igb: Copyright (c) 2007-2014 Intel Corporation.
[    0.662247] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    0.662796] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    0.663629] sky2: driver version 1.30
[    0.665452] VFIO - User Level meta-driver version: 0.3
[    0.669067] usbcore: registered new interface driver usb-storage
[    0.672531] i2c_dev: i2c /dev entries driver
[    0.676160] platform fe470000.i2s: Fixed dependency cycle(s) with 
/i2c@fec90000/audio-codec@11
[    0.676953] i2c 7-0011: Fixed dependency cycle(s) with /i2s@fe470000
[    0.684569] sdhci: Secure Digital Host Controller Interface driver
[    0.685116] sdhci: Copyright(c) Pierre Ossman
[    0.686391] Synopsys Designware Multimedia Card Interface Driver
[    0.688020] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.691528] arm-scmi arm-scmi.0.auto: Using scmi_smc_transport
[    0.692054] arm-scmi arm-scmi.0.auto: SCMI max-rx-timeout: 30ms
[    0.692640] scmi_protocol scmi_dev.1: Enabled polling mode TX channel 
- prot_id:16
[    0.693420] arm-scmi arm-scmi.0.auto: SCMI Notifications - Core Enabled.
[    0.694041] arm-scmi arm-scmi.0.auto: SCMI Protocol v2.0 'rockchip:' 
Firmware version 0x0
[    0.701721] SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
[    0.703204] usbcore: registered new interface driver usbhid
[    0.703698] usbhid: USB HID core driver
[    0.708183] hw perfevents: enabled with armv8_cortex_a55 PMU driver, 
7 (0,8000003f) counters available
[    0.709920] hw perfevents: enabled with armv8_cortex_a76 PMU driver, 
7 (0,8000003f) counters available
[    0.713333] optee: probing for conduit method.
[    0.713731] optee: api uid mismatch
[    0.714040] optee firmware:optee: probe with driver optee failed with 
error -22
[    0.717921] NET: Registered PF_PACKET protocol family
[    0.718421] 9pnet: Installing 9P2000 support
[    0.718824] Key type dns_resolver registered
[    0.722907] mmc0: SDHCI controller on fe2e0000.mmc [fe2e0000.mmc] 
using ADMA
[    0.724236] registered taskstats version 1
[    0.724707] Loading compiled-in X.509 certificates
[    0.729117] Demotion targets for Node 0: null
[    0.729302] mmc0: Failed to initialize a non-removable card
[    0.759524] rk808-regulator rk808-regulator.2.auto: there is no dvs0 gpio
[    0.760629] rk808-regulator rk808-regulator.2.auto: there is no dvs1 gpio
[    0.780002] fan53555-regulator 2-0042: FAN53555 Option[10] Rev[1] 
Detected!
[    0.780147] fan53555-regulator 0-0042: FAN53555 Option[10] Rev[1] 
Detected!
[    0.780742] fan53555-regulator 0-0043: FAN53555 Option[10] Rev[1] 
Detected!
[    0.783655] dwmmc_rockchip fe2c0000.mmc: IDMAC supports 32-bit 
address mode.
[    0.784334] dwmmc_rockchip fe2c0000.mmc: Using internal DMA controller.
[    0.784934] dwmmc_rockchip fe2c0000.mmc: Version ID is 270a
[    0.785477] dwmmc_rockchip fe2c0000.mmc: DW MMC controller at irq 
74,32 bit host data width,256 deep fifo
[    0.793708] ehci-platform fc800000.usb: EHCI Host Controller
[    0.794229] ehci-platform fc800000.usb: new USB bus registered, 
assigned bus number 1
[    0.794358] ohci-platform fc840000.usb: Generic Platform OHCI controller
[    0.794975] ehci-platform fc880000.usb: EHCI Host Controller
[    0.795441] ehci-platform fc800000.usb: irq 75, io mem 0xfc800000
[    0.795550] ohci-platform fc840000.usb: new USB bus registered, 
assigned bus number 2
[    0.795764] cpufreq: cpufreq_online: CPU0: Running at unlisted 
initial frequency: 816000 KHz, changing to: 1008000 KHz
[    0.795855] cpu cpu0: EM: created perf domain
[    0.796017] ehci-platform fc880000.usb: new USB bus registered, 
assigned bus number 3
[    0.796624] ohci-platform fc840000.usb: irq 77, io mem 0xfc840000
[    0.798108] ehci-platform fc880000.usb: irq 76, io mem 0xfc880000
[    0.799059] cpufreq: cpufreq_online: CPU4: Running at unlisted 
initial frequency: 816000 KHz, changing to: 1200000 KHz
[    0.799335] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 
400000Hz, actual 400000HZ div = 0)
[    0.799849] cpu cpu4: EM: created perf domain
[    0.805762] cpufreq: cpufreq_online: CPU6: Running at unlisted 
initial frequency: 816000 KHz, changing to: 1200000 KHz
[    0.806769] cpu cpu6: EM: created perf domain
[    0.807058] ehci-platform fc800000.usb: USB 2.0 started, EHCI 1.00
[    0.808110] hub 1-0:1.0: USB hub found
[    0.808452] hub 1-0:1.0: 1 port detected
[    0.810495] ohci-platform fc8c0000.usb: Generic Platform OHCI controller
[    0.810681] clk: Disabling unused clocks
[    0.811107] ohci-platform fc8c0000.usb: new USB bus registered, 
assigned bus number 4
[    0.811897] PM: genpd: Disabling unused power domains
[    0.812165] ohci-platform fc8c0000.usb: irq 78, io mem 0xfc8c0000
[    0.812631] ALSA device list:
[    0.813355]   No soundcards found.
[    0.813723] dw-apb-uart feb50000.serial: forbid DMA for kernel console
[    0.819039] ehci-platform fc880000.usb: USB 2.0 started, EHCI 1.00
[    0.820240] hub 3-0:1.0: USB hub found
[    0.820607] hub 3-0:1.0: 1 port detected
[    0.855579] hub 2-0:1.0: USB hub found
[    0.855943] hub 2-0:1.0: 1 port detected
[    0.871510] hub 4-0:1.0: USB hub found
[    0.871853] hub 4-0:1.0: 1 port detected
[    0.874666] Freeing unused kernel memory: 10496K
[    0.875125] Run /init as init process
[    0.875448]   with arguments:
[    0.875450]     /init
[    0.875452]   with environment:
[    0.875454]     HOME=/
[    0.875456]     TERM=linux
[    0.989081] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 
150000000Hz, actual 148500000HZ div = 0)
[    1.058964] usb 1-1: new high-speed USB device number 2 using 
ehci-platform
[    1.114297] rockchip-vop2 fdd90000.vop: Adding to iommu group 0
[    1.136088] rk_gmac-dwmac fe1c0000.ethernet: IRQ eth_lpi not found
[    1.136634] rk_gmac-dwmac fe1c0000.ethernet: IRQ sfty not found
[    1.137218] rk_gmac-dwmac fe1c0000.ethernet: supply phy not found, 
using dummy regulator
[    1.137978] rk_gmac-dwmac fe1c0000.ethernet: clock input or output? 
(output).
[    1.138600] rk_gmac-dwmac fe1c0000.ethernet: TX delay(0x3a).
[    1.139100] rk_gmac-dwmac fe1c0000.ethernet: RX delay(0x3e).
[    1.139597] rk_gmac-dwmac fe1c0000.ethernet: integrated PHY? (no).
[    1.142089] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
[    1.142574] xhci-hcd xhci-hcd.4.auto: new USB bus registered, 
assigned bus number 5
[    1.143608] xhci-hcd xhci-hcd.4.auto: hcc params 0x0220fe64 hci 
version 0x110 quirks 0x0000808002000010
[    1.144441] xhci-hcd xhci-hcd.4.auto: irq 81, io mem 0xfcd00000
[    1.145009] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
[    1.145147] rk_gmac-dwmac fe1c0000.ethernet: init for RGMII
[    1.145487] xhci-hcd xhci-hcd.4.auto: new USB bus registered, 
assigned bus number 6
[    1.146646] xhci-hcd xhci-hcd.4.auto: Host supports USB 3.0 SuperSpeed
[    1.149921] hub 5-0:1.0: USB hub found
[    1.150274] hub 5-0:1.0: 1 port detected
[    1.150682] rk_gmac-dwmac fe1c0000.ethernet: User ID: 0x30, Synopsys 
ID: 0x51
[    1.151314] rk_gmac-dwmac fe1c0000.ethernet: 	DWMAC4/5
[    1.151762] rk_gmac-dwmac fe1c0000.ethernet: DMA HW capability 
register supported
[    1.152412] rk_gmac-dwmac fe1c0000.ethernet: RX Checksum Offload 
Engine supported
[    1.153063] rk_gmac-dwmac fe1c0000.ethernet: TX Checksum insertion 
supported
[    1.153674] rk_gmac-dwmac fe1c0000.ethernet: Wake-Up On Lan supported
[    1.154959] rk_gmac-dwmac fe1c0000.ethernet: TSO supported
[    1.155442] rk_gmac-dwmac fe1c0000.ethernet: Enable RX Mitigation via 
HW Watchdog Timer
[    1.156143] usb usb6: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    1.156744] rk_gmac-dwmac fe1c0000.ethernet: Enabled L3L4 Flow TC 
(entries=2)
[    1.156973] hub 6-0:1.0: USB hub found
[    1.157465] rk_gmac-dwmac fe1c0000.ethernet: Enabled RFS Flow TC 
(entries=10)
[    1.157794] hub 6-0:1.0: 1 port detected
[    1.158650] rk_gmac-dwmac fe1c0000.ethernet: TSO feature enabled
[    1.159295] rk_gmac-dwmac fe1c0000.ethernet: SPH feature enabled
[    1.159652] rockchip-drm display-subsystem: bound fdd90000.vop (ops 
vop2_component_ops [rockchipdrm])
[    1.159816] rk_gmac-dwmac fe1c0000.ethernet: Using 32/32 bits DMA 
host/device width
[    1.161059] dwhdmiqp-rockchip fde80000.hdmi: registered DesignWare 
HDMI QP I2C bus driver
[    1.162037] rockchip-drm display-subsystem: bound fde80000.hdmi (ops 
dw_hdmi_qp_rockchip_ops [rockchipdrm])
[    1.163380] [drm] Initialized rockchip 1.0.0 for display-subsystem on 
minor 0
[    1.164153] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.164855] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.165654] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.166344] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.167038] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.167745] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.170607] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't 
support RGB, something's wrong.
[    1.188384] Console: switching to colour frame buffer device 128x48
[    1.188454] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't 
support RGB, something's wrong.
[    1.210936] rockchip-drm display-subsystem: [drm] fb0: rockchipdrmfb 
frame buffer device
[    1.212661] hub 1-1:1.0: USB hub found
[    1.213123] hub 1-1:1.0: 4 ports detected
[    1.257486] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.259355] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.261198] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.261556] rockchip-dw-pcie a41000000.pcie: host bridge 
/pcie@fe190000 ranges:
[    1.261710] dwmmc_rockchip fe2c0000.mmc: Successfully tuned phase to 205
[    1.262340] rockchip-dw-pcie a41000000.pcie:       IO 
0x00f4100000..0x00f41fffff -> 0x00f4100000
[    1.262930] mmc1: new UHS-I speed SDR104 SDHC card at address aaaa
[    1.263701] rockchip-dw-pcie a41000000.pcie:      MEM 
0x00f4200000..0x00f4ffffff -> 0x00f4200000
[    1.264816] mmcblk1: mmc1:aaaa SE32G 29.7 GiB
[    1.264994] rockchip-dw-pcie a41000000.pcie:      MEM 
0x0a00000000..0x0a3fffffff -> 0x0040000000
[    1.266384] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.266562] rockchip-dw-pcie a41000000.pcie: iATU: unroll T, 8 ob, 8 
ib, align 64K, limit 8G
[    1.268187] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[    1.292497] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't 
support RGB, something's wrong.
[    1.296896] rk_gmac-dwmac fe1c0000.ethernet end0: renamed from eth0
[    1.344548] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't 
support RGB, something's wrong.
[    1.471034] rockchip-dw-pcie a41000000.pcie: PCIe Gen.1 x1 link up
[    1.472026] rockchip-dw-pcie a41000000.pcie: PCI host bridge to bus 
0004:40
[    1.475577] pci_bus 0004:40: root bus resource [bus 40-4f]
[    1.478856] pci_bus 0004:40: root bus resource [io  0x0000-0xfffff] 
(bus address [0xf4100000-0xf41fffff])
[    1.482491] pci_bus 0004:40: root bus resource [mem 
0xf4200000-0xf4ffffff]
[    1.485972] pci_bus 0004:40: root bus resource [mem 
0xa00000000-0xa3fffffff] (bus address [0x40000000-0x7fffffff])
[    1.489720] pci 0004:40:00.0: [1d87:3588] type 01 class 0x060400 PCIe 
Root Port
[    1.493158] pci 0004:40:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    1.496452] pci 0004:40:00.0: PCI bridge to [bus 01-ff]
[    1.499303] pci 0004:40:00.0:   bridge window [io  0x0000-0x0fff]
[    1.502570] pci 0004:40:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.505580] pci 0004:40:00.0:   bridge window [mem 
0x00000000-0x000fffff 64bit pref]
[    1.508146] pci 0004:40:00.0: supports D1 D2
[    1.510312] pci 0004:40:00.0: PME# supported from D0 D1 D3hot
[    1.517094] pci 0004:40:00.0: Primary bus is hard wired to 0
[    1.519772] pci 0004:40:00.0: bridge configuration invalid ([bus 
01-ff]), reconfiguring
[    1.522743] pci 0004:41:00.0: [10ec:b852] type 00 class 0x028000 PCIe 
Endpoint
[    1.525494] pci 0004:41:00.0: BAR 0: initial BAR value 0x00000000 invalid
[    1.528124] pci 0004:41:00.0: BAR 0 [io  size 0x0100]
[    1.530328] pci 0004:41:00.0: BAR 2 [mem 0x00000000-0x000fffff 64bit]
[    1.533026] pci 0004:41:00.0: PME# supported from D0 D3hot D3cold
[    1.543123] pci_bus 0004:41: busn_res: [bus 41-4f] end is updated to 41
[    1.545512] pci 0004:40:00.0: bridge window [mem 
0xf4200000-0xf42fffff]: assigned
[    1.548254] pci 0004:40:00.0: ROM [mem 0xf4300000-0xf430ffff pref]: 
assigned
[    1.550988] pci 0004:40:00.0: bridge window [io  0x1000-0x1fff]: assigned
[    1.553827] pci 0004:41:00.0: BAR 2 [mem 0xf4200000-0xf42fffff 
64bit]: assigned
[    1.556341] pci 0004:41:00.0: BAR 0 [io  0x1000-0x10ff]: assigned
[    1.558657] pci 0004:40:00.0: PCI bridge to [bus 41]
[    1.560647] pci 0004:40:00.0:   bridge window [io  0x1000-0x1fff]
[    1.562706] pci 0004:40:00.0:   bridge window [mem 0xf4200000-0xf42fffff]
[    1.564677] pci_bus 0004:40: resource 4 [io  0x0000-0xfffff]
[    1.566535] pci_bus 0004:40: resource 5 [mem 0xf4200000-0xf4ffffff]
[    1.568447] pci_bus 0004:40: resource 6 [mem 0xa00000000-0xa3fffffff]
[    1.570441] pci_bus 0004:41: resource 0 [io  0x1000-0x1fff]
[    1.572328] pci_bus 0004:41: resource 1 [mem 0xf4200000-0xf42fffff]
[    1.575991] pcieport 0004:40:00.0: PME: Signaling with IRQ 94
[    1.578141] pcieport 0004:40:00.0: AER: enabled with IRQ 95
[    1.598755] xhci-hcd xhci-hcd.5.auto: xHCI Host Controller
[    1.600944] xhci-hcd xhci-hcd.5.auto: new USB bus registered, 
assigned bus number 7
[    1.603376] xhci-hcd xhci-hcd.5.auto: hcc params 0x0220fe64 hci 
version 0x110 quirks 0x0000808002000010
[    1.605875] xhci-hcd xhci-hcd.5.auto: irq 96, io mem 0xfc000000
[    1.608221] xhci-hcd xhci-hcd.5.auto: xHCI Host Controller
[    1.610127] xhci-hcd xhci-hcd.5.auto: new USB bus registered, 
assigned bus number 8
[    1.611019] raid6: neonx8   gen() 11881 MB/s
[    1.612074] xhci-hcd xhci-hcd.5.auto: Host supports USB 3.0 SuperSpeed
[    1.615882] hub 7-0:1.0: USB hub found
[    1.617595] hub 7-0:1.0: 1 port detected
[    1.619496] usb usb8: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    1.621939] hub 8-0:1.0: USB hub found
[    1.623652] hub 8-0:1.0: 1 port detected
[    1.678946] raid6: neonx4   gen() 11924 MB/s
[    1.747021] raid6: neonx2   gen() 10068 MB/s
[    1.787060] usb 1-1.3: new full-speed USB device number 3 using 
ehci-platform
[    1.815069] raid6: neonx1   gen()  7974 MB/s
[    1.883039] raid6: int64x8  gen()  2218 MB/s
[    1.951066] raid6: int64x4  gen()  4272 MB/s
[    2.018988] raid6: int64x2  gen()  4665 MB/s
[    2.087022] raid6: int64x1  gen()  3841 MB/s
[    2.088590] raid6: using algorithm neonx4 gen() 11924 MB/s
[    2.155017] raid6: .... xor() 4926 MB/s, rmw enabled
[    2.157520] raid6: using neon recovery algorithm
[    2.161104] xor: measuring software checksum speed
[    2.162111]    8regs           : 13921 MB/sec
[    2.163056]    32regs          : 13569 MB/sec
[    2.163918]    arm64_neon      : 19529 MB/sec
[    2.164606] xor: using function: arm64_neon (19529 MB/sec)
[    2.172097] Btrfs loaded, zoned=no, fsverity=no
[    2.607148] usb 8-1: new SuperSpeed USB device number 2 using xhci-hcd
[    2.626246] usb-storage 8-1:1.0: USB Mass Storage device detected
[    2.629834] scsi host0: usb-storage 8-1:1.0
[    3.663235] scsi 0:0:0:0: Direct-Access     Logitec  LMD USB Device 
PMAP PQ: 0 ANSI: 6
[    3.674594] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 
GB/233 GiB)
[    3.679739] sd 0:0:0:0: [sda] Write Protect is off
[    3.682200] sd 0:0:0:0: [sda] Mode Sense: 5f 00 00 08
[    3.684495] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    3.733716]  sda: sda1
[    3.736298] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.886295] EXT4-fs (sda1): mounted filesystem 
4310f77a-a5c1-43d3-83ee-3b3d9a2821be ro with ordered data mode. Quota 
mode: none.
[    4.070202] systemd[1]: System time before build time, advancing clock.
[    4.097302] NET: Registered PF_INET6 protocol family
[    4.098709] Segment Routing with IPv6
[    4.099476] In-situ OAM (IOAM) with IPv6
[    4.117652] systemd[1]: systemd 255.4-1ubuntu8.4 running in system 
mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT 
-GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC 
+KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 
+BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT 
default-hierarchy=unified)
[    4.122571] systemd[1]: Detected architecture arm64.
[    4.132140] systemd[1]: Hostname set to <radxa-test>.
[    4.312653] systemd[1]: Configuration file 
/run/systemd/system/netplan-ovs-cleanup.service is marked 
world-inaccessible. This has no effect as configuration data is 
accessible via APIs without restrictions. Proceeding anyway.
[    4.332846] systemd[1]: Configuration file 
/run/systemd/system/systemd-networkd-wait-online.service.d/10-netplan.conf 
is marked world-inaccessible. This has no effect as configuration data 
is accessible via APIs without restrictions. Proceeding anyway.
[    4.426530] systemd[1]: Queued start job for default target 
graphical.target.
[    4.472374] systemd[1]: Created slice system-modprobe.slice - Slice 
/system/modprobe.
[    4.479597] systemd[1]: Created slice system-serial\x2dgetty.slice - 
Slice /system/serial-getty.
[    4.487440] systemd[1]: Created slice user.slice - User and Session 
Slice.
[    4.495182] systemd[1]: Started systemd-ask-password-wall.path - 
Forward Password Requests to Wall Directory Watch.
[    4.503218] systemd[1]: proc-sys-fs-binfmt_misc.automount - Arbitrary 
Executable File Formats File System Automount Point was skipped because 
of an unmet condition check (ConditionPathExists=/proc/sys/fs/binfmt_misc).
[    4.506541] systemd[1]: Expecting device dev-ttyS2.device - /dev/ttyS2...
[    4.515086] systemd[1]: Reached target integritysetup.target - Local 
Integrity Protected Volumes.
[    4.523126] systemd[1]: Reached target slices.target - Slice Units.
[    4.531079] systemd[1]: Reached target snapd.mounts-pre.target - 
Mounting snaps.
[    4.539075] systemd[1]: Reached target snapd.mounts.target - Mounted 
snaps.
[    4.547082] systemd[1]: Reached target swap.target - Swaps.
[    4.549178] systemd[1]: Reached target veritysetup.target - Local 
Verity Protected Volumes.
[    4.559230] systemd[1]: Listening on dm-event.socket - Device-mapper 
event daemon FIFOs.
[    4.567258] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll 
daemon socket.
[    4.575236] systemd[1]: Listening on multipathd.socket - multipathd 
control socket.
[    4.583231] systemd[1]: Listening on systemd-fsckd.socket - fsck to 
fsckd communication Socket.
[    4.591160] systemd[1]: Listening on systemd-initctl.socket - initctl 
Compatibility Named Pipe.
[    4.599251] systemd[1]: Listening on systemd-journald-dev-log.socket 
- Journal Socket (/dev/log).
[    4.607273] systemd[1]: Listening on systemd-journald.socket - 
Journal Socket.
[    4.615308] systemd[1]: Listening on systemd-networkd.socket - 
Network Service Netlink Socket.
[    4.623091] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extension 
(Varlink) was skipped because of an unmet condition check 
(ConditionSecurity=measured-uki).
[    4.626393] systemd[1]: Listening on systemd-udevd-control.socket - 
udev Control Socket.
[    4.635216] systemd[1]: Listening on systemd-udevd-kernel.socket - 
udev Kernel Socket.
[    4.683249] systemd[1]: Mounting dev-hugepages.mount - Huge Pages 
File System...
[    4.692601] systemd[1]: Mounting dev-mqueue.mount - POSIX Message 
Queue File System...
[    4.700265] systemd[1]: Mounting sys-kernel-debug.mount - Kernel 
Debug File System...
[    4.707158] systemd[1]: sys-kernel-tracing.mount - Kernel Trace File 
System was skipped because of an unmet condition check 
(ConditionPathExists=/sys/kernel/tracing).
[    4.713657] systemd[1]: Starting systemd-journald.service - Journal 
Service...
[    4.724529] systemd[1]: Starting keyboard-setup.service - Set the 
console keyboard layout...
[    4.732504] systemd[1]: Starting kmod-static-nodes.service - Create 
List of Static Device Nodes...
[    4.735684] systemd[1]: Starting lvm2-monitor.service - Monitoring of 
LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    4.748205] systemd[1]: Starting modprobe@configfs.service - Load 
Kernel Module configfs...
[    4.755958] systemd-journald[333]: Collecting audit messages is disabled.
[    4.756390] systemd[1]: Starting modprobe@dm_mod.service - Load 
Kernel Module dm_mod...
[    4.768391] systemd[1]: Starting modprobe@drm.service - Load Kernel 
Module drm...
[    4.776321] systemd[1]: Starting modprobe@efi_pstore.service - Load 
Kernel Module efi_pstore...
[    4.778189] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) 
initialised: dm-devel@lists.linux.dev
[    4.788285] systemd[1]: Starting modprobe@fuse.service - Load Kernel 
Module fuse...
[    4.796175] systemd[1]: Starting modprobe@loop.service - Load Kernel 
Module loop...
[    4.803138] systemd[1]: netplan-ovs-cleanup.service - OpenVSwitch 
configuration for cleanup was skipped because of an unmet condition 
check (ConditionFileIsExecutable=/usr/bin/ovs-vsctl).
[    4.806262] systemd[1]: systemd-fsck-root.service - File System Check 
on Root Device was skipped because of an unmet condition check 
(ConditionPathExists=!/run/initramfs/fsck-root).
[    4.811929] systemd[1]: Starting systemd-modules-load.service - Load 
Kernel Modules...
[    4.817610] fuse: init (API version 7.41)
[    4.819071] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machine 
ID Measurement was skipped because of an unmet condition check 
(ConditionSecurity=measured-uki).
[    4.824273] systemd[1]: Starting systemd-remount-fs.service - Remount 
Root and Kernel File Systems...
[    4.831083] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK 
Setup (Early) was skipped because of an unmet condition check 
(ConditionSecurity=measured-uki).
[    4.835720] systemd[1]: Starting systemd-udev-trigger.service - 
Coldplug All udev Devices...
[    4.845235] systemd[1]: Started systemd-journald.service - Journal 
Service.
[    4.877876] EXT4-fs (sda1): re-mounted 
4310f77a-a5c1-43d3-83ee-3b3d9a2821be r/w. Quota mode: none.
[    4.958994] random: crng init done
[    5.036442] systemd-journald[333]: Received client request to flush 
runtime journal.
[    5.076796] systemd-journald[333]: 
/var/log/journal/1d8fb168781745f7ad290e40a68bb043/system.journal: 
Realtime clock jumped backwards relative to last journal entry, rotating.
[    5.076806] systemd-journald[333]: Rotating system journal.
[    5.387408] mc: Linux media interface: v0.10
[    5.396844] videodev: Linux video capture interface: v2.00
[    5.418446] rockchip-thermal fec00000.tsadc: Missing rockchip,grf 
property
[    5.418762] cfg80211: Loading compiled-in X.509 certificates for 
regulatory database
[    5.423238] at24 2-0050: supply vcc not found, using dummy regulator
[    5.423989] hantro-vpu fdb50000.video-codec: Adding to iommu group 1
[    5.425492] hantro-vpu fdb50000.video-codec: registered 
rockchip,rk3568-vpu-dec as /dev/video0
[    5.426827] hantro-vpu fdba0000.video-codec: Adding to iommu group 2
[    5.426860] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.427186] hantro-vpu fdba0000.video-codec: registered 
rockchip,rk3588-vepu121-enc as /dev/video1
[    5.427366] Loaded X.509 cert 'wens: 
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    5.431989] Bluetooth: Core ver 2.22
[    5.432563] NET: Registered PF_BLUETOOTH protocol family
[    5.432567] Bluetooth: HCI device and connection manager initialized
[    5.432573] Bluetooth: HCI socket layer initialized
[    5.432576] Bluetooth: L2CAP socket layer initialized
[    5.432583] Bluetooth: SCO socket layer initialized
[    5.440878] hantro-vpu fdba4000.video-codec: Adding to iommu group 3
[    5.441068] hantro-vpu fdba4000.video-codec: missing multi-core 
support, ignoring this instance
[    5.443673] hantro-vpu fdba8000.video-codec: Adding to iommu group 4
[    5.443751] hantro-vpu fdba8000.video-codec: missing multi-core 
support, ignoring this instance
[    5.443795] input: rk805 pwrkey as 
/devices/platform/feb20000.spi/spi_master/spi2/spi2.0/rk805-pwrkey.3.auto/input/input0
[    5.445075] hantro-vpu fdbac000.video-codec: Adding to iommu group 5
[    5.445133] hantro-vpu fdbac000.video-codec: missing multi-core 
support, ignoring this instance
[    5.453252] hantro-vpu fdc70000.video-codec: registered 
rockchip,rk3588-av1-vpu-dec as /dev/video2
[    5.482335] usbcore: registered new interface driver btusb
[    5.488889] Bluetooth: hci0: RTL: examining hci_ver=0b hci_rev=000b 
lmp_ver=0b lmp_subver=8852
[    5.489892] Bluetooth: hci0: RTL: rom_version status=0 version=1
[    5.489899] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
[    5.493953] rtw89_8852be 0004:41:00.0: loaded firmware 
rtw89/rtw8852b_fw-1.bin
[    5.494079] ACPI: <n/a>: failed to evaluate _DSM 
e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:5 (0x1001)
[    5.494109] rtw89_8852be 0004:41:00.0: enabling device (0000 -> 0003)
[    5.498916] rtw89_8852be 0004:41:00.0: Firmware version 0.29.29.5 
(da87cccd), cmd version 0, type 5
[    5.498925] rtw89_8852be 0004:41:00.0: Firmware version 0.29.29.5 
(da87cccd), cmd version 0, type 3
[    5.499194] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
[    5.502299] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't 
support RGB, something's wrong.
[    5.503899] Bluetooth: hci0: RTL: cfg_sz 6, total sz 65603
[    5.544794] rk_gmac-dwmac fe1c0000.ethernet end0: Register 
MEM_TYPE_PAGE_POOL RxQ-0
[    5.545032] rk_gmac-dwmac fe1c0000.ethernet end0: Register 
MEM_TYPE_PAGE_POOL RxQ-1
[    5.554359] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't 
support RGB, something's wrong.
[    5.588977] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't 
support RGB, something's wrong.
[    5.614976] rk_gmac-dwmac fe1c0000.ethernet end0: PHY [stmmac-0:01] 
driver [RTL8211F Gigabit Ethernet] (irq=POLL)
[    5.621667] dwmac4: Master AXI performs any burst length
[    5.621683] rk_gmac-dwmac fe1c0000.ethernet end0: No Safety Features 
support found
[    5.621696] rk_gmac-dwmac fe1c0000.ethernet end0: IEEE 1588-2008 
Advanced Timestamp supported
[    5.621893] rk_gmac-dwmac fe1c0000.ethernet end0: registered PTP clock
[    5.622196] rk_gmac-dwmac fe1c0000.ethernet end0: configuring for 
phy/rgmii link mode
[    5.623647] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't 
support RGB, something's wrong.
[    5.781862] rtw89_8852be 0004:41:00.0: chip rfe_type is 1
[    5.809977] ACPI: <n/a>: failed to evaluate _DSM 
e8c3a8d2-694b-004f-82bd-fe8607803aa7 rev:0 func:6 (0x1001)
[    5.810363] rtw89_8852be 0004:41:00.0: rfkill hardware state changed 
to enable
[    5.813210] rtw89_8852be 0004:41:00.0 wlP4p65s0: renamed from wlan0
[    6.023955] Bluetooth: hci0: RTL: fw version 0x04479301
[    6.559624] Bluetooth: MGMT ver 1.23
[    6.565153] NET: Registered PF_ALG protocol family
[    6.813274] loop0: detected capacity change from 0 to 8
[    6.813690] Filesystem uses "xz" compression. This is not supported
[    7.338894] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't 
support RGB, something's wrong.
[    9.742796] rk_gmac-dwmac fe1c0000.ethernet end0: Link is Up - 
1Gbps/Full - flow control rx/tx

> ---
>   arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 47 ++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> index 87fce8d9a964cd53d179ce214ae1c0ff505a2dce..1fd122250b0c70e729b7a2239ab5f288a6387a70 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> @@ -5,6 +5,7 @@
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/leds/common.h>
>   #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
>   #include "rk3588s.dtsi"
>   
>   / {
> @@ -35,6 +36,17 @@ chosen {
>   		stdout-path = "serial2:1500000n8";
>   	};
>   
> +	hdmi0-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi0_con_in: endpoint {
> +				remote-endpoint = <&hdmi0_out_con>;
> +			};
> +		};
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> @@ -296,6 +308,26 @@ &gmac1_rgmii_clk
>   	status = "okay";
>   };
>   
> +&hdmi0 {
> +	status = "okay";
> +};
> +
> +&hdmi0_in {
> +	hdmi0_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi0>;
> +	};
> +};
> +
> +&hdmi0_out {
> +	hdmi0_out_con: endpoint {
> +		remote-endpoint = <&hdmi0_con_in>;
> +	};
> +};
> +
> +&hdptxphy_hdmi0 {
> +	status = "okay";
> +};
> +
>   &mdio1 {
>   	rgmii_phy1: ethernet-phy@1 {
>   		/* RTL8211F */
> @@ -788,3 +820,18 @@ &usb_host1_ohci {
>   &usb_host2_xhci {
>   	status = "okay";
>   };
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vop {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi0_in_vp0>;
> +	};
> +};

