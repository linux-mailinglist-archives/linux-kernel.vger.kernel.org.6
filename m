Return-Path: <linux-kernel+bounces-379541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0835D9AE02C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802B91F21974
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDE01B3933;
	Thu, 24 Oct 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="g+IJyeZ/"
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0E2FC52
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761037; cv=none; b=hdkA29Da0ed38BxkTOeHWwdlgHQMnwl4iaN+KIfTJadfV9I1fCGgn/0IVGz9LUZeFXSrDlQMeb3AJGpjsY65q+WsHlrnOZrglWvHziZsvdFP+WkCFpi9Tbv7lKpu+PNtkH5bZ+yREXkuUkjnSlLFA/uSR4V/utxlqrwM45jeo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761037; c=relaxed/simple;
	bh=L4myXpw4mgb9dGIsZfMXu0i+Gkspj7YW7tpED+brbuI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q/ST2MN51ZX/pcuOdDh1bBrjWALKmATwgmysrDr9SIyv4CS5BpzE8FqcIQ8sqzLmdEq4uNxGq01iY2uwJvm+rFr+hrt86tpq/7kfNeX5XL3Zy/3RYZVHd9OLvv9SyGkT+BS6qYDLeE1FsTLv4/w9AbtQMQyzs7Qq4FBc7R1UyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=g+IJyeZ/; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729761026; x=1730020226;
	bh=CYuHQsgcu4ZG4boy3DdDx4oaHfX5s3wPZXP4fdHNw/s=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=g+IJyeZ/MXnF/enP8jqk/Zp2hk7zs7Q+naxSOXwFdeBisp/7iW4leHju7b+42rs3d
	 DdOxuzXWOLt0WxM/7i9S3wrLFN9SLvoBZLZM3nypQUChFcYrE6HIYHMq3QV3nvX8d9
	 gL8n9nePzBQ/mrhDMAJHtpHWwo/0Si1p1lz8zzA4bKCSjhEh37X1TY2lVLDBpSbaGB
	 V2sEMLvC3mcR6MdFL/mVTWCBX7OpsV1ZXycZ6Y6fX/NIEXGeQE5XZN9Vktk4kLBymd
	 JWOfmWXglONThwraGXFrwbvIDOT+wzEx8mYBe7DRc0M3TwS2xvFT//hpBwmaEk/45c
	 dUvsgfnD2Y1iA==
Date: Thu, 24 Oct 2024 09:10:21 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: edjsn0wden <edjsn0wden@proton.me>
Cc: "edjsn0wden@proton.me" <edjsn0wden@proton.me>
Subject: [PATCH] MAINTAINERS: Remove certain entries due to their involvement in the PRISM  (US-984XN) program.
Message-ID: <qUEsjMZ5C95BqPoeHUg8_1SGNjeIrFgKUWInutz3xDjYqsqR6otCKUgCRM1sHfKr7ms5fGBbmVX8vfrRBz06t2jjBegVgKr34uzOi2V1MsQ=@proton.me>
Feedback-ID: 123825025:user:proton
X-Pm-Message-ID: adabb37d7ae71276beb6062ef9fc8a78ebd87f99
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From 60399896ac24e29de97cd82542ad99728963cde1 Mon Sep 17 00:00:00 2001
From: "Ed. J. Sn0wden" <edjsn0wden@proton.me>
Date: Thu, 24 Oct 2024 09:01:22 +0000
Subject: [PATCH] Remove certain entries due to their involvement in the PRI=
SM
 (US-984XN) program.

Companies with a history of unethical practices should be excluded from the=
 maintainers'
list of open-source freedom software to ensure the integrity and trustworth=
iness of the community.
---
 MAINTAINERS | 73 -----------------------------------------------------
 1 file changed, 73 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7fb3..b71ed3019f1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1566,8 +1566,6 @@ M:=09Todd Kjos <tkjos@android.com>
 M:=09Martijn Coenen <maco@android.com>
 M:=09Joel Fernandes <joel@joelfernandes.org>
 M:=09Christian Brauner <christian@brauner.io>
-M:=09Carlos Llamas <cmllamas@google.com>
-M:=09Suren Baghdasaryan <surenb@google.com>
 L:=09linux-kernel@vger.kernel.org
 S:=09Supported
 T:=09git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
@@ -2194,7 +2192,6 @@ F:=09drivers/mmc/host/usdhi6rol0.c
 F:=09drivers/pinctrl/pinctrl-artpec*
=20
 ARM/ASPEED I2C DRIVER
-M:=09Brendan Higgins <brendanhiggins@google.com>
 R:=09Benjamin Herrenschmidt <benh@kernel.crashing.org>
 R:=09Joel Stanley <joel@jms.id.au>
 L:=09linux-i2c@vger.kernel.org
@@ -2739,9 +2736,6 @@ ARM/NUVOTON NPCM ARCHITECTURE
 M:=09Avi Fishman <avifishman70@gmail.com>
 M:=09Tomer Maimon <tmaimon77@gmail.com>
 M:=09Tali Perry <tali.perry1@gmail.com>
-R:=09Patrick Venture <venture@google.com>
-R:=09Nancy Yuen <yuenn@google.com>
-R:=09Benjamin Fair <benjaminfair@google.com>
 L:=09openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:=09Supported
 F:=09Documentation/devicetree/bindings/*/*/*npcm*
@@ -4168,7 +4162,6 @@ R:=09Yonghong Song <yonghong.song@linux.dev>
 R:=09John Fastabend <john.fastabend@gmail.com>
 R:=09KP Singh <kpsingh@kernel.org>
 R:=09Stanislav Fomichev <sdf@fomichev.me>
-R:=09Hao Luo <haoluo@google.com>
 R:=09Jiri Olsa <jolsa@kernel.org>
 L:=09bpf@vger.kernel.org
 S:=09Supported
@@ -4271,7 +4264,6 @@ F:=09kernel/bpf/ringbuf.c
=20
 BPF [SECURITY & LSM] (Security Audit and Enforcement using BPF)
 M:=09KP Singh <kpsingh@kernel.org>
-M:=09Matt Bobrowski <mattbobrowski@google.com>
 L:=09bpf@vger.kernel.org
 S:=09Maintained
 F:=09Documentation/bpf/prog_lsm.rst
@@ -5388,7 +5380,6 @@ S:=09Maintained
 F:=09drivers/watchdog/cros_ec_wdt.c
=20
 CHRONTEL CH7322 CEC DRIVER
-M:=09Joe Tessler <jrt@google.com>
 L:=09linux-media@vger.kernel.org
 S:=09Maintained
 T:=09git git://linuxtv.org/media_tree.git
@@ -5515,7 +5506,6 @@ S:=09Supported
 F:=09drivers/infiniband/hw/usnic/
=20
 CLANG CONTROL FLOW INTEGRITY SUPPORT
-M:=09Sami Tolvanen <samitolvanen@google.com>
 M:=09Kees Cook <kees@kernel.org>
 R:=09Nathan Chancellor <nathan@kernel.org>
 L:=09llvm@lists.linux.dev
@@ -5532,9 +5522,6 @@ F:=09.clang-format
=20
 CLANG/LLVM BUILD SUPPORT
 M:=09Nathan Chancellor <nathan@kernel.org>
-R:=09Nick Desaulniers <ndesaulniers@google.com>
-R:=09Bill Wendling <morbo@google.com>
-R:=09Justin Stitt <justinstitt@google.com>
 L:=09llvm@lists.linux.dev
 S:=09Supported
 W:=09https://clangbuiltlinux.github.io/
@@ -5619,7 +5606,6 @@ F:=09Documentation/process/code-of-conduct-interpreta=
tion.rst
 F:=09Documentation/process/code-of-conduct.rst
=20
 CODE TAGGING
-M:=09Suren Baghdasaryan <surenb@google.com>
 M:=09Kent Overstreet <kent.overstreet@linux.dev>
 S:=09Maintained
 F:=09include/asm-generic/codetag.lds.h
@@ -5653,9 +5639,7 @@ COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
 M:=09Steve French <sfrench@samba.org>
 R:=09Paulo Alcantara <pc@manguebit.com> (DFS, global name space)
 R:=09Ronnie Sahlberg <ronniesahlberg@gmail.com> (directory leases, sparse =
files)
-R:=09Shyam Prasad N <sprasad@microsoft.com> (multichannel)
 R:=09Tom Talpey <tom@talpey.com> (RDMA, smbdirect)
-R:=09Bharath SM <bharathsm@microsoft.com> (deferred close, directory lease=
s)
 L:=09linux-cifs@vger.kernel.org
 L:=09samba-technical@lists.samba.org (moderated for non-subscribers)
 S:=09Supported
@@ -6494,7 +6478,6 @@ F:=09drivers/base/devcoredump.c
 F:=09include/linux/devcoredump.h
=20
 DEVICE DEPENDENCY HELPER SCRIPT
-M:=09Saravana Kannan <saravanak@google.com>
 L:=09linux-kernel@vger.kernel.org
 S:=09Maintained
 F:=09scripts/dev-needs.sh
@@ -6753,8 +6736,6 @@ DMA-BUF HEAPS FRAMEWORK
 M:=09Sumit Semwal <sumit.semwal@linaro.org>
 R:=09Benjamin Gaignard <benjamin.gaignard@collabora.com>
 R:=09Brian Starkey <Brian.Starkey@arm.com>
-R:=09John Stultz <jstultz@google.com>
-R:=09T.J. Mercier <tjmercier@google.com>
 L:=09linux-media@vger.kernel.org
 L:=09dri-devel@lists.freedesktop.org
 L:=09linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
@@ -7618,7 +7599,6 @@ M:=09Tian Tao  <tiantao6@hisilicon.com>
 R:=09Xinwei Kong <kong.kongxinwei@hisilicon.com>
 R:=09Sumit Semwal <sumit.semwal@linaro.org>
 R:=09Yongqin Liu <yongqin.liu@linaro.org>
-R:=09John Stultz <jstultz@google.com>
 L:=09dri-devel@lists.freedesktop.org
 S:=09Maintained
 T:=09git https://gitlab.freedesktop.org/drm/misc/kernel.git
@@ -8085,7 +8065,6 @@ F:=09drivers/edac/
 F:=09include/linux/edac.h
=20
 EDAC-DMC520
-M:=09Lei Wang <lewan@microsoft.com>
 L:=09linux-edac@vger.kernel.org
 S:=09Supported
 F:=09drivers/edac/dmc520_edac.c
@@ -8370,7 +8349,6 @@ M:=09Gao Xiang <xiang@kernel.org>
 M:=09Chao Yu <chao@kernel.org>
 R:=09Yue Hu <huyue2@coolpad.com>
 R:=09Jeffle Xu <jefflexu@linux.alibaba.com>
-R:=09Sandeep Dhavale <dhavale@google.com>
 L:=09linux-erofs@lists.ozlabs.org
 S:=09Maintained
 W:=09https://erofs.docs.kernel.org
@@ -8630,7 +8608,6 @@ F:=09net/core/failover.c
 FANOTIFY
 M:=09Jan Kara <jack@suse.cz>
 R:=09Amir Goldstein <amir73il@gmail.com>
-R:=09Matthew Bobrowski <repnop@google.com>
 L:=09linux-fsdevel@vger.kernel.org
 S:=09Maintained
 F:=09fs/notify/fanotify/
@@ -9635,9 +9612,6 @@ S:=09Maintained
 F:=09drivers/input/touchscreen/goodix*
=20
 GOOGLE ETHERNET DRIVERS
-M:=09Jeroen de Borst <jeroendb@google.com>
-M:=09Praveen Kaligineedi <pkaligineedi@google.com>
-R:=09Shailend Chand <shailend@google.com>
 L:=09netdev@vger.kernel.org
 S:=09Supported
 F:=09Documentation/networking/device_drivers/ethernet/google/gve.rst
@@ -10157,7 +10131,6 @@ F:=09Documentation/scsi/hptiop.rst
 F:=09drivers/scsi/hptiop.c
=20
 HIKEY960 ONBOARD USB GPIO HUB DRIVER
-M:=09John Stultz <jstultz@google.com>
 L:=09linux-kernel@vger.kernel.org
 S:=09Maintained
 F:=09drivers/misc/hisi_hikey_usb.c
@@ -10544,10 +10517,7 @@ S:=09Maintained
 F:=09drivers/media/i2c/hi847.c
=20
 Hyper-V/Azure CORE AND DRIVERS
-M:=09"K. Y. Srinivasan" <kys@microsoft.com>
-M:=09Haiyang Zhang <haiyangz@microsoft.com>
 M:=09Wei Liu <wei.liu@kernel.org>
-M:=09Dexuan Cui <decui@microsoft.com>
 L:=09linux-hyperv@vger.kernel.org
 S:=09Supported
 T:=09git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
@@ -11022,7 +10992,6 @@ F:=09Documentation/devicetree/bindings/iio/multiple=
xer/io-channel-mux.yaml
 F:=09drivers/iio/multiplexer/iio-mux.c
=20
 IIO SCMI BASED DRIVER
-M:=09Jyoti Bhayana <jbhayana@google.com>
 L:=09linux-iio@vger.kernel.org
 S:=09Maintained
 F:=09drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -12216,9 +12185,7 @@ F:=09drivers/hwmon/k8temp.c
=20
 KASAN
 M:=09Andrey Ryabinin <ryabinin.a.a@gmail.com>
-R:=09Alexander Potapenko <glider@google.com>
 R:=09Andrey Konovalov <andreyknvl@gmail.com>
-R:=09Dmitry Vyukov <dvyukov@google.com>
 R:=09Vincenzo Frascino <vincenzo.frascino@arm.com>
 L:=09kasan-dev@googlegroups.com
 S:=09Maintained
@@ -12242,7 +12209,6 @@ F:=09scripts/Kconfig.include
 F:=09scripts/kconfig/
=20
 KCOV
-R:=09Dmitry Vyukov <dvyukov@google.com>
 R:=09Andrey Konovalov <andreyknvl@gmail.com>
 L:=09kasan-dev@googlegroups.com
 S:=09Maintained
@@ -12254,8 +12220,6 @@ F:=09kernel/kcov.c
 F:=09scripts/Makefile.kcov
=20
 KCSAN
-M:=09Marco Elver <elver@google.com>
-R:=09Dmitry Vyukov <dvyukov@google.com>
 L:=09kasan-dev@googlegroups.com
 S:=09Maintained
 F:=09Documentation/dev-tools/kcsan.rst
@@ -12402,9 +12366,6 @@ F:=09fs/smb/common/
 F:=09fs/smb/server/
=20
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
-M:=09Brendan Higgins <brendanhiggins@google.com>
-M:=09David Gow <davidgow@google.com>
-R:=09Rae Moar <rmoar@google.com>
 L:=09linux-kselftest@vger.kernel.org
 L:=09kunit-dev@googlegroups.com
 S:=09Maintained
@@ -12534,7 +12495,6 @@ F:=09tools/testing/selftests/kvm/*/s390x/
 F:=09tools/testing/selftests/kvm/s390x/
=20
 KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)
-M:=09Sean Christopherson <seanjc@google.com>
 M:=09Paolo Bonzini <pbonzini@redhat.com>
 L:=09kvm@vger.kernel.org
 S:=09Supported
@@ -12638,9 +12598,6 @@ W:=09https://kernsec.org/wiki/index.php/Linux_Kerne=
l_Integrity
 F:=09security/integrity/platform_certs
=20
 KFENCE
-M:=09Alexander Potapenko <glider@google.com>
-M:=09Marco Elver <elver@google.com>
-R:=09Dmitry Vyukov <dvyukov@google.com>
 L:=09kasan-dev@googlegroups.com
 S:=09Maintained
 F:=09Documentation/dev-tools/kfence.rst
@@ -12696,9 +12653,6 @@ F:=09mm/kmemleak.c
 F:=09samples/kmemleak/kmemleak-test.c
=20
 KMSAN
-M:=09Alexander Potapenko <glider@google.com>
-R:=09Marco Elver <elver@google.com>
-R:=09Dmitry Vyukov <dvyukov@google.com>
 L:=09kasan-dev@googlegroups.com
 S:=09Maintained
 F:=09Documentation/dev-tools/kmsan.rst
@@ -12776,7 +12730,6 @@ F:=09include/uapi/linux/kvm_para.h
=20
 KVM X86 HYPER-V (KVM/hyper-v)
 M:=09Vitaly Kuznetsov <vkuznets@redhat.com>
-M:=09Sean Christopherson <seanjc@google.com>
 M:=09Paolo Bonzini <pbonzini@redhat.com>
 L:=09kvm@vger.kernel.org
 S:=09Supported
@@ -12790,7 +12743,6 @@ F:=09arch/x86/kvm/vmx/hyperv.*
 KVM X86 Xen (KVM/Xen)
 M:=09David Woodhouse <dwmw2@infradead.org>
 M:=09Paul Durrant <paul@xen.org>
-M:=09Sean Christopherson <seanjc@google.com>
 M:=09Paolo Bonzini <pbonzini@redhat.com>
 L:=09kvm@vger.kernel.org
 S:=09Supported
@@ -12806,7 +12758,6 @@ F:=09net/l3mdev
=20
 LANDLOCK SECURITY MODULE
 M:=09Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
-R:=09G=C3=BCnther Noack <gnoack@google.com>
 L:=09linux-security-module@vger.kernel.org
 S:=09Supported
 W:=09https://landlock.io
@@ -13177,7 +13128,6 @@ F:=09drivers/misc/lis3lv02d/
 F:=09drivers/platform/x86/hp/hp_accel.c
=20
 LIST KUNIT TEST
-M:=09David Gow <davidgow@google.com>
 L:=09linux-kselftest@vger.kernel.org
 L:=09kunit-dev@googlegroups.com
 S:=09Maintained
@@ -14746,7 +14696,6 @@ F:=09mm/mm_init.c
 F:=09tools/testing/memblock/
=20
 MEMORY ALLOCATION PROFILING
-M:=09Suren Baghdasaryan <surenb@google.com>
 M:=09Kent Overstreet <kent.overstreet@linux.dev>
 L:=09linux-mm@kvack.org
 S:=09Maintained
@@ -14819,7 +14768,6 @@ M:=09Andrew Morton <akpm@linux-foundation.org>
 M:=09Liam R. Howlett <Liam.Howlett@oracle.com>
 M:=09Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:=09Vlastimil Babka <vbabka@suse.cz>
-R:=09Jann Horn <jannh@google.com>
 L:=09linux-mm@kvack.org
 S:=09Maintained
 W:=09http://www.linux-mm.org
@@ -14909,7 +14857,6 @@ F:=09drivers/staging/media/meson/vdec/
 META ETHERNET DRIVERS
 M:=09Alexander Duyck <alexanderduyck@fb.com>
 M:=09Jakub Kicinski <kuba@kernel.org>
-R:=09kernel-team@meta.com
 S:=09Supported
 F:=09Documentation/networking/device_drivers/ethernet/meta/
 F:=09drivers/net/ethernet/meta/
@@ -15282,8 +15229,6 @@ F:=09include/linux/cciss*.h
 F:=09include/uapi/linux/cciss*.h
=20
 MICROSOFT MANA RDMA DRIVER
-M:=09Long Li <longli@microsoft.com>
-M:=09Ajay Sharma <sharmaajay@microsoft.com>
 L:=09linux-rdma@vger.kernel.org
 S:=09Supported
 F:=09drivers/infiniband/hw/mana/
@@ -15567,7 +15512,6 @@ F:=09include/dt-bindings/clock/mobileye,eyeq5-clk.h
 MODULE SUPPORT
 M:=09Luis Chamberlain <mcgrof@kernel.org>
 R:=09Petr Pavlu <petr.pavlu@suse.com>
-R:=09Sami Tolvanen <samitolvanen@google.com>
 R:=09Daniel Gomez <da.gomez@samsung.com>
 L:=09linux-modules@vger.kernel.org
 L:=09linux-kernel@vger.kernel.org
@@ -15978,7 +15922,6 @@ F:=09net/core/drop_monitor.c
 NETWORKING DRIVERS
 M:=09Andrew Lunn <andrew+netdev@lunn.ch>
 M:=09"David S. Miller" <davem@davemloft.net>
-M:=09Eric Dumazet <edumazet@google.com>
 M:=09Jakub Kicinski <kuba@kernel.org>
 M:=09Paolo Abeni <pabeni@redhat.com>
 L:=09netdev@vger.kernel.org
@@ -16039,7 +15982,6 @@ F:=09tools/testing/selftests/drivers/net/dsa/
=20
 NETWORKING [GENERAL]
 M:=09"David S. Miller" <davem@davemloft.net>
-M:=09Eric Dumazet <edumazet@google.com>
 M:=09Jakub Kicinski <kuba@kernel.org>
 M:=09Paolo Abeni <pabeni@redhat.com>
 L:=09netdev@vger.kernel.org
@@ -16188,7 +16130,6 @@ F:=09tools/testing/selftests/bpf/*/*mptcp*.c
 F:=09tools/testing/selftests/net/mptcp/
=20
 NETWORKING [TCP]
-M:=09Eric Dumazet <edumazet@google.com>
 L:=09netdev@vger.kernel.org
 S:=09Maintained
 F:=09Documentation/networking/net_cachelines/tcp_sock.rst
@@ -16381,7 +16322,6 @@ S:=09Maintained
 F:=09drivers/input/touchscreen/novatek-nvt-ts.c
=20
 NSDEPS
-M:=09Matthias Maennich <maennich@google.com>
 S:=09Maintained
 F:=09Documentation/core-api/symbol-namespaces.rst
 F:=09scripts/nsdeps
@@ -17218,7 +17158,6 @@ F:=09include/linux/oa_tc6.h
=20
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:=09Rob Herring <robh@kernel.org>
-M:=09Saravana Kannan <saravanak@google.com>
 L:=09devicetree@vger.kernel.org
 S:=09Maintained
 W:=09http://www.devicetree.org/
@@ -17787,7 +17726,6 @@ F:=09drivers/pci/pci-bridge-emul.c
 F:=09drivers/pci/pci-bridge-emul.h
=20
 PCI PEER-TO-PEER DMA (P2PDMA)
-M:=09Bjorn Helgaas <bhelgaas@google.com>
 M:=09Logan Gunthorpe <logang@deltatee.com>
 L:=09linux-pci@vger.kernel.org
 S:=09Supported
@@ -17808,7 +17746,6 @@ F:=09drivers/pci/pwrctl/*
 F:=09include/linux/pci-pwrctl.h
=20
 PCI SUBSYSTEM
-M:=09Bjorn Helgaas <bhelgaas@google.com>
 L:=09linux-pci@vger.kernel.org
 S:=09Supported
 Q:=09https://patchwork.kernel.org/project/linux-pci/list/
@@ -18030,7 +17967,6 @@ M:=09Namhyung Kim <namhyung@kernel.org>
 R:=09Mark Rutland <mark.rutland@arm.com>
 R:=09Alexander Shishkin <alexander.shishkin@linux.intel.com>
 R:=09Jiri Olsa <jolsa@kernel.org>
-R:=09Ian Rogers <irogers@google.com>
 R:=09Adrian Hunter <adrian.hunter@intel.com>
 R:=09"Liang, Kan" <kan.liang@linux.intel.com>
 L:=09linux-perf-users@vger.kernel.org
@@ -18430,7 +18366,6 @@ F:=09include/uapi/linux/pps.h
=20
 PRESSURE STALL INFORMATION (PSI)
 M:=09Johannes Weiner <hannes@cmpxchg.org>
-M:=09Suren Baghdasaryan <surenb@google.com>
 R:=09Peter Ziljstra <peterz@infradead.org>
 S:=09Maintained
 F:=09include/linux/psi*
@@ -20077,7 +20012,6 @@ R:=09Gary Guo <gary@garyguo.net>
 R:=09Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
 R:=09Benno Lossin <benno.lossin@proton.me>
 R:=09Andreas Hindborg <a.hindborg@kernel.org>
-R:=09Alice Ryhl <aliceryhl@google.com>
 R:=09Trevor Gross <tmgross@umich.edu>
 L:=09rust-for-linux@vger.kernel.org
 S:=09Supported
@@ -20462,7 +20396,6 @@ M:=09Juri Lelli <juri.lelli@redhat.com> (SCHED_DEAD=
LINE)
 M:=09Vincent Guittot <vincent.guittot@linaro.org> (SCHED_NORMAL)
 R:=09Dietmar Eggemann <dietmar.eggemann@arm.com> (SCHED_NORMAL)
 R:=09Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
-R:=09Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
 R:=09Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
 R:=09Valentin Schneider <vschneid@redhat.com> (TOPOLOGY)
 L:=09linux-kernel@vger.kernel.org
@@ -21121,7 +21054,6 @@ F:=09drivers/nvmem/layouts/sl28vpd.c
 SLAB ALLOCATOR
 M:=09Christoph Lameter <cl@linux.com>
 M:=09Pekka Enberg <penberg@kernel.org>
-M:=09David Rientjes <rientjes@google.com>
 M:=09Joonsoo Kim <iamjoonsoo.kim@lge.com>
 M:=09Andrew Morton <akpm@linux-foundation.org>
 M:=09Vlastimil Babka <vbabka@suse.cz>
@@ -23202,7 +23134,6 @@ W:=09https://wireless.wiki.kernel.org/en/users/Driv=
ers/wl1251
 F:=09drivers/net/wireless/ti/
=20
 TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
-M:=09John Stultz <jstultz@google.com>
 M:=09Thomas Gleixner <tglx@linutronix.de>
 R:=09Stephen Boyd <sboyd@kernel.org>
 L:=09linux-kernel@vger.kernel.org
@@ -23261,7 +23192,6 @@ F:=09Documentation/hwmon/tmp513.rst
 F:=09drivers/hwmon/tmp513.c
=20
 TMPFS (SHMEM FILESYSTEM)
-M:=09Hugh Dickins <hughd@google.com>
 L:=09linux-mm@kvack.org
 S:=09Maintained
 F:=09include/linux/shmem_fs.h
@@ -23570,7 +23500,6 @@ F:=09include/uapi/linux/ublk_cmd.h
=20
 UBSAN
 M:=09Kees Cook <kees@kernel.org>
-R:=09Marco Elver <elver@google.com>
 R:=09Andrey Konovalov <andreyknvl@gmail.com>
 R:=09Andrey Ryabinin <ryabinin.a.a@gmail.com>
 L:=09kasan-dev@googlegroups.com
@@ -24586,7 +24515,6 @@ M:=09Andrew Morton <akpm@linux-foundation.org>
 M:=09Liam R. Howlett <Liam.Howlett@oracle.com>
 M:=09Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:=09Vlastimil Babka <vbabka@suse.cz>
-R:=09Jann Horn <jannh@google.com>
 L:=09linux-mm@kvack.org
 S:=09Maintained
 W:=09https://www.linux-mm.org
@@ -25584,7 +25512,6 @@ K:=09zstd
=20
 ZSWAP COMPRESSED SWAP CACHING
 M:=09Johannes Weiner <hannes@cmpxchg.org>
-M:=09Yosry Ahmed <yosryahmed@google.com>
 M:=09Nhat Pham <nphamcs@gmail.com>
 R:=09Chengming Zhou <chengming.zhou@linux.dev>
 L:=09linux-mm@kvack.org
--=20
2.46.2



