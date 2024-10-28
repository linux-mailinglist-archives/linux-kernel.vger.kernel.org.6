Return-Path: <linux-kernel+bounces-384326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D71389B292B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061F71C2163E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5B21D88C3;
	Mon, 28 Oct 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2BgYyqWz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6KynMN7o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158918FC85
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100936; cv=none; b=RlKRAO1og4lBhsFeyfFveeaBghChZhfZcCRMxcVrUCmZSrbcF5g47b1GGclE2UWaoJyRV0yc240bg51PUA0Jnro9ny270M7eIFM8c3LLv8EDXTiWi9AdlIRxhrbDn5OeyyRiCeIbFGhDoiAlLhn23M0R3jqAVbJr0yJARuqw4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100936; c=relaxed/simple;
	bh=PFl4WMBhSjlJPRf+OZU+7UFdgAd+/rfiuufOUvu3uQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RgbVKxrsQlvckycxRerfNg63Cky9MZIfu7u9Q3yeoGg+JwnMPf2x1iTVuazxYOfzo3CljqQ45oW1l30BDbiBNrxWQxFTYPcRHSztxT2BI+6In89rOeeQvDSS8emL+3Sb7KxnWX1tLYoLRdGEtuZWyylAuJpal3ohFWN3BR+bSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2BgYyqWz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6KynMN7o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AlRtxb07iRMVIg/LUtMP0IBE/9RrVRCJwo0Cho1Un1Y=;
	b=2BgYyqWzFi9hSIhfYTohAZG6jGsUEQM4rsudpQktOvkMpPQfgTHcWjAgeh0VWkBdEw23Pr
	R25HmbLXaafgPmGA/O8Gea5RBMs5zEG8tE844fxJ0SRAqpYlPxZL92ThLqfu24WFtBqhdn
	ab611GgR+MQnyixIYiFp3yQ/4NNbDyYTKXfAYqMH4Duc33dF9nGnrS+XCEcnsO6GacK5J1
	VxEg6qqIiE9sbX0GL21UrZrOw1fm4jf3h/wDeOq4pfYcRyq+E0NoGt4ANwF3Q6yBEa3Kqq
	tMjbWl4RtfR8dqFgKFSGJECV04VmkMhdQxTlCTc3+r3aCFPvmPSI7Ia/t+24qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AlRtxb07iRMVIg/LUtMP0IBE/9RrVRCJwo0Cho1Un1Y=;
	b=6KynMN7o2OknCRmcNvthguKIL1jqFi0zitFA/yFa2lzJ3I99FzcO0P+VPuZda327kG+zM9
	CiA2lNTKjOzX/dAg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Will Deacon <will@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Pavel Machek <pavel@ucw.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rob Clark <robdclark@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 00/44] hrtimers: Switch to new hrtimer interface functions (4/5)
Date: Mon, 28 Oct 2024 08:34:36 +0100
Message-Id: <cover.1729865485.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is the forth part of a 5-part series (split for convenience). All 5
parts are:

Part 1: https://lore.kernel.org/lkml/cover.1729864615.git.namcao@linutronix=
.de
Part 2: https://lore.kernel.org/lkml/cover.1729864823.git.namcao@linutronix=
.de
Part 3: https://lore.kernel.org/lkml/cover.1729865232.git.namcao@linutronix=
.de
Part 4: https://lore.kernel.org/lkml/cover.1729865485.git.namcao@linutronix=
.de
Part 5: https://lore.kernel.org/lkml/cover.1729865740.git.namcao@linutronix=
.de

To use hrtimer, hrtimer_init() (or one of its variant) must be called, and
also the timer's callfack function must be setup separately.

That can cause misuse of hrtimer. For example, because:
  - The callback function is not setup
  - The callback function is setup while it is not safe to do so

To prevent misuse of hrtimer, this series:
  - Introduce new functions hrtimer_setup*(). These new functions are
    similar to hrtimer_init*(), except that they also sanity-check and
    initialize the callback function.
  - Introduce hrtimer_update_function() which checks that it is safe to
    change the callback function. The 'function' field of hrtimer is then
    made private.
  - Convert all users to use the new functions.
  - Some minor cleanups on the way.

Most conversion patches were created using Coccinelle with the sematic
patch below; except for tricky cases that Coccinelle cannot handle, or for
some cases where a Coccinelle's bug regarding 100 column limit is
triggered. Any patches not mentioning Coccinelle were done manually.

virtual patch
@@ expression timer, clock, mode, func; @@
- hrtimer_init(timer, clock, mode);
  ...
- timer->function =3D func;
+ hrtimer_setup(timer, func, clock, mode);

@@ expression timer, clock, mode, func; @@
- hrtimer_init(&timer, clock, mode);
  ...
- timer.function =3D func;
+ hrtimer_setup(&timer, func, clock, mode);

@@ expression timer, clock, mode, func; @@
- hrtimer_init_on_stack(&timer, clock, mode);
  ...
- timer.function =3D func;
+ hrtimer_setup_on_stack(&timer, func, clock, mode);

@@ expression timer, clock, mode; @@
- hrtimer_init_sleeper_on_stack(timer, clock, mode);
+ hrtimer_setup_sleeper_on_stack(timer, clock, mode);

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>

Nam Cao (44):
  USB: chipidea: Switch to use hrtimer_setup()
  usb: dwc2: Switch to use hrtimer_setup()
  usb: fotg210-hcd: Switch to use hrtimer_setup()
  usb: gadget: Switch to use hrtimer_setup()
  usb: ehci: Switch to use hrtimer_setup()
  usb: musb: cppi41: Switch to use hrtimer_setup()
  usb: typec: tcpm: Switch to use hrtimer_setup()
  serial: 8250: Switch to use hrtimer_setup()
  serial: imx: Switch to use hrtimer_setup()
  serial: sh-sci: Switch to use hrtimer_setup()
  serial: xilinx_uartps: Switch to use hrtimer_setup()
  scsi: Switch to use hrtimer_setup()
  rtc: class: Switch to use hrtimer_setup()
  pps: generators: pps_gen_parport: Switch to use hrtimer_setup()
  powercap: Switch to use hrtimer_setup()
  power: supply: ab8500_chargalg: Switch to use hrtimer_setup()
  power: reset: ltc2952-poweroff: Switch to use hrtimer_setup()
  drivers: perf: Switch to use hrtimer_setup()
  ntb: ntb_pingpong: Switch to use hrtimer_setup()
  mmc: dw_mmc: Switch to use hrtimer_setup()
  misc: vcpu_stall_detector: Switch to use hrtimer_setup()
  media: Switch to use hrtimer_setup()
  mailbox: Switch to use hrtimer_setup()
  leds: trigger: pattern: Switch to use hrtimer_setup()
  Input: Switch to use hrtimer_setup()
  iio: Switch to use hrtimer_setup()
  i2c: Switch to use hrtimer_setup()
  stm class: heartbeat: Switch to use hrtimer_setup()
  drm/amdgpu: Switch to use hrtimer_setup()
  drm/i915/huc: Switch to use hrtimer_setup()
  drm/i915/gvt: Switch to use hrtimer_setup()
  drm/i915/perf: Switch to use hrtimer_setup()
  drm/i915/pmu: Switch to use hrtimer_setup()
  drm/i915/uncore: Switch to use hrtimer_setup()
  drm/i915/request: Switch to use hrtimer_setup()
  drm/msm: Switch to use hrtimer_setup()
  drm/vkms: Switch to use hrtimer_setup()
  drm/xe/oa: Switch to use hrtimer_setup()
  drm/vmwgfx: Switch to use hrtimer_setup()
  virtio: mem: Switch to use hrtimer_setup()
  RDMA: Switch to use hrtimer_setup()
  pwm: gpio: Switch to use hrtimer_setup()
  ASoC: fsl: imx-pcm-fiq: Switch to use hrtimer_setup()
  ALSA: Switch to use hrtimer_setup()

 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c         |  4 ++--
 drivers/gpu/drm/i915/gt/uc/intel_huc.c           |  4 ++--
 drivers/gpu/drm/i915/gvt/display.c               |  3 +--
 drivers/gpu/drm/i915/gvt/sched_policy.c          |  3 +--
 drivers/gpu/drm/i915/i915_perf.c                 |  5 ++---
 drivers/gpu/drm/i915/i915_pmu.c                  |  3 +--
 drivers/gpu/drm/i915/i915_request.c              |  3 +--
 drivers/gpu/drm/i915/intel_uncore.c              |  3 +--
 drivers/gpu/drm/msm/msm_fence.c                  |  3 +--
 drivers/gpu/drm/msm/msm_io_utils.c               |  3 +--
 drivers/gpu/drm/vkms/vkms_crtc.c                 |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c             |  4 ++--
 drivers/gpu/drm/xe/xe_oa.c                       |  4 ++--
 drivers/hwtracing/stm/heartbeat.c                |  6 ++----
 drivers/i2c/busses/i2c-imx.c                     |  4 ++--
 drivers/iio/adc/ti-tsc2046.c                     |  4 +---
 drivers/iio/trigger/iio-trig-hrtimer.c           |  4 ++--
 drivers/infiniband/hw/hfi1/init.c                |  5 ++---
 drivers/infiniband/sw/rdmavt/qp.c                |  5 ++---
 drivers/input/joystick/walkera0701.c             |  3 +--
 drivers/input/keyboard/gpio_keys.c               | 10 ++++------
 drivers/leds/trigger/ledtrig-pattern.c           |  4 ++--
 drivers/mailbox/mailbox.c                        |  4 +---
 drivers/media/cec/core/cec-pin.c                 |  3 +--
 drivers/media/pci/cx88/cx88-input.c              |  3 +--
 .../media/platform/chips-media/wave5/wave5-vpu.c |  4 ++--
 drivers/media/rc/pwm-ir-tx.c                     |  3 +--
 drivers/misc/vcpu_stall_detector.c               |  3 +--
 drivers/mmc/host/dw_mmc.c                        |  3 +--
 drivers/ntb/test/ntb_pingpong.c                  |  3 +--
 drivers/perf/arm-ccn.c                           |  5 ++---
 drivers/perf/marvell_cn10k_ddr_pmu.c             |  4 ++--
 drivers/perf/thunderx2_pmu.c                     |  5 ++---
 drivers/power/reset/ltc2952-poweroff.c           |  8 ++++----
 drivers/power/supply/ab8500_chargalg.c           |  9 ++++-----
 drivers/powercap/idle_inject.c                   |  3 +--
 drivers/powercap/intel_rapl_common.c             |  3 +--
 drivers/pps/generators/pps_gen_parport.c         |  3 +--
 drivers/pwm/pwm-gpio.c                           |  5 ++---
 drivers/rtc/class.c                              |  3 +--
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c         |  4 +---
 drivers/scsi/lpfc/lpfc_init.c                    |  7 +++----
 drivers/scsi/scsi_debug.c                        |  4 ++--
 drivers/tty/serial/8250/8250_bcm7271.c           |  3 +--
 drivers/tty/serial/8250/8250_port.c              | 10 ++++------
 drivers/tty/serial/imx.c                         |  8 ++++----
 drivers/tty/serial/sh-sci.c                      |  3 +--
 drivers/tty/serial/xilinx_uartps.c               |  4 ++--
 drivers/usb/chipidea/otg_fsm.c                   |  3 +--
 drivers/usb/dwc2/hcd_queue.c                     |  3 +--
 drivers/usb/fotg210/fotg210-hcd.c                |  3 +--
 drivers/usb/gadget/function/f_ncm.c              |  3 +--
 drivers/usb/gadget/udc/dummy_hcd.c               |  6 ++----
 drivers/usb/host/ehci-hcd.c                      |  3 +--
 drivers/usb/musb/musb_cppi41.c                   |  4 ++--
 drivers/usb/typec/tcpm/tcpm.c                    | 16 ++++++++--------
 drivers/virtio/virtio_mem.c                      |  4 ++--
 sound/core/hrtimer.c                             |  3 +--
 sound/drivers/dummy.c                            |  3 +--
 sound/drivers/pcsp/pcsp.c                        |  3 +--
 sound/sh/sh_dac_audio.c                          |  3 +--
 sound/soc/fsl/imx-pcm-fiq.c                      |  3 +--
 62 files changed, 108 insertions(+), 160 deletions(-)

--=20
2.39.5


