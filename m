Return-Path: <linux-kernel+bounces-186386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B52218CC386
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2C11F22B86
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE961EA91;
	Wed, 22 May 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f3h/FXkd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75191CAA6;
	Wed, 22 May 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389387; cv=none; b=t0qNcwNWXSvoBdkMzTFcx9fuBExvWznv1+9lflwU+fQwDW9V9q+1pqQrPRpbg+/kLYb6Y+hm9l0Ek/eUWK7pS/C4/SwrSvne/OqTMtKEp/GvkUa+q456mNAN/jdz1kjoDqF+nYPQJILd3A7YGLKUEtLSkjB1nj4dMiQj4p/lEcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389387; c=relaxed/simple;
	bh=A/JHw7Gv9bkuxzXooBZkfpUGMoav1/PyRjgDItv+tDY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ld0mWNzYrnrpIkP/7Y7nRb2ULqtjsp6it6Qcf0QvI3+MzrMMwpZOb57JUj0kEV3UB/hH/2AeSDyL40vbXumT9+h22qTIRHnZSlclONnbMe9kvIyF5toP6McpBYN+KqDXscmHACQ8gvzmwTtwTpN2dCjyDdmiDe4AApQrA01+abc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f3h/FXkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4ABC32782;
	Wed, 22 May 2024 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716389386;
	bh=A/JHw7Gv9bkuxzXooBZkfpUGMoav1/PyRjgDItv+tDY=;
	h=Date:From:To:Cc:Subject:From;
	b=f3h/FXkd0WvxQgmqcecxkPuAlTbD8+f4dns6kCMAFVzRtF0ihP6AhvOaTdRk/Ttex
	 b8O9RuOw6PEC1IrCzeP/MVm+wLvoUDbgNkgcIzhLQVB1rTYfFsQL+q5fn0BTHuI6m2
	 SExVd5ECVRfbfIxtsC35jimtFtR4EwbOwqhmBnoE=
Date: Wed, 22 May 2024 16:49:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver changes for 6.10-rc1
Message-ID: <Zk4GCA9FcWdWtjnt@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-rc1

for you to fetch changes up to 51474ab44abf907023a8a875e799b07de461e466:

  drm/bridge: aux-hpd-bridge: correct devm_drm_dp_hpd_bridge_add() stub (2024-05-11 13:02:14 +0100)

----------------------------------------------------------------
USB / Thunderbolt changes for 6.10-rc1

Here is the big set of USB and Thunderbolt changes for 6.10-rc1.
Nothing hugely earth-shattering, just constant forward progress for
hardware support of new devices and cleanups over the drivers.

Included in here are:
  - Thunderbolt / USB 4 driver updates
  - typec driver updates
  - dwc3 driver updates
  - gadget driver updates
  - uss720 driver id additions and fixes (people use USB->arallel port
    devices still!)
  - onboard-hub driver rename and additions for new hardware
  - xhci driver updates
  - other small USB driver updates and additions for quirks and api
    changes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alex Henrie (4):
      usb: misc: uss720: point pp->dev to usbdev->dev
      usb: misc: uss720: document the names of the compatible devices
      usb: misc: uss720: add support for another variant of the Belkin F5U002
      usb: misc: uss720: check for incompatible versions of the Belkin F5U002

Alex James (1):
      thunderbolt: Enable NVM upgrade support on Intel Maple Ridge

Anand Moon (5):
      usb: ehci-exynos: Use devm_clk_get_enabled() helpers
      usb: ehci-exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      usb: ohci-exynos: Use devm_clk_get_enabled() helpers
      usb: ohci-exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      usb: dwc3: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions

André Draszik (2):
      dt-bindings: usb: samsung,exynos-dwc3: add gs101 compatible
      usb: dwc3: exynos: add support for Google Tensor gs101

Andy Shevchenko (6):
      xhci: pci: Use full names in PCI IDs for Intel platforms
      xhci: pci: Group out Thunderbolt xHCI IDs
      xhci: pci: Use PCI_VENDOR_ID_RENESAS
      usb: phy: tegra: Replace of_gpio.h by proper one
      usb: fotg210: Use *-y instead of *-objs in Makefile
      usb: fotg210: Add missing kernel doc description

Arnd Bergmann (1):
      usb: gadget: omap_udc: remove unused variable

Biju Das (6):
      dt-bindings: usb: renesas,usbhs: Document RZ/G2L family compatible
      usb: renesas_usbhs: Simplify obtaining device data
      usb: renesas_usbhs: Improve usbhsc_default_pipe[] for isochronous transfers
      usb: renesas_usbhs: Update usbhs pipe configuration for RZ/G2L family
      usb: renesas_usbhs: Remove trailing comma in the terminator entry for OF table
      arm64: dts: renesas: r9a07g0{43,44,54}: Update RZ/G2L family compatible

Bo Liu (1):
      usb: typec: stusb160x: convert to use maple tree register cache

Chris Wulff (2):
      usb: gadget: u_audio: Fix race condition use of controls after free during gadget unbind.
      usb: gadget: u_audio: Clear uac pointer when freed.

Christian A. Ehrhardt (3):
      usb: typec: ucsi: Stop abuse of bit definitions from ucsi.h
      usb: typec: ucsi: Never send a lone connector change ack
      usb: typec: ucsi_acpi: Remove Dell quirk

Christophe JAILLET (6):
      usb: dwc2: Remove cat_printf()
      usb: gadget: u_audio: Fix the size of a buffer in a strscpy() call
      usb: gadget: u_audio: Use the 2-argument version of strscpy()
      usb: gadget: u_audio: Use snprintf() instead of sprintf()
      usb: gadget: function: Remove usage of the deprecated ida_simple_xx() API
      usb: core: Remove the useless struct usb_devmap which is just a bitmap

Dingyan Li (1):
      USB: Use EHCI control transfer pid macros instead of constant values.

Diogo Ivo (1):
      usb: typec: ucsi: Only enable supported notifications

Dmitry Baryshkov (22):
      usb: typec: ucsi: allow non-partner GET_PDOS for Qualcomm devices
      usb: typec: ucsi: limit the UCSI_NO_PARTNER_PDOS even further
      usb: typec: ucsi: properly register partner's PD device
      usb: typec: ucsi: always register a link to USB PD device
      usb: typec: ucsi: simplify partner's PD caps registration
      usb: typec: ucsi: extract code to read PD caps
      usb: typec: ucsi: support delaying GET_PDOS for device
      usb: typec: ucsi_glink: rework quirks implementation
      usb: typec: ucsi_glink: enable the UCSI_DELAY_DEVICE_PDOS quirk
      soc: qcom: pmic_glink: reenable UCSI on sc8280xp
      soc: qcom: pmic_glink: enable UCSI on sc8180x
      usb: typec: ucsi_glink: enable the UCSI_DELAY_DEVICE_PDOS quirk on qcm6490
      usb: typec: ucsi_glink: drop NO_PARTNER_PDOS quirk for sm8550 / sm8650
      usb: typec: ucsi_glink: drop special handling for CCI_BUSY
      usb: typec: ucsi: add callback for connector status updates
      usb: typec: ucsi: glink: move GPIO reading into connector_status callback
      usb: typec: ucsi: glink: use typec_set_orientation
      usb: typec: ucsi: add update_connector callback
      usb: typec: ucsi: glink: set orientation aware if supported
      dt-bindings: usb: qcom,pmic-typec: update example to follow connector schema
      usb: typec: qcom-pmic-typec: split HPD bridge alloc and registration
      drm/bridge: aux-hpd-bridge: correct devm_drm_dp_hpd_bridge_add() stub

Dr. David Alan Gilbert (1):
      usb: musc: Remove unused list 'buffers'

Fabio Estevam (2):
      dt-bindings: usb: Document the Microchip USB2514 hub
      dt-bindings: usb: hx3: Remove unneeded dr_mode

Francesco Dolcini (1):
      usb: typec: mux: gpio-sbu: Allow GPIO operations to sleep

Geert Uytterhoeven (1):
      usb: renesas_usbhs: Remove renesas_usbhs_get_info() wrapper

Gil Fine (4):
      thunderbolt: Fix calculation of consumed USB3 bandwidth on a path
      thunderbolt: Allow USB3 bandwidth to be lower than maximum supported
      thunderbolt: Fix uninitialized variable in tb_tunnel_alloc_usb3()
      thunderbolt: Fix kernel-doc for tb_tunnel_alloc_dp()

Greg Kroah-Hartman (4):
      Merge 6.9-rc2 into usb-next
      Merge 6.9-rc5 into usb-next
      Merge 6.9-rc7 into usb-next
      Merge tag 'thunderbolt-for-v6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next

Guenter Roeck (1):
      MAINTAINERS: Remove {ehci,uhci}-platform.c from ARM/VT8500 entry

Hans de Goede (1):
      usb: dwc3: pci: Don't set "linux,phy_charger_detect" property on Lenovo Yoga Tab2 1380

Hardik Gajjar (1):
      usb: gadget: f_fs: Add the missing get_alt callback

Heikki Krogerus (1):
      usb: typec: ucsi: displayport: Fix potential deadlock

Inochi Amaoto (2):
      dt-bindings: usb: dwc2: Add support for Sophgo CV18XX/SG200X series SoC
      usb: dwc2: add support for Sophgo CV18XX/SG200X series SoC

Javier Carrasco (11):
      usb: misc: onboard_hub: use device supply names
      usb: misc: onboard_hub: rename to onboard_dev
      drm: ci: arm64.config: update ONBOARD_USB_HUB to ONBOARD_USB_DEV
      arm64: defconfig: update ONBOARD_USB_HUB to ONBOARD_USB_DEV
      ARM: multi_v7_defconfig: update ONBOARD_USB_HUB to ONBOAD_USB_DEV
      usb: misc: onboard_dev: add support for non-hub devices
      ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500 voice processor
      usb: misc: onboard_dev: add support for XMOS XVF3500
      usb: typec: tipd: fix event checking for tps25750
      usb: typec: tipd: fix event checking for tps6598x
      usb: typec: tipd: rely on i2c_get_match_data()

Johan Hovold (1):
      dt-bindings: usb: qcom,dwc3: fix interrupt max items

Justin Stitt (2):
      usb: gadget: u_ether: replace deprecated strncpy with strscpy
      usb: gadget: mv_u3d: replace deprecated strncpy with strscpy

Komal Bajaj (1):
      dt-bindings: usb: dwc3: Add QDU1000 compatible

Krishna Kurapati (11):
      dt-bindings: usb: Add bindings for multiport properties on DWC3 controller
      usb: dwc3: core: Access XHCI address space temporarily to read port info
      usb: dwc3: core: Skip setting event buffers for host only controllers
      usb: dwc3: core: Refactor PHY logic to support Multiport Controller
      dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
      usb: dwc3: qcom: Add helper function to request wakeup interrupts
      usb: dwc3: qcom: Refactor IRQ handling in glue driver
      usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
      usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
      usb: dwc3: core: Fix compile warning on s390 gcc in dwc3_get_phy call
      usb: dwc3: core: Fix unused variable warning in core driver

Krzysztof Kozlowski (3):
      usb: phy: fsl-usb: drop driver owner assignment
      usb: typec: nvidia: drop driver owner assignment
      usb: typec: displayport: drop driver owner assignment

Luca Weiss (2):
      usb: typec: ptn36502: switch to DRM_AUX_BRIDGE
      dt-bindings: usb: qcom,pmic-typec: Add support for the PM7250B PMIC

Marcello Sylvester Bauer (2):
      usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler
      usb: gadget: dummy_hcd: Set transfer interval to 1 microframe

Mathias Nyman (4):
      xhci: stored cached port capability values in one place
      xhci: remove xhci_check_usb2_port_capability helper
      xhci: improve PORTSC register debugging output
      xhci: remove XHCI_TRUST_TX_LENGTH quirk

Michael Grzeschik (4):
      usb: gadget: uvc: fix try format returns on uncompressed formats
      usb: gadget: uvc: configfs: ensure guid to be valid before set
      usb: phy-generic: add short delay after pulling the reset pin
      usb: chipidea: move ci_ulpi_init after the phy initialization

Mika Westerberg (6):
      thunderbolt: Use correct error code with ERROR_NOT_SUPPORTED
      thunderbolt: Get rid of TB_CFG_PKG_PREPARE_TO_SLEEP
      thunderbolt: Increase sideband access polling delay
      thunderbolt: No need to loop over all retimers if access fails
      thunderbolt: There are only 5 basic router registers in pre-USB4 routers
      thunderbolt: Correct trace output of firmware connection manager packets

Minas Harutyunyan (7):
      usb: dwc2: Add core new versions definition
      usb: dwc2: New bit definition in GOTGCTL register
      usb: dwc2: Add new parameter eusb2_disc
      usb: dwc2: Add eUSB2 PHY disconnect flow support
      usb: dwc2: New bit definition in GPWRDN register
      usb: dwc2: Add hibernation updates for ULPI PHY
      usb: dwc2: New bitfield definition and programming in GRSTCTL

Mohammad Shehar Yaar Tausif (1):
      dt-bindings: usb: uhci: convert to dt schema

Nathan Chancellor (1):
      usb: typec: ptn36502: Only select DRM_AUX_BRIDGE with OF

Niklas Neronin (11):
      usb: xhci: check if 'requested segments' exceeds ERST capacity
      usb: xhci: improve debug message in xhci_ring_expansion_needed()
      usb: xhci: address off-by-one in xhci_num_trbs_free()
      usb: xhci: remove redundant variable 'erst_size'
      usb: xhci: use array_size() when allocating and freeing memory
      usb: xhci: prevent potential failure in handle_tx_event() for Transfer events without TRB
      usb: xhci: remove 'handling_skipped_tds' from handle_tx_event()
      usb: xhci: replace goto with return when possible in handle_tx_event()
      usb: xhci: remove goto 'cleanup' in handle_tx_event()
      usb: xhci: remove duplicate TRB_TO_SLOT_ID() calls
      usb: xhci: compact 'trb_in_td()' arguments

Oliver Neukum (1):
      USB: usb_parse_endpoint: ignore reserved bits

Pavan Holla (1):
      usb: typec: ucsi: Wait 20ms before reading CCI after a reset

Prashanth K (1):
      usb: dwc3: Wait unconditionally after issuing EndXfer command

Roy Luo (1):
      USB: gadget: core: create sysfs link between udc and gadget

Stephen Rothwell (1):
      USB: fix up for "usb: misc: onboard_hub: rename to onboard_dev"

Thinh Nguyen (1):
      usb: dwc3: Select 2.0 or 3.0 clk base on maximum_speed

Uwe Kleine-König (1):
      usb: chipidea: npcm: Convert to platform remove callback returning void

Xu Yang (4):
      usb: chipidea: ci_hdrc_imx: align usb wakeup clock name with dt-bindings
      dt-bindings: usb: chipidea,usb2-imx: move imx parts to dedicated schema
      dt-bindings: usb: ci-hdrc-usb2-imx: add restrictions for reg, interrupts, clock and clock-names properties
      dt-bindings: usb: ci-hdrc-usb2-imx: add compatible and clock-names restriction for imx93

 ...-usb-hub => sysfs-bus-platform-onboard-usb-dev} |   3 +-
 .../devicetree/bindings/sound/xmos,xvf3500.yaml    |  63 +++
 .../bindings/usb/chipidea,usb2-common.yaml         | 200 ++++++++
 .../devicetree/bindings/usb/chipidea,usb2-imx.yaml | 287 +++++++++++
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      | 360 +-------------
 .../devicetree/bindings/usb/cypress,hx3.yaml       |   1 -
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   1 +
 .../devicetree/bindings/usb/microchip,usb2514.yaml |  63 +++
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  41 +-
 .../devicetree/bindings/usb/qcom,pmic-typec.yaml   |  35 +-
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |   6 +-
 .../bindings/usb/samsung,exynos-dwc3.yaml          |  18 +
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  13 +-
 Documentation/devicetree/bindings/usb/usb-uhci.txt |  18 -
 .../devicetree/bindings/usb/usb-uhci.yaml          |  75 +++
 MAINTAINERS                                        |   6 +-
 arch/arm/configs/multi_v7_defconfig                |   2 +-
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi         |   2 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi         |   2 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi         |   2 +-
 arch/arm64/configs/defconfig                       |   2 +-
 drivers/gpu/drm/ci/arm64.config                    |   4 +-
 drivers/soc/qcom/pmic_glink.c                      |   5 -
 drivers/thunderbolt/debugfs.c                      |   2 +-
 drivers/thunderbolt/icm.c                          |   1 +
 drivers/thunderbolt/retimer.c                      |  12 +-
 drivers/thunderbolt/tb.c                           |   9 +-
 drivers/thunderbolt/tb_msgs.h                      |   6 -
 drivers/thunderbolt/trace.h                        |  13 +-
 drivers/thunderbolt/tunnel.c                       |  39 +-
 drivers/thunderbolt/usb4.c                         |  22 +-
 drivers/thunderbolt/xdomain.c                      |   2 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   2 +-
 drivers/usb/chipidea/ci_hdrc_npcm.c                |   6 +-
 drivers/usb/chipidea/core.c                        |   8 +-
 drivers/usb/chipidea/ulpi.c                        |   5 -
 drivers/usb/core/Makefile                          |   4 +-
 drivers/usb/core/config.c                          |   8 +-
 drivers/usb/core/hcd.c                             |   4 +-
 drivers/usb/core/hub.c                             |  17 +-
 drivers/usb/core/hub.h                             |   2 +-
 drivers/usb/dwc2/core.c                            |  42 ++
 drivers/usb/dwc2/core.h                            |   8 +
 drivers/usb/dwc2/core_intr.c                       |  26 +-
 drivers/usb/dwc2/debugfs.c                         |   1 +
 drivers/usb/dwc2/gadget.c                          |  28 +-
 drivers/usb/dwc2/hcd.c                             |  10 +
 drivers/usb/dwc2/hcd_queue.c                       |  52 +-
 drivers/usb/dwc2/hw.h                              |  14 +
 drivers/usb/dwc2/params.c                          |  43 ++
 drivers/usb/dwc3/core.c                            | 320 +++++++++---
 drivers/usb/dwc3/core.h                            |  20 +-
 drivers/usb/dwc3/drd.c                             |  15 +-
 drivers/usb/dwc3/dwc3-exynos.c                     |  22 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   8 +-
 drivers/usb/dwc3/dwc3-qcom.c                       | 265 ++++++----
 drivers/usb/dwc3/gadget.c                          |   4 +-
 drivers/usb/fotg210/Makefile                       |  10 +-
 drivers/usb/fotg210/fotg210-core.c                 |   1 +
 drivers/usb/gadget/function/f_fs.c                 |  20 +-
 drivers/usb/gadget/function/f_hid.c                |   6 +-
 drivers/usb/gadget/function/f_printer.c            |   6 +-
 drivers/usb/gadget/function/rndis.c                |   4 +-
 drivers/usb/gadget/function/u_audio.c              |  32 +-
 drivers/usb/gadget/function/u_ether.c              |   2 +-
 drivers/usb/gadget/function/uvc_configfs.c         |  14 +-
 drivers/usb/gadget/function/uvc_v4l2.c             |  24 +-
 drivers/usb/gadget/udc/core.c                      |   9 +
 drivers/usb/gadget/udc/dummy_hcd.c                 |  37 +-
 drivers/usb/gadget/udc/mv_u3d_core.c               |   4 +-
 drivers/usb/gadget/udc/omap_udc.c                  |  10 +-
 drivers/usb/host/ehci-dbg.c                        |  10 +-
 drivers/usb/host/ehci-exynos.c                     |  27 +-
 drivers/usb/host/ehci-q.c                          |  20 +-
 drivers/usb/host/ehci.h                            |   8 +-
 drivers/usb/host/ohci-exynos.c                     |  27 +-
 drivers/usb/host/xhci-dbgcap.c                     |   2 +-
 drivers/usb/host/xhci-mem.c                        |  48 +-
 drivers/usb/host/xhci-pci.c                        |  49 +-
 drivers/usb/host/xhci-rcar.c                       |   6 +-
 drivers/usb/host/xhci-ring.c                       | 138 +++---
 drivers/usb/host/xhci.c                            |  38 +-
 drivers/usb/host/xhci.h                            |  28 +-
 drivers/usb/misc/Kconfig                           |  16 +-
 drivers/usb/misc/Makefile                          |   2 +-
 drivers/usb/misc/onboard_usb_dev.c                 | 550 +++++++++++++++++++++
 .../misc/{onboard_usb_hub.h => onboard_usb_dev.h}  |  62 ++-
 ...ard_usb_hub_pdevs.c => onboard_usb_dev_pdevs.c} |  47 +-
 drivers/usb/misc/onboard_usb_hub.c                 | 507 -------------------
 drivers/usb/misc/uss720.c                          |  42 +-
 drivers/usb/musb/musb_gadget.c                     |   9 -
 drivers/usb/phy/phy-fsl-usb.c                      |   1 -
 drivers/usb/phy/phy-generic.c                      |   1 +
 drivers/usb/renesas_usbhs/common.c                 |  41 +-
 drivers/usb/renesas_usbhs/rza.h                    |   1 +
 drivers/usb/renesas_usbhs/rza2.c                   |  13 +
 drivers/usb/typec/altmodes/displayport.c           |   1 -
 drivers/usb/typec/altmodes/nvidia.c                |   1 -
 drivers/usb/typec/mux/Kconfig                      |   2 +-
 drivers/usb/typec/mux/gpio-sbu-mux.c               |   8 +-
 drivers/usb/typec/mux/ptn36502.c                   |  44 +-
 drivers/usb/typec/stusb160x.c                      |   2 +-
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c      |  10 +-
 drivers/usb/typec/tipd/core.c                      |  56 ++-
 drivers/usb/typec/tipd/tps6598x.h                  |  11 +
 drivers/usb/typec/ucsi/displayport.c               |   4 -
 drivers/usb/typec/ucsi/ucsi.c                      | 225 +++++----
 drivers/usb/typec/ucsi/ucsi.h                      |   8 +-
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |  56 +--
 drivers/usb/typec/ucsi/ucsi_glink.c                |  92 ++--
 drivers/usb/typec/ucsi/ucsi_stm32g0.c              |   1 +
 include/drm/bridge/aux-bridge.h                    |   2 +-
 include/linux/thunderbolt.h                        |   1 -
 include/linux/usb.h                                |   7 +-
 include/linux/usb/onboard_dev.h                    |  18 +
 include/linux/usb/onboard_hub.h                    |  18 -
 include/linux/usb/renesas_usbhs.h                  |   5 -
 include/linux/usb/tegra_usb_phy.h                  |   3 +-
 118 files changed, 2755 insertions(+), 1941 deletions(-)
 rename Documentation/ABI/testing/{sysfs-bus-platform-onboard-usb-hub => sysfs-bus-platform-onboard-usb-dev} (74%)
 create mode 100644 Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/chipidea,usb2-common.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-uhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-uhci.yaml
 create mode 100644 drivers/usb/misc/onboard_usb_dev.c
 rename drivers/usb/misc/{onboard_usb_hub.h => onboard_usb_dev.h} (56%)
 rename drivers/usb/misc/{onboard_usb_hub_pdevs.c => onboard_usb_dev_pdevs.c} (68%)
 delete mode 100644 drivers/usb/misc/onboard_usb_hub.c
 create mode 100644 include/linux/usb/onboard_dev.h
 delete mode 100644 include/linux/usb/onboard_hub.h

