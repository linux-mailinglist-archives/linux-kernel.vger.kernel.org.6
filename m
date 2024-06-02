Return-Path: <linux-kernel+bounces-198380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7D8D7778
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE91E1F21379
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 18:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849CE6D1B2;
	Sun,  2 Jun 2024 18:28:17 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647939FDD
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717352896; cv=none; b=cTtyUnnlKXS2q8mKcsnIfRQDcG0EQ+k1Vp8gP+ZnnHe+v2GVEsRwbGS9oOKoQTrY2+Pq+PiIkRBt+nzRzWxEUTdo7Oh4vs1TmadAbmtCDzFqbotzDGHDr9konqrT2tFYmcBgCX/F1wBAfDu/K+cF0CBzpif51qbzPJNvM9/Nh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717352896; c=relaxed/simple;
	bh=8a6IcoiPTViCJV5pFGHC0h7AOVRxZEdKz4E03FTqz3Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r6T5GJoQdhY1K5t2SdbcOY7GANk8POhDleIJP66qBgrZB1zKkicBUQa4hli25t0MYhp4f3n5EFlbVMg0pKFjMRzvchmzjoIauIkn91gWs8PgwlnaWRljPBypKJXr5NNh9GeyYT06KskahlMVB3lKEI6nRkvUmoHY4FdeY+niOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id F22E41A0337;
	Sun,  2 Jun 2024 18:17:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 4A83380009;
	Sun,  2 Jun 2024 18:17:56 +0000 (UTC)
Message-ID: <00cad298b292fe061d56e3909ab981ec0d476cf0.camel@perches.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
From: Joe Perches <joe@perches.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Mateusz Guzik
	 <mjguzik@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, =?ISO-8859-1?Q?=CD=F1igo?=
 Huguet <ihuguet@redhat.com>, Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
 Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org, danny@kdrag0n.dev,
 jgg@nvidia.com, mic@digikod.net,  linux-kernel@vger.kernel.org,
 linux@rasmusvillemoes.dk, willy@infradead.org
Date: Sun, 02 Jun 2024 11:17:55 -0700
In-Reply-To: <CANiq72kSyHxLUFYA0KyXoQszHoZpTXyN5oPyx2OMbQZVG4dzcg@mail.gmail.com>
References: <20230601075333.14021-1-ihuguet@redhat.com>
	 <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
	 <874jiikr6e.fsf@meer.lwn.net>
	 <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
	 <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
	 <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com>
	 <thbrfziusf37nj5mwsj2a6zmjtenj5b5vhzwu2z5zkhr7ajsg6@whvx46y6mxbz>
	 <CANiq72kSyHxLUFYA0KyXoQszHoZpTXyN5oPyx2OMbQZVG4dzcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4A83380009
X-Stat-Signature: 1x8m7xmhk3cw3jpgtw8ahwjudum6nimg
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+DMmXGuQVGYOrDNQGP6Y0qIDMBY3Uvs1I=
X-HE-Tag: 1717352276-595448
X-HE-Meta: U2FsdGVkX18opUe9vPqZC06UaJ3SZwXKeAyUJzzr8OX39fBtGURpQqVV0y2HDuY6Bkbf7a/8I6PxixqXKf9QfI1/0g6oUJSrEcN9XQUkvK6KBmtlpVml/BnKSpLfkxPcdTdCKt5taxmvPs6Ex2RkH1xcvHpL2dyUsWyDkBmqoku+tP9Cp4vpBSN4GjphjQroGPPX+H7rt8bl6SF7TCxLA2cgahDY3OG8wWzCwYg7oVYjc8o02v6iP/Vm2ICJJlOGwhkZjfMSn9gNJGDyidyYLpKZgsgC1GXpXG7prh3SJnienT4p3iqd70yFn4q+k/QNwIAlW5WwMXZeqKuVZ33sJm1144DyGEzc

On Sun, 2024-06-02 at 18:28 +0200, Miguel Ojeda wrote:
> On Sun, Jun 2, 2024 at 5:31=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> >=20
> > You can try yourself by editing fs/dcache.c or fs/bad_inode.c.
> >=20
> > It stems from this line:
> > trim_trailing_whitespace =3D true
> >=20
> > The problem is dodged by setting it to false or adding this to
> > ~/.config/nvim/init.lua:
> > vim.g.editorconfig =3D false
> >=20
> > Is there a non-giant-hammer method to disable the thing? Maybe some lua
> > magic to special-case that this is the kernel tree?
>=20
> It may be possible to disable it for particular folder/patterns and
> then try to get their maintainers to do a sweep eventually.

Not too likely as trailing spaces are all over the tree

Ugly grep:

$ git ls-tree -d -r --name-only HEAD | \
  while read dir ; do \
    echo -n "$dir " ; git grep -c -h -P "\s$" -- $dir | \
    awk '{count +=3D $1} END {print count}'; \
  done | \
  grep -P " \d+$"
Documentation 1498
Documentation/ABI 1
Documentation/ABI/testing 1
Documentation/PCI 1
Documentation/admin-guide 18
Documentation/admin-guide/aoe 5
Documentation/admin-guide/media 1
Documentation/arch 10
Documentation/arch/arm64 9
Documentation/arch/sparc 1
Documentation/arch/sparc/oradax 1
Documentation/bpf 2
Documentation/core-api 1
Documentation/dev-tools 1
Documentation/devicetree 12
Documentation/devicetree/bindings 12
Documentation/devicetree/bindings/interrupt-controller 6
Documentation/devicetree/bindings/misc 1
Documentation/devicetree/bindings/regulator 3
Documentation/devicetree/bindings/sound 1
Documentation/devicetree/bindings/watchdog 1
Documentation/driver-api 282
Documentation/driver-api/usb 257
Documentation/filesystems 7
Documentation/filesystems/ext4 4
Documentation/filesystems/xfs 1
Documentation/firmware-guide 1
Documentation/firmware-guide/acpi 1
Documentation/firmware_class 1
Documentation/images 7
Documentation/leds 1
Documentation/locking 1
Documentation/maintainer 1
Documentation/mm 1
Documentation/networking 462
Documentation/networking/net_cachelines 460
Documentation/process 2
Documentation/scsi 401
Documentation/sound 183
Documentation/sound/cards 103
Documentation/sound/designs 2
Documentation/sound/hd-audio 10
Documentation/sound/kernel-api 19
Documentation/sound/soc 5
Documentation/sphinx-static 1
Documentation/trace 93
Documentation/translations 3
Documentation/translations/ja_JP 1
Documentation/translations/zh_CN 1
Documentation/translations/zh_CN/admin-guide 1
Documentation/translations/zh_TW 1
Documentation/translations/zh_TW/admin-guide 1
Documentation/usb 5
LICENSES 6
LICENSES/dual 1
LICENSES/preferred 5
arch 4635
arch/alpha 825
arch/alpha/boot 14
arch/alpha/boot/tools 2
arch/alpha/include 77
arch/alpha/include/asm 67
arch/alpha/include/uapi 10
arch/alpha/include/uapi/asm 10
arch/alpha/kernel 711
arch/alpha/lib 19
arch/alpha/math-emu 3
arch/alpha/mm 1
arch/arm 95
arch/arm/boot 10
arch/arm/boot/compressed 8
arch/arm/boot/dts 2
arch/arm/boot/dts/ti 2
arch/arm/boot/dts/ti/omap 2
arch/arm/common 2
arch/arm/include 12
arch/arm/include/asm 8
arch/arm/include/debug 2
arch/arm/include/uapi 2
arch/arm/include/uapi/asm 2
arch/arm/kernel 8
arch/arm/lib 5
arch/arm/mach-ep93xx 2
arch/arm/mach-omap2 1
arch/arm/mach-pxa 1
arch/arm/mach-rpc 5
arch/arm/mach-rpc/include 3
arch/arm/mach-rpc/include/mach 3
arch/arm/mach-s3c 2
arch/arm/mach-sa1100 6
arch/arm/mach-sa1100/include 3
arch/arm/mach-sa1100/include/mach 3
arch/arm/mm 20
arch/arm/nwfpe 18
arch/arm/xen 2
arch/arm64 2
arch/arm64/boot 1
arch/arm64/boot/dts 1
arch/arm64/boot/dts/amlogic 1
arch/arm64/kvm 1
arch/m68k 261
arch/m68k/coldfire 22
arch/m68k/include 236
arch/m68k/include/asm 236
arch/m68k/kernel 1
arch/m68k/lib 1
arch/m68k/mac 1
arch/parisc 2637
arch/parisc/include 81
arch/parisc/include/asm 77
arch/parisc/include/uapi 4
arch/parisc/include/uapi/asm 4
arch/parisc/kernel 1823
arch/parisc/lib 32
arch/parisc/math-emu 699
arch/parisc/mm 2
arch/powerpc 245
arch/powerpc/boot 27
arch/powerpc/boot/dts 8
arch/powerpc/crypto 1
arch/powerpc/include 29
arch/powerpc/include/asm 20
arch/powerpc/include/uapi 9
arch/powerpc/include/uapi/asm 9
arch/powerpc/kernel 116
arch/powerpc/kernel/ptrace 2
arch/powerpc/lib 3
arch/powerpc/mm 1
arch/powerpc/mm/nohash 1
arch/powerpc/perf 1
arch/powerpc/platforms 33
arch/powerpc/platforms/44x 4
arch/powerpc/platforms/chrp 1
arch/powerpc/platforms/maple 2
arch/powerpc/platforms/powermac 15
arch/powerpc/platforms/pseries 11
arch/powerpc/sysdev 2
arch/powerpc/xmon 32
arch/s390 32
arch/s390/include 8
arch/s390/include/asm 5
arch/s390/include/uapi 3
arch/s390/include/uapi/asm 3
arch/s390/kernel 24
arch/sh 62
arch/sh/boards 4
arch/sh/boards/mach-se 1
arch/sh/boards/mach-se/770x 1
arch/sh/boot 1
arch/sh/boot/compressed 1
arch/sh/drivers 1
arch/sh/drivers/dma 1
arch/sh/include 2
arch/sh/include/asm 2
arch/sh/kernel 33
arch/sh/kernel/cpu 26
arch/sh/kernel/cpu/sh2 13
arch/sh/kernel/cpu/sh2a 10
arch/sh/kernel/cpu/sh3 3
arch/sh/lib 17
arch/sparc 244
arch/sparc/crypto 1
arch/sparc/include 45
arch/sparc/include/asm 22
arch/sparc/include/uapi 23
arch/sparc/include/uapi/asm 23
arch/sparc/kernel 123
arch/sparc/lib 42
arch/sparc/math-emu 9
arch/sparc/mm 17
arch/sparc/prom 7
arch/um 51
arch/um/drivers 21
arch/um/include 19
arch/um/include/asm 13
arch/um/include/shared 6
arch/um/kernel 3
arch/um/os-Linux 6
arch/um/os-Linux/drivers 5
arch/x86 134
arch/x86/boot 7
arch/x86/boot/compressed 2
arch/x86/events 1
arch/x86/events/intel 1
arch/x86/include 4
arch/x86/include/asm 4
arch/x86/kernel 5
arch/x86/kernel/acpi 1
arch/x86/lib 49
arch/x86/math-emu 40
arch/x86/mm 5
arch/x86/pci 9
arch/x86/realmode 4
arch/x86/realmode/rm 4
arch/x86/um 8
arch/x86/um/asm 2
arch/x86/um/shared 2
arch/x86/um/shared/sysdep 2
arch/x86/xen 1
arch/xtensa 47
arch/xtensa/kernel 11
arch/xtensa/mm 15
arch/xtensa/variants 21
arch/xtensa/variants/csp 4
arch/xtensa/variants/csp/include 4
arch/xtensa/variants/csp/include/variant 4
arch/xtensa/variants/dc233c 3
arch/xtensa/variants/dc233c/include 3
arch/xtensa/variants/dc233c/include/variant 3
arch/xtensa/variants/de212 4
arch/xtensa/variants/de212/include 4
arch/xtensa/variants/de212/include/variant 4
arch/xtensa/variants/test_kc705_be 6
arch/xtensa/variants/test_kc705_be/include 6
arch/xtensa/variants/test_kc705_be/include/variant 6
arch/xtensa/variants/test_kc705_hifi 4
arch/xtensa/variants/test_kc705_hifi/include 4
arch/xtensa/variants/test_kc705_hifi/include/variant 4
block 17
block/partitions 17
crypto 27
drivers 9947
drivers/acpi 7
drivers/ata 1
drivers/atm 1968
drivers/base 4
drivers/base/regmap 2
drivers/block 83
drivers/bus 2
drivers/cdrom 49
drivers/char 122
drivers/char/agp 1
drivers/char/ipmi 3
drivers/char/mwave 34
drivers/char/tpm 14
drivers/char/xilinx_hwicap 2
drivers/clk 2
drivers/clk/imx 2
drivers/clocksource 3
drivers/connector 1
drivers/cpufreq 10
drivers/cpuidle 1
drivers/crypto 2
drivers/dma 2
drivers/dma/bestcomm 1
drivers/extcon 1
drivers/gpu 3139
drivers/gpu/drm 3139
drivers/gpu/drm/amd 2191
drivers/gpu/drm/amd/amdgpu 20
drivers/gpu/drm/amd/display 4
drivers/gpu/drm/amd/display/dc 4
drivers/gpu/drm/amd/display/dc/dce 2
drivers/gpu/drm/amd/display/dc/dml2 1
drivers/gpu/drm/amd/display/dc/resource 1
drivers/gpu/drm/amd/display/dc/resource/dcn301 1
drivers/gpu/drm/amd/include 1805
drivers/gpu/drm/amd/include/asic_reg 1127
drivers/gpu/drm/amd/include/asic_reg/nbif 1127
drivers/gpu/drm/amd/include/ivsrcid 376
drivers/gpu/drm/amd/include/ivsrcid/dcn 350
drivers/gpu/drm/amd/include/ivsrcid/sdma1 2
drivers/gpu/drm/amd/pm 362
drivers/gpu/drm/amd/pm/powerplay 44
drivers/gpu/drm/amd/pm/powerplay/hwmgr 1
drivers/gpu/drm/amd/pm/powerplay/inc 43
drivers/gpu/drm/amd/pm/powerplay/inc/vega12 5
drivers/gpu/drm/amd/pm/swsmu 318
drivers/gpu/drm/amd/pm/swsmu/inc 317
drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if 299
drivers/gpu/drm/amd/pm/swsmu/smu13 1
drivers/gpu/drm/msm 15
drivers/gpu/drm/msm/dp 2
drivers/gpu/drm/msm/registers 13
drivers/gpu/drm/msm/registers/adreno 1
drivers/gpu/drm/msm/registers/display 1
drivers/gpu/drm/nouveau 7
drivers/gpu/drm/nouveau/include 7
drivers/gpu/drm/nouveau/include/nvrm 7
drivers/gpu/drm/nouveau/include/nvrm/535.113.01 7
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/common 4
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/common/sdk 4
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/common/sdk/nvidia 4
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/common/sdk/nvidia/inc 4
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/common/sdk/nvidia/inc/ctrl =
4
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/common/sdk/nvidia/inc/ctrl/=
ctrla06f 3
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia 3
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/arch 1
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/arch/nvalloc 1
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/arch/nvalloc/common =
1
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/arch/nvalloc/common/=
inc 1
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/kernel 2
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/kernel/inc 2
drivers/gpu/drm/nouveau/include/nvrm/535.113.01/nvidia/kernel/inc/vgpu 2
drivers/gpu/drm/radeon 926
drivers/hid 36
drivers/hid/usbhid 3
drivers/hwmon 2
drivers/i2c 17
drivers/i2c/busses 16
drivers/iio 3
drivers/iio/dac 1
drivers/iio/gyro 1
drivers/iio/potentiometer 1
drivers/infiniband 4
drivers/infiniband/hw 4
drivers/infiniband/hw/hfi1 2
drivers/infiniband/hw/mlx4 1
drivers/infiniband/hw/qib 1
drivers/input 25
drivers/input/joystick 1
drivers/input/keyboard 2
drivers/input/misc 17
drivers/input/mouse 1
drivers/input/serio 4
drivers/irqchip 1
drivers/macintosh 125
drivers/md 1
drivers/md/bcache 1
drivers/memstick 1
drivers/memstick/core 1
drivers/message 8
drivers/message/fusion 8
drivers/mfd 216
drivers/misc 1
drivers/misc/cxl 1
drivers/mmc 3
drivers/mmc/core 3
drivers/mtd 8
drivers/mtd/maps 1
drivers/mtd/nand 3
drivers/mtd/nand/onenand 2
drivers/mtd/nand/raw 1
drivers/net 658
drivers/net/ethernet 187
drivers/net/ethernet/3com 22
drivers/net/ethernet/8390 95
drivers/net/ethernet/chelsio 5
drivers/net/ethernet/chelsio/cxgb 4
drivers/net/ethernet/chelsio/cxgb3 1
drivers/net/ethernet/dec 4
drivers/net/ethernet/dec/tulip 4
drivers/net/ethernet/fujitsu 36
drivers/net/ethernet/i825xx 3
drivers/net/ethernet/marvell 3
drivers/net/ethernet/marvell/octeon_ep 3
drivers/net/ethernet/seeq 1
drivers/net/ethernet/sfc 2
drivers/net/ethernet/silan 1
drivers/net/ethernet/smsc 12
drivers/net/ethernet/xircom 3
drivers/net/fddi 115
drivers/net/fddi/skfp 115
drivers/net/fddi/skfp/h 34
drivers/net/hamradio 318
drivers/net/wan 20
drivers/net/wireless 18
drivers/net/wireless/ath 1
drivers/net/wireless/ath/ath9k 1
drivers/net/wireless/intel 1
drivers/net/wireless/intel/ipw2x00 1
drivers/net/wireless/ralink 1
drivers/net/wireless/ralink/rt2x00 1
drivers/net/wireless/rsi 11
drivers/net/wireless/ti 4
drivers/net/wireless/ti/wl1251 3
drivers/net/wireless/ti/wlcore 1
drivers/nvme 1
drivers/nvme/host 1
drivers/parisc 323
drivers/parport 46
drivers/pcmcia 92
drivers/platform 4
drivers/platform/x86 4
drivers/pnp 3
drivers/pnp/pnpbios 3
drivers/power 1
drivers/power/supply 1
drivers/powercap 4
drivers/regulator 1
drivers/s390 27
drivers/s390/char 25
drivers/s390/cio 2
drivers/sbus 39
drivers/sbus/char 39
drivers/scsi 1829
drivers/scsi/aacraid 40
drivers/scsi/aic7xxx 170
drivers/scsi/aic7xxx/aicasm 15
drivers/scsi/arcmsr 7
drivers/scsi/arm 18
drivers/scsi/ibmvscsi 30
drivers/scsi/megaraid 7
drivers/scsi/pcmcia 43
drivers/scsi/sym53c8xx_2 789
drivers/soc 1
drivers/soc/bcm 1
drivers/soc/bcm/brcmstb 1
drivers/soc/bcm/brcmstb/pm 1
drivers/staging 2
drivers/staging/rtl8712 1
drivers/staging/rtl8723bs 1
drivers/staging/rtl8723bs/include 1
drivers/target 1
drivers/target/iscsi 1
drivers/tty 300
drivers/tty/hvc 3
drivers/tty/serial 46
drivers/tty/serial/8250 1
drivers/tty/vt 239
drivers/usb 255
drivers/usb/atm 1
drivers/usb/chipidea 1
drivers/usb/class 1
drivers/usb/gadget 1
drivers/usb/host 5
drivers/usb/image 15
drivers/usb/misc 51
drivers/usb/musb 1
drivers/usb/serial 45
drivers/usb/storage 133
drivers/video 509
drivers/video/console 24
drivers/video/fbdev 483
drivers/video/fbdev/aty 109
drivers/video/fbdev/core 1
drivers/video/fbdev/i810 211
drivers/video/fbdev/matrox 91
drivers/video/fbdev/riva 62
drivers/video/logo 2
drivers/xen 3
drivers/xen/events 1
fs 1703
fs/adfs 2
fs/affs 3
fs/befs 90
fs/bfs 3
fs/btrfs 2
fs/cachefiles 1
fs/coda 115
fs/dlm 6
fs/efs 16
fs/ext2 50
fs/freevxfs 18
fs/gfs2 17
fs/hfs 1
fs/hpfs 40
fs/isofs 11
fs/jbd2 1
fs/jffs2 32
fs/lockd 5
fs/nfs 30
fs/nfs/flexfilelayout 1
fs/nfsd 32
fs/nls 1006
fs/ocfs2 7
fs/ocfs2/cluster 1
fs/omfs 1
fs/openpromfs 2
fs/proc 12
fs/qnx4 5
fs/reiserfs 5
fs/smb 1
fs/smb/client 1
fs/sysv 12
fs/ubifs 1
fs/ufs 114
fs/xfs 1
include 785
include/crypto 9
include/crypto/internal 3
include/linux 223
include/linux/byteorder 1
include/linux/fsl 1
include/linux/fsl/bestcomm 1
include/linux/isdn 5
include/linux/mfd 2
include/linux/sunrpc 8
include/math-emu 20
include/net 40
include/net/sctp 6
include/scsi 18
include/sound 82
include/trace 4
include/trace/events 4
include/uapi 329
include/uapi/asm-generic 4
include/uapi/drm 1
include/uapi/linux 311
include/uapi/linux/isdn 3
include/uapi/linux/netfilter 2
include/uapi/linux/netfilter_bridge 4
include/uapi/linux/netfilter_ipv4 1
include/uapi/linux/netfilter_ipv6 3
include/uapi/linux/nfsd 1
include/uapi/linux/tc_act 2
include/uapi/sound 7
include/uapi/xen 6
include/video 58
include/xen 2
include/xen/interface 2
include/xen/interface/hvm 1
init 1
kernel 6
kernel/rcu 1
kernel/trace 2
lib 47
lib/fonts 5
lib/zlib_deflate 12
lib/zlib_inflate 2
mm 2
net 9
net/bluetooth 1
net/ipv4 1
net/mac80211 1
net/netfilter 6
net/netfilter/ipset 1
net/netfilter/ipvs 5
samples 1
samples/connector 1
scripts 21
scripts/gcc-plugins 1
scripts/kconfig 17
scripts/kconfig/tests 17
scripts/kconfig/tests/auto_submenu 7
scripts/kconfig/tests/choice 8
scripts/kconfig/tests/new_choice_with_dep 2
security 4
security/apparmor 1
sound 2833
sound/aoa 3
sound/aoa/fabrics 1
sound/aoa/soundbus 1
sound/core 254
sound/core/oss 56
sound/core/seq 114
sound/core/seq/oss 19
sound/drivers 178
sound/drivers/mpu401 4
sound/drivers/opl3 31
sound/drivers/vx 36
sound/i2c 18
sound/i2c/other 6
sound/isa 366
sound/isa/ad1816a 7
sound/isa/ad1848 1
sound/isa/cs423x 24
sound/isa/es1688 12
sound/isa/gus 35
sound/isa/opti9xx 22
sound/isa/sb 51
sound/isa/wavefront 177
sound/oss 2
sound/oss/dmasound 2
sound/parisc 62
sound/pci 1824
sound/pci/ac97 79
sound/pci/ali5451 54
sound/pci/au88x0 37
sound/pci/ca0106 88
sound/pci/cs46xx 447
sound/pci/cs5535audio 9
sound/pci/echoaudio 11
sound/pci/emu10k1 168
sound/pci/hda 16
sound/pci/ice1712 60
sound/pci/korg1212 12
sound/pci/mixart 27
sound/pci/nm256 19
sound/pci/riptide 10
sound/pci/rme9652 63
sound/pci/trident 201
sound/pci/vx222 3
sound/pci/ymfpci 33
sound/pcmcia 18
sound/pcmcia/pdaudiocf 11
sound/pcmcia/vx 7
sound/ppc 23
sound/sh 1
sound/soc 40
sound/soc/bcm 2
sound/soc/cirrus 1
sound/soc/codecs 35
sound/soc/sh 1
sound/synth 18
sound/synth/emux 18
sound/usb 6
tools 151
tools/bootconfig 2
tools/bootconfig/samples 2
tools/include 15
tools/include/uapi 15
tools/include/uapi/linux 15
tools/perf 34
tools/perf/Documentation 9
tools/perf/scripts 1
tools/perf/scripts/perl 1
tools/perf/scripts/perl/Perf-Trace-Util 1
tools/perf/tests 16
tools/perf/trace 3
tools/perf/trace/beauty 3
tools/perf/trace/beauty/include 2
tools/perf/trace/beauty/include/uapi 2
tools/perf/trace/beauty/include/uapi/linux 2
tools/perf/util 3
tools/power 57
tools/power/cpupower 56
tools/power/cpupower/bench 1
tools/power/cpupower/debug 2
tools/power/cpupower/debug/i386 2
tools/power/cpupower/man 50
tools/power/cpupower/utils 2
tools/power/cpupower/utils/helpers 1
tools/power/pm-graph 1
tools/power/pm-graph/config 1
tools/testing 36
tools/testing/ktest 7
tools/testing/ktest/examples 5
tools/testing/selftests 29
tools/testing/selftests/alsa 1
tools/testing/selftests/arm64 3
tools/testing/selftests/arm64/fp 3
tools/testing/selftests/bpf 3
tools/testing/selftests/bpf/prog_tests 1
tools/testing/selftests/bpf/progs 1
tools/testing/selftests/ftrace 3
tools/testing/selftests/ftrace/test.d 3
tools/testing/selftests/ftrace/test.d/ftrace 3
tools/testing/selftests/kvm 1
tools/testing/selftests/kvm/x86_64 1
tools/testing/selftests/net 15
tools/testing/selftests/net/netfilter 13
tools/testing/selftests/net/openvswitch 1
tools/testing/selftests/rcutorture 2
tools/testing/selftests/rcutorture/bin 2
tools/testing/selftests/x86 1
tools/virtio 7
tools/virtio/linux 1
tools/virtio/ringtest 4


